extends Node
class_name StateMachine

@export var INITIAL_STATE : State
var currentState : State

func init(parent : CharacterBody3D):
	for child in get_children():
		child.parent = parent
	change_state(INITIAL_STATE)

func change_state(newState : State):
	if currentState:
		currentState._exit()
	currentState = newState
	currentState._enter()

func process_physics(delta):
	var newState = currentState.process_physics(delta)
	if newState:
		change_state(newState)

func process_input(event):  ##This is only used for player States. Maybe it'd be convenient to make a generic stateMachine class that doesn't include it? And make children classes that include these functions.
	var newState = currentState.process_input(event)
	if newState:
		change_state(newState)


func process_frame(delta):
	var newState = currentState.process_frame(delta)
	if newState:
		change_state(newState)
