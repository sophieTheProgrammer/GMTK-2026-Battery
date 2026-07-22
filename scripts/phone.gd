extends CharacterBody2D

# Constants
const TOP_SPEED := 10.0
const ACCELERATION := 2.0
const ACCELERATION_WEIGHT := 0.6
# TODO: implement the friction weight feature
const FRICTION_WEIGHT := 0.1

var current_spin_velocity : float = 0.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("right", "left")

	var target_spin_speed : float = TOP_SPEED * direction
	current_spin_velocity = lerp(current_spin_velocity, target_spin_speed, ACCELERATION * delta)
	# you can normally lerp velocity with other properties and just lerp the velocity but spin doesn't have any
	# once we've updated what spin velocity should be, we can add it to rotation since velocity = change/time and you are applying this change
	print(current_spin_velocity, target_spin_speed, ACCELERATION * delta)
	rotation += current_spin_velocity * delta
	#else:
	#	rotation -= rotate_toward(0, direction * TOP_SPEED, FRICTION * delta)
	#	print(rotate_toward(0, direction * TOP_SPEED, FRICTION * delta))
	move_and_slide()
