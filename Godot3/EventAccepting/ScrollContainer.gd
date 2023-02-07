extends ScrollContainer


func _input(event):
    print("ScrollContainer._input")

    if event is InputEventMouseButton and event.is_pressed():
        if event.button_index == BUTTON_WHEEL_UP or event.button_index == BUTTON_WHEEL_DOWN:
            #SceneTree.set_input_as_handled(event)
            print("Accepting mouse wheel event")
            ._gui_input(event)
            accept_event()
    
    
func _gui_input(event):
    print("ScrollContainer._gui_input")
