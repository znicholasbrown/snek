extends CharacterBody2D

@export var speed : float = 1.0

var _direction : Vector2 = Vector2.ZERO
var _timer : Timer

func _ready() -> void:
	_timer = Timer.new()
	_timer.wait_time = speed
	add_child(_timer)
	_timer.timeout.connect(_on_timer_timeout)
	_timer.start()
 

func _on_timer_timeout() -> void:
	print("timeout")
	pass
