class_name Body extends Node2D

@onready var _child : Body

func _ready() -> void:
	var child = find_child("Body")
	if child and child.is_in_group("body"):
		_child = child

func move(pos: Vector2):
	var child_next : Vector2i = position
	position = pos
	
	if _child:
		_child.move(child_next)
