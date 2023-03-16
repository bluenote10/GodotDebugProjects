extends Node

var initialized = false
var viewport: SubViewport
var viewport_texture: ViewportTexture
var sprite: Sprite2D

func add_something_to_viewport(viewport: SubViewport):
	var label = Label.new()
	label.text = "Hello world"
	viewport.add_child(label)
	

func _ready():
	viewport = SubViewport.new()
	viewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	add_something_to_viewport(viewport)
	add_child(viewport)
	
	print("own path: ", get_path())
	print("viewport path: ", viewport.get_path())
	
	viewport_texture = ViewportTexture.new()
	viewport_texture.viewport_path = viewport.get_path()
	viewport_texture.emit_changed()

	sprite = Sprite2D.new()
	sprite.texture = viewport_texture
	sprite.centered = false
	add_child(sprite)
	
	
	
	


func _process(_delta):
	if not initialized:
		viewport.size = Vector2(300, 300)
		print("before")
		sprite.texture = viewport_texture
		print("after")
		initialized = true
