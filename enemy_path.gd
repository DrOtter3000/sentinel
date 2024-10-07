extends Path3D

@onready var path_timer: Timer = $PathTimer

@export var zombie_scene: PackedScene
@export_enum("left", "middle", "right") var path


var zombie_counter := 0


func _on_path_timer_timeout() -> void:
	if zombie_counter < 10:
		var zombie = zombie_scene.instantiate()
		add_child(zombie)
		zombie_counter += 1
		
