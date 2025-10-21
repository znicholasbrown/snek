extends Node

var _food_scene : PackedScene = preload("res://food.tscn")

@export var tile_size : Vector2 = Vector2(128.0, 128.0)
@export var tile_map_layer: TileMapLayer

func add_food() -> void:
	if not tile_map_layer:
		push_warning("Game manager is missing tilemap layer registration.")
		return

	var cells = tile_map_layer.get_used_cells()
	var cell = cells.pick_random()
	var food = _food_scene.instantiate()
	food.global_position = tile_map_layer.map_to_local(cell)
	tile_map_layer.get_parent().add_child(food)

func game_over() -> void:
	get_tree().reload_current_scene.call_deferred()

func register_tilemap(tile_map: TileMapLayer) -> void:
	tile_map_layer = tile_map
