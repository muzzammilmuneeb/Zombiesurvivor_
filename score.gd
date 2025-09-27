extends Label

@export var score = 0

func _process(delta):
	self.text = str(score)
