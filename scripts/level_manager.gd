extends Node2D

@export var levels: Array[PackedScene]
var current_level_index : int = 0
var current_charger : Charger
var current_level : Node

func _ready() -> void:
	_load_level(0)

# listen to signal from child to start new level here
func _on_phone_enter_charger(area: Area2D) -> void:
	EventBus.start_next_level.emit()
	print("emitted start_next_level")
	# Start new level here
	current_level_index += 1
	_load_level(current_level_index)


func _load_level(level_number : int) -> void:
	var level : Node
	
	if current_level:
		current_level.queue_free.call_deferred()
	if levels[level_number]:
		level = levels[level_number].instantiate()
		add_child.call_deferred(level)
	else:
		printerr("no more levels")
	
	# get charger reference here
	current_charger = level.get_node("charger")
	current_charger.phone_enter_charger.connect(_on_phone_enter_charger)
	current_level = level
