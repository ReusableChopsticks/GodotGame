extends CharacterBody2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@export var player_stats: Resource
const SPEED = 30

var path_loaded = false
var target_reached = false



func _ready():
	call_deferred("update_path")
	#print("getting ready")
	#NavigationServer2D.map_changed.connect(_on_map_is_ready)
	#nav_agent.get_navigation_map()
	#nav_agent.target_position = player_stats.player_pos

func _physics_process(delta):
	#print(path_loaded)
	# when path is loaded and target is not reached yet, move the pigeon
	#nav_agent.target_position = player_stats.player_pos
	#print(target_reached)
	if (path_loaded and !target_reached):
	#if true:
		if (nav_agent.is_connected("path_changed", _on_navigation_agent_2d_path_changed)):
			nav_agent.disconnect("path_changed", _on_navigation_agent_2d_path_changed)
		var target = update_path()
		velocity = target * SPEED

		move_and_slide()


func update_path():
	nav_agent.target_position = player_stats.player_pos
	return to_local(nav_agent.get_next_path_position()).normalized()


func _on_navigation_agent_2d_navigation_finished():
	target_reached = true


func _on_navigation_agent_2d_path_changed():
	print("PLEASE" + str(Time.get_ticks_msec()))
	path_loaded = true
