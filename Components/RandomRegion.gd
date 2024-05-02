extends Node

@export var sprite: Sprite2D
@export var regions: Array[Rect2]

func _ready():
	if regions.size() > 0:
		sprite.region_rect = regions.pick_random()
