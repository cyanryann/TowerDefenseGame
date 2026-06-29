extends CharacterBody2D


#Variables that define the properties of the enemy
@export var maxHealth = 2
@export var speed = 100
var direction = Vector2.RIGHT
var curHealth





# When its loaded it sets health to max and prints so i can see if it worked
func _ready():
	curHealth = maxHealth
	print("new enemy created, ", "Health: ", curHealth, "/", maxHealth)


#would movement go here? idk.
func _process(delta):
	velocity = direction * speed
	move_and_slide()

#dont really know exactly what each part does in the func params
#checks to see if someone left clicked the enemy and does damage if true
func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		takeDamage(1)
#call this to decrease health of enemy. calls die if it reaches 0.
func takeDamage(damage):
	curHealth -= damage
	
	if curHealth > 0:
		print("enemy has taken damage, Health: ", curHealth, "/", maxHealth)
		
	if curHealth == 0:
		die()
	
	
#removes the enemy from map. Unsure if queue free is the right thing to use.	
func die():
	print("enemy has died")
	queue_free()
	
