extends CharacterBody2D
class_name ICharacter

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_direction = Vector2(1,0)
@export var resource: RCharacter
@export var animation = AnimatedSprite2D

func _physics_process(delta):
	turn()
	move_and_slide()

func turn():
	if velocity.x < 0:
		animation.flip_h = true
		facing_direction = Vector2(-1,0)
	elif velocity.x > 0:
		animation.flip_h = false
		facing_direction = Vector2(1,0)
