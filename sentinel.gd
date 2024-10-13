extends Node3D

@onready var timer: Timer = $Timer
@onready var attack_area: Area3D = $AttackArea
@onready var collision_shape_3d: CollisionShape3D = $AttackArea/CollisionShape3D
@onready var muzzle_position: Marker3D = $MuzzlePosition

@export var damage := 10
@export var fire_rate := 12.0
@export var radius := 10.0
@export var muzzle_scene: PackedScene


var enemies_in_range := []
var target = null


func _ready() -> void:
	timer.wait_time = 60 / fire_rate
	collision_shape_3d.shape.radius = radius


func _process(delta: float) -> void:
	compensating_godot_bug_66468()
	if target == null:
		target = detect_target()
		timer.stop()
	else:
		look_at(target.global_position)
		if timer.is_stopped():
			timer.start()


func shoot() -> void:
	var muzzle = muzzle_scene.instantiate() as Node3D
	get_parent().add_child(muzzle)
	muzzle.global_transform = muzzle_position.global_transform 
	target.take_damage(damage)


func _on_timer_timeout() -> void:
	shoot()
	timer.start()


func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.name == "EnemyBody":
		enemies_in_range.append(body.get_parent())


func _on_attack_area_body_exited(body: Node3D) -> void:
	if body.name == "EnemyBody":
		enemies_in_range.erase(body.get_parent())
		detect_target()


func compensating_godot_bug_66468() -> void:
	attack_area.set_collision_layer_value(32, not attack_area.get_collision_layer_value(32))


func detect_target():
	if enemies_in_range.size() == 0:
		target = null
	var min_distance = 1000
	var nearest_enemy
	for enemy in enemies_in_range:
		var distance_to_sentinel = position.distance_to(enemy.position)
		if distance_to_sentinel < min_distance:
			min_distance = distance_to_sentinel
			nearest_enemy = enemy
	return nearest_enemy
