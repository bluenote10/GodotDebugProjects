extends AudioStreamPlayback
class_name CustomAudioStreamPlayback

var i := 0
const f: float = 440
const sr: float = 44100
const amp: float = 0.5

func _init():
	print("Instantiating CustomAudioStreamPlayback")

func _start(_from_pos):
	pass

func _is_playing():
	return true

func _mix(buffer, _rate_scale, frames):
	# Well, looks like it is not possible to fill a `AudioFrame* buffer` from GDScript?
	"""
	print("num frames to generate: ", frames)
	for j in range(frames):
		print(j)
		var value = sin(2 * PI * f * i / sr)
		buffer[j] = amp * Vector2(value, value)
	"""
	return frames
