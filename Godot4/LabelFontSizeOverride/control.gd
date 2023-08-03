extends Control


func _ready():
	var label = Label.new()
	label.text = "Hello World"
	
	# This doesn't work:
	# label.add_theme_constant_override("font_size", 8)
	
	# But this does:
	label.add_theme_font_size_override("font_size", 8)
	
	# Conclusion: Mainly confusing that `add_theme_constant_override` which
	# typically deals with integer-like theme properties doesn't handle
	# font size.
	
	add_child(label)
