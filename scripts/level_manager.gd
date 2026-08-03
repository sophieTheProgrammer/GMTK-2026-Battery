extends Node2D

@export var levels: Array[PackedScene]
var current_level_index : int = 0
var current_charger : Charger
var current_level : Node

func _ready() -> void:
	Global.game_state = Global.game_states.GAME
	_load_level(0)

# listen to signal from child to start new level here
func _on_phone_recieved(area: Area2D) -> void:
	print("phone recieved from levelmanager!!")
	# Start new level here
	current_level_index += 1
	# we can do additional checks if the level was really completed here
	EventBus.level_completed.emit(current_level_index)
	await Global.fade_node.fade(1).finished

	_load_level(current_level_index)
	
	EventBus.start_next_level.emit()
	Global.fade_node.fade(0)

	
func _load_level(level_number : int) -> void:
	var level : Node
	
	if current_level:
		current_level.queue_free()

	if levels[level_number]:
		level = levels[level_number].instantiate()
		add_child.call_deferred(level)
	else:
		printerr("no more levels")
	
	# get charger reference here
	for chargers in level.get_nodes_in_group("group_name")
	current_charger = level.get_node("charger")
	current_charger.phone_recieved.connect(_on_phone_recieved)
	current_level = level
	if !current_charger:
		print("NO CHARGER REFERENCE FROM LEVEL_MANAGER.GD")
	else:
		print(current_charger)
