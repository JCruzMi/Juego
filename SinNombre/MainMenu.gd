extends Control

func _ready():
	OS.center_window()


func _on_ButtonStart_pressed():
	get_tree().change_scene("res://mapa.tscn")
