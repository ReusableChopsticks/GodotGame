extends Control

@onready var animator: AnimationPlayer = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("start_screen")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
