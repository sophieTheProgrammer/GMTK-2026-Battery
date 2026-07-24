extends CanvasLayer

@export var debug_toggle_btn: Button
@export var fps_label: Label
@export var debug_v_box: VBoxContainer

var debug_vars_to_update : Dictionary = {}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_fps()
	

## WARNING: WILL CAUSE PROBLEMS IF YOU HAVE 2 VARS YOU WANT TO DISPLAY BUT THEY HAVE THE SAME NAME
## EVERYTIME YOU RUN IT IT IT WILL UPDATE THAT VARIABLE SO THE BEST IS TO PUT IT INx
func display_debug_var(name : String, variable : Variant) -> void:
	# if it is not in the list of vars to update then create a label
	if name not in debug_vars_to_update.keys():
		var new_label : Label 	= Label.new()
		new_label.text = name + ": " + str(variable)
		new_label.name = name
		debug_v_box.add_child(new_label)
		debug_vars_to_update[name] = new_label
	else: # otherwise update the debug var
		#print("variable updated")
		debug_vars_to_update[name].text = name + ": " + str(variable)
 
func _update_fps() -> void:
	fps_label.text = "FPS: " + str(Engine.get_frames_per_second())

func _on_debug_toggle_button_up() -> void:
	if debug_toggle_btn.text == "off":
		debug_toggle_btn.text = "on"
		Global.debug_mode = true

	else:
		debug_toggle_btn.text = "off"
		Global.debug_mode = false
	print("debug mode is now: " + str(Global.debug_mode))
