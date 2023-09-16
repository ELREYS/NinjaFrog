extends  Node2D

@export var jumpDirection = Vector2() 


func _on_area_2d_body_entered(body):
	body.set_canMove()
	body.PlayerDamaged()
	print(body.name)
	##If moves its negative value swap
	if body.getPlayerFacingDirection():
		body.jump(Vector2(jumpDirection.x * 1 ,jumpDirection.y))
	else:
		body.jump(Vector2(jumpDirection.x * -1 ,jumpDirection.y))
