extends Node
class_name GenericCollectable

@export var PARENT : StaticBody3D
@export var COLLECTABLE_NAME : String = "Primitive"
@export var ANIMATIONS : AnimatedSprite3D


func _on_collection_component_area_entered(area):
	if area is PlayerHitboxComponent:
		var hitbox : PlayerHitboxComponent = area
		if area.PARENT is Player:
			hitbox.COLLECTABLE_COMPONENT.add_collectable_amount(COLLECTABLE_NAME,1)
			PARENT.queue_free()
