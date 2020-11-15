extends Control

func _ready():
	OS.center_window()


func _on_ButtonStart_pressed():
	var data_game = {
	'current_level' : 1
	}
	var file = File.new()
	file.open('res://data.save', File.WRITE)
	
	file.store_line(to_json(data_game))
	file.close()
	get_tree().change_scene("res://selectorNiveles/selector.tscn")


func _on_ButtonLoad_pressed():
	get_tree().change_scene("res://selectorNiveles/selector.tscn")
