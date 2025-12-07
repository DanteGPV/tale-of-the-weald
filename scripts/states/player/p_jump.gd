extends pState

##Diccionario de estados
@export var IDLE_STATE : pState
@export var RUN_STATE : pState

##Referencia a SpringArm3D
@export var spring_arm : SpringArm3D

func _enter():
	super()

func process_physics(delta):
	parent.velocity.y -= GRAVITY *0.75 * delta
	
	if !Input.is_action_pressed("jump"):
		parent.velocity.y -= GRAVITY * delta
	if parent.velocity.y <= 0:
		parent.animations.play("fall")
		parent.velocity.y -= GRAVITY *2 * delta
	
	input_move(delta, spring_arm)
	
	parent.move_and_slide()
	
	if parent.is_on_floor():
		if parent.velocity != Vector3(0,parent.velocity.y,0):
			return RUN_STATE
		else:
			return IDLE_STATE
	return null

func process_frame(_delta):
	flip_sprite()
