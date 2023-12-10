extends Area2D

class_name GroundItem

signal ground_item_entered

func _on_body_entered(_body: Node2D) -> void:
	SignalBus.player_crashed.emit(self)
