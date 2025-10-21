@tool class_name Player extends CharacterBody2D

@export var speed : float = 3.0
@export var head_speed : float = 10.0


@onready var head : Bone2D = %Head
@onready var skeleton : Skeleton2D = %Skeleton2D
@export var body : Line2D

var _body_segment_scene : PackedScene = preload("res://body_segment.tscn")
var _direction : Vector2 = Vector2(0, -1)
var _last_segment : BodySegment
var _bone_segment_index : int = 1

func _ready() -> void:
	pass

func _get_global_speed_for_direction(direction: Vector2i) -> float:
	if direction.x != 0:
		return GameManager.tile_size.x * speed
	
	return GameManager.tile_size.y * speed

func _process(delta: float) -> void:
	if not Engine.is_editor_hint():
		_update_direction()
		_move(delta)
	
	_update_skeleton(delta)
	
func _update_skeleton(delta: float) -> void:
	if not body:
		return

	for i in skeleton.get_bone_count():
		var bone: Bone2D = skeleton.get_bone(i)
		var point: Vector2 = bone.global_position
		
		if body.get_point_count() > i:
			body.set_point_position(i, to_local(point))
		else:
			body.add_point(to_local(point))
	
	
func _update_direction() -> void:
	var axis = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down"))
	if axis != Vector2.ZERO:
		_direction = axis

func _move(delta: float) -> void:
	var motion = _direction.normalized() * delta * _get_global_speed_for_direction(_direction)
	
	var to_angle = _direction.angle()
	var head_rotation = lerp_angle(head.rotation, to_angle, delta * head_speed)
	var head_bone_rotation = lerp_angle(head.get_bone_angle(), -to_angle, delta * head_speed)
	#head.rotation = head_rotation
	#head.set_bone_angle(head_bone_rotation)

	
	
	var collided = move_and_collide(motion)
	
	if collided:
		_handle_collision(collided)
		
	
func _handle_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	print("collision", collision, collider)
	if collider.is_in_group("food"):
		var parent_segment = _last_segment if _last_segment else head
		var new_segment = _add_segment(parent_segment)
		_last_segment = new_segment
		collider.queue_free.call_deferred()
		GameManager.add_food()
		return
		
	GameManager.game_over()



func _add_segment(parent_segment: Bone2D) -> Bone2D:
	var segment = _body_segment_scene.instantiate()
	
	if segment is not BodySegment:
		push_warning("Tried to add an invalid segment.")
		return

	parent_segment.add_child(segment)
		
	print("Added segment ", segment)
	return segment
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	if not body:
		warnings.append("Player needs body (Line2D)")
		
	return warnings
