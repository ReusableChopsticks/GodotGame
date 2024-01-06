extends Area2D
@export var player_stats: Resource
var in_picture = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(player_stats.player_facing + player_stats.player_pos)
	


func _on_player_camera_out(is_camera_out):
	set_visible(is_camera_out)
	#set_visible(!visible)


func _on_player_camera_taking():
	for enemy in in_picture:
		print(enemy.get_parent().name)
	print(in_picture.size())
	pass # Replace with function body.


func _on_area_entered(area):
	if area.name != "DetectArea":
		in_picture.append(area)
	pass # Replace with function body.


func _on_area_exited(area):
	in_picture.erase(area)
	pass # Replace with function body.
