extends Label

@export var PARENT : Node
var springLength : float

func _process(_delta):
	springLength = PARENT.springArm.spring_length
	text = "spring length: %s" %springLength
