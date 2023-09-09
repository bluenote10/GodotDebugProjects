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