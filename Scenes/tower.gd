extends Node2D
var attackOrder = [];
@onready var timer = $AttackTimer;
var isAttacking = false;
func _process(delta: float) -> void:
	pass
	


func _on_attack_range_body_entered(body: Node2D) -> void:
	if (body.get_groups().has("enemy")):
		if (attackOrder.is_empty()):
			isAttacking = true;
			attackOrder.push_back(body);
			timer.start();
		else:
			attackOrder.push_back(body);



func _on_attack_range_body_exited(body: Node2D) -> void:
	if (attackOrder.has(body)):
		attackOrder.pop_front();
		if (attackOrder.is_empty()):
			isAttacking = false;


func _on_attack_timer_timeout() -> void:
	if (!isAttacking):
		timer.stop();
	else:
		attack(attackOrder[0]);
	
func attack(enemy):
	pass
		
