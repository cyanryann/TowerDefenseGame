extends Path2D

var baked_points: PackedVector2Array
func _ready() -> void:
	baked_points = curve.tessellate(5, 4.0)
	
	var line = Line2D.new()
	for point in baked_points:
		line.add_point(point)
	line.width = 45
	line.show_behind_parent = true
	line.use_parent_material = true
	var line2 = line.duplicate()
	line2.width = 55
	line2.default_color = Color.CORNFLOWER_BLUE
	add_child(line2)
	add_child(line)
	
	var area = Area2D.new()
	for i in len(baked_points) - 1:
		var a = baked_points[i]
		var b = baked_points[i + 1]
		var coll = CollisionShape2D.new()
		var caps = CapsuleShape2D.new()
		caps.radius = 25
		caps.height = (b - a).length() + 50
		coll.position = (a + b) / 2
		coll.rotation = a.angle_to_point(b) - PI/2
		coll.shape = caps
		area.add_child(coll)
	add_child(area)
	
func _draw():
	pass
	# debug distance to path visualization
	'''
	for i in range(0, 1152, 4):
		for j in range(0, 648, 4):
			var x = get_viewport().get_canvas_transform().affine_inverse() * Vector2(i, j)
			var mind = INF
			for k in range(len(baked_points) - 1):
				var a = baked_points[k]
				var b = baked_points[k + 1]
				var t = clamp((x - a).dot(b - a) / (b - a).length_squared(), 0, 1)
				var d = (x - (a + t * (b - a))).length()
				if d < mind: mind = d
			draw_rect(Rect2(i, j, 4, 4), Color(1 / (1 + abs(mind - 25)/10), 0, 0), true)
	'''

func _process(delta: float) -> void:
	for i in get_children():
		if i is PathFollow2D:
			i.progress += (140 if i.get_child(0).modulate == Color.SKY_BLUE else 100) * delta # temp type check
			if i.progress_ratio >= 1:
				i.queue_free()
				print("player lose hp")
			else:
				# sprite stacking (just for fun) - set Path2D y-scale to 0.577
				'''
				var e = i.get_child(0).get_child(0)
				var s = null
				for j in e.get_children():
					if j is Sprite2D:
						if s == null: s = j.duplicate()
						j.queue_free()
				for j in 9:
					var sss = s.duplicate()
					sss.position = Vector2(1, 1).normalized().rotated(-i.rotation) * j * sqrt(2) * 32/8 * .5
					sss.z_as_relative = false
					sss.z_index = -10000
					sss.modulate = Color.BLACK
					e.add_child(sss)
				for j in 9:
					var ss = s.duplicate()
					ss.position = Vector2.UP.rotated(-i.rotation) * j * sqrt(2) * 32/8
					ss.z_as_relative = true
					ss.modulate = Color.WHITE
					e.add_child(ss)
				'''

func spawn(enemy : Node2D):
	var pf = PathFollow2D.new()
	pf.loop = false
	enemy.process_mode = Node.PROCESS_MODE_DISABLED # temporary fix
	pf.add_child(enemy)
	add_child(pf)
