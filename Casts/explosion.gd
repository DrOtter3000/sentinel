extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

@export var max_radius := 1.0
@export var damage := 7
@export var growth_rate := .015


func _process(delta: float) -> void:
	if collision_shape_3d.shape.radius < max_radius:
		collision_shape_3d.shape.radius += growth_rate
		mesh_instance_3d.mesh.radius += growth_rate
		mesh_instance_3d.mesh.height += growth_rate * 2
	else: 
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	body.get_parent().take_damage(damage)
