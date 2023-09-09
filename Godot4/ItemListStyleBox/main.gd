extends MarginContainer


func _ready():
	var item_list = ItemList.new()
	for i in 100:
		item_list.add_item("Item %d" % i)
	add_child(item_list)

	var custom_theme = Theme.new()
	custom_theme.set_constant("margin_left", "MarginContainer", 20)
	custom_theme.set_constant("margin_right", "MarginContainer", 20)
	custom_theme.set_constant("margin_bottom", "MarginContainer", 20)
	custom_theme.set_constant("margin_top", "MarginContainer", 20)
	
	# This line messes up the priority of the guides
	custom_theme.set_color("guide_color", "ItemList", Color(0.95, 0.95, 0.95))
	
	var style_box
	style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(1, 1, 1)
	style_box.set_border_width_all(1)
	style_box.set_content_margin_all(20)
	custom_theme.set_stylebox("panel", "ItemList", style_box)

	style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.9, 0.9, 1)
	style_box.border_color = Color(0.5, 0.5, 1)
	style_box.set_border_width_all(1)
	custom_theme.set_stylebox("selected", "ItemList", style_box)
	custom_theme.set_stylebox("selected_focus", "ItemList", style_box)

	custom_theme.set_stylebox("focus", "ItemList", StyleBoxEmpty.new())
	
	set_theme(custom_theme)
