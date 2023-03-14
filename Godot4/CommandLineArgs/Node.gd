extends Node


func _ready():
	print("OS.get_cmdline_args(): ", OS.get_cmdline_args())
	print("OS.get_cmdline_user_args(): ", OS.get_cmdline_user_args())
