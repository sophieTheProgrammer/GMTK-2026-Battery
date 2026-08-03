class_name Charger
extends Area2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
signal phone_recieved
@onready var direction : Vector2 = Vector2.from_angle(rotation - 90)

func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("phone"):
		var phone_velocity : Vector2 = area.get_parent().velocity.normalized()
		print("RAAAWRYGIYAWGKDHSAKHDJ A PHONE ENTERED ME!!!")
		#print(direction.dot(phone_velocity))
		if direction.dot(phone_velocity) > 0.5:
			print("Phone has the right dot product so I'm emitting")
			phone_recieved.emit(self)
			
