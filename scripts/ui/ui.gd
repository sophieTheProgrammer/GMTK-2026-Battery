extends CanvasLayer
@onready var battery_label: Label = $BatteryLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.battery_changed.connect(_on_battery_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# recieves battery_changed signal
func _on_battery_changed(number: int) -> void:
	battery_label.text = "Battery: " + str(number) + "%"
