extends Node

@export var node: Node2D
@export var offsets: Array[Vector2]

func _ready():
	if offsets.size() > 0:
		node.position += offsets.pick_random()
