extends Node3D

@onready var construction_ray_cast: RayCast3D = $ConstructionCam/ConstructionRayCast

@export var construction_mode := true


func _process(delta: float) -> void:
	if construction_mode:
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		construction_ray_cast.target_position = $Camera3D.project_local_ray_normal(mouse_position) * 1000.0
		construction_ray_cast.force_raycast_update()
		
		var colliding_object = construction_ray_cast.get_collider()
		
		if colliding_object == null:
			print("No construction area")
		elif colliding_object.name == "Ground":
			print("Can't add sentinel here")
		elif colliding_object.name == "BuildingArea":
			print("Build something here")
