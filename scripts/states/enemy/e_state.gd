extends State
class_name eState

##Variable exportables
@export var GRAVITY : float = 50
@export var MOVE_SPEED : float
@export var ANIMATION_NAME : String
@export var SLIDE : float

var player = null
var parent : CharacterBody3D

func _enter():
	if (ANIMATION_NAME):
		parent.animations.play(ANIMATION_NAME)
