extends Node2D
var points = 200;
@export var scoreUI : Label;
func _ready() -> void:
	scoreUI.text = "Points: " + str(points);
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		var tower_scene = preload("res://Scenes/tower.tscn")  # Replace with your tower scene path
		var tower = tower_scene.instantiate()
		tower.position = get_global_mouse_position()
		# Check if the intended location is clear
		var space_state = get_world_2d().direct_space_state
		var shape = CircleShape2D.new();
		shape.radius = 70;
		var query = PhysicsShapeQueryParameters2D.new()
		query.shape = shape;
		query.collide_with_areas = true;
		query.collide_with_bodies = false;
		query.collision_mask = 1;
		query.transform = Transform2D(0, get_global_mouse_position())
		var result = space_state.intersect_shape(query, 2)  # Exclude the tower itself
		print(result);
		print(result.size())
		if result.is_empty():
			towerPlacement(tower)
		else:
			print("Cannot place tower here!")
func towerPlacement(tow):
	if (points >= 20):
		points -= 20;
		scoreUI.text = "Points: " + str(points);
		add_child(tow);
	else:
		print("not enough funds");
