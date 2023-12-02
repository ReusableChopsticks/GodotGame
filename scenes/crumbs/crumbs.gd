extends Area2D

var throw_time
var velocity
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(throw_time).timeout
	velocity = Vector2.ZERO
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
