extends Container


func _ready():
	set_anchors_preset(PRESET_FULL_RECT, true)

	create_subtree()

	self.sort_children.connect(_on_sort_children)


func _on_sort_children():
	print("Layout children")
	var available_size = self.size
	for child in self.get_children():
		var size = available_size - Vector2(100, 100)
		var pos = Vector2(50, 50)
		fit_child_in_rect(child, Rect2(pos, size))


func create_subtree():
	# The 'wrapper' will be controlled by this container:
	var wrapper = Control.new()
	wrapper.name = "Wrapper"

	# The 'wrapper' in turn contains two children that are both set to 'full rect'
	var custom_panel_container = CustomPanelContainer.new()
	custom_panel_container.name = "CustomPanelContainer"
	custom_panel_container.set_anchors_preset(PRESET_FULL_RECT)
	wrapper.add_child(custom_panel_container)

	var color_rect = ColorRect.new()
	color_rect.name = "ColorRect"
	color_rect.set_anchors_preset(PRESET_FULL_RECT)
	color_rect.color = Color(1, 0, 0, 0.1)
	wrapper.add_child(color_rect)

	add_child(wrapper)
