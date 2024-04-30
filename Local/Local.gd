extends CharacterBody2D

@onready var sprite_male = $SpriteMale
@onready var sprite_female = $SpriteFemale

@export_category("Properties")
@export var sex := Main.Sex.Male
@export_range(0, 100, 1, "or_greater") var age := 0
@export var role := Main.Role.None

func _ready():
	if sex == Main.Sex.Male:
		sprite_male.visible = true
		sprite_female.visible = false
	else:
		sprite_male.visible = false
		sprite_female.visible = true
