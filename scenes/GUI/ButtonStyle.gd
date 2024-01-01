extends TextureButton

@export var col_fade_time: float = 0.2

func _on_mouse_entered():
	get_tree().create_tween().tween_property($".", "modulate", Color.ORANGE_RED, col_fade_time).set_trans(Tween.TRANS_CUBIC)
	

func _on_mouse_exited():
	get_tree().create_tween().tween_property($".", "modulate", Color.WHITE_SMOKE, col_fade_time).set_trans(Tween.TRANS_CUBIC)


func _on_button_up():
	get_tree().change_scene_to_file("res://scenes/GUI/main_menu.tscn")
