extends Node

var audio_stream_player: AudioStreamPlayer

func _ready():
	audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = CustomAudioStream.new()
	
	add_child(audio_stream_player)

	audio_stream_player.play()

func _process(_delta):
	pass
