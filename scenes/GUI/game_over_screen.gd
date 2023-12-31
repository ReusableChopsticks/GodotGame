extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	GlobalSignals.game_over.connect(on_game_over)

func on_game_over():
	visible = true

