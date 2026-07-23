extends CharacterBody2D

@onready var shoot_indicator: Node2D = $shoot_indicator

# Constants
const TOP_SPIN_SPEED := 10.0
const SPIN_ACCELERATION := 2.0
const SPEED := 1000.0
const DECELERATION : = 800.0

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
	elif state == player_state.LAUNCHING:
		handle_launching(delta)
	Debug.display_debug_var("state", player_state.find_key(state))
	Debug.display_debug_var("player velocity", velocity)
	Debug.display_debug_var("player degrees", int(rotation_degrees))
		
	move_and_slide()

func handle_idle(delta: float) -> void:
	shoot_indicator.show()
	
	var direction := Input.get_axis("right", "left")

	var target_spin_speed : float = TOP_SPIN_SPEED * direction
	current_spin_velocity = lerp(current_spin_velocity, target_spin_speed, SPIN_ACCELERATION * delta)
	# you can normally lerp velocity with other properties and just lerp the velocity but spin doesn't have any
	# once we've updated what spin velocity should be, we can add it to rotation since velocity = change/time and you are applying this change
	rotation += current_spin_velocity * delta
	
	if Input.is_action_just_pressed("click"):
		current_spin_velocity = 0
		state = player_state.AIMING
	Debug.display_debug_var("spin velocity", current_spin_velocity)
func handle_aiming(delta : float) -> void:
	if Input.is_action_just_released("click"):
		state = player_state.LAUNCHING
		velocity = SPEED * Vector2.UP.rotated(rotation)
func handle_launching(delta : float) -> void:
	shoot_indicator.hide()
	
	velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	if abs(velocity.x) < 0.5 and abs(velocity.y) < 0.5:
		velocity = Vector2.ZERO
		state = player_state.IDLE
