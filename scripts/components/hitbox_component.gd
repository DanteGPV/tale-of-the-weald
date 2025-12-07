extends Area3D
class_name HitboxComponent

@export var HEALTH_COMPONENT : HealthComponent
@export var PARENT : Node3D


func damage(attack : Attack):
	if HEALTH_COMPONENT:
		HEALTH_COMPONENT.damage(attack)
	
