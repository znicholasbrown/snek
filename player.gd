extends CharacterBody2D

@export var tile_map_layer : TileMapLayer
@export var speed : float = 10.0


var _global_speed : float = 128.0
var _direction : Vector2 = Vector2(0, -1)

func _ready() -> void:
	if not tile_map_layer:
		push_warning("Player scene needs tile map layer")
		return

	
func _get_global_speed_for_direction(direction: Vector2i) -> float:
	if direction.x != 0:
		return tile_map_layer.tile_set.tile_size.x * speed
	
	return  tile_map_layer.tile_set.tile_size.y * speed

func _physics_process(delta: float) -> void:
	_update_direction()
	_move(delta)
	
func _update_direction() -> void:
	var axis = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if axis != Vector2.ZERO:
		_direction = axis

func _move(delta: float) -> void:
	var _motion = _direction * delta * _get_global_speed_for_direction(_direction)
	move_and_collide(_motion)
	
