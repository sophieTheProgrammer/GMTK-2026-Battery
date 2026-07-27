extends Node

const LEVEL_PATH : String = "res://levels/level_"

func _ready() -> void:
	#EventBus.phone_enter_charger.connect(_on_phone_enter_charger)
	self.position = Vector2.ZERO
