class_name BodySegment extends Bone2D

signal collided(body: Node)

@onready var sprite : Sprite2D = %Sprite2D
		
func _ready() -> void:
	pass
	#var size = 128.0 / get_length()
	#sprite.scale = Vector2(size, size)

func _on_rigid_body_2d_body_entered(body: Node) -> void:
	collided.emit(body)
