extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = 400.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_VELOCITY
		
	turn()
	update_animation()
	move_and_slide()

func turn():
	if velocity.x < 0:
		animation.flip_h = true
	elif velocity.x > 0:
		animation.flip_h = false
	
func update_animation():
	if is_on_wall_only():
		animation.animation = "wall_jump"
	elif not is_on_floor():
		if velocity.y > 0:
			animation.animation = "fall"
		elif velocity.y < 0:
			animation.animation = "jump"
	elif is_on_floor():
		if velocity.x != 0:
			animation.animation = "run"
		elif velocity.x == 0:
			animation.animation = "idle"
		
