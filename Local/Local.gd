extends CharacterBody2D
class_name Local

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

const MOVE_SPEED := 5000

func _ready():
	if sex == Local.Sex.Male:
		sprite_male.visible = true
		sprite_female.visible = false
	else:
		sprite_male.visible = false
		sprite_female.visible = true

func _physics_process(delta):
	var direction = global_position.direction_to(navigation_agent.get_next_path_position())
	navigation_agent.velocity = direction * MOVE_SPEED * delta
	
	move_and_slide()

func _on_navigation_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
