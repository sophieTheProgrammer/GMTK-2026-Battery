extends Node2D

@export var levels: Array[PackedScene]
var current_level_index : int = 0
var current_charger : Charger
var current_level : Node

func _ready() -> void:
	_load_level(0)

# listen to signal from child to start new level here
func _on_phone_recieved(area: Area2D) -> void:
	# Start new level here
	current_level_index += 1
	# we can do additional checks if the level was really completed here
	EventBus.level_completed.emit(current_level_index)
	_load_level(current_level_index)


func _load_level(level_number : int) -> void:
	var level : Node
	
	if current_level:
		print("awaiting")
		await Global.fade_node.fade(1).finished
		print("awaited")
		current_level.queue_free.call_deferred()
		EventBus.start_next_level.emit()
		print("emit start_next_level")
	if levels[level_number]:
		level = levels[level_number].instantiate()
		add_child.call_deferred(level)
		if Global.fade_node:
			Global.fade_node.fade(0).finished
	else:
		printerr("no more levels")
	
	# get charger reference here
	current_charger = level.get_node("charger")
	current_charger.phone_recieved.connect(_on_phone_recieved)
	current_level = level
