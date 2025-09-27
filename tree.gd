extends Node2D  # or the appropriate type for your TreeGroup node

func _ready():
	$AnimationPlayer.play("TreeBounce")  # This assumes AnimationPlayer is a direct child
