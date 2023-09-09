# Issue overview

Issue: https://github.com/godotengine/godot/issues/65155

With discussions:
- https://github.com/godotengine/godot/pull/73162
- https://github.com/godotengine/godot/pull/73162#issuecomment-1427138058
- https://github.com/godotengine/godot/pull/73162#issuecomment-1427146963 (suggesting to partially revert mixing all in the audio server)
- https://github.com/godotengine/godot/pull/71780#issuecomment-1427131768
- https://github.com/godotengine/godot/pull/71780#issuecomment-1427149052

Caused by:
- https://github.com/godotengine/godot/pull/55846 (Fix ogg edge cases)
- https://github.com/godotengine/godot/pull/51296 (Move mixing out of the AudioStreamPlayback* nodes)


# Implementation notes

- `AudioStream` is the base representation of an audio stream.
- `AudioStreamPlayback` is a kind of "associated type" of an `AudioStream`, implementing things like `start`, `stop`, and `mix`.
- `AudioStreamPlaybackResampled` is the main implementator of that interface, but still abstract.
- `AudioStreamGeneratorPlayback` inherits from it and is responsible for the generation of "generator playback".
- `AudioStreamPlayer` is the node tree based interface for `AudioStream`

`AudioStreamPlayback::start` is called from `AudioServer::start_playback_stream` which in turn is called from `AudioStreamPlayer::play`.

Search for `::is_playing()` to see all implementations of how the playing state is defined.

`AudioServer::_mix_step()` the core mixing logic.

The usage of `begin_resample` is quite weird:
It calls `_mix_internal` internally, i.e., it tries to pull something from the buffer immediately.
For the `AudioStreamGeneratorPlayback` this doesn't really make sense, because the input buffer is empty at that point.
This actually internally leads to the skip counter getting incremented, because it is a kind of buffer underrun.
The only reason this kind of works is that `AudioStreamGeneratorPlayback::start` first calls `begin_resample()` but then re-resets the skip counter.
The only motivation to do that is perhaps for other "playback" types to really pre-fill the buffer, leading to less actual buffer underruns?

Making sense of:

```c++
uint64_t mix_increment = uint64_t(((get_stream_sampling_rate() * p_rate_scale * playback_speed_scale) / double(target_rate)) * double(FP_LEN));
```

The `get_stream_sampling_rate()` can be considered the `source_rate`.
So if the source rate is 22050 and the target rate is 44100, the first term would be 0.5.
The `double(FP_LEN)` term equals to 2**16 = 65536, so `mix_increment` would be have of that if the "scale" variables are all 1.0.
But why is that useful?

In the code that follows that formula `p_buffer` is the output buffer that needs to be filled with `p_frames` frames.
So the for loop over `i` loops over that output.
`_mix_internal` actually fills the `internal_buffer`, i.e., that the one that operates in the "source rate", whereas `p_buffer`  operators in the "target rate".

Possible explanation: It is a kind of fixed-point time delta computation.
Let's say the ration of source rate to target rate is 0.3.
The output buffer always gets incremented by exactly 1, because we need to generate output at each index.
But how do we advance the index in the source buffer (`internal_buffer`)?
One possibility would be to use floating point math on each sample to determine the proper source index.
Perhaps because that would be slow, the logic instead uses a fixed point integer arithmetic.
The mix increment would be `int(0.3 * 2 ** 16)` = 19660 in this case.
The logic now gets away with a very fast incremental update `mix_offset += mix_increment;` instead of having to use floating point math.
When converting back to real indices (`idx = CUBIC_INTERP_HISTORY + uint32_t(mix_offset >> FP_BITS)`) it is basically truncating the integer precision.
If we would for instance increment 100 times, we would arrive at `(100 * 19660) >> 16` = 29, i.e., approximately what 0.3 * 100 floating point would give.
Note that the is still floating point math involved in the computation of `mu`.
It looks like this is the "fractional" part encoded in `mix_offset` -- it is always in `[0, 1)`.
In the example of 100 increments we would for instance be at a fractional part of `((100 * 19660) & (2**16 - 1)) / (2 ** 16) = 0.998779296875`.