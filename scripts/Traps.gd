extends Area2D

@export var jumpDirection = Vector2() 
@export var idlePoint1 = Marker2D
@export var idlePoint2 = Marker2D
var idlePointDef : Array[Marker2D] = []
var index : int = 0
var move_direction: float 
var flip: bool = false
@export var moveSpeed : float
@export var distance: float = 0.5
@export var duration : float
@onready var idleTimer = $idleTimer
@onready var anim = $AnimatedSprite2D
 

# Called when the node enters the scene tree for the first time.
func _ready():
	idleTimer.set_wait_time(duration)
	idlePointDef.append(idlePoint1)
	idlePointDef.append(idlePoint2)
	
	
	

func _physics_process(delta):
	
	#print(idleTimer.time_left)
	#print(position.distance_to(idlePoint1.position))
	if idleTimer.get_time_left() <=  0:
		$AnimatedSprite2D.play("on")
		#print(position.distance_to(idlePoint1.position))
		position = position.move_toward(idlePointDef[index].position,delta * moveSpeed)
		if  position.distance_to(idlePointDef[index].position) < distance:
				flip_sprite()
				index += 1
				if(index > idlePointDef.size()-1):
					index = 0
				idleTimer.set_wait_time(duration)			
				idleTimer.start()				
	else:
		$AnimatedSprite2D.play("idle")
		
		


func flip_sprite():
	flip = !flip	
	anim.flip_h = flip



func _process(delta):
	pass


func _on_body_entered(body):
	body.set_canMove()
	body.PlayerDamaged()
	print(body)
	if body.getDirection() == 1:
		body.jump(Vector2(jumpDirection.x * 1 ,jumpDirection.y))
	elif body.getDirection() == -1:
		body.jump(Vector2(jumpDirection.x * -1 ,jumpDirection.y))
	elif body.getDirection() == 0:
		if body.getPlayerFacingDirection():
			body.jump(Vector2(jumpDirection.x * -1 ,jumpDirection.y))
		else:
			body.jump(Vector2(jumpDirection.x * 1 ,jumpDirection.y))
	



