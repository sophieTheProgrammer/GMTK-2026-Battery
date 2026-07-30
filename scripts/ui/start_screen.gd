extends Node2D
@onready var start_screen_start_button: Button = $CanvasLayer/MarginContainer/VBoxContainer/StartScreenStartButton
@onready var start_screen_settings_button: Button = $CanvasLayer/MarginContainer/VBoxContainer/StartScreenSettingsButton

@onready var start_title: Label = $CanvasLayer/VBoxContainer/StartTitle
@onready var settings: Control = $CanvasLayer/MarginContainer/Settings
@onready var phone_sprite: AnimatedSprite2D = $PhoneSprite

func _button_pressed(source: BaseButton) -> void:
	match source:
		start_screen_start_button:
			get_tree().change_scene_to_packed(Global.GAME)
		start_screen_settings_button:
			settings.show()

	AudioPlayer.play_sfx(AudioPlayer.CLICK, 0.25)
func _ready() -> void:
	float_up()
	settings.hide()

func float_up() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(phone_sprite, "position:y", phone_sprite.position.y - 20, 1)
	tween.tween_callback(float_down)
func float_down() -> void:
	var tween : Tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(phone_sprite, "position:y", phone_sprite.position.y + 20, 1)
	tween.tween_callback(float_up)
