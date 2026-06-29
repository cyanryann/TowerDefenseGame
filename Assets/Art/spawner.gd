extends Node2D

@export var enemyScene: PackedScene

@onready var activeEnemies = $"../ActiveEnemies"
@onready var timer =$Timer

func _ready():
	timer.timeout.connect(spawnEnemy)

func spawnEnemy():
	var newEnemy = enemyScene.instantiate()
	
	newEnemy.global_position = self.global_position
	
	activeEnemies.add_child(newEnemy)


func _process(delta):
	pass
