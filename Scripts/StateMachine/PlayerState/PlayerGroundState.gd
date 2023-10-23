extends IState
class_name PlayerGroundState

@export var air_state: IState

func input(event: InputEvent):
	if(event.is_action_pressed("dash")):
		character.dash()
	if(event.is_action_pressed("jump")):
		character.jump()
	
func update(delta):
	if not character.is_on_floor():
		next_state = air_state
		
	if character.velocity.x != 0:
		character.animation.animation = "Run"
	elif character.velocity.x == 0:
		character.animation.animation = "Idle"
		
	pass
	
func on_enter():
	print("ground")
	character.animation.animation = "Idle"
	pass
	
func on_exit():
	pass
