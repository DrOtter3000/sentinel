extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func start_game() -> void:
	Gamestate.audio_stream_player.play()
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")


func play_otter_sound() -> void:
	audio_stream_player.stream = load("res://SFX/AC_Funny_Riser_02.wav")
	audio_stream_player.play()


func play_darknet_sound() -> void:
	audio_stream_player.stream = load("res://SFX/AC_Ominous_Bell_03.wav")
	audio_stream_player.play()
