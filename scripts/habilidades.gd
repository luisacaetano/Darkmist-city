extends Node2D

@onready var personagem_container = $TileMap/Node2D  # Certifique-se de que isso é um Node2D ou similar
@onready var titulo = $TileMap/Label
@onready var descricao = $TileMap/Label2
@onready var habilidades = $TileMap/Label4

var jogadorCavaleiro = preload("res://cenas/JogadorCavaleiro.tscn")
var jogadorExplorador = preload("res://cenas/JogadorExplorador.tscn")
var jogadorFeiticeiro = preload("res://cenas/JogadorFeiticeiro.tscn")
var jogadorGoblin = preload("res://cenas/JogadorGoblin.tscn")
var jogadorGuerreiro = preload("res://cenas/JogadorGuerreiro.tscn")

func _ready():
	if not personagem_container:
		print("Erro: personagem_container não encontrado.")
		return
	
	var personagem_selecionado = Global.playerSelecionado
	var scene_path = null

	match personagem_selecionado:
		"Explorador":
			scene_path = jogadorExplorador
			titulo.text = "Jogador: Explorador"
			descricao.text = "Ágeis e curiosos, os Exploradores são especialistas em navegar por terrenos difíceis \n e descobrir segredos ocultos. Eles usam sua velocidade e inteligência para evitar confrontos \ndiretos, preferindo ataques à distância."
			habilidades.text = "Disparo Rápido: Atira uma flecha rapidamente em linha reta, causando dano ao \nprimeiro inimigo atingido.\n\nEvasão: Temporariamente aumenta a chance de esquivar ataques inimigos.\n\nArmadilha de Urso: Coloca uma armadilha no chão que prende e causa dano \nao primeiro inimigo que pisar nela."
		"Cavaleiro":
			scene_path = jogadorCavaleiro
			titulo.text = "Jogador: Cavaleiro"
			descricao.text = "Os Cavaleiros são defensores honrados e protetores do reino. Equipados com armaduras \npesadas e espadas, eles são especialistas em combate corpo a corpo e proteção de aliados."
			habilidades.text = "Disparo Rápido: Atira uma flecha rapidamente em linha reta, causando dano \nao primeiro inimigo atingido.\n\nEvasão: Temporariamente aumenta a chance de esquivar ataques inimigos.\n\nArmadilha de Urso: Coloca uma armadilha no chão que prende e causa dano ao \nprimeiro inimigo que pisar nela."
		"Feiticeiro":
			scene_path = jogadorFeiticeiro
			titulo.text = "Jogador: Feiticeiro"
			descricao.text = "Mestres das artes arcanas, os Feiticeiros lançam feitiços poderosos para atacar inimigos \napoiar aliados. Eles são vulneráveis em combate corpo a corpo, mas devastadores\n à distância."
			habilidades.text = "Bola de Fogo: Lança uma bola de fogo que causa dano ao atingir um inimigo.\n\nCura Arcana: Restaura a vida de um aliado ou do próprio feiticeiro.\n\nEscudo Mágico: Cria uma barreira temporária que absorve uma certa \nquantidade de dano."
		"Goblin":
			scene_path = jogadorGoblin
			titulo.text = "Jogador: Goblin"
			descricao.text = "Pequenos e astutos, os Goblins são criaturas traiçoeiras que atacam em grupos. Eles são \nrápidos e difíceis de acertar, preferindo táticas de guerrilha para derrotar seus \noponentes."
			habilidades.text = "Ataque Furtivo: Realiza um ataque surpresa que causa dano adicional se o \ninimigo estiver distraído.\n\nFumaça Envenenada: Lança uma bomba de fumaça que envenena os inimigos \nna área, causando dano ao longo do tempo.\n\nRoubo: Tenta roubar um item ou ouro do inimigo."
		"Guerreiro":
			scene_path = jogadorGuerreiro
			titulo.text = "Jogador: Guerreiro"
			descricao.text = "Os Guerreiros são combatentes corajosos e habilidosos, treinados para enfrentar qualquer \nameaça de frente. Eles combinam força bruta com táticas de combate para dominar \nseus inimigos."
			habilidades.text = "Ataque Poderoso: Um golpe forte que causa dano extra ao inimigo.\n\nGrito de Batalha: Aumenta temporariamente o ataque e a moral dos aliados \npróximos.\n\nBerserk: Entra em um estado de fúria que aumenta o dano causado, mas \nreduz a defesa por um curto período."

func _physics_process(delta):
	# Remove a chamada ao `play` aqui se o AnimatedSprite2D estiver sendo controlado pela cena do personagem
	pass
	
func goToScene():
	get_tree().change_scene_to_file("res://cenas/Mundo.tscn")

func _on_button_pressed():
	goToScene()

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://cenas/Personagens.tscn")
