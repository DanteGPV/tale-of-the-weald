extends eState

##State Dictionary
@export var PURSUE_STATE : State

func _enter():
	super()
	parent.velocity = Vector3.ZERO

func process_physics(delta) -> pState:
	parent.velocity.y -= GRAVITY*delta
	parent.move_and_slide()
	return null


func _on_scan_sphere_area_entered(area):
	if area is PlayerHitboxComponent:
		parent.state_machine.change_state(PURSUE_STATE)
	return self
