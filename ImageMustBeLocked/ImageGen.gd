extends Node2D


func _ready():
    
    var w = 21000
    var h = 432
    var image = Image.new()
    
    image.create(w, h, false, Image.FORMAT_RGBA8)
    image.lock()
    for i in range(w):
        for j in range(h):
            image.set_pixel(i, j, Color(1, 1, 1, 1))
    image.unlock()
    
    print("done")
