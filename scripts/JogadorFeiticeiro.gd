extends CharacterBody2D

@export var SPEED:float = 50.0
const JUMP_VELOCITY:float = -400.0

@onready var animacoes = $AnimatedSprite2D
var gravidade = ProjectSettings.get_setting("physics/2d/default_gravity")
var coins: int = 0 
@export var vida: int = 20
var canAttack = true
var InimigoCol:bool = false
var inimigo = null
var dano: int = 4
var pontos: int = 0 

func _ready():
	add_to_group("jogador")
	pass

func _physics_process(delta):
	# Movimentação vertical com gravidade
	if not is_on_floor():
		velocity.y += gravidade * delta

	# Pulo
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movimentação horizontal
	var direcaoX := Input.get_axis("ui_left", "ui_right")
	var direcaoY := Input.get_axis("ui_up", "ui_down")  # Adicionando movimento vertical
	
	# Atualiza a velocidade horizontal
	if direcaoX != 0:
		velocity.x = direcaoX * SPEED
		animacoes.play("run")
		animacoes.flip_h = direcaoX < 0  # Flip horizontal baseado na direção
	else:
		velocity.x = 0
	
	# Atualiza a velocidade vertical
	if direcaoY != 0:
		velocity.y = direcaoY * SPEED
		animacoes.play("run")  # Pode ser necessário ajustar as animações para movimento vertical
	else:
		velocity.y = 0

	# Movimentação do jogador
	move_and_slide()

	# Verifica condição de Game Over
	GameOver()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if inimigo != null and InimigoCol:
			Attack(inimigo, dano)
	
func GameOver() -> void:
	if vida <= 0: 
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("spike"):
		vida -= 2
	if body.is_in_group("inimigo"):
		InimigoCol = true	
		inimigo = body
	
func Attack(inimigo, dano) -> void:
	if canAttack and inimigo != null: 
		inimigo.vida -= dano
		if inimigo.vida <= 0: 
			pontos += 1
			inimigo.queue_free()  # Remover o inimigo da cena
		$Timer.start()
		canAttack = false

func _on_timer_timeout():
	canAttack = true
	
func _on_area_2d_body_exited(body):
	if body.is_in_group("inimigo"):
		InimigoCol = false
		inimigo = null  # Limpa a referência ao inimigo
		
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/MenuPause.tscn")
	pass # Replace with function body.
