extends KinematicBody2D
var current_speed = Vector2()
var UP = Vector2(0,-1)
export var max_speed = 1000
export var gravity = 25
export var jump = 900
export var ground_friction = .3
export var air_friction = .4
export var accel = 300
var direction = 0
var arm_length

func _ready():
	arm_length = $Arms.get_arm_length()

func _physics_process(delta):
	if !$Arms.grabbed:
		move()
		throw()
	else:
		swing()

func swing():
	var grab_point = $Arms.get_grab_point()
	print(grab_point)
	var arm_vector = grab_point - global_position
	current_speed = (arm_vector.tangent()*Vector2(-1,-1)).normalized()*Vector2(current_speed.x, current_speed.x)
	move_and_slide(current_speed, UP)

func throw():
	if Input.is_action_pressed('throw'):
		$Arms.throw(direction)

func move():
	var friction = false
	
	current_speed = move_and_slide(current_speed, UP)
	
	if Input.is_action_pressed('right'):
		current_speed.x = min(current_speed.x + accel, max_speed)
		direction = 1
	elif Input.is_action_pressed('left'):
		current_speed.x = max(current_speed.x - accel, -max_speed)
		direction = -1
	else:
		friction = true
	
	if is_on_floor():
		if Input.is_action_pressed('jump'):
			current_speed.y -= jump
		if friction:
			current_speed.x = lerp(current_speed.x, 0, ground_friction)
	else:
		current_speed.x = lerp(current_speed.x, 0, air_friction)
		current_speed.y += gravity