class_name State extends Node2D

@export var local: Local
@export_range(0, 1, 0.01) var importance_factor := 0

func toggle_state():
	for state in local.state_machine.get_children():
		state.visible = false
	
	visible = true
