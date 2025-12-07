extends eState

##States Dictionary
@export var PURSUIT_STATE : eState

func _enter():
	parent.velocity = Vector3.ZERO
	await parent.summon_attack(PURSUIT_STATE)



func process_physics(delta) -> pState:
	parent.velocity.y -= GRAVITY*delta
	parent.move_and_slide()
	return null
