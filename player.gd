extends Node3D

@onready var construction_ray_cast: RayCast3D = $Camera3D/ConstructionRayCast
@onready var lbl_status: Label = $ConstructionCam/ManagementMenu/LblStatus
@onready var level = get_tree().get_first_node_in_group("Level")
@onready var lbl_health_value: Label = %LblHealthValue
@onready var lbl_money_value: Label = %LblMoneyValue
@onready var management_menu: CanvasLayer = $ConstructionCam/ManagementMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var combat_menu: CanvasLayer = $CombatCam/CombatMenu
@onready var camera_3d: Camera3D = $Camera3D
@onready var cast_spawn_point = camera_3d.global_position
@onready var mana_regen_timer: Timer = $ManaRegenTimer
@onready var mana_bar: ProgressBar = $Camera3D/StatusView/MarginContainer/VBoxContainer/ManaContainer/ManaBar
@onready var lbl_mana: Label = $Camera3D/StatusView/MarginContainer/VBoxContainer/ManaContainer/LblMana
@onready var btn_recruit: Button = $ConstructionCam/ManagementMenu/MarginContainer/ConstructionContainer/BuildContainer/BtnRecruit
@onready var build_container: VBoxContainer = $ConstructionCam/ManagementMenu/MarginContainer/ConstructionContainer/BuildContainer
@onready var upgrade_container: VBoxContainer = $ConstructionCam/ManagementMenu/MarginContainer/ConstructionContainer/UpgradeContainer
@onready var lbl_damage: Label = $ConstructionCam/ManagementMenu/MarginContainer/ConstructionContainer/UpgradeContainer/LblDamage
@onready var btn_upgrade_damage: Button = $ConstructionCam/ManagementMenu/MarginContainer/ConstructionContainer/UpgradeContainer/BtnUpgradeDamage
@onready var btn_sell: Button = $ConstructionCam/ManagementMenu/MarginContainer/ConstructionContainer/UpgradeContainer/BtnSell
@onready var price_per_sentinel_sold = int(price_per_sentinel * 0.75)

@export var money := 100
@export var price_per_sentinel := 12
@export var max_mana := 10.0
@export var mana_regen := 1.0
@export var mouse_sensetivity := .15
@export var mana := 5.0
@export var construction_mode := true
@export_enum("construction", "combat") var mode
@export var sentinel_scene: PackedScene
@export var fireball_scene: PackedScene
var sentinel_ready_to_build := false
var build_mode = true
var selected_sentinel


func _ready() -> void:
	switch_mode()
	mana = max_mana
	btn_recruit.text = "Recruit Villager (" + str(price_per_sentinel) + ")"
	btn_sell.text = "Sell Villager (" + str(price_per_sentinel_sold) + ")"
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("switch_mode"):
		switch_mode()
	
	if mode == 0:
		if build_mode == true:
			build_container.visible = true
			upgrade_container.visible = false
		else:
			build_container.visible = false
			upgrade_container.visible = true
		
		if sentinel_ready_to_build:
			view_message("Add Villager")
		
		if Input.is_action_just_pressed("RMB"):
			reset_selections()
		
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		construction_ray_cast.target_position = $Camera3D.project_local_ray_normal(mouse_position) * 1000.0
		construction_ray_cast.force_raycast_update()
		
		var colliding_object = construction_ray_cast.get_collider()
		
		if colliding_object == null:
			pass
		elif colliding_object.name == "Ground":
			pass
		elif colliding_object.name == "Sentinel":
			var hovered_sentinel = colliding_object.get_parent()
			if not sentinel_ready_to_build:
				if Input.is_action_just_pressed("LMB"):
					selected_sentinel = hovered_sentinel
					build_mode = false
					lbl_damage.text = "Damage: " + str(selected_sentinel.damage)
					btn_upgrade_damage.text = "Damage +5 (10Gold)"
					
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
	
	if mode == 1:
		if Input.is_action_just_pressed("LMB"):
			if mana >= Gamestate.fireball_mana_cost:
				mana -= Gamestate.fireball_mana_cost
				var fireball = fireball_scene.instantiate() as Node3D
				get_tree().get_first_node_in_group("Level").add_child(fireball)
				fireball.transform = camera_3d.global_transform
				fireball.linear_velocity = camera_3d.global_transform.basis.z * -1 * 10
			
	update_lbl_money()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mode == 1:
		camera_3d.rotation_degrees.y -= event.relative.x * mouse_sensetivity
		camera_3d.rotation_degrees.x -= event.relative.y * mouse_sensetivity
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -60, 90)


func _on_btn_recruit_pressed() -> void:
	if money >= price_per_sentinel:
		sentinel_ready_to_build = true
	else:
		view_message("Insufficient Funds")


func add_money(amount: int) -> void:
	money += amount
	update_lbl_money()


func update_lbl_money() -> void:
	lbl_money_value.text = str(money)


func update_lbl_health(amount: int, maximum: int) -> void:
	lbl_health_value.text = str(amount) + " / " + str(maximum)


func update_mana_HUD() -> void:
	mana_bar.max_value = max_mana
	mana_bar.value = mana
	lbl_mana.text = "Mana: " + str("%.1f" % mana) + " / " + str(max_mana) 


func reset_selections() -> void:
	selected_sentinel = null
	build_mode = true
	sentinel_ready_to_build = false
	view_message("")


func view_message(text: String) -> void:
	lbl_status.text = text


func switch_mode() -> void:
	if mode == 0:
		sentinel_ready_to_build = false
		view_message("")
		mode = 1
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		animation_player.play("switch_to_combat")
		management_menu.visible = false
		combat_menu.visible = true
	else:
		mode = 0
		build_mode = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		animation_player.play("switch_to_construction")
		management_menu.visible = true
		combat_menu.visible = false


func _on_mana_regen_timer_timeout() -> void:
	update_mana_HUD()
	mana += mana_regen / 60
	mana = min(mana, max_mana)


func _on_btn_upgrade_damage_pressed() -> void:
	if selected_sentinel:
		if money >= 10:
			selected_sentinel.damage += 5
			money -= 10
			lbl_damage.text = "Damage: " + str(selected_sentinel.damage)
			update_lbl_money()


func _on_btn_sell_pressed() -> void:
	money += price_per_sentinel_sold
	selected_sentinel.queue_free()
	reset_selections()
