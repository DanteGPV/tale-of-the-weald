extends Label
@export var PARENT : Player
@onready var collectableComponent : CollectableComponent

func _process(_delta):
	text = "Primitives: " + "%s" %PARENT.collectableComponent.collectables[0] + "\n" + "Spores: " + "%s" %PARENT.collectableComponent.collectables[1]
