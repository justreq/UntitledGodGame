class_name Local extends CharacterBody2D

enum Sex {
	Male,
	Female
}

enum Role {
	None,
}

@onready var sprite_male = $SpriteMale
@onready var sprite_female = $SpriteFemale
@onready var navigation_agent = $NavigationAgent
@onready var state_machine = $StateMachine

@export_category("Properties")
@export var sex := Sex.Male
@export_range(0, 100, 1, "or_greater") var age := 0
@export var role := Role.None

func _ready():
	if sex == Local.Sex.Male:
		sprite_male.visible = true
		sprite_female.visible = false
	else:
		sprite_male.visible = false
		sprite_female.visible = true

func _physics_process(delta):
	var direction = global_position.direction_to(navigation_agent.target_position)
	velocity = direction * 5000 * delta
	
	move_and_slide()
