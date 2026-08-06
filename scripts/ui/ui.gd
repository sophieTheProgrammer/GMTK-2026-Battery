extends CanvasLayer
@onready var battery_label: Label = $BatteryLabel
@onready var fade: CanvasLayer = $Fade

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.battery_changed.connect(_on_battery_changed)
	$"game complete".hide()

	
# recieves battery_changed signal
func _on_battery_changed(number: int) -> void:
	battery_label.text = "Battery: " + str(number) + "%"


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("uid://cjulv74qj1553"))


func _on_level_manager_game_completed() -> void:
	$"game complete".show()
