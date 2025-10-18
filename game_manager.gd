extends Node

func game_over() -> void:
	get_tree().reload_current_scene.call_deferred()
