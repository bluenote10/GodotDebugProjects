extends Node2D


func _ready():

	var points = PackedVector2Array()
	points.push_back(Vector2(10, 30))
	points.push_back(Vector2(100, 100))
	points.push_back(Vector2(30, 10))

	var arrays = []
	arrays.resize(ArrayMesh.ARRAY_MAX)
	arrays[ArrayMesh.ARRAY_VERTEX] = points

	var mesh = ArrayMesh.new()
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_POINTS, arrays)

	var mesh_instance = MeshInstance2D.new()
	mesh_instance.mesh = mesh
	mesh_instance.material = load("res://shader_material.tres")
	
	add_child(mesh_instance)
