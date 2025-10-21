@tool class_name Body extends Path2D

@export var skeleton_shape: Line2D

func _process(_delta: float) -> void:
	if not skeleton_shape:
		return
	if not skeleton_shape.curve:
		#points = []
		return
	#points = skeleton_shape.curve.get_baked_points()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	
	if not skeleton_shape:
		warnings.append("Need to assign the skeleton_shape (Path2D) to the body")
		
	return warnings
