extends CharacterBody2D

@onready var battery_indicator_label: Label = $BatteryIndicatorLabel
@onready var charging_port: Area2D = $ChargingPort
@onready var phone_sprite: AnimatedSprite2D = $PhoneSprite

# Constants
const TOP_SPIN_SPEED := 5.0
const SPIN_ACCELERATION := 5.0
const SPEED := 1400.0
const DECELERATION : = 1000.0

var current_spin_velocity : float = 0.0
var current_battery_level : int = 20
const BATTERY_LEVEL : int = 5
var state : player_state = player_state.IDLE

enum player_state {
	IDLE,
	AIMING,
	LAUNCHING,
	CHARGING,
	OUT_OF_BATTERY
}
func _ready() -> void:
	EventBus.level_completed.connect(_on_level_completed)
	EventBus.start_next_level.connect(reset_for_level)
	self.position = Vector2.ZERO
	add_current_battery_level(0)

func _physics_process(delta: float) -> void:
	match state:
		player_state.IDLE:
			handle_idle(delta)
		#player_state.AIMING:
		#	handle_aiming(delta)
		player_state.LAUNCHING:
			handle_launching(delta)
		player_state.CHARGING:
			handle_charging(delta)
	Debug.display_debug_var("state", player_state.find_key(state))
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
func handle_idle(delta: float) -> void:
	
	handle_rotation(delta)
	
	if Input.is_action_just_pressed("click"):
		# Enter Launch state
		current_spin_velocity = 0
		state = player_state.LAUNCHING
		velocity = SPEED * -Vector2.UP.rotated(rotation)
		add_current_battery_level(-1)
	elif current_battery_level == 0:
		#Global.fade_node.fade(1.5)
		AudioPlayer.play_sfx(AudioPlayer.LOW_POWER_WARNING)
		reset_for_level()
'''
func handle_aiming(delta : float) -> void:
	current_spin_velocity = 0
	if Input.is_action_just_released("click"):
		state = player_state.LAUNCHING
		add_current_battery_level(-1)
		velocity = SPEED * -Vector2.UP.rotated(rotation)
'''

func handle_launching(delta : float) -> void:
	handle_rotation(delta)
	velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)
	if abs(velocity.x) < 5 and abs(velocity.y) < 5:
		#velocity = Vector2.ZERO
		state = player_state.IDLE

func handle_charging(delta: float) -> void:
	#velocity = Vector2.ZERO
	phone_sprite.play("charging")
	velocity = velocity.lerp(Vector2.ZERO, 0.6)
	#position = charging_port.global_position.lerp(charger_pos,0.5)
	#rotation_degrees = lerp(rotation_degrees, 180.0, 0.1)
	#position = Vector2.ZERO

func _on_level_completed(number : int) -> void:
	state = player_state.CHARGING
	AudioPlayer.play_sfx(AudioPlayer.CHARGING_SFX)
	print("CHANGE STATE TO CHARGING")

func handle_rotation(delta: float) -> void:
	var direction := Input.get_axis("right", "left")

	var target_spin_speed : float = TOP_SPIN_SPEED * direction
	current_spin_velocity = lerp(current_spin_velocity, target_spin_speed, SPIN_ACCELERATION * delta)
	# you can normally lerp velocity with other properties and just lerp the velocity but spin doesn't have any
	# once we've updated what spin velocity should be, we can add it to rotation since velocity = change/time and you are applying this change
	rotation += current_spin_velocity * delta

func add_current_battery_level(amount : int) -> void:
	current_battery_level += amount
	#battery_indicator_label.text = str(current_battery_level)
	EventBus.battery_changed.emit(current_battery_level)

func set_current_battery_level(amount : int) -> void:
	current_battery_level = amount
	#battery_indicator_label.text = str(current_battery_level)
	EventBus.battery_changed.emit(current_battery_level)

func reset_for_level() -> void:
	phone_sprite.play("low")
	position = Vector2.ZERO
	velocity = Vector2.ZERO
	print("CHNAGE STATE TO IDLE WHILE RESETTING LEVEL")
	set_current_battery_level(BATTERY_LEVEL)
	state = player_state.IDLE
