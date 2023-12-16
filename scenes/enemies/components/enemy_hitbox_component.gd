extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		GlobalSignals.player_hit.emit(get_parent())
