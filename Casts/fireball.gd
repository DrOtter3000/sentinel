extends RigidBody3D

@export var mana_cost := 1.0
@export var explosion: PackedScene

var exploding := false


func _physics_process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	explode()

func _on_self_destruction_timeout() -> void:
	explode()


func explode() -> void:
	exploding = true
	var explosion_instance = explosion.instantiate()
	get_parent().add_child(explosion_instance)
	explosion_instance.global_position = global_position
	queue_free()
