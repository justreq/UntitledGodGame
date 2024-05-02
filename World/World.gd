@tool
extends Node2D

@onready var tile_map := $TileMap

@export var world_camera: WorldCamera

@export_category("Generation Settings")
@export var world_size := Vector2i(256, 256)

@export var terrain_noise: FastNoiseLite
@export var object_noise: Array[FastNoiseLite]

@export var falloff_start: float = 0.75
@export var falloff_end: float = 1

@export_category("Generate")
@export var generate := true:
	set(v): generate_world()

func _ready():
	if not Engine.is_editor_hint():
		generate_world()
	
	var local_spawn_positions = []
	var spawnable_area = tile_map.get_used_cells(0).filter(
		func(t): return t.x in range(world_size.x / 2 - 5, world_size.x / 2 + 5)\
					and t.y in range(world_size.y / 2 - 5, world_size.y / 2 + 5))
	
	for tile in spawnable_area:
		tile = tile as Vector2
		
		if (tile_map as TileMap).get_cell_source_id(1, tile) == -1:
			local_spawn_positions.append(tile)
		
		if local_spawn_positions.size() >= 2:
			break
	
	for i in range(local_spawn_positions.size()):
		spawn_local(to_global(tile_map.map_to_local(local_spawn_positions[i])), Local.Sex.Male if i % 2 == 0 else Local.Sex.Female)
	
	world_camera.global_position = to_global(tile_map.map_to_local((local_spawn_positions[0] + local_spawn_positions[1]) / 2))
	world_camera.target_global_position = world_camera.global_position

func _input(_event):
	if Input.is_action_just_pressed("DEBUG_RELOAD"):
		get_tree().reload_current_scene()

func get_noise(noise: FastNoiseLite, x: float, y: float):
	var scaled_x: float = x / world_size.x
	var scaled_y: float = y / world_size.y
	
	if scaled_x <= .5: scaled_x = 1 - scaled_x
	if scaled_y <= .5: scaled_y = 1 - scaled_y
	
	var falloff_x: float = 1
	var falloff_y: float = 1
	if scaled_x <= falloff_end and scaled_x >= falloff_start:
		falloff_x = 1 - (scaled_x - falloff_start) / (falloff_end - falloff_start)
	if scaled_y <= falloff_end and scaled_y >= falloff_start:
		falloff_y = 1 - (scaled_y - falloff_start) / (falloff_end - falloff_start)
		
	var falloff: float = min(falloff_x, falloff_y)
	
	return (noise.get_noise_2d(x, y) + 1) * falloff - 1

func get_probability(probabilities: Array):
	var sum = probabilities.reduce(func(i, j): return i + j)
	var running_sum = 0
	var odds = sum * randf()
	
	for i in range(probabilities.size()):
		running_sum += probabilities[i]
		
		if running_sum >= odds:
			return i

func generate_world():
	tile_map.clear()
	terrain_noise.seed = randi()
	object_noise.map(func(n): n.seed = randi())
	
	for x in range(world_size.x):
		for y in range(world_size.y):
			var noise_at_position = get_noise(terrain_noise, x, y)
			
			for tile in Main.TILE_GENERATION_PROPERTIES:
				if noise_at_position <= tile.threshold_max and noise_at_position >= tile.threshold_min:
					var variant = tile.variants[get_probability(tile.variants.map(func(v): return v.probability))]
					tile_map.set_cell(tile.layer, Vector2i(x, y), 0, variant.atlas_coords)
			
			for i in range(Main.OBJECT_GENERATION_PROPERTIES.size()):
				if Main.OBJECT_GENERATION_PROPERTIES[i] == null or object_noise[i] == null:
					continue
				
				var object = Main.OBJECT_GENERATION_PROPERTIES[i]
				noise_at_position = get_noise(object_noise[i], x, y)
				
				if noise_at_position <= object.threshold_max and noise_at_position >= object.threshold_min:
					if not object.whitelist.has(tile_map.get_cell_tile_data(0, Vector2i(x, y)).get_custom_data("Name")):
						continue
					
					tile_map.set_cell(object.layer, Vector2i(x, y), 1, Vector2.ZERO, i)

func spawn_local(spawn_position: Vector2, sex: Local.Sex, role := Local.Role.None):
	var local = Main.LocalScene.instantiate()
	local.sex = sex
	local.role = role
	local.global_position = spawn_position
	
	add_child(local)
