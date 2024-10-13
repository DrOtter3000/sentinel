extends PathFollow3D

@export var base_hitpoints := 15
@export var money := 5
@export var damage := 1
@export var speed := 1.0
@export_enum("Zombie") var type
@export var death_sound_scene: PackedScene

@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var timer: Timer = $Timer

var speed_modifier := 1.0 + float(Gamestate.enemy_perks["Faster"][0]/10)
var speed_status := 1.0
var final_speed := 0.0
var alive := true
var hitpoints: int
var zombie_sounds := ["res://SFX/Dark Fantasy Studio-Zombie_1.wav", "res://SFX/Dark Fantasy Studio-Zombie_2.wav"]


func _ready() -> void:
	hitpoints = int(float(base_hitpoints) * (1.0 + float(Gamestate.enemy_perks["Health"][0] * .2)))
	timer.wait_time = randi_range(1, 40)
	timer.start()


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
		
		var death_sound = death_sound_scene.instantiate()
		get_parent().add_child(death_sound)
		death_sound.global_position = global_position
		
		
		get_tree().call_group("Player", "add_money", money)
		get_tree().call_group("Level", "update_kills", type)
		queue_free() 


func _on_timer_timeout() -> void:
	audio_stream_player_3d.stream = load(zombie_sounds[randi_range(0, zombie_sounds.size()-1)])
	audio_stream_player_3d.pitch_scale = randf_range(.8, 1.2)
	audio_stream_player_3d.play()
	timer.wait_time = randi_range(20, 50)
	timer.start()
