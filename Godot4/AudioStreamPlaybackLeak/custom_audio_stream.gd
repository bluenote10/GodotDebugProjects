extends AudioStream
class_name CustomAudioStream

func _instantiate_playback():
	return CustomAudioStreamPlayback.new()

