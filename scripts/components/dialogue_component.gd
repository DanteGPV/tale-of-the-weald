extends Node3D

class_name DialogueComponent

@export var RANGE : float
@export var CHARACTER_ID : String
@export var DIALOGUE_START_ID : String
@onready var enterDialogueRange = $EnterDialogueRange/CollisionShape3D

var playerIsInDialogueRange : bool = false

func _ready():
	enterDialogueRange.shape.radius = RANGE

func _input(event):
	if Input.is_action_just_pressed("jump") and playerIsInDialogueRange:
		find_and_play_dialogue()

func _on_enter_dialogue_range_body_entered(body):
	if body is Player:
		playerIsInDialogueRange = true
	return

func _on_enter_dialogue_range_body_exited(body):
	if body is Player:
		playerIsInDialogueRange = false
	return

func find_and_play_dialogue():
	var dialogue = get_node_or_null("Dialogue")
	
	if dialogue and !dialogue.isDialogueActive:
		dialogue.play_from(DIALOGUE_START_ID)
