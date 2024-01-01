extends Resource
class_name PlayerStats


@export var player_pos: Vector2
@export var player_facing: Vector2
# I wrote a proposed health/scoring system linked to how much lunch you have
# in the design doc. These values follow that
const start_lunch_value: int = 100
# actual amount of lunch eaten by player
# must be set before updating lunch_remaining for accurate game_over_cause value
var lunch_eaten: int:
	set(value):
		lunch_eaten = value
		game_over_cause = GlobalSignals.Game_Over_Cause.BY_EATING
		GlobalSignals.stats_updated.emit()
# the amount of lunch player currently has left
# detects game_over and emits signal
# update this after setting lunch_eaten
var lunch_remaining: int:
	set(value):
		if value <= 0:
			GlobalSignals.game_over.emit(game_over_cause)
			
		lunch_remaining = value
		game_over_cause = GlobalSignals.Game_Over_Cause.BY_DAMAGE
		GlobalSignals.stats_updated.emit()
# tracks how the last bit of lunch was finished
# play different animations based on how game ends
var game_over_cause
