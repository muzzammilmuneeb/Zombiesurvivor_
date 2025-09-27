extends CharacterBody2D

# Use a class variable for base health so it affects new instances
static var base_health: int = 2
var health: int = base_health

@onready var player = get_node("/root/Game/Player")
@onready var score_label = player.get_node("Score")

func _ready():
	# put this mob in the "enemies" group so the player can find it
	add_to_group("enemies")
	%Slime.play_walk()

func _physics_process(delta):
	# simple chase AI
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 150.0
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()

	# Mobs die
	if health <= 0:
		queue_free()
		# Increment the score when mob is defeated
		score_label.score += 10

# This gets called by the Player when you press E
func do_sacrifice():
	# Permanently double this mob's health
	health *= 2

	# Update the base health so new mobs spawn with the increased health
	base_health = health

	# Play smoke explosions
	const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke = SMOKE_SCENE.instantiate()
	get_parent().add_child(smoke)
	smoke.global_position = global_position
