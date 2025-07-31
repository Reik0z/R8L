extends Node3D

@export var angular_speed: int = PI


func _process(delta: float) -> void:
	rotate_y(angular_speed * delta)
