extends Label

@export var PARENT : Player
@onready var healthComponent : HealthComponent 

func _process(_delta):
	text = "%s" %PARENT.healthComponent.health + "/%s" %PARENT.healthComponent.MAX_HEALTH 
