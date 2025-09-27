extends Node

var music_player: AudioStreamPlayer

func _ready():
	music_player = $AudioStreamPlayer  # Adjust the path if necessary
	music_player.play()  # Start playing the music
