extends Node

signal player_hit(body)
signal lunch_finished
signal stats_updated
signal game_over(GAME_OVER_CAUSE)
enum Game_Over_Cause {BY_EATING, BY_DAMAGE}
