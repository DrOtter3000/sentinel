extends Path3D

@onready var path_timer: Timer = $PathTimer

@export var zombie_scene: PackedScene

var zombie_target := 0
var zombie_counter := 0


func _on_path_timer_timeout() -> void:
	if zombie_counter < zombie_target:
		print(name + " " + str(zombie_counter) + " " + str(zombie_target))
		var zombie = zombie_scene.instantiate()
		add_child(zombie)
		zombie_counter += 1
		path_timer.start()
	else:
		$PathTimer.stop()
		print(name + "wave complete")


func start_new_wave(zombie: int) -> void:
	zombie_counter = 0
	zombie_target = zombie
	path_timer.start()
