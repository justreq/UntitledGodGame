extends State

@onready var timer = $Timer

func _physics_process(_delta):
	if not visible:
		return
	
	if timer.is_stopped():
		timer.start(randi_range(1, 15))

func _on_timer_timeout():
	local.navigation_agent.target_position = local.global_position + Vector2(randi_range(-10, 10) * 16, randi_range(-10, 10) * 16)
