extends CharacterBody2D

@export var gravity = 400
@export var move_speed = 125
@export var jump_force = 200



@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	
	if !is_on_floor():
		velocity.y += gravity * delta
		
	var direction = Input.get_axis("left","right")	
	velocity.x  =  direction * move_speed
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		
		velocity.y -= jump_force
		if velocity.y > 500:
			velocity.y = 500
	
	
	move_and_slide()
	update_animation(direction)
	
func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else: 
			animated_sprite.play("run")	
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		animated_sprite.play("jump")
	elif !is_on_floor() && velocity.y < jump_force:
		animated_sprite.play("fall")
	

func _process(delta):
	print(velocity.x)
	
		


