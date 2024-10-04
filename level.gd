extends Node3D

@export var hitpoints := 10


func take_damage(amount: int) -> void:
	hitpoints -= amount
	print(hitpoints)
