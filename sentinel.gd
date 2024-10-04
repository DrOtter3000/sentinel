extends Node3D

@onready var timer: Timer = $Timer

@export var fire_rate := 6.0


func _ready() -> void:
	timer.wait_time = 60 / fire_rate
	print(timer.wait_time)
	timer.start()


func _on_timer_timeout() -> void:
	print(str(name) + str(" firing"))
	timer.start()
