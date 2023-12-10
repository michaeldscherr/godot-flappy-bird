extends Node2D

class_name Ground


@onready var ground_item_1: Sprite2D = $GroundItem1/Sprite2D
@onready var ground_item_2: Sprite2D = $GroundItem2/Sprite2D

var speed: float = -Global.environment_speed
var should_move: bool = false

func _ready() -> void:
	ground_item_2.global_position.x = ground_item_1.global_position.x + ground_item_1.texture.get_width()
	
func _process(delta: float) -> void:
	if !should_move:
		return
	
	ground_item_1.global_position.x += speed * delta
	ground_item_2.global_position.x += speed * delta
	
	if ground_item_1.global_position.x < -ground_item_1.texture.get_width():
		ground_item_1.global_position.x = ground_item_2.global_position.x + ground_item_2.texture.get_width()
	
	if ground_item_2.global_position.x < -ground_item_2.texture.get_width():
		ground_item_2.global_position.x = ground_item_1.global_position.x + ground_item_1.texture.get_width()
		
func start() -> void:
	should_move = true

func stop() -> void:
	speed = 0
