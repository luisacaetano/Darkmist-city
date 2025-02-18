extends Node

var player : CharacterBody2D = null  # Ajuste o tipo conforme o tipo real do jogador
var playerDir : String
var playerSelecionado : String = "" 

func _ready():
	pass

func instance_node(node: PackedScene, location: Vector2, parent: Node) -> Node:
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location

	if node_instance is CharacterBody2D:
		player = node_instance
	return node_instance

# Adicione este método para definir o jogador globalmente
func set_player(node: CharacterBody2D) -> void:
	player = node
