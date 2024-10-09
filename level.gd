extends Node3D

@export var max_houses := 10

var houses = max_houses


func _ready() -> void:
	update_HUD_health()


func take_damage(amount: int) -> void:
	houses -= amount
	update_HUD_health()


func update_HUD_health() -> void:
	get_tree().call_group("Player", "update_lbl_health", houses, max_houses)
