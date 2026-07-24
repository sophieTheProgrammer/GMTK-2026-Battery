extends CharacterBody2D

@onready var shoot_indicator: Node2D = $shoot_indicator

# Constants
const TOP_SPIN_SPEED := 10.0
const SPIN_ACCELERATION := 2.0
const SPEED := 1200.0
const DECELERATION : = 800.0

var current_spin_velocity : float = 0.0

enum player_state {
	IDLE,
	AIMING,
	LAUNCHING,
	CHARGING
}
func _ready() -> void:
	EventBus.phone_enter_charger.connect(_on_phone_enter_charger)

var state : player_state = player_state.IDLE
func _physics_process(delta: float) -> void:
	match state:
		player_state.IDLE:
			handle_idle(delta)
		player_state.AIMING:
			handle_aiming(delta)
		player_state.LAUNCHING:
			handle_launching(delta)
		player_state.CHARGING:
			handle_charging(delta)
	Debug.display_debug_var("state", player_state.find_key(state))
	Debug.display_debug_var("player velocity", velocity)
	Debug.display_debug_var("player degrees", int(rotation_degrees))
		
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
func handle_idle(delta: float) -> void:
	
	handle_rotation(delta)
	
	if Input.is_action_just_pressed("click"):
		#current_spin_velocity = 0
		state = player_state.AIMING
	Debug.display_debug_var("spin velocity", int(current_spin_velocity))

func handle_aiming(delta : float) -> void:
	handle_rotation(delta)
	if Input.is_action_just_released("click"):
		state = player_state.LAUNCHING
		
		velocity = SPEED * -Vector2.UP.rotated(rotation)

func handle_launching(delta : float) -> void:
	handle_rotation(delta)
	velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	if abs(velocity.x) < 5 and abs(velocity.y) < 5:
		#velocity = Vector2.ZERO
		state = player_state.IDLE

func handle_charging(delta: float) -> void:
	velocity = Vector2.ZERO
func _on_phone_enter_charger(area : Area2D) -> void:
	state = player_state.CHARGING

func handle_rotation(delta: float) -> void:
	var direction := Input.get_axis("right", "left")

	var target_spin_speed : float = TOP_SPIN_SPEED * direction
	current_spin_velocity = lerp(current_spin_velocity, target_spin_speed, SPIN_ACCELERATION * delta)
	# you can normally lerp velocity with other properties and just lerp the velocity but spin doesn't have any
	# once we've updated what spin velocity should be, we can add it to rotation since velocity = change/time and you are applying this change
	rotation += current_spin_velocity * delta
