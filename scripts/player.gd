extends CharacterBody2D
class_name  Player
@export var gravity = 400
@export var move_speed = 125
@export var jump_force = 200
var direction
var playerDamaged = false
var canMove: bool = true

var knockback = Vector2.ZERO


@onready var canMoveTime = $canMoveTimer
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta 
			
	##Wait before move and Damaged	
	if canMoveTime.get_time_left() <= 0:
		canMove = true
		playerDamaged = false
		velocity.x  =  getDirection() * move_speed
	
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	if Input.is_action_just_pressed("jump"): #&& is_on_floor():
		jump(Vector2(position.x,-jump_force))
		
	
	
	move_and_slide()
	update_animation(direction)
	
func update_animation(direction):
	
	if is_on_floor():
		if playerDamaged:
			animated_sprite.play("hit")
		if direction == 0:
			animated_sprite.play("idle")
		else: 
			animated_sprite.play("run")	
	
	else:
		if playerDamaged:
			animated_sprite.play("hit") 
		else:	
			if velocity.y < 0:
				animated_sprite.play("jump")
			else:
				animated_sprite.play("fall")
	
	
func set_canMove():
	canMove = !canMove
	canMoveTime.start()
	
func jump(direction:Vector2):
	velocity = direction

func PlayerDamaged():
	playerDamaged = true
	
func getPlayerFacingDirection():
	return animated_sprite.is_flipped_h()
func getDirection():
	direction = Input.get_axis("left","right")
	return direction
	
		


