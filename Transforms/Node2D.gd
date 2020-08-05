extends Node2D



func _ready():
    var M = generate_random_matrix()

    var R = Transform.IDENTITY.rotated(Vector3(1, 0, 0), 45)
    var S = Transform.IDENTITY.scaled(Vector3(2, 3, 5))
    var T = Transform.IDENTITY.translated(Vector3(4, 5, 6))
    
    var M_rot = M.rotated(Vector3(1, 0, 0), 45)
    var M_rot_lm = R * M
    var M_rot_rm = M * R
    check_left_right("Rotation", M_rot, M_rot_lm, M_rot_rm)

    var M_scaled = M.scaled(Vector3(2, 3, 5))
    var M_scaled_lm = S * M
    var M_scaled_rm = M * S
    check_left_right("Scale", M_scaled, M_scaled_lm, M_scaled_rm)
    
    var M_translated = M.translated(Vector3(4, 5, 6))
    var M_translated_lm = T * M
    var M_translated_rm = M * T
    check_left_right("Translation", M_translated, M_translated_lm, M_translated_rm)


func generate_random_matrix():
    randomize()
    return Transform.IDENTITY\
        .translated(Vector3(rand_range(-1, +1), rand_range(-1, +1), rand_range(-1, +1)))\
        .rotated(Vector3(1.0, 1.0, 1.0).normalized(), rand_range(-10, +10))\
        .scaled(Vector3(rand_range(0.1, 10), rand_range(0.1, 10), rand_range(0.1, 10)))


func check_left_right(name, actual, left_multiply, right_multiply):
    print(actual)
    print(left_multiply)
    print(right_multiply)
    if actual.is_equal_approx(left_multiply):
        print("%s is equal to LEFT multiply" % name)
    if actual.is_equal_approx(right_multiply):
        print("%s is equal to RIGHT multiply" % name)
