@tool

extends CharacterBody2D

@export var speed: int = 100

func _ready():
	if not Engine.is_editor_hint():
		# choose random starting direction
		var angle = randf_range(0, 2 * PI)
		velocity = Vector2(sin(angle), cos(angle)).normalized()


func _physics_process(delta):
	if not Engine.is_editor_hint():
		var collision_info = move_and_collide(speed * velocity * delta)
		if collision_info:
			velocity = velocity.bounce(collision_info.get_normal())


func _on_area_2d_body_entered(body):
	print(str(body.name) + " entered child enemy")


func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	
	if get_node("SpriteOrienter") == null:
		warnings.append("Entity requires a SpriteOrienter scene component")
	if get_node("EnemyHitboxComponent") == null:
		warnings.append("Entity requires a EnemyHitboxComponent")
	return warnings
