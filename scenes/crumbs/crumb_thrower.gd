extends Node2D
@export var crumb_scene: PackedScene
@export var throw_time:float = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_throw(player_pos, throw_pos):
	# Create a new instance of the Mob scene.
	var crumb = crumb_scene.instantiate()
#
	# Choose a random location on Path2D.
	#var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	#mob_spawn_location.progress_ratio = randf()
#
	## Set the mob's direction perpendicular to the path direction.
	#var direction = mob_spawn_location.rotation + PI / 2
#
	## Set the mob's position to a random location.
	crumb.position = player_pos
	crumb.throw_time = throw_time
	crumb.velocity = (throw_pos - player_pos) / throw_time
#
	## Add some randomness to the direction.
	#direction += randf_range(-PI / 4, PI / 4)
	#mob.rotation = direction
#
	## Choose the velocity for the mob.
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#mob.linear_velocity = velocity.rotated(direction)
#
	## Spawn the mob by adding it to the Main scene.
	add_child(crumb)
	pass
