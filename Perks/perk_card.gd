extends Control

@onready var lbl_title: Label = $MarginContainer/VBoxContainer/LblTitle
@onready var lbl_description: Label = $MarginContainer/VBoxContainer/LblDescription

var perk_key: String
var mouse_hover := false


func setup_card(perk: String):
	perk_key = perk
	lbl_title.text = perk
	lbl_description.text = Gamestate.player_perks[perk][1]


func _on_area_2d_mouse_entered() -> void:
	mouse_hover = true


func _on_area_2d_mouse_exited() -> void:
	mouse_hover = false


func _input(event: InputEvent) -> void:
	if mouse_hover:
		if event.is_action_pressed("LMB"):
			Gamestate.apply_perk(perk_key)
			get_tree().paused = false
			get_tree().get_first_node_in_group("Player").next_wave()
			get_tree().get_first_node_in_group("Level").next_wave()
			Gamestate.selected_perks = []
			
