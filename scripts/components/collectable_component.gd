extends Node
class_name CollectableComponent

@export var PARENT : Node3D

var collectables = [0,0]
var collectableDict = {"Primitive" : 0, "Spore" : 1}

func add_collectable_amount(collectable,collectableAmount):
	var collectablePos = collectableDict[collectable]
	collectables[collectablePos] += collectableAmount
