extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# show all default values for UI
	GlobalSignals.stats_updated.emit()


func _process(delta):
	pass


func _on_tutorial_screen_game_started():
	print("game started")
