class_name Body extends Node

func move(next_position: Vector2) -> void:
	var segments = get_children()
	var toward = next_position
	for segment in segments:
		if segment is BodySegment:
			segment.move_and_collide(toward - segment.global_position)
			toward = segment.global_position

func add_segment() -> void:
	var segment = BodySegment.new()
	add_child(segment)
