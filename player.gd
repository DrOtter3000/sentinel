extends Node3D

@onready var construction_ray_cast: RayCast3D = $ConstructionCam/ConstructionRayCast
@onready var level = get_tree().get_first_node_in_group("Level")

@export var construction_mode := true
@export var sentinel_scene: PackedScene

var sentinel_ready_to_build := true


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
			if Input.is_action_just_pressed("LMB"):
				print("Seninel Build")
				var sentinel = sentinel_scene.instantiate()
				level.add_child(sentinel)
				sentinel.global_position = construction_ray_cast.get_collision_point()
				


func _on_btn_recruit_pressed() -> void:
	pass # Replace with function body.
