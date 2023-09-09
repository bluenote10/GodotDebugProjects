extends Node

var audio_stream_player: AudioStreamPlayer
var audio_stream_generator_playback: AudioStreamGeneratorPlayback
var i := 0

const SAMPLE_RATE = 44100.0


func _ready():
	print("Running scene with work-around attempts...")
	audio_stream_player = AudioStreamPlayer.new()
	
	add_child(audio_stream_player)

	try_add_generator()

	print(audio_stream_generator_playback)


func try_add_generator():
	var audio_stream_generator = AudioStreamGenerator.new()
	audio_stream_generator.set_mix_rate(SAMPLE_RATE)
	audio_stream_generator.set_buffer_length(0.1)
	audio_stream_player.set_stream(audio_stream_generator)

	var num_frames_available = 0
	var start_time = Time.get_ticks_msec()
	var max_wait_time_ms = 100
	var num_expected_successful_fills = 3
	
	# This internally start the generator, i.e., from here it matters to fill
	# the buffer as quickly as possible to avoid running into the buffer underrun
	audio_stream_player.play(0.0)
	
	# Note that it only possible to get access to the "playback" instance via
	# the audio stream player -- surprisingly the generator itself does not
	# offer access to it, which would be more intuitive.
	audio_stream_generator_playback = audio_stream_player.get_stream_playback()
	
	while true:
		var frames_available = audio_stream_generator_playback.get_frames_available()
		fill(frames_available)
		if frames_available > 0:
			num_frames_available += 1
			# print(frames_available)
		var elapsed_ms = Time.get_ticks_msec() - start_time
		if num_frames_available == num_expected_successful_fills:
			print("Stream seems to work after %d ms" % elapsed_ms)
			return
		elif elapsed_ms > max_wait_time_ms:
			print("Failed to get working stream after %d ms, retrying..." % elapsed_ms)
			break
			
	try_add_generator()
	

func fill(n: int):
	# print("Filling buffer of length %s" % n)
	
	var buffer = PackedVector2Array()
	buffer.resize(n)

	var freq = 440.0

	for buffer_index in range(n):
		var phase = 0.5 * sin(2.0 * PI * i / SAMPLE_RATE * freq)
		buffer[buffer_index] = Vector2(phase, phase);
		i += 1

	audio_stream_generator_playback.push_buffer(buffer)


func _process(_delta):
	
	var frames_available = audio_stream_generator_playback.get_frames_available()
	
	if frames_available > 0:
		fill(frames_available)


func _input(event):
	if event.is_pressed() and event.is_action("ui_accept"):
		print("Simulating buffer underrun...")
		var start_time = Time.get_ticks_msec()
		while true:
			var elapsed_ms = Time.get_ticks_msec() - start_time
			if elapsed_ms > 1000:
				break
