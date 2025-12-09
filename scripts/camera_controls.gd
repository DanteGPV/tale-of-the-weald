extends Node3D

@export var PLAYER : Player
@export var SENSITIVITY : float = 1000
@export var MAX_CAMERA_ZOOM : float = 15
@export var MIN_CAMERA_ZOOM : float = 5

@export_range(-90.0,0.0,0.1,"radians_as_degrees") var minVerticalAngle : float = -PI/2
@export_range(0.0,90.0,0.1,"radians_as_degrees") var maxVerticalAngle : float = PI/4

@onready var springArm = $SpringArm3D




func _unhandled_input(event : InputEvent):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / SENSITIVITY
		rotation.y = wrapf(rotation.y,0.0, TAU)
		
		rotation.x -= event.relative.y / SENSITIVITY
		rotation.x = clamp(rotation.x, minVerticalAngle,maxVerticalAngle)
	
	if event.is_action_pressed("wheel_down"):
		springArm.spring_length += 1
	if event.is_action_pressed("wheel_up"):
		springArm.spring_length -= 1
	springArm.spring_length = clamp(springArm.spring_length, MIN_CAMERA_ZOOM,MAX_CAMERA_ZOOM)
