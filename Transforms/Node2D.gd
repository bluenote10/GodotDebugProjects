extends Node2D


func _ready():
    var R = Transform.IDENTITY.rotated(Vector3(1, 0, 0), 45)
    var S = Transform.IDENTITY.scaled(Vector3(2, 3, 5))
    var T = Transform.IDENTITY.translated(Vector3(4, 5, 6))
    
    var M = R * S * T
    
    var M_rot_1 = M.rotated(Vector3(1, 0, 0), 45)
    var M_rot_2 = M * R
    var M_rot_3 = R * M
    
    print(M_rot_1)
    print(M_rot_2)
    print(M_rot_3)
    assert(M_rot_1.is_equal_approx(M_rot_3))
    

    var M_scaled_1 = M.scaled(Vector3(2, 3, 5))
    var M_scaled_2 = M * S
    var M_scaled_3 = S * M
    
    print(M_scaled_1)
    print(M_scaled_2)
    print(M_scaled_3)
    assert(M_scaled_1.is_equal_approx(M_scaled_3))
    

    var M_translated_1 = M.translated(Vector3(4, 5, 6))
    var M_translated_2 = M * T
    var M_translated_3 = T * M
    
    print(M_translated_1)
    print(M_translated_2)
    print(M_translated_3)
    assert(M_translated_1.is_equal_approx(M_translated_2))
