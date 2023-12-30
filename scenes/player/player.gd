extends CharacterBody2D
signal hit
signal eat(is_moving:bool)
signal throw(player_pos, throw_pos)
signal camera_out(is_camera_out:bool)
signal camera_taking

var dir_facing
var screen_size
var is_camera_out
var throw_distance
var is_invincible: bool = false
@onready var i_frames_timer: Timer = $InvincibilityTimer

@export var base_speed: int = 100
@export var moving = false
@export var starting_throw_distance = 5
@export var throw_grow_distance = 5
@export var player_stats: Resource
@export var enemies: Node

var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	throw_distance = starting_throw_distance
	is_camera_out = false
	speed = base_speed
	player_stats.player_pos = position
	dir_facing = Vector2.DOWN
	
	GlobalSignals.player_hit.connect(on_player_hit)
	
	# Dummy eat setup
	GlobalSignals.stats_updated.connect(on_stats_updated)
	#$LunchProgressBar.value = player_stats.lunch_remaining
	$EatProgressBar.value = 0
	player_stats.lunch_remaining = 100
	GlobalSignals.stats_updated.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	#var velocity = Vector2.ZERO
	#if Input.is_action_pressed("move_up"):
		#velocity.y -= 1
	#if Input.is_action_pressed("move_down"):
		#velocity.y += 1
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
		#
	if direction.length() > 0:
		#velocity = velocity.normalized() * speed
		dir_facing = direction
		moving = true
	else:
		moving = false
	#position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
		
	
	if Input.is_action_pressed("throw"):
		throw_distance += throw_grow_distance
	if Input.is_action_just_released("throw"):
		var throw_pos = global_position + (dir_facing * throw_distance)
		throw.emit(global_position, throw_pos)
		throw_distance = starting_throw_distance
	
	if Input.is_action_just_pressed("eat"):
		#TODO: this is a dummy implementation
		# JULIUS replace this with your minigame
		#eat.emit(moving)
		pass
	if Input.is_action_pressed("eat"):
		var hold_time = 2
		var eat_value = 10
		velocity = Vector2.ZERO
		# keep track of hold time
		$EatProgressBar.value += delta * (100/hold_time)
		if $EatProgressBar.value >= 100:
			$EatProgressBar.value = 0
			# only eat if you still have lunch
			if player_stats.lunch_remaining > 0:
				# make sure 
				var eaten = min(player_stats.lunch_remaining, eat_value)
				player_stats.lunch_remaining -= eaten
				player_stats.lunch_eaten += eaten
	if Input.is_action_just_released("eat"):
		$EatProgressBar.value = 0
	
	if Input.is_action_just_pressed("ready_camera"):
		is_camera_out = !is_camera_out
		camera_out.emit(is_camera_out)
	if Input.is_action_pressed("take_photo"):
		if is_camera_out:
			camera_taking.emit()

	
	var collision = move_and_slide()
	# Set the player pos in stats resource to be accessed by other nodes
	player_stats.player_facing = dir_facing
	player_stats.player_pos = position


func on_player_hit(body):
	if not is_invincible:
		print("ouch!!! hit by " + body.name)
		player_stats.lunch_remaining -= 5
		$EatProgressBar.value = 0
		i_frames_timer.start()

func on_stats_updated():
	$LunchProgressBar.value = player_stats.lunch_remaining

func _on_body_entered(_body):
	#hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func _on_lunch_eating_speed_percentage(percent):
	speed = base_speed * percent/100


func _on_invincibility_timer_timeout():
	is_invincible = false
