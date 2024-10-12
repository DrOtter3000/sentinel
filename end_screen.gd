extends Control

@onready var lbl_status: Label = $CenterContainer/VBoxContainer/LblStatus
@onready var lbl_content: Label = $CenterContainer/VBoxContainer/LblContent



func _ready() -> void:
	reset_game()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	update_screen()


func update_screen() -> void:
	if Gamestate.victory:
		lbl_status.text = "Victory!"
		lbl_content.text = "The villagers survived this night. The evil forces are defeated!"
	else:
		lbl_status.text = "Defeat!"
		lbl_content.text = "You failed! The villagers have been slain by the forces of evil!"


func reset_game() -> void:
	Gamestate.reset_gamestate()


func _on_btn_again_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")


func _on_btn_quit_pressed() -> void:
	pass # Replace with function body.
