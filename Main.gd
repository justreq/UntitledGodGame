extends Node

const LocalScene := preload("res://Local/Local.tscn")

const TILE_GENERATION_PROPERTIES := [
	{
		"name": "Water",
		"layer": 0,
		"threshold_min": -1,
		"threshold_max": 1,
		"variants": [
			{ "atlas_coords": Vector2i(0, 3), "probability": 1.0 },
			{ "atlas_coords": Vector2i(1, 3), "probability": 0.5 },
		]
	},
	{
		"name": "Sand",
		"layer": 0,
		"threshold_min": -0.25,
		"threshold_max": 1,
		"variants": [
			{ "atlas_coords": Vector2i(0, 2), "probability": 1.0 },
			{ "atlas_coords": Vector2i(1, 2), "probability": 0.5 },
		]
	},
	{
		"name": "Grass",
		"layer": 0,
		"threshold_min": -0.1,
		"threshold_max": 1,
		"variants": [
			{ "atlas_coords": Vector2i(0, 1), "probability": 1.0 },
			{ "atlas_coords": Vector2i(1, 1), "probability": 0.5 },
			{ "atlas_coords": Vector2i(2, 1), "probability": 0.05 },
			{ "atlas_coords": Vector2i(3, 1), "probability": 0.01 },
		]
	},
	{
		"name": "Dirt",
		"layer": 0,
		"threshold_min": 0.4,
		"threshold_max": 1,
		"variants": [
			{ "atlas_coords": Vector2i(0, 0), "probability": 1.0 },
			{ "atlas_coords": Vector2i(1, 0), "probability": 0.5 },
			{ "atlas_coords": Vector2i(2, 0), "probability": 0.01 },
		]
	},
]

const OBJECT_GENERATION_PROPERTIES := [
	{
		"name": "YellowTree",
		"layer": 1,
		"threshold_min": 0.35,
		"threshold_max": 1,
		"whitelist": ["EmptyDirt"],
	},
	{
		"name": "GreenTree",
		"layer": 1,
		"threshold_min": 0.35,
		"threshold_max": 1,
		"whitelist": ["EmptyGrass"],
	},
	{
		"name": "YellowBush",
		"layer": 1,
		"threshold_min": 0.35,
		"threshold_max": 1,
		"whitelist": ["EmptyDirt"],
	},
	{
		"name": "GreenBush",
		"layer": 1,
		"threshold_min": 0.35,
		"threshold_max": 1,
		"whitelist": ["EmptyGrass"],
	},
]
