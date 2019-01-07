extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if !$AnimationPlayer.is_playing():
		visible = false
	else:
		visible = true

func throw(direction):
	if direction == -1:
		$AnimationPlayer.play('arms_throw_left')
	else:
		$AnimationPlayer.play('arms_throw_right')

func _on_GrabArea_body_entered(body):
	if body.is_in_group('grabable'):
		pass
