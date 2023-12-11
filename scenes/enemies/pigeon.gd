extends Area2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var hop_timer: Timer = $HopTimer

@export var player_stats: Resource
@export var hop_travel_speed: float = 0.2
# Min and max time between each hop
@export var min_hop_interval: float = 0.5
@export var max_hop_interval: float = 1
# Max distance of each hop in global units
@export var max_hop_distance: float = 100


var path_loaded = false
var target_reached = false

var i = 0

func _ready():
	call_deferred("get_next_pos")
	nav_agent.path_desired_distance = max_hop_distance
	hop_timer.start(randf() * max_hop_interval)

#func _physics_process(delta):
	##print(path_loaded)
	## when path is loaded and target is not reached yet, move the pigeon
	##nav_agent.target_position = player_stats.player_pos
	##print(target_reached)
	##if true:
	#if (path_loaded and !target_reached):
		#if (nav_agent.is_connected("path_changed", _on_navigation_agent_2d_path_changed)):
			#nav_agent.disconnect("path_changed", _on_navigation_agent_2d_path_changed)
		#
		#var target_pos = get_next_pos()
		#var tween = get_tree().create_tween()
		#tween.tween_property($".", "position", target_pos, hop_speed)


func get_next_pos():
	nav_agent.target_position = player_stats.player_pos
	return (nav_agent.get_next_path_position() - position).normalized() * max_hop_distance
	#return to_local(nav_agent.get_next_path_position()).normalized()


func _on_navigation_agent_2d_navigation_finished():
	target_reached = true
	print("pigeon reached player")


func _on_navigation_agent_2d_path_changed():
	path_loaded = true


func _on_timer_timeout():
	i += 1
	print(i)
	if (path_loaded):
		if (nav_agent.is_connected("path_changed", _on_navigation_agent_2d_path_changed)):
			nav_agent.disconnect("path_changed", _on_navigation_agent_2d_path_changed)
		
		var target_pos = get_next_pos()
		var tween = get_tree().create_tween()
		tween.tween_property($".", "position", target_pos, hop_travel_speed)
		
		# restart hop timer
		hop_timer.start(randf_range(min_hop_interval, max_hop_interval))
