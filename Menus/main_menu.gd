extends Control


func _on_btn_start_pressed() -> void:
	get_tree().change_scene_to_file("res://level.tscn")


func _on_btn_how_to_play_pressed() -> void:
	pass # Replace with function body.


func _on_btn_credits_pressed() -> void:
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
