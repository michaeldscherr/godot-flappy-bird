extends CanvasLayer 

class_name UI

@onready var game_over_box: VBoxContainer = $MarginContainer/GameOverBox
@onready var points_label: Label = $MarginContainer/PointsLabel

func _ready() -> void:
	points_label.text = "%d" % 0
	
func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func update_score(points: int):
	points_label.text = '%d' % points
	
func on_game_over() -> void:
	game_over_box.visible = true
