extends VBoxContainer



func _ready():
    var slider = HSlider.new()
    slider.size_flags_horizontal = SIZE_FILL | SIZE_EXPAND
    slider.rounded = false
    slider.min_value = 0.0
    slider.max_value = 1.0
    slider.value = 0.5
    slider.step = 0.01
    
    add_child(slider)
