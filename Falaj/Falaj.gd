extends KinematicBody2D
var current_speed = Vector2()
var UP = Vector2(0,-1)
export var max_speed = 1000
export var gravity = 25
export var jump = 900
export var ground_friction = .3
export var air_friction = .4
export var accel = 300


func _physics_process(delta):
	move()

func move():
	var friction = false
	
	
	current_speed = move_and_slide(current_speed, UP)
	
	if Input.is_action_pressed('right'):
		current_speed.x = min(current_speed.x + accel, max_speed)
	elif Input.is_action_pressed('left'):
		current_speed.x = max(current_speed.x - accel, -max_speed)
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