extends CharacterBody2D

signal health_depleted

@onready var joystick = $Joystick

var max_health = 100.0
var current_health = max_health
	

func _process(delta):
	# watch for E (or whatever you mapped)
	if Input.is_action_just_pressed("sacrifice"):
		do_sacrifice()
		
func _ready():
	$sacrifcebutton.pressed.connect(_on_sacrificebutton_pressed)

func _on_sacrificebutton_pressed():
	do_sacrifice()
	
func do_sacrifice():
	# heal the player
	current_health = max_health
	%ProgressBar.value = current_health   # update UI bar too

	# strengthen all enemies
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy.has_method("do_sacrifice"):
			enemy.do_sacrifice()

	print("Sacrifice pressed. Player healed, enemies strengthened.")

func reset_health():
	current_health = max_health

func _physics_process(delta):
	var keyboard_direction = Input.get_vector('move_left', 'move_right', 'move_up', 'move_down')
	var joystick_direction = joystick.posVector
	var direction = keyboard_direction + joystick_direction

	if direction:
		velocity = direction * 900
	else:
		velocity = Vector2.ZERO
	move_and_slide()

	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()

	const DAMAGE_RATE = 50.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		current_health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = current_health
		if current_health <= 0.0:
			health_depleted.emit()
