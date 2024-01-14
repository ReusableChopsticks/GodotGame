extends Area2D

@export var damage_rate: float = 0.5
func _ready():
	$DamageRateTimer.wait_time = damage_rate

func _on_area_entered(area):
	deal_damage(area)


func _on_damage_rate_timer_timeout():
	for node in get_overlapping_bodies():
		deal_damage(node)

func deal_damage(body):
	if body.name == "Player":
		GlobalSignals.player_hit.emit(get_parent())
	if body.is_in_group("crumbs"):
		GlobalSignals.crumb_hit.emit(body)


func _on_body_entered(_body):
	pass # Replace with function body.
