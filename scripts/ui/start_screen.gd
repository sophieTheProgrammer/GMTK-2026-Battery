extends Node2D

@onready var start_screen_tutorial_button: Button = $CanvasLayer/StartScreenTutorialButton
@onready var start_screen_start_button: Button = $CanvasLayer/StartScreenStartButton
@onready var start_screen_settings_button: Button = $CanvasLayer/StartScreenSettingsButton

func _button_pressed(source: BaseButton) -> void:
	match source:
		start_screen_tutorial_button:
			get_tree().change_scene_to_packed(Global.TUTORIAL)
		start_screen_start_button:
			get_tree().change_scene_to_packed(Global.GAME)
		start_screen_start_button:
			get_tree().change_scene_to_packed(Global.SETTINGS)

	AudioPlayer.play_sfx(AudioPlayer.CLICK, 0.25)
