extends Node2D

@export var base_tile_map_layer : TileMapLayer

func _ready() -> void:
	if not base_tile_map_layer:
		push_warning("Need base tilemap layer for registration")
	else:	
		GameManager.register_tilemap(base_tile_map_layer)
