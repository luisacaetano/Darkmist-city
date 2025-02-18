extends CharacterBody2D

@export var SPEED = 30.0

@onready var animacoes = $AnimatedSprite2D
@onready var detection_area = $Area2D 

var player: CharacterBody2D = null
var vida: int = 5 
var dano: int = 1
var playerCol: bool = false
var move_velocity = Vector2.ZERO

func _ready():
	# Tenta encontrar o jogador diretamente no grupo "jogador"
	var jogadores = get_tree().get_nodes_in_group("jogador")
	if jogadores.size() > 0:
		player = jogadores[0] as CharacterBody2D
		if player:
			print("Jogador encontrado: ", player)
		else:
			print("O jogador encontrado não é do tipo CharacterBody2D!")
	else:
		print("Nenhum jogador encontrado no grupo 'jogador'.")

	animacoes.play("default")

	if detection_area:
		detection_area.connect("body_entered", Callable(self, "_on_detection_area_body_entered"))
		detection_area.connect("body_exited", Callable(self, "_on_detection_area_body_exited"))
		print("Sinais de detecção conectados.")
	else:
		print("Erro: DetectionArea não encontrado.")

func _physics_process(delta):
	if player and playerCol:
		var direcao = global_position.direction_to(player.global_position)
		move_velocity = direcao * SPEED
		
		if move_velocity.length() > 0:
			animacoes.play("run")
			animacoes.flip_h = (move_velocity.x < 0)
		else:
			animacoes.play("default")
		
		velocity = move_velocity
		move_and_slide()
		
		Morte()
		if player and playerCol:
			Attack(player, dano)
	else:
		animacoes.play("default")

func Attack(player: CharacterBody2D, dano: int) -> void:
	if player and player is CharacterBody2D:
		if player.has_method("get_vida"):
			player.vida -= dano
			print("Vida do jogador: ", player.vida)
			$Timer.start()
		else:
			print("A propriedade 'vida' não existe no jogador!")
	else:
		print("O jogador não é do tipo CharacterBody2D!")

func Morte() -> void:
	if vida <= 0:
		queue_free()

func _on_detection_area_body_entered(body):
	if body.is_in_group("jogador"):
		player = body as CharacterBody2D
		playerCol = true
		print("Jogador detectado, inimigo começando a se mover.")

func _on_detection_area_body_exited(body):
	if body.is_in_group("jogador"):
		playerCol = false
		print("Jogador saiu do campo de visão, inimigo parando.")

func _on_timer_timeout():
	if playerCol and player:
		Attack(player, dano)
