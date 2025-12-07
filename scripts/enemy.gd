extends CharacterBody3D

@onready var animations = $AnimatedSprite3D
@onready var state_machine = $StateMachine
@onready var healthComponent = $HealthComponent
@onready var nav_agent = $NavigationAgent3D 
@onready var attack_range = $AttackRange
@export var DEATH_STATE : State

var attack_target : HitboxComponent
var attack_timer = 0.5
@onready var cooldown_timer = $CooldownTimer
@onready var attack = $Attack
var attackBall = preload("res://scenes/attack_ball.tscn")


var player = null
@export var PLAYER_PATH : NodePath



func _ready():
	player = get_node(PLAYER_PATH) 
	state_machine.init(self)

func _unhandled_key_input(event):
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func die():
	state_machine.change_state(DEATH_STATE)

func summon_attack(state : eState):
	await get_tree().create_timer(attack_timer).timeout
	var attackBallInstance = attackBall.instantiate()
	add_child(attackBallInstance)
	attackBallInstance.global_position = attack_range.global_position
	await get_tree().create_timer(1).timeout
	attackBallInstance.queue_free()
	cooldown_timer.start()
	state_machine.change_state(state)
