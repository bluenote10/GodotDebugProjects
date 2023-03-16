extends Node


func _ready():
	# Create the viewport, add something to it, and add it to the scene tree:
	# Note that setting UPDATE_ALWAYS doesn't help.
	var viewport = SubViewport.new()
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	add_something_to_viewport(viewport)
	add_child(viewport)
	
	# Now that the viewport has a path, we can create a texture and connect it:
	var viewport_texture = ViewportTexture.new()
	viewport_texture.viewport_path = viewport.get_path()

	# Finally create a sprite that uses the viewport texture:
	var sprite = Sprite2D.new()
	sprite.centered = false
	sprite.texture = viewport_texture # <== this line causes debugger errors
	add_child(sprite)


func add_something_to_viewport(viewport: SubViewport):
	var label = Label.new()
	label.text = "Hello world"
	viewport.add_child(label)
