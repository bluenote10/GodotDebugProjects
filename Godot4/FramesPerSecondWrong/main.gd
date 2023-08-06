extends Node2D

var sprite: Sprite2D

func _ready():
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
	sprite = Sprite2D.new()
	sprite.texture = load("res://icon.svg")
	
	add_child(sprite)


func _process(_delta):
	
	var start_time = Time.get_ticks_usec()
	
	sprite.position = Vector2(
		200 + cos(start_time / 100000.0) * 100,
		200 + sin(start_time / 100000.0) * 100,
	)
	
	var elapsed = 0
	while elapsed < 30000:
		elapsed = Time.get_ticks_usec() - start_time
		
	print("fps: %3d    process delta: %.6f" % [
		Engine.get_frames_per_second(),
		get_process_delta_time(),
	])
	
"""
Conclusion:

It looks like if the load happens inside `_process` itself, the fps computation
is correct. So, only if the load is external and slowing down the process function
when measured from the outside the fps computation seems to be wrong.
"""
