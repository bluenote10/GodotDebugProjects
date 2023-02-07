extends PanelContainer
class_name CustomPanelContainer


func _ready():
    print("_ready PanelContainer")

    print("\nOriginal:")
    print_geometry(self)

    #self.set_anchors_preset(Control.PRESET_WIDE)
    self.set_anchors_preset(Control.PRESET_WIDE, true)
    #anchor_right = 1.0
    #anchor_bottom = 1.0

    # The following two lines should clearly be a no-op but they aren't.
    if rect_position.x == 0:
        rect_position.x = 0

    print("\nEnd of _ready:")
    print_geometry(self)


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
