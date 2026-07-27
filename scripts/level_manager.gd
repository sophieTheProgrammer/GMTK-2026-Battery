extends Node2D

@export var levels: Array[PackedScene]
var current_level_index : int = 0
var current_charger : Charger
var current_level : Node
func _ready() -> void:	
	var first_level : Node = levels[current_level_index].instantiate()
	add_child(first_level)
	
	current_charger = first_level.get_node("charger")
	current_charger.phone_enter_charger.connect(_on_phone_enter_charger)
	current_level = first_level
func _on_phone_enter_charger(area: Area2D) -> void:
	EventBus.start_next_level.emit()
	print("emitted start_next_level")
	# Start new level here
	current_level.queue_free.call_deferred()
	
	current_level_index += 1
	var next_level : Node = levels[current_level_index].instantiate()
	add_child.call_deferred(next_level)
	current_level = next_level
