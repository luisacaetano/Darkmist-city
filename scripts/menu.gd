extends Node2D

func _ready():
	pass

func _on_button_pressed():
	get_tree().change_scene_to_file("res://cenas/Personagens.tscn")
	pass
	
func _on_button_2_pressed():
	get_tree().quit()
	pass 
