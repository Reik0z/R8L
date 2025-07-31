extends PathFollow3D

@export var speed: float = 3.0

func _process(delta: float) -> void:
	progress += speed * delta
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		speed *= 2
	if event.is_action_released("ui_accept"):
		speed /= 2
