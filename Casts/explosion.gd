extends Area3D

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


@export var base_radius := 1.0
@export var base_damage := 6
@export var growth_rate := .008

var damage = base_damage
var max_radius = base_radius


func _ready() -> void:
	audio_stream_player_3d.pitch_scale = randf_range(.7, 1.4)
	audio_stream_player_3d.play()
	damage = int(base_damage * (1.0 + (Gamestate.player_perks["Fireball Damage"][0] * .25)))
	max_radius = base_radius * (1.0 + (Gamestate.player_perks["Fireball Radius"][0] * .5))

func _process(delta: float) -> void:
	if collision_shape_3d.shape.radius < max_radius:
		collision_shape_3d.shape.radius += growth_rate
		mesh_instance_3d.mesh.radius += growth_rate  * (1.0 + (Gamestate.player_perks["Fireball Radius"][0] * .3))
		mesh_instance_3d.mesh.height += growth_rate * 2 * (1.0 + (Gamestate.player_perks["Fireball Radius"][0] * .3))
	else: 
		queue_free()


func _on_body_entered(body: Node3D) -> void:
	body.get_parent().take_damage(damage)
