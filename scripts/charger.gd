extends Area2D

# WARNING: CHARGER ONLY WORKS FACING DOWN
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("phone"):
		if Global.DEBUG_EASY_WIN or body.velocity.y < 0:
			print("phone entered charger")
			EventBus.phone_enter_charger.emit(self)
			print("finished emitted phone_enter_charger")
			set_deferred("monitoring", false)

func _ready() -> void:
	monitoring = false
	await get_tree().create_timer(2.0).timeout
	monitoring = true
	#var entry_vector : Vector2 = global_position.direction_to(body.global_position)
	#print(entry_vector)
	
	# if it entred the range of 180
	#print(entry_vector.dot(Vector2.UP))
	#if entry_vector.dot(Vector2.UP) > 0:
		#print("entered charger properly")
	#if body.is_in_group("phone"):
	#	print("Player detected in charger area")
		#EventBus.phone_enter_charger.emit(self)


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
