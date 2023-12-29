extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tutorial_screen_game_started():
	get_tree().paused = false
