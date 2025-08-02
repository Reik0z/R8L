extends PathFollow3D

@export_category("Car Properties")
@export var max_speed: float = 25.0
@export var engine_force: float = 25.0
@export var mass: float = 1.0
@export var gravity: float = 9.8
@export var friction_coefficient: float = 0.95            

var current_speed: float = 0.0
var current_sum_of_forces: float = 0.0
var current_normal_force: float = mass * gravity
var current_friction_force: float = 0.0
# gravity force component that acts on rail
var current_in_rail_gravity_force: float = 0.0
var current_acceleration: float = 0.0

@export_category("Derailment")
@export var boost_multiplier: float = 2.0
@export var derail_threshold: float = 0.7
@export var derail_speed_reduction: float = 0.9
@export var base_speed: float = 3.0

var is_derailed: bool = false
var is_boosting: bool = false

#func _ready() -> void:
	#current_speed = base_speed

func _process(delta: float) -> void:
	# when the button is held, apply engine force
	if Input.is_action_pressed("ui_accept"):
		current_sum_of_forces = engine_force + current_friction_force + current_in_rail_gravity_force
	else:
		current_sum_of_forces = current_friction_force + current_in_rail_gravity_force
		
	## if the car is not moving, there's no friction force
	#if abs(current_speed - 0.0) < 0.1:
		#current_friction_force = 0.0
	# if the car is moving, calculate the friction force
	if current_speed > 0.0:
		current_friction_force = - current_normal_force * friction_coefficient
	elif current_speed < 0.0:
		current_friction_force = current_normal_force * friction_coefficient
	
	# the gravity force affecting the direction of the car is calculated
	current_in_rail_gravity_force = - current_normal_force * cos(deg_to_rad(90 - rotation_degrees.x))
	
	# the acceleration is calculated
	current_acceleration = current_sum_of_forces / mass
	
	# the speed is calculated
	current_speed += current_acceleration * delta
	# speed is clamped
	current_speed = clampf(current_speed, - max_speed, max_speed)
	
	# progress is calculated
	progress += current_speed * delta
	
	# angle with gravity
	print(current_speed)
	

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
