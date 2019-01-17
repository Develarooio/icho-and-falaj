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
var max_arm_length
var initial_h_speed = null
var initial_swing = true
var grab_length = null

func _ready():
	max_arm_length = $Arms.get_max_arm_length()

func _physics_process(delta):
	if !$Arms.grabbed:
		move()
		throw()
	else:
		swing(delta)

func swing(delta):
	#vf = (2gh)½ 
	var grab_point = $Arms.get_grab_point()
	var arm_vector = (grab_point - global_position)
	if initial_swing == true:
		grab_length = arm_vector.length()
		initial_swing = false
	if grab_length != null and grab_length != arm_vector.length():
		position += arm_vector - arm_vector.clamped(grab_length)
	var tangent_vector = arm_vector.tangent().normalized()
	#doesn't work if you go higher then the point.....
	if current_speed.x >= 0:
		tangent_vector*=Vector2(-1,-1)
	var height = global_position.y - grab_point.y
	if round(height) == 0:
		current_speed = tangent_vector*-100
	else:
		current_speed = (tangent_vector*height)*6
	#Adjust speed to land on tangent line
	#current_speed = current_speed.rotated((current_speed - arm_vector).angle_to(current_speed))
	#current_speed += (current_speed - arm_vector).normalized()
	var next_position = global_position + delta*current_speed
	var radius = (next_position - grab_point).clamped(grab_length)
	var adjusted_speed = radius - arm_vector
	
	var r = global_position - grab_point
	#var next_position = r + current_speed
	var theta = (global_position - grab_point).angle_to(next_position)
	var testy = atan(current_speed.length()/r.length())
	var r_prime = arm_vector.rotated(-1*testy)
	var v_prime = current_speed - r_prime
	var alpha = current_speed.angle_to(v_prime)
	#current_speed = current_speed.rotated(alpha)
	move_and_slide(current_speed, UP)
	#current_speed = adjusted_point
	#current_speed = tangent_vector*500
	#current_speed += arm_vector
	#Testing new approach
	#var normalized_gravity = Vector2(0,gravity).normalized()
	#var gravity_contribution = tangent_vector.normalized().dot(normalized_gravity)
	#Ok so every frame by Vx isn't right I don't think
	#if initial_swing == true:
	#	current_speed = tangent_vector*current_speed.x
	#	initial_swing = false
	#else:
	#current_speed = tangent_vector*current_speed.length()
	#current_speed += tangent_vector*gravity_contribution*36

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