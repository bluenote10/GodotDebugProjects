extends Control


func _ready():
    #set_anchors_preset(PRESET_WIDE, true)
    rect_position = Vector2(10, 10)
    rect_size = Vector2(100, 100)
    create_subtree()


func create_subtree():

    print("Initializing CustomPanelContainer")
    var custom_panel_container = CustomPanelContainer.new()
    custom_panel_container.name = "CustomPanelContainer"
    #custom_panel_container.set_anchors_preset(Control.PRESET_WIDE)
    #custom_panel_container.anchor_right = 1
    #custom_panel_container.anchor_bottom = 1
    add_child(custom_panel_container)
    print("Added CustomPanelContainer")

    var color_rect = ColorRect.new()
    print_geometry(color_rect)
    color_rect.name = "ColorRect"
    #color_rect.rect_size = Vector2(100, 100)
    #color_rect.set_anchors_preset(Control.PRESET_WIDE)
    #color_rect.rect_position = Vector2(10, 10)
    #color_rect.anchor_right = 1
    #color_rect.anchor_bottom = 1
    color_rect.color = Color(1, 0, 0, 0.1)
    print_geometry(color_rect)
    add_child(color_rect)
    print_geometry(color_rect)

    #custom_panel_container.rect_position = Vector2(10, 10)
    #custom_panel_container.rect_size = Vector2(100, 100)


func print_geometry(node):
    print("rect_position: ", node.rect_position)
    print("rect_size: ", node.rect_size)
    print("anchor_left: ", node.anchor_left)
    print("anchor_right: ", node.anchor_right)
    print("anchor_top: ", node.anchor_top)
    print("anchor_bottom: ", node.anchor_bottom)
    print("margin_left: ", node.margin_left)
    print("margin_right: ", node.margin_right)
    print("margin_top: ", node.margin_top)
    print("margin_bottom: ", node.margin_bottom)
