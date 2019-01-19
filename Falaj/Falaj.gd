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
	var grab_point = $Arms.get_grab_point()
	var arm_vector = (grab_point - global_position)
	
	if initial_swing == true:
		grab_length = arm_vector.length()
		initial_swing = false

	var tangent_vector = arm_vector.tangent().normalized()

	if current_speed.x >= 0:
		tangent_vector*=Vector2(-1,-1)
	var height = global_position.y - grab_point.y
	if round(height) == 0:
		current_speed = tangent_vector*-100
	else:
		current_speed = (tangent_vector*height)*6
	
	#Adjust speed to land on tangent line
	var next_position = global_position + delta*current_speed
	var next_radius = (next_position - grab_point).clamped(grab_length)
	var adjusted_speed = -1*arm_vector - next_radius
	
	current_speed = -1*adjusted_speed/delta
	move_and_slide(current_speed, UP)

	if Input.is_action_just_released("throw"):
		$Arms.set_grabbed(false)
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