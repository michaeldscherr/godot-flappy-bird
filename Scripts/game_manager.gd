extends Node

@onready var bird: Bird = $"../Bird" as Bird
@onready var ground: Ground = $"../Ground" as Ground
@onready var pipe_spawner: PipeSpawner = $"../PipeSpawner" as PipeSpawner
@onready var fade: Fade = $"../Fade" as Fade
@onready var ui: CanvasLayer = $"../UI" as UI

func _ready() -> void:
	SignalBus.game_started.connect(_on_game_started)
	SignalBus.player_crashed.connect(_on_game_ended)
	SignalBus.point_scored.connect(_on_point_scored)

func _on_game_started() -> void:
	ground.start()
	pipe_spawner.start()

func _on_game_ended(body_collided_with: Node2D) -> void:
	if (fade != null):
		fade.play()
	
	ground.stop()
	pipe_spawner.stop()
	
	var should_player_fall: bool = body_collided_with.is_in_group(
		"on_crash_should_fall_through"
	)
	
	bird.stop(should_player_fall)
	
	ui.on_game_over()

func _on_point_scored() -> void:
	PlayerVariables.add_point_to_score()
	
	ui.update_score(PlayerVariables.points)
