extends Control

@onready var back_button: Button = $BackButton

func _on_music_slider_value_changed(value: float) -> void:
	var index : int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(index, linear_to_db(value))

func _on_sfx_slider_value_changed(value: float) -> void:
	var index : int = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(index, linear_to_db(value))


func _on_back_button_pressed() -> void:
	hide()
