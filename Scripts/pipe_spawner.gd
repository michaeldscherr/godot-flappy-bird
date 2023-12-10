extends Node

class_name PipeSpawner

@onready var spawn_timer: Timer = $SpawnTimer

var pipe_pair_scene: PackedScene = preload("res://Scenes/pipe_group.tscn")
var speed: float = -Global.environment_speed

func _ready() -> void:
	spawn_timer.timeout.connect(spawn_group)
	
func start():
	spawn_timer.start()
	
func spawn_group() -> void:
	var pipe_group = pipe_pair_scene.instantiate() as PipeGroup
	
	add_child(pipe_group)
	
	var viewport_rect = get_viewport().get_camera_2d().get_viewport_rect()
	
	pipe_group.position.x = viewport_rect.end.x
	
	var half_height: float = viewport_rect.size.y / 2
	
	pipe_group.position.y = randf_range(
		viewport_rect.size.y * 0.15 - half_height,
		viewport_rect.size.y * 0.65 - half_height
	)
	
	pipe_group.set_speed(speed)

func stop() -> void:
	spawn_timer.stop()
	
	get_tree().call_group("pipe_group", "stop")
