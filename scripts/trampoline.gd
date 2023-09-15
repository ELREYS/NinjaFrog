extends Area2D

@export var jumpForce = 0
@onready var anim = $AnimatedSprite2D





func _on_body_entered(body):
	if body is Player:
		anim.play("Jump")
		body.velocity.y = 0
		body.jump(jumpForce)
	
	
