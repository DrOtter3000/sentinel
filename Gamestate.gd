extends Node

var fireball_mana_cost := 1.0

var available_player_perks := {
			"More Mana": [0, "Increases Mana by 10%", 0],
			"Increase Interest": [0, "Increases interest by 3%", 0],
			"Fireball Damage": [0, "Increases fireball damage by 25%", 0],
			"Fireball Radius": [0, "Increases fireball radius by 50%", 0]
		}

var available_enemy_perks := {
			"Health": [0, "Enemies now have additional 20% health"],
			"Faster": [0, "Enemies are now 10% faster"]
		}

var player_perks = available_player_perks.duplicate()
var available_perk_keys := []
var selected_perks := []

var enemy_perks = available_enemy_perks.duplicate()


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


func upgrade_enemy_perks() -> void:
	var perk = enemy_perks.keys().pick_random()
	enemy_perks[perk][0] += 1
