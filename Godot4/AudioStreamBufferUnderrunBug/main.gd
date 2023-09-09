extends Node

"""
Test data from:
https://freetestdata.com/audio-files/
"""

func _ready():
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	
	var audio_stream = load("res://Free_Test_Data_100KB_MP3.mp3")
	audio_stream.loop = true
	
	audio_stream_player.stream = audio_stream
	audio_stream_player.play()


func _input(event):
	if event.is_pressed() and event.is_action("ui_accept"):
		print("Simulating buffer underrun...")
		var start_time = Time.get_ticks_msec()
		while true:
			var elapsed_ms = Time.get_ticks_msec() - start_time
			if elapsed_ms > 10000:
				break

