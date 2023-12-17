extends Resource
class_name PlayerStats


@export var player_pos: Vector2
# I wrote a proposed health/scoring system linked to how much lunch you have
# in the design doc. These values follow that
const start_lunch_value: int = 100
# actual amount of lunch eaten by player
var lunch_eaten: int
# the amount of lunch player currently has left
var lunch_remaining: int:
	set(value):
		GlobalSignals.stats_updated.emit()
		if value <= 0:
			GlobalSignals.lunch_finished.emit()
		lunch_remaining = value
