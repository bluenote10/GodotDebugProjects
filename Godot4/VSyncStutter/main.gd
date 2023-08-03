extends Node2D

var sprite: Sprite2D
var label: Label

func _ready():
	sprite = Sprite2D.new()
	label = Label.new()
	
	var texture = load("res://icon.svg")
	sprite.texture = texture
	
	add_child(sprite)
	add_child(label)


func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		sprite.position += event.relative
		
	if event is InputEventKey:
		if event.keycode == KEY_V and event.is_pressed() and not event.is_echo():
			if DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED:
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
			elif DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_DISABLED:
				DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			

func _process(_delta):
	label.text = "fps: %s, vsync: %s" % [Engine.get_frames_per_second(), DisplayServer.window_get_vsync_mode()]
