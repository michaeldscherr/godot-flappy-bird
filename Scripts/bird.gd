extends CharacterBody2D

class_name Bird

@export var gravity: float = 900.0
@export var jump_force: float = 300.0
@export var rotated_speed: int = 2

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var max_speed: float = 400.0
var is_started: bool = false
var should_process_input: bool = true

func _ready() -> void:
	velocity = Vector2.ZERO 
	
	animation_player.play("idle")
	
func _physics_process(delta: float) -> void:
	if should_process_input:
		process_input()
	
	if !is_started:
		return
		
	velocity.y += gravity * delta
	
	velocity.y = min(velocity.y, max_speed)
	
	move_and_collide(velocity * delta)
	
	rotate_bird()

func process_input() -> void:
	if Input.is_action_just_pressed("jump"):
		if !is_started:
			is_started = true
			
			SignalBus.game_started.emit()
			
			animation_player.play("flap")
		
		jump()

func jump() -> void:
	velocity.y = -jump_force
	rotation = deg_to_rad(-30)

func rotate_bird() -> void:
	# rotate downwards when falling
	if velocity.y > 0 && rad_to_deg(rotation) < 90:
		rotation += rotated_speed * deg_to_rad(1)
	elif velocity.y < 0 && rad_to_deg(rotation) > -30:
		rotation -= rotated_speed * deg_to_rad(1)

func stop(should_fall = true) -> void:
	should_process_input = false
	
	animation_player.stop()
	
	if (should_fall):
		return
		
	gravity = 0
	velocity = Vector2.ZERO
