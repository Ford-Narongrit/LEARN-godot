extends Node
class_name CharacterStateMachine

@export var current_state: IState
@export var character: ICharacter
var states: Array[IState]

func _ready():
	for child in get_children():
		if(child is IState):
			states.append(child)
			# setup states
			child.character = character
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine.")

func _physics_process(delta):
	if(current_state.next_state != null):
		change_state(current_state.next_state)
	current_state.update(delta)
	
func _input(event: InputEvent):
	current_state.input(event)

func change_state(new_state: IState):
	if(current_state != null):
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	current_state.on_enter()

