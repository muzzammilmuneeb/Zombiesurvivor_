extends Node2D


@export var left_limit = -1880
@export var right_limit = 3800
@export var top_limit = -1040
@export var bottom_limit = 2085

func _ready():
	$AnimationPlayer.play("TreeBounce")  # Adjust based on your structure

	#set_process_unhandled_input(true)
		
	# Ensure the signal is not connected multiple times
	if not %RestartButton.is_connected("pressed", Callable(self, "_on_restart_button_pressed")):
		%RestartButton.connect("pressed", Callable(self, "_on_restart_button_pressed"))


func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	
	# Generate a random position along the path
	%PathFollow2D.progress_ratio = randf()
	var spawn_position = %PathFollow2D.global_position
	
	# Check if the spawn position is within the boundaries
	if spawn_position.x > left_limit and spawn_position.x < right_limit and spawn_position.y > top_limit and spawn_position.y < bottom_limit:
		
		# If within boundaries, spawn the mob
		new_mob.global_position = spawn_position
		add_child(new_mob)
	else:
		# If out of bounds, retry spawning
		spawn_mob()

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true

func _on_restart_button_pressed():
	#print("Restart button pressed")
	## Reset game state
	#get_tree().paused = false
	#%GameOver.visible = false
	#
	## Reset player health and position
	#var player = %Player
	#player.reset_health()
	#player.global_position = Vector2(1000, 500)  # or wherever the starting position should be
#
	## Remove all mobs
	#for mob in get_tree().get_nodes_in_group("Mobs"):
		#mob.queue_free()
		#
		#
	## Restart the timer or any other necessary game elements
	#$Timer.start()
	##get_tree().reload_current_scene()
	get_tree().paused = false
	%GameOver.visible = false
	get_tree().reload_current_scene()
