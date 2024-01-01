extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	#visible = false
	GlobalSignals.game_over.connect(on_game_over)
	$VBoxContainer/HBoxContainer/RestartButton.grab_focus()

func on_game_over(cause):
	visible = true

