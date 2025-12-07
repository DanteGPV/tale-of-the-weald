extends Label

@export var PARENT : Node
var currentState : pState


func _process(_delta):
	currentState = PARENT.stateMachine.currentState
	currentState = PARENT.stateMachine.currentState
	text = "current state: %s" %currentState
