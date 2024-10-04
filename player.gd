extends Node3D

@onready var construction_ray_cast: RayCast3D = $ConstructionCam/ConstructionRayCast
@onready var lbl_status: Label = $ConstructionCam/ManagementMenu/LblStatus
@onready var level = get_tree().get_first_node_in_group("Level")
@onready var lbl_health_value: Label = %LblHealthValue
@onready var lbl_money_value: Label = %LblMoneyValue

@export var money := 100
@export var construction_mode := true
@export var sentinel_scene: PackedScene

var sentinel_ready_to_build := false


func _process(delta: float) -> void:
	if construction_mode:			
		
		if sentinel_ready_to_build:
			lbl_status.text = "Add Villager"
		else:
			lbl_status.text = ""
		
		if Input.is_action_just_pressed("RMB"):
			sentinel_ready_to_build = false
		
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		construction_ray_cast.target_position = $Camera3D.project_local_ray_normal(mouse_position) * 1000.0
		construction_ray_cast.force_raycast_update()
		
		var colliding_object = construction_ray_cast.get_collider()
		
		if colliding_object == null:
			pass
		elif colliding_object.name == "Ground":
			pass
		elif colliding_object.name == "BuildingArea":
			if sentinel_ready_to_build:
				if Input.is_action_just_pressed("LMB"):
					var sentinel = sentinel_scene.instantiate()
					get_node("../Sentinels").add_child(sentinel)
					sentinel.global_position = construction_ray_cast.get_collision_point()
					sentinel_ready_to_build = false
	
	update_lbl_money()


func _on_btn_recruit_pressed() -> void:
	sentinel_ready_to_build = true


func update_lbl_money() -> void:
	lbl_money_value.text = str(money)


func update_lbl_health(amount: int, maximum: int) -> void:
	lbl_health_value.text = str(amount) + " / " + str(maximum)
