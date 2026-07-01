extends Node2D

@export var schedule : Array[Array]
var paths : Array[Path2D]
@onready var timer = $Timer

# these variables will likely be moved elsewhere
const test_rounds = [
	# format: [enemy_type, number, delay] or [-1, 1, delay]
	[
		[0, 20, 1]
	],
	[
		[0, 35, 0.5],
	],
	[
		[0, 25, 0.5],
		[-1, 1, 1],
		[1, 5, 0.5]
	],
	[
		[0, 35, 0.5],
		[1, 18, 0.5]
	]
]
var roundn = 0;
var waven = 0;
var enemyn = 0;

func _ready() -> void:
	for i in get_children():
		if i is Path2D:
			paths.append(i)
	timer.start(test_rounds[roundn][waven][2])
	print("round 1")

func _process(delta: float) -> void:
	if roundn >= len(test_rounds): return
	if waven >= len(test_rounds[roundn]):
		if paths.all(func(x): return not x.get_children().any(func(y): return y is PathFollow2D)):
			waven = 0
			roundn += 1
			if roundn >= len(test_rounds):
				print("player win")
			else:
				print("round " + str(roundn + 1))
				timer.wait_time = test_rounds[roundn][waven][2]
				timer.start()

func _on_timer_timeout() -> void:
	if roundn >= len(test_rounds): return
	if waven >= len(test_rounds[roundn]): return
	if test_rounds[roundn][waven][0] >= 0:
		var sched = schedule[roundn % len(schedule)]
		var e = preload("res://Scenes/enemies.tscn").instantiate()
		e.modulate = [Color(3.157, 0.755, 0.493), Color.SKY_BLUE][test_rounds[roundn][waven][0]]
		e.scale *= [1, 1.1][test_rounds[roundn][waven][0]]
		paths[sched[enemyn % len(sched)]].spawn(e)
	enemyn += 1
	if enemyn >= test_rounds[roundn][waven][1]:
		enemyn = 0
		waven += 1
		if waven >= len(test_rounds[roundn]):
			pass
		else:
			timer.wait_time = test_rounds[roundn][waven][2]
