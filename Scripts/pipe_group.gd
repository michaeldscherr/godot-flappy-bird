extends Node2D

class_name PipeGroup

var speed: float = 0.0
	
func _process(delta: float) -> void:
	position.x += speed * delta
	
func _on_scoring_area_body_entered(_body: Node2D) -> void:
	SignalBus.point_scored.emit()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func set_speed(new_speed: float) -> void:
	speed = new_speed
	
func stop() -> void:
	speed = 0;
