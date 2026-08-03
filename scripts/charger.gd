class_name Charger
extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
signal phone_recieved
var direction : Vector2 = Vector2.from_angle(deg_to_rad(rotation_degrees))


func _ready() -> void:
	print(direction)
# WARNING: CHARGER ONLY WORKS FACING DOWN
'''
func _on_area_entered(area: Area2D) -> void:	
	if Global.DEBUG_EASY_WIN or area.get_parent().velocity.y < 0:
		phone_recieved.emit(self)
'''

func _on_area_entered(area: Area2D) -> void:
	#phone_recieved.emit(self)
	if area.get_parent().is_in_group("phone"):
		var phone_velocity : Vector2 = area.get_parent().velocity.normalized()
		print("RAAAWRYGIYAWGKDHSAKHDJ A PHONE ENTERED ME!!!")
		print(direction.dot(phone_velocity))
		if direction.dot(phone_velocity) > 0:
			print("Phone has the right dot product so I'm emitting")
			phone_recieved.emit(self)
			
