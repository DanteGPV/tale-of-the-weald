extends State
class_name pState ##p(layer)State


##Variables Exportadas

@export var ANIMATION_NAME : String
@export var MOVE_SPEED : float = 15
@export var SLIDE : float = 4
@export var JUMP_SPEED : float = 30
@export var GRAVITY : int = 50

##Referencias a objetos usados
var parent : Player

func _enter():
	parent.animations.play(ANIMATION_NAME)

func input_move(delta):
	var input = Input.get_vector("moveleft","moveright","moveforward","moveback")
	var direction = Vector3(input.x,0,input.y).rotated(Vector3.UP, parent.springPivot.rotation.y)
	parent.velocity = lerp(parent.velocity, direction * MOVE_SPEED, SLIDE * delta)

func flip_sprite():
	if Input.is_action_just_pressed("moveleft") or Input.is_action_pressed("moveleft"):
		parent.animations.flip_h = true
	if Input.is_action_just_pressed("moveright") or Input.is_action_pressed("moveright"):
		parent.animations.flip_h = false
