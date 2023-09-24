extends Node

var audio_stream_player: AudioStreamPlayer

func _ready():
	audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	
	# Test data from: https://freetestdata.com/audio-files/
	var audio_stream = load("res://Free_Test_Data_100KB_MP3.mp3")
	audio_stream.loop = true
	
	audio_stream_player.stream = audio_stream
	audio_stream_player.play()


func _input(event):
	if event.is_pressed() and event.is_action("ui_accept"):
		print("Toggling...")
		if audio_stream_player.playing:
			audio_stream_player.stop()
		else:
			audio_stream_player.play()

