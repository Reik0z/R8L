extends Node3D

@export var angular_speed: int = 1


func _process(delta: float) -> void:
	rotate_y(angular_speed * delta)
	
func _input(event):
	if event.is_action_pressed("ui_left"):
		angular_speed -=1
	elif event.is_action_pressed("ui_right"):
		angular_speed +=1
	
