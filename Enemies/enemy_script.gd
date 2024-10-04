extends PathFollow3D

@export var basic_speed := 1.0
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
	if progress >= 100:
		get_tree().call_group("Level", "take_damage", damage)
		queue_free()
