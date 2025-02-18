extends Node2D

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass

# Reinicar
func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/Mundo.tscn")

# Menu Principal
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/Menu.tscn")

# Sair
func _on_button_4_pressed() -> void:
	get_tree().quit()

# Continuar
func _on_button_pressed() -> void:
	get_tree().paused = false  # Despausa o jogo
	queue_free()  # Fecha o menu de pausa
