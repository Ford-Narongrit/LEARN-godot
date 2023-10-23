extends IState
class_name PlayerJumpState

@export var ground_state: IState

func input(event: InputEvent):
	if(event.is_action_pressed("dash")):
		character.dash()
	if(event.is_action_pressed("jump")):
		character.air_jump()
	pass
	
func update(delta):
	if not character.is_on_floor():
		character.velocity.y += character.resource.AIR_FALL_SPEED * delta
		if character.velocity.y > 0:
			character.animation.animation = "Fall"
		elif character.velocity.y < 0:
			character.animation.animation = "Jump"
		
	if character.is_on_floor():
		next_state = ground_state

	pass
	
func on_enter():
	print("air")
	pass
	
func on_exit():
	pass
