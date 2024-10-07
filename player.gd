extends Node3D

@onready var construction_ray_cast: RayCast3D = $Camera3D/ConstructionRayCast
@onready var lbl_status: Label = $ConstructionCam/ManagementMenu/LblStatus
@onready var level = get_tree().get_first_node_in_group("Level")
@onready var lbl_health_value: Label = %LblHealthValue
@onready var lbl_money_value: Label = %LblMoneyValue
@onready var management_menu: CanvasLayer = $ConstructionCam/ManagementMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var combat_menu: CanvasLayer = $CombatCam/CombatMenu

@export var money := 100
@export var price_per_sentinel := 12
@export var construction_mode := true
@export var sentinel_scene: PackedScene
@export_enum("construction", "combat") var mode

var sentinel_ready_to_build := false


func _ready() -> void:
	switch_mode()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_mode"):
		switch_mode()
	
	if mode == 0:
		
		if sentinel_ready_to_build:
			view_message("Add Villager")
		
		if Input.is_action_just_pressed("RMB"):
			sentinel_ready_to_build = false
			view_message("")
		
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
					money -= price_per_sentinel
					update_lbl_money()
					view_message("")
					sentinel_ready_to_build = false
	
	update_lbl_money()


func _on_btn_recruit_pressed() -> void:
	if money >= price_per_sentinel:
		sentinel_ready_to_build = true
	else:
		view_message("Insufficient Funds")


func update_lbl_money() -> void:
	lbl_money_value.text = str(money)


func update_lbl_health(amount: int, maximum: int) -> void:
	lbl_health_value.text = str(amount) + " / " + str(maximum)


func view_message(text: String) -> void:
	lbl_status.text = text


func switch_mode() -> void:
	if mode == 0:
		mode = 1
		animation_player.play("switch_to_combat")
		management_menu.visible = false
		combat_menu.visible = true
	else:
		mode = 0
		animation_player.play("switch_to_construction")
		management_menu.visible = true
		combat_menu.visible = false
