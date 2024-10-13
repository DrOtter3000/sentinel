extends AudioStreamPlayer3D

var sounds := ["res://SFX/Dark Fantasy Studio-Zombie_die2.wav", "res://SFX/Dark Fantasy Studio-Zombie_die.wav"] 


func _ready() -> void:
	pitch_scale = randf_range(.8, 1.2)
	stream = load(sounds[randi_range(0, sounds.size()-1)])
	play()


func _on_timer_timeout() -> void:
	queue_free()
