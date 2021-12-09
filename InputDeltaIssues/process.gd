extends Control

var num_frames := 0
var time := 0.0


func _ready():
    simulate_load(2000)


func _input(event):
    var delta = get_process_delta_time()
    print("_input   @ frame = %d, delta = %s event: %s" % [num_frames, delta, event.as_text()])

    if event.is_pressed() and event.scancode == KEY_SPACE:
        time += delta


func _process(delta):
    print("_process @ frame = %d, delta = %s" % [num_frames, delta])

    # dummy load to simulate frame dropping below 60 fps.
    simulate_load(1000)

    num_frames += 1
    update()


func _draw():
    var x = 100 + 100 * cos(time)
    var y = 100 + 100 * sin(time)
    draw_rect(Rect2(x, y, 10, 10), Color(1, 0, 0))


func simulate_load(n):
    var sum := 0.0
    for _i in n:
        for _j in n:
            sum += 0.1
