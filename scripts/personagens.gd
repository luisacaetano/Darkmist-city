extends Node2D

@onready var animacoes = $TileMap/AnimatedSprite2D
@onready var animacoes2 = $TileMap/AnimatedSprite2D2
@onready var animacoes3 = $TileMap/AnimatedSprite2D3
@onready var animacoes4 = $TileMap/AnimatedSprite2D4
@onready var animacoes5 = $TileMap/AnimatedSprite2D5

var jogadorCavaleiro = "res://cenas/JogadorCavaleiro.tscn"
var jogadorExplorador = "res://cenas/JogadorExplorador.tscn"
var jogadorFeiticeiro = "res://cenas/JogadorFeiticeiro.tscn"
var jogadorGoblin = "res://cenas/JogadorGoblin.tscn"
var jogadorGuerreiro = "res://cenas/JogadorGuerreiro.tscn"

func _ready():
	pass 
	
func goToScene():
	get_tree().change_scene_to_file("res://cenas/Habilidades.tscn")
	pass

func _physics_process(delta):
	animacoes.play("default")
	animacoes2.play("default")
	animacoes3.play("default")
	animacoes4.play("default")
	animacoes5.play("default")

func _on_button_pressed():
	Global.playerSelecionado = "Explorador"
	Global.playerDir = jogadorExplorador
	goToScene()

func _on_button_2_pressed():
	Global.playerSelecionado = "Goblin"
	Global.playerDir = jogadorGoblin
	goToScene()
	
func _on_button_3_pressed():
	Global.playerSelecionado = "Guerreiro"
	Global.playerDir = jogadorGuerreiro
	goToScene()
	
func _on_button_4_pressed():
	Global.playerSelecionado = "Cavaleiro"
	Global.playerDir = jogadorCavaleiro
	goToScene()

func _on_button_5_pressed():
	Global.playerSelecionado = "Feiticeiro"
	Global.playerDir = jogadorFeiticeiro
	goToScene()
