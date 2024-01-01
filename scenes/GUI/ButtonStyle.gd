extends TextureButton

@export var col_fade_time: float = 0.1
@export var is_clickable: bool = true

func _ready():
	if not is_clickable:
		mouse_filter = Control.MOUSE_FILTER_IGNORE

func _on_button_up():
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")

func highlight():
	get_tree().create_tween().tween_property($".", "modulate", Color.ORANGE_RED, col_fade_time).set_trans(Tween.TRANS_CUBIC)
func unhighlight():
	get_tree().create_tween().tween_property($".", "modulate", Color.WHITE_SMOKE, col_fade_time).set_trans(Tween.TRANS_CUBIC)

func _on_mouse_entered():
	highlight()
	
func _on_mouse_exited():
	if not has_focus():
		unhighlight()

func _on_focus_entered():
	highlight()

func _on_focus_exited():
	unhighlight()
