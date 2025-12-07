extends Node
class_name HealthComponent

@export var PARENT : Node3D

@export var MAX_HEALTH : float = 10
var health : float

func _ready():
	health = MAX_HEALTH

func damage(attack : Attack):
	health -= attack.ATTACK_DAMAGE
	if health <= 0:
		PARENT.die()
