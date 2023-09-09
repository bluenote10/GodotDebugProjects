extends Node

var audio_stream_player: AudioStreamPlayer
var audio_stream_generator_playback: AudioStreamGeneratorPlayback
var i := 0

const SAMPLE_RATE = 44100.0


func _ready():
	audio_stream_player = AudioStreamPlayer.new()
	
	var audio_stream_generator = AudioStreamGenerator.new()
	audio_stream_generator.set_mix_rate(SAMPLE_RATE)
	audio_stream_generator.set_buffer_length(0.1)
	
	audio_stream_player.set_stream(audio_stream_generator)
	
	add_child(audio_stream_player)
	audio_stream_player.play(0.0)
	
	audio_stream_generator_playback = audio_stream_player.get_stream_playback()

	print(audio_stream_generator_playback)


func _process(_delta):
	
	var frames_available = audio_stream_generator_playback.get_frames_available()
	
	if frames_available > 0:
		print("Filling buffer of length %s" % frames_available)
		
		var buffer = PackedVector2Array()
		buffer.resize(frames_available)

		var freq = 440.0

		for buffer_index in range(frames_available):
			var phase = 0.5 * sin(2.0 * PI * i / SAMPLE_RATE * freq)
			buffer[buffer_index] = Vector2(phase, phase);
			i += 1

		audio_stream_generator_playback.push_buffer(buffer)

func _input(event):
	if event.is_pressed() and event.is_action("ui_accept"):
		print("Toggling")
		if audio_stream_player.is_playing():
			audio_stream_player.stop()
		else:
			audio_stream_player.play(0.0)
			# Note that calling `play` will always create a new instance of the "playback" object.
			# Therefore we cannot use the old playback reference any longer, and have to update
			# to the new reference.
			audio_stream_generator_playback = audio_stream_player.get_stream_playback()
