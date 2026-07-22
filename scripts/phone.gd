extends CharacterBody2D

# Constants
const TOP_SPIN_SPEED := 10.0
const SPIN_ACCELERATION := 2.0
const SPEED := 50000.0

var current_spin_velocity : float = 0.0

enum player_state {
	IDLE,
	AIMING,
	LAUNCHING,
}

var state : player_state = player_state.IDLE
func _physics_process(delta: float) -> void:
	if state == player_state.IDLE:
		handle_idle(delta)
	elif state == player_state.AIMING:
		handle_aiming(delta)
	Debug.display_debug_var("state", player_state.find_key(state))

		
	move_and_slide()

func handle_idle(delta: float) -> void:
	var direction := Input.get_axis("right", "left")

	var target_spin_speed : float = TOP_SPIN_SPEED * direction
	current_spin_velocity = lerp(current_spin_velocity, target_spin_speed, SPIN_ACCELERATION * delta)
	# you can normally lerp velocity with other properties and just lerp the velocity but spin doesn't have any
	# once we've updated what spin velocity should be, we can add it to rotation since velocity = change/time and you are applying this change
	rotation += current_spin_velocity * delta
	
	if Input.is_action_just_pressed("click"):
		state = player_state.AIMING

func handle_aiming(delta : float) -> void:
	if Input.is_action_just_released("click"):
		velocity = SPEED * delta * Vector2.UP.rotated(rotation)
		
	velocity = lerp(velocity, Vector2.ZERO, 0.2)
	Debug.display_debug_var("player velocity", velocity)
