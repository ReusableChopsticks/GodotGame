extends Node2D

@export var stats: PlayerStats
var game_over = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# show all default values for UI
	GlobalSignals.stats_updated.emit()
	GlobalSignals.game_over.connect(on_game_over)


func _process(delta):
	if not game_over:
		stats.total_time += delta

func on_game_over(_cause):
	game_over = true

func _on_tutorial_screen_game_started():
	print("game started")
