class_name WorldCamera extends Camera2D

@export_category("Properties")
@export var minimum_zoom := Vector2.ONE
@export var maximum_zoom := Vector2(6, 6)
@export var default_zoom := Vector2(3, 3)
@export var move_speed := 7

var target_zoom := default_zoom
var target_global_position := global_position
var dragging := false
var drag_start_position := Vector2.ZERO

func _input(_event):
	if Input.is_action_just_pressed("camera_zoom_in"):
		target_zoom = clamp(zoom + Vector2(zoom.x * 0.5, zoom.y * 0.5), minimum_zoom, maximum_zoom)
	
	if Input.is_action_just_pressed("camera_zoom_out"):
		target_zoom = clamp(zoom - Vector2(zoom.x * 0.5, zoom.y * 0.5), minimum_zoom, maximum_zoom)
	
	if Input.is_action_just_pressed("camera_zoom_reset"):
		target_zoom = default_zoom
	
	if Input.is_action_just_pressed("camera_drag"):
		dragging = true
		drag_start_position = get_global_mouse_position()
	
	if Input.is_action_pressed("camera_drag"):
		target_global_position = global_position - (get_global_mouse_position() - drag_start_position)
	
	if Input.is_action_just_released("camera_drag"):
		dragging = false
		drag_start_position = Vector2.ZERO

func _physics_process(_delta):
	if not Input.is_action_pressed("camera_drag"):
		target_global_position += Input.get_vector("camera_move_left", "camera_move_right", "camera_move_up", "camera_move_down").normalized() * move_speed
	
	if not target_zoom == zoom:
		zoom = lerp(zoom, target_zoom, 0.1)
	
	if not target_global_position == global_position:
		global_position = lerp(global_position, target_global_position, 0.1)
