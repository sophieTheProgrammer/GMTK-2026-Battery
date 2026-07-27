extends Node

const LEVEL_PATH : String = "res://levels/level_"

func _ready() -> void:
	#EventBus.phone_enter_charger.connect(_on_phone_enter_charger)
	self.position = Vector2.ZERO
	
#func _on_phone_enter_charger(area : Area2D) -> void:
	#EventBus.level_completed.emit()
	'''
	var next_level_number : int = self.name.to_int() + 1
	
	var next_level_path : String = LEVEL_PATH + str(next_level_number) + ".tscn"
	if !load(next_level_path):
		print("no more levels to load", next_level_path, "name", name)
		return
	
	var next_level : Node = load(next_level_path).instantiate()
	next_level.name = "level" + str(next_level_number)
	next_level.add_to_group("level")

	await Global.fade_node.fade(1.5).finished
	print("Finished Level Fade await")
	get_tree().current_scene.call_deferred("add_child", next_level)
	print("instaniated level", next_level_number)
	Global.fade_node.fade(0)
	# TODO: add fancy smanchy scene transitions
	call_deferred("queue_free")
	'''
func get_next_level_path() -> String:
	var node_name : String = get_tree().get_first_node_in_group("level").name
	var next_level_number : int = node_name.to_int() + 1
	var current_level_number : String = str(node_name.to_int())
	
	
	var next_level_path : String = LEVEL_PATH + str(next_level_number) + ".tscn"
	if !next_level_path:
		print("no more levels to load")
		return current_level_number
	return next_level_path
	
