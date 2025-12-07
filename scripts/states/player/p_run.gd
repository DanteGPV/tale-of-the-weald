extends pState

##Diccionario de estados
@export var IDLE_STATE : pState
@export var FALL_STATE: pState

##Referencia al SpringArm3D
@export var spring_arm : SpringArm3D

func _enter():
	super()

func process_physics(delta) -> pState:
	
	parent.velocity.y -= GRAVITY*delta ##Gravedad
	
	input_move(delta, spring_arm)
	
	if !parent.is_on_floor():
		return FALL_STATE
	
	if !Input.is_anything_pressed():
		parent.velocity = Vector3(move_toward(parent.velocity.x,0,SLIDE),parent.velocity.y,move_toward(parent.velocity.z,0,SLIDE))
	parent.move_and_slide()
	if parent.velocity == Vector3(0,0,0) and !Input.is_anything_pressed():
		return IDLE_STATE
	if (parent.velocity.x < 1 && parent.velocity.x > -1) && (parent.velocity.z < 1 && parent.velocity.z > -1):
		parent.animations.play("idle")
	else:
		parent.animations.play("run")
	return null

func process_frame(_delta):
	flip_sprite()

func process_input(_event):
	if Input.is_action_just_pressed("jump"):
		parent.velocity.y = JUMP_SPEED
		return FALL_STATE
