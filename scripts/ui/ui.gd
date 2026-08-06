extends CanvasLayer
@onready var battery_label: Label = $BatteryLabel
@onready var game_complete: CanvasLayer = $"game complete"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.battery_changed.connect(_on_battery_changed)
	game_complete.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# recieves battery_changed signal
func _on_battery_changed(number: int) -> void:
	battery_label.text = "Battery: " + str(number) + "%"


func _on_level_manager_game_complete() -> void:
	game_complete.show()
	battery_label.hide()


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(load("uid://cjulv74qj1553"))
