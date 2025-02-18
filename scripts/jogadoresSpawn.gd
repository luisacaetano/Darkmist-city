extends Node2D

@onready var jogadorposition = $CharacterBody2D
@onready var personagem_sprite = $AnimatedSprite2D

var player : Node2D = null

func _ready():
	# Carrega a cena do jogador a partir do caminho em Global.playerDir
	var player_scene = load(Global.playerDir)
	
	# Verifica se a cena foi carregada corretamente
	if player_scene and player_scene is PackedScene:
		# Instancia a cena do jogador
		player = player_scene.instantiate()
		
		# Define a posição global do jogador
		player.global_position = jogadorposition.global_position
		
		# Adiciona o jogador como filho deste nó
		add_child(player)
	else:
		print("Erro: Cena do jogador não foi carregada corretamente ou o caminho é inválido.")
