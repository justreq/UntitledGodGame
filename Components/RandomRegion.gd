extends Node

@export var regions: Array[Rect2]

func _ready():
	if get_parent() is Sprite2D and regions.size() > 0:
		get_parent().region_rect = regions.pick_random()
