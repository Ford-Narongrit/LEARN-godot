extends State
class_name WallState

@export var ground_state: State
@export var air_state: State
@export var wall_raycasts: Node

func input(event: InputEvent):
	pass
	
func update(delta):
	if !check_is_wall_raycasts():
		next_state = air_state
	if character.is_on_floor():
		next_state = ground_state
	
	if(character.velocity.y >= -model.max_wall_gravity):
		character.velocity.y += model.wall_gravity * delta
	
func on_enter():
	animation.animation = "wall"
	character.velocity.y = 0
	print("wall")
	pass
	
func on_exit():
	pass
	
func check_is_wall_raycasts():
	for raycast in wall_raycasts.get_children():
		if raycast.is_colliding():
				return true
	return false
