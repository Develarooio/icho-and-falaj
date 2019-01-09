extends Node2D

var grabbed = false

func _physics_process(delta):
	if $AnimationPlayer.is_playing():
		$Grabray.enabled = true
	else:
		$Grabray.enabled = false
	
	if $Grabray.is_colliding():
		if $Grabray.get_collider().is_in_group("grabable"):
			set_grabbed(true)
	
	if grabbed:
		$AnimationPlayer.stop()
		rotation = global_position.angle_to(get_grab_point())
		print(rotation)

func throw(direction):
	if direction == -1:
		$AnimationPlayer.play('ray_throw_left')
	else:
		$AnimationPlayer.play('ray_throw_right')

func set_grabbed(booly):
	grabbed = booly

func get_arm_length():
	return $Grabray.cast_to.y

func get_grab_point():
	if grabbed:
		return $Grabray.get_collision_point()