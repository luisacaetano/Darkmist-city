extends Node

# Caminhos dos inimigos
var inimigos_paths = {
	"Marker2D1": ["res://cenas/InimigoOrc1.tscn"],
	"Marker2D2": ["res://cenas/InimigoOrc2.tscn"],
	"Marker2D3": ["res://cenas/InimigoOrc3.tscn"],
	"Marker2D4": ["res://cenas/InimigoMortoVivo1.tscn"],
	"Marker2D5": ["res://cenas/InimigoMortoVivo2.tscn"],
	"Marker2D6": ["res://cenas/InimigoMortoVivo1.tscn"],
	"Marker2D7": ["res://cenas/InimigoMortoVivo3.tscn"],
	"Marker2D8": ["res://cenas/InimigoDemônio1.tscn"],
	"Marker2D9": ["res://cenas/InimigoDemônio1.tscn"],
	"Marker2D10": ["res://cenas/InimigoDemônio3.tscn"],
	"Marker2D11": ["res://cenas/InimigoDemônio2.tscn"],
	"Marker2D12": ["res://cenas/InimigoDemônio2.tscn"],
	"Marker2D13": ["res://cenas/InimigoFortaleza3.tscn"],
	"Marker2D14": ["res://cenas/InimigoFortaleza2.tscn"],
	"Marker2D15": ["res://cenas/InimigoFortaleza1.tscn"],
	"Marker2D16": ["res://cenas/InimigoFortaleza1.tscn"],
}

var pontos_spawn = []
var inimigos = {}

func _ready():
	# Define a semente para garantir aleatoriedade
	randomize()

	# Adiciona todos os pontos de spawn ao array
	for i in range(1, 17):
		var point_path = "Marker2D" + str(i)
		var ponto_spawn = get_node_or_null(point_path)
		if ponto_spawn:
			pontos_spawn.append(ponto_spawn)
			print("Ponto de spawn adicionado: ", point_path)
		else:
			print("Ponto de spawn não encontrado: ", point_path)

	if pontos_spawn.size() == 0:
		print("Nenhum ponto de spawn encontrado!")

	# Carrega inimigos para cada ponto de spawn
	for point_name in inimigos_paths.keys():
		var point_inimigos = inimigos_paths[point_name]
		inimigos[point_name] = []
		for path in point_inimigos:
			var inimigo = load(path)
			if not inimigos[point_name].has(inimigo):
				inimigos[point_name].append(inimigo)
		print("Inimigos configurados para o ponto de spawn: ", point_name, inimigos[point_name])

	# Instancia todos os inimigos no início do jogo
	instanciar_inimigos()

func instanciar_inimigos():
	for ponto_spawn in pontos_spawn:
		var point_name = ponto_spawn.name
		var inimigos_possiveis = inimigos.get(point_name, [])
		if inimigos_possiveis.size() == 0:
			print("Nenhum inimigo configurado para o ponto de spawn: ", point_name)
			continue

		var inimigo_index = randi_range(0, inimigos_possiveis.size() - 1)
		var inimigo_path = inimigos_possiveis[inimigo_index]
		var inimigo = inimigo_path.instantiate()

		if inimigo and ponto_spawn:
			inimigo.global_position = ponto_spawn.global_position
			if inimigo.has_node("AnimatedSprite2D"):
				inimigo.get_node("AnimatedSprite2D").play("default")
			add_child(inimigo)
			print("Inimigo instanciado no ponto de spawn: ", point_name)
		else:
			print("Erro: Inimigo ou ponto de spawn não encontrado!")
