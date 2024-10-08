extends RigidBody3D

var exploding := false

func _physics_process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	sleeping = true
	exploding = true
	print(exploding)

func _on_self_destruction_timeout() -> void:
	exploding = true
	print(exploding)
