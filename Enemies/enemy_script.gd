extends PathFollow3D

@export var hitpoints := 15
@export var money := 5
@export var damage := 1
@export var speed := 1.0
@export_enum("Zombie") var type

var speed_modifier := 1.0
var speed_status := 1.0
var final_speed := 0.0
var alive := true


func _process(delta: float) -> void:
	check_if_in_gate()
	calculate_speed()
	progress += delta * final_speed


func calculate_speed() -> void:
	final_speed = speed_modifier * speed_status * speed


func check_if_in_gate() -> void:
	if progress_ratio >= 1.0:
		get_tree().call_group("Level", "take_damage", damage)
		queue_free()


func take_damage(amount: int) -> void:
	hitpoints -= amount
	check_if_alive()


func check_if_alive() -> void:
	if hitpoints <= 0 and alive:
		alive = false
		get_tree().call_group("Player", "add_money", money)
		get_tree().call_group("Level", "update_kills", type)
		queue_free() 
