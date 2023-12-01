# The seagull locks onto the player if they get too close
# Then it flies to the player's last position in a straight line
# and overshoots a little to make it look natural
# Potential problems: 
#	- what if seagull overshoots and goes out of bounds?
#		- Make it respawn somewhere else out of camera view?

extends CharacterBody2D


@export var attack_travel_time: float = 2
@export var attack_extra_distance_percentage: float = 0.5
@export var player_stats: Resource

# to avoid seagull continuously locking on to player
var is_attacking: bool = false
#func _process(delta):


# Will change player to be characterbody instead so this works instead
func _on_detect_area_body_entered(body):
	pass

func _on_detect_area_area_entered(area):
	if area.name == "Player" and !is_attacking:
		print("player detected")
		is_attacking = true
		fly_towards_player()
	else:
		# TODO: debugging for now, delete later
		print(str(area.name) + " has entered seagull range")

func fly_towards_player():
	var tween = get_tree().create_tween().set_parallel(false)
	tween.connect("finished", on_attack_finished)
	# Adding this will make the seagull fly <attack_extra_distance_percentage> more past the player
	var extra_flight = ((player_stats.player_pos - position) * attack_extra_distance_percentage)
	var target_pos = player_stats.player_pos + extra_flight
	# Make seagull fly to target pos with tween
	tween.tween_property($".", "position", target_pos, attack_travel_time).set_trans(Tween.TRANS_QUAD)
	

func on_attack_finished():
	is_attacking = false
