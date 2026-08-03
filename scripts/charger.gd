class_name Charger
extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
signal phone_recieved

# WARNING: CHARGER ONLY WORKS FACING DOWN
'''
func _on_area_entered(area: Area2D) -> void:	
	if Global.DEBUG_EASY_WIN or area.get_parent().velocity.y < 0:
		phone_recieved.emit(self)
'''

func _on_area_entered(area: Area2D) -> void:
	#phone_recieved.emit(self)
	var entry_vector : Vector2 = global_position.direction_to(area.global_position)
	print(entry_vector)
	if area.get_parent().is_in_group("phone"):
		print("RAAAWRYGIYAWGKDHSAKHDJ A PHONE ENTERED ME!!!")
		#print((entry_vector.dot(Vector2.UP)))
		phone_recieved.emit(self)
		if entry_vector.dot(Vector2.UP) > 0:
			print("Player detected in charger area")
			
