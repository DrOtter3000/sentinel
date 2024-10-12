extends Node3D

@export var max_houses := 10
@onready var left_path: Path3D = $LeftPath
@onready var mid_path: Path3D = $MidPath
@onready var right_path: Path3D = $RightPath
@onready var lights_in_the_village: Node3D = $LightsInTheVillage

var houses = max_houses
var wave := 1
var zombies_in_wave := 0
var zombies_removed_from_wave := 0


func _ready() -> void:
	randomize()
	Gamestate.initialize_perks()
	update_HUD_health()
	start_wave()


func take_damage(amount: int) -> void:
	zombies_removed_from_wave += 1
	check_for_victory()
	print(zombies_removed_from_wave)
	houses -= amount
	for i in amount:
		turn_off_light()
	update_HUD_health()
	check_for_game_over()


func turn_off_light() -> void:
	var children = lights_in_the_village.get_children()
	if children.size() == 0:
		return
	children[randi() % children.size()].queue_free()


func update_HUD_health() -> void:
	get_tree().call_group("Player", "update_lbl_health", houses, max_houses)


func start_wave() -> void:
	#start_new_wave(zombies)
	if wave == 1:
		zombies_in_wave = 10
		left_path.start_new_wave(10)
	elif wave == 2:
		zombies_in_wave = 20
		left_path.start_new_wave(10)
		right_path.start_new_wave(10)
	elif wave == 3:
		zombies_in_wave = 30
		left_path.start_new_wave(10)
		mid_path.start_new_wave(10)
		right_path.start_new_wave(10)


func next_wave() -> void:
	wave += 1
	zombies_removed_from_wave = 0
	start_wave()


func update_kills(type: int) -> void:
	if type == 0:
		zombies_removed_from_wave += 1
	check_for_victory()


func check_for_victory() -> void:
	if zombies_in_wave == zombies_removed_from_wave:
		print("winner")
		get_tree().get_first_node_in_group("Player").offer_perks()


func check_for_game_over() -> void:
	if houses <= 0:
		print("game over")
