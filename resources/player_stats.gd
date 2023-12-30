extends Resource
class_name PlayerStats


@export var player_pos: Vector2
@export var player_facing: Vector2
# I wrote a proposed health/scoring system linked to how much lunch you have
# in the design doc. These values follow that
const start_lunch_value: int = 100
# actual amount of lunch eaten by player
var lunch_eaten: int:
	set(value):
		lunch_eaten = value
		GlobalSignals.stats_updated.emit()
# the amount of lunch player currently has left
var lunch_remaining: int:
	set(value):
		if value <= 0:
			GlobalSignals.game_over.emit()
			
		lunch_remaining = value
		GlobalSignals.stats_updated.emit()
