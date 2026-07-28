class_name Charger
extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
signal phone_recieved

# WARNING: CHARGER ONLY WORKS FACING DOWN
'''
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("phone"):
		if Global.DEBUG_EASY_WIN or body.velocity.y < 0:
			print("phone entered charger")
			EventBus.phone_enter_charger.emit(self)
			print("finished emitted phone_enter_charger")
			set_deferred("monitoring", false)
'''
func _on_area_entered(area: Area2D) -> void:
	if Global.DEBUG_EASY_WIN or area.get_parent().velocity.y < 0:
		phone_recieved.emit(self)


func _ready() -> void:

	#var entry_vector : Vector2 = global_position.direction_to(body.global_position)
	#print(entry_vector)
	pass
	# if it entred the range of 180
	#print(entry_vector.dot(Vector2.UP))
	#if entry_vector.dot(Vector2.UP) > 0:
		#print("entered charger properly")
	#if body.is_in_group("phone"):
	#	print("Player detected in charger area")
		#EventBus.phone_enter_charger.emit(self)
