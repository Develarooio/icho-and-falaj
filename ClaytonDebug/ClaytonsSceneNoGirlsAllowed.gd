extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var pos_cell_global= $TileMap.map_to_world(Vector2(64, 64)) 
	print(pos_cell_global)