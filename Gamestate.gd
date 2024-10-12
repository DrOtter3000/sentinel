extends Node

var fireball_mana_cost := 1.0

var available_player_perks := {
			"More Mana": [0, "+10% Mana", 0],
			"text_perk_1": [1, "Lorem", 1],
			"text_perk_2": [0, "Ipsum", 1]
		}

var player_perks = available_player_perks.duplicate()
var available_perk_keys := []
var selected_perks := []


func _ready() -> void:
	initialize_perks()


func initialize_perks():
	available_perk_keys = player_perks.keys()


func select_perks():
	selected_perks.append(pick_perk())
	for i in 2:
		selected_perks.append(pick_perk())
	return selected_perks


func pick_perk():
	var perk = available_perk_keys.pick_random()
	while perk in selected_perks:
		perk = available_perk_keys.pick_random()
	return perk


func apply_perk(perk) -> void:
	player_perks[perk][0] += 1
