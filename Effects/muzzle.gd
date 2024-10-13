extends Node3D


@onready var omni_light_3d: OmniLight3D = $OmniLight3D
@onready var timer: Timer = $Timer
@onready var gpu_particles_3d: GPUParticles3D = $GPUParticles3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


func _ready() -> void:
	gpu_particles_3d.emitting = true
	audio_stream_player_3d.pitch_scale = randf_range(.8, 1.2)
	audio_stream_player_3d.play()


func _process(delta: float) -> void:
	if timer.wait_time < .9:
		deactivate_light()


func deactivate_light() -> void:
	omni_light_3d.light_energy = 0


func _on_timer_timeout() -> void:
	queue_free()
