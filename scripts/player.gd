extends CharacterBody3D
class_name Player

@onready var animations : AnimatedSprite3D = $AnimatedSprite3D
@onready var stateMachine : Node = $pStateMachine
@onready var springArm : SpringArm3D = $SpringArm3D
@onready var healthComponent : HealthComponent = $HealthComponent
@onready var collectableComponent : CollectableComponent = $CollectableComponent

@export var DEATH_STATE: pState 

func _ready():
	stateMachine.init(self)

func _unhandled_key_input(event):
	stateMachine.process_input(event)

func _physics_process(delta):
	stateMachine.process_physics(delta)
	if Input.is_action_just_pressed("camera_moveleft"):
		rotate_camera("left")
	if Input.is_action_just_pressed("camera_moveright"):
		rotate_camera("right")
	if Input.is_action_just_pressed("camera_forward"):
		camera_zoom(false)
	if Input.is_action_just_pressed("camera_back"):
		camera_zoom(true)


func _process(delta):
	stateMachine.process_frame(delta)

func die():
	stateMachine.change_state(DEATH_STATE)

##movimientos de cámara
var is_camera_moving : bool = false

func camera_zoom(direction : bool):
	var increment = -5
	if direction == true:
		increment = -increment
	var maxZoom = 5
	var minZoom = 15
	
	if (springArm.spring_length-0.5 >= maxZoom and increment < 0) or (springArm.spring_length+0.5 <= minZoom and increment > 0):
		springArm.spring_length = move_toward(springArm.spring_length, springArm.spring_length+increment,0.5)

func rotate_camera(direction : String):
	var degs : float = +45
	if direction == "right":
		degs = -45
	if !is_camera_moving:
		is_camera_moving = true
		var cameraRotationTween = create_tween()
		cameraRotationTween.set_trans(Tween.TRANS_SINE)
		cameraRotationTween.tween_property(springArm, 'rotation_degrees', Vector3(springArm.rotation_degrees.x, springArm.rotation_degrees.y -degs, springArm.rotation_degrees.z),0.5)
		await cameraRotationTween.finished
		is_camera_moving = false

func set_active(active):
	set_physics_process(active)
	set_process(active)
	set_process_input(active)
