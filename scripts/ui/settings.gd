extends Node2D

@onready var back_button: Button = $BackButton

func _button_pressed(source: BaseButton) -> void:
	if source == back_button:
		get_tree().change_scene_to_packed(load("res://scenes/start.tscn"))


func _on_button_3_pressed() -> void:
	AudioPlayer.play_sfx(AudioPlayer.CLICK)

func _on_music_slider_value_changed(value: float) -> void:
	var index : int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	var index : int = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
