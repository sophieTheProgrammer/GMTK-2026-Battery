extends Node

const LEVEL_PATH : String = "res://levels/level_"

func _ready() -> void:
	EventBus.phone_enter_charger.connect(_on_phone_enter_charger)
	
	
func _on_phone_enter_charger(area : Area2D) -> void:
	var node_name : String = get_tree().get_first_node_in_group("level").name
	var next_level_number : int = node_name.to_int() + 1
	
	var next_level_path : String = LEVEL_PATH + str(next_level_number) + ".tscn"
	if !next_level_path:
		print("no more levels to load")
		return
	
	var next_level : Node = load(next_level_path).instantiate()
	next_level.name = "Level" + str(next_level_number)
	
	print(next_level)
	get_tree().current_scene.call_deferred("add_child", next_level)
	EventBus.start_next_level.emit()
	
	# TODO: add fancy smanchy scene transitions
	call_deferred("queue_free")
