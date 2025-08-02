extends PathFollow3D

@export_category("Movementd")
@export var base_speed: float = 3.0
@export var max_speed: float = 30.0
@export var acceleration: float = 20.0


@export_category("Derailment")
@export var boost_multiplier: float = 2.0
@export var derail_threshold: float = 0.7
@export var derail_speed_reduction: float = 0.9

var current_speed: float = 0.0
var is_derailed: bool = false
var is_boosting: bool = false

#func _ready() -> void:
	#current_speed = base_speed

func _process(delta: float) -> void:
	# when the button is held, accelerate
	if Input.is_action_pressed("ui_accept"):
		current_speed += acceleration * delta
	
	# speed is clamped
	current_speed = clampf(current_speed, 0.0, max_speed)
	
	# progress is calculated
	progress += current_speed * delta

#func _physics_process(delta: float) -> void:
	#check_derail()

#func _input(event):
	#if event.is_action_pressed("ui_accept"):
		#current_speed = base_speed * boost_multiplier
		#is_boosting = true
	#if event.is_action_released("ui_accept"):
		#current_speed = base_speed
		#is_boosting = false
#
#func check_derail() -> void:
	#if not is_boosting:
		#is_derailed = false
		#return
	#
	#var path_direction = -transform.basis.z.normalized()
	#var ideal_direction = Vector3.FORWARD
	#var alignment = path_direction.dot(ideal_direction)
	#
	#if alignment < derail_threshold:
		#handle_derail()
#
#func handle_derail() -> void:
	#if not is_derailed:
		#is_derailed = true
		#current_speed *= derail_speed_reduction
		#start_derail_effect()
		#print("¡Descarrile detectado!")
#
#func start_derail_effect() -> void:
	#pass
