extends Node

@export var offsets: Array[Vector2]

func _ready():
	if get_parent() is Node2D and offsets.size() > 0:
		get_parent().position += offsets.pick_random()
