class_name Snek extends Body

@export var direction : String = 'up'
@export var speed : float = 1.0

@onready var tile_map : TileMapLayer = %TileMapLayer
@onready var head : Sprite2D = %Head

var _time_elapsed : float = 0.0

func _process(delta: float) -> void:
	if true:
		move_head(delta)
		#detect_collision()
		

func move_head(delta: float):
	print(position)
	_time_elapsed += delta
	if _time_elapsed >= speed:
		var head_position = tile_map.local_to_map(head.position)
		var surrounding_cells = tile_map.get_surrounding_cells(head_position)
		
		var current = head_position
		var next
		match direction:
			'up':
				next = surrounding_cells[0]
			'down':
				next = surrounding_cells[2]
			'left':
				next = surrounding_cells[3]
			'right':
				next = surrounding_cells[1]
				
		position = tile_map.map_to_local(next)
		print(position)
		_time_elapsed = 0.0

func _input(event: InputEvent) -> void:
	#var up = event.is_action_pressed("up")
	#var down = event.is_action_pressed("down")
	#var left = event.is_action_pressed("left")
	#var right = event.is_action_pressed("right")
	
	match event:
		'up':
			direction = 'up'
		'down':
			direction = 'down'
		'left':
			direction = 'left'
		'right':
			direction = 'right'
	
	
