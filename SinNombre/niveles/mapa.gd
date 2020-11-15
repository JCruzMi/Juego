extends Node2D

export var level_int = 1

func _ready():
	if level_int >= Globals.current_level:
		Globals.current_level += 1
		
