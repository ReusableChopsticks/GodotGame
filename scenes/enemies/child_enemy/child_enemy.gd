extends CharacterBody2D

@export var speed: int = 200

func _ready():
	# choose random starting direction
	var angle = randf_range(0, 2 * PI)
	velocity = Vector2(sin(angle), cos(angle)).normalized()


func _physics_process(delta):
	move_and_collide(speed * velocity * delta)


func _on_area_2d_body_entered(body):
	print(str(body.name) + " entered child enemy")
