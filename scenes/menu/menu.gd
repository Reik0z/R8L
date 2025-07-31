extends Control

const MAIN_SCENE = "res://scenes/main.tscn" # TODO: add scene? type or string

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(MAIN_SCENE)
	

func _on_exit_pressed() -> void:
	get_tree().quit()
