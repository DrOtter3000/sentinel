extends Control


@onready var menu_container: CenterContainer = $MenuContainer
@onready var lbl_version: Label = $LblVersion
@onready var how_to_play: Control = $HowToPlay
@onready var credits: Control = $Credits


func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")


func _on_btn_how_to_play_pressed() -> void:
	menu_container.visible = false
	lbl_version.visible = false
	how_to_play.visible = true


func _on_btn_credits_pressed() -> void:
	menu_container.visible = false
	lbl_version.visible = false
	credits.visible = true


func _on_btn_quit_pressed() -> void:
	get_tree().quit()


func _on_btn_back_pressed() -> void:
	menu_container.visible = true
	lbl_version.visible = true
	how_to_play.visible = false
	credits.visible = false
