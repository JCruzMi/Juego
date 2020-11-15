extends TextureButton

export var level_int = 0
export var level_proyec_dir = ''

func _ready():
	if level_int <= Globals.current_level:
		disabled = false
		$Label.visible = true
		$Label.text = str(level_int)
	else:
		disabled = true
		$Label.visible = false
		

func _on_btn_pressed():
	if level_proyec_dir != '':
		get_tree().change_scene(level_proyec_dir)
		
