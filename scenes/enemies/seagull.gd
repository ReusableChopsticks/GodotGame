# The seagull locks onto the player if they get too close
# Then it flies to the player's last position in a straight line
# and overshoots a little to make it look natural
# Potential problems: 
#	- what if seagull overshoots and goes out of bounds?
#		- Make it respawn somewhere else out of camera view?

extends Area2D

@export var attack_travel_time: float = 2
@export var attack_extra_distance_percentage: float = 0.5
@export var player_stats: Resource

@export var max_time_before_hop: int = 1
@export var max_hop_distance: int = 5
var hop_time: float = 0.1

# to avoid seagull continuously locking on to player
var is_attacking: bool = false

func _process(_delta):
	pass

# For a character body 2d
func _on_detect_area_body_entered(body):
	if body.name == "Player" and !is_attacking:
		#print("player detected")
		is_attacking = true
		fly_towards_player()
	else:
		# TODO: debugging for now, delete later
		#print(str(body.name) + " has entered seagull range")
		pass

# If the player is an Area2D for some reason, copy paste code above down here
func _on_detect_area_area_entered(_area):
	pass

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

# TODO: add hop animation that plays
func hop_random_direction():
	# get random distance and angle
	var hop_dist = randf() * max_hop_distance
	var angle = randf() * 2 * PI
	var target_pos = Vector2(position.x, position.y)
	target_pos.x += hop_dist * cos(angle)
	target_pos.y += hop_dist * sin(angle)
	
	# move seagull to this point
	$AnimationPlayer.play("seagull_hop")
	var tween = get_tree().create_tween()
	tween.tween_property($".", "position", target_pos, hop_time).set_trans(Tween.TRANS_QUAD)
	
	# restart hop timer
	$HopTimer.start(randf() * max_time_before_hop)

# hop every time the timer runs out
func _on_hop_timer_timeout():
	if !is_attacking:
		hop_random_direction()
	
