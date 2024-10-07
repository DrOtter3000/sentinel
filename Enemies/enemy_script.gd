extends PathFollow3D

@export var basic_speed := 1.0
@export var hitpoints := 15
@export var damage := 1

var speed_modifier := 1.0
var speed_status := 1.0
var speed := 0.0


func _process(delta: float) -> void:
	check_if_in_gate()
	calculate_speed()
	progress += delta * speed


func calculate_speed():
	speed = basic_speed * speed_modifier * speed_status


func check_if_in_gate():
	if progress_ratio >= 1.0:
		get_tree().call_group("Level", "take_damage", damage)
		queue_free()


func take_damage(amount: int) -> void:
	hitpoints -= amount
	check_if_alive()


func check_if_alive() -> void:
	if hitpoints <= 0:
		queue_free() 
