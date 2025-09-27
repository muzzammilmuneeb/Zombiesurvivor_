extends Node

#func _ready():
	#print("Global script is ready and working!")
	#set_process(true)  # Ensure this script always processes
#
func _process(delta):
	if get_tree().paused or !get_tree().paused:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()
