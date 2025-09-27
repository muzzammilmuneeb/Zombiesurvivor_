extends Node2D

func _ready():
	set_process(true)
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED  # Ensure input is processed when the game is paused

func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
