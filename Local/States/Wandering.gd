extends State

@onready var timer = $Timer

func _on_timer_timeout():
	var edge = local.navigation_agent.path_max_distance
	local.navigation_agent.target_position = local.global_position + Vector2(randi_range(-edge, edge), randi_range(-edge, edge))
	timer.start(randi_range(1, 15))
