extends CharacterBody3D

#How fast the player moves in m/s
@export var speed = 5
#The downward acceleration when in the air, m/s^2.
@export var fall_acceleration = 2
#How many hits before you get downed
@export var health=10

#Different parts of the scene, including the player's body, the camera, and the opponent
@onready var camorigin=$CamYaw
@onready var pivot=$Pivot
@onready var opp=$"../Opp"

func _ready():
	#Capture mouse and rotate player and opponent towards eachother
	pivot.basis=Basis.looking_at(position.direction_to(opp.position))
	opp.basis=Basis.looking_at(opp.position.direction_to(position))
	camorigin.basis=Basis.looking_at(position.direction_to(opp.position))
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		

func _physics_process(_delta):
	#If mouse is captured
	if 1: #Input.mouse_mode != Input.MOUSE_MODE_VISIBLE:
		#Assigned moves to axes
		var input_dir = Input.get_vector("move_left","move_right","move_forward","move_back")
		#Adjust movement direction based on camera direction
		var direction = (camorigin.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		#Rotate to face forward and move
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		#Slow to a stop
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
		
	#If in the air, fall towards the floor. Literally gravity
	if not is_on_floor(): 
		velocity.y -= fall_acceleration
	#Execute movement
	pivot.basis=Basis.looking_at(position.direction_to(opp.position))
	camorigin.basis=Basis.looking_at(position.direction_to(opp.position))
	opp.basis=Basis.looking_at(opp.position.direction_to(position))
	move_and_slide()
	if is_on_wall():
		move_and_collide(get_wall_normal())
		
		
