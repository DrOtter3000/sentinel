extends Node3D

@onready var timer: Timer = $Timer
@onready var attack_area: Area3D = $AttackArea


@export var fire_rate := 6.0


func _ready() -> void:
	timer.wait_time = 60 / fire_rate
	timer.start()


func _process(delta: float) -> void:
	compensating_godot_bug_66468()


func _on_timer_timeout() -> void:
	timer.start()


func _on_attack_area_body_entered(body: Node3D) -> void:
	if body.name == "EnemyBody":
		print("OpenFire")


func _on_attack_area_body_exited(body: Node3D) -> void:
	if body.name == "EnemyBody":
		print("CeaseFire")


func compensating_godot_bug_66468() -> void:
	attack_area.set_collision_layer_value(32, not attack_area.get_collision_layer_value(32))
