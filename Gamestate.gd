extends Node

var fireball_mana_cost := 1.0

var available_player_perks := {
			"mana_regeneration": [0, "", 0],
			"fireball_damage": [0, "", 0],
			"fireball_size": [0, "", 0],
			"text_perk_1": [0, "", 1],
			"text_perk_2": [0, "", 1],
			"text_perk_3": [0, "", 1]
		}

var player_perks = available_player_perks.duplicate()
var available_perk_keys := []
var selected_perks := []


func _ready() -> void:
	initialize_perks()
	select_perks()
	select_perks()
	


func initialize_perks():
	available_perk_keys = player_perks.keys()
	print(available_perk_keys)


func select_perks():
	for i in 3:
		selected_perks.append(pick_perk())
	print(selected_perks)


func pick_perk():
	var perk = available_perk_keys.pick_random()
	if perk in selected_perks:
		pick_perk()
	return perk
