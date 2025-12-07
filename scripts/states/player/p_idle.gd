extends pState

##Diccionario de estados
@export var FALL_STATE : pState
@export var RUN_STATE : pState

func _enter():
	super()
	parent.velocity.x = 0
	parent.velocity.y = 0

func process_physics(delta) -> pState:
	parent.velocity.y -= GRAVITY*delta
	parent.move_and_slide()
	if !parent.is_on_floor():
		return FALL_STATE
	return null

func process_input(_event) -> pState:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		parent.velocity.y = JUMP_SPEED
		return FALL_STATE
	if Input.is_action_just_pressed("moveforward") or Input.is_action_just_pressed("moveback") or Input.is_action_just_pressed("moveleft") or Input.is_action_just_pressed("moveright"):
		return RUN_STATE
	return null
