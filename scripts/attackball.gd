extends Attack
class_name EnemyAttack

func _on_area_3d_area_entered(area):
	if area.PARENT is Player:
		area.damage(self)
