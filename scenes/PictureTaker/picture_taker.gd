extends Area2D
@export var player_stats: Resource

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	look_at(player_stats.player_facing + player_stats.player_pos)
	


func _on_player_camera_out(is_camera_out):
	set_visible(!visible)
	pass # Replace with function body.


func _on_player_camera_taking():
	pass # Replace with function body.
