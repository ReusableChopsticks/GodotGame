extends Area2D

@export var damage_rate: float = 0.5

func _ready():
	$DamageRateTimer.wait_time = damage_rate

func _on_body_entered(body):
	if body.name == "Player":
		GlobalSignals.player_hit.emit(get_parent())


func _on_damage_rate_timer_timeout():
	for node in get_overlapping_bodies():
		if node.name == "Player":
			GlobalSignals.player_hit.emit(get_parent())
			break
