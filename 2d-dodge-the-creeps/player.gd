extends Area2D

#know that player was hit
signal hit

#player's movement speed
@export var speed = 400.0
var screen_size = Vector2.ZERO

#gives size of game viewport
func _ready():
	screen_size = get_viewport_rect().size
	hide()

#how character updates every frame
func _process(delta):
	#player's input direction
	var direction = Vector2.ZERO
	#check player's input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	
	if direction.length() > 0:
		direction = direction.normalized()
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += direction * speed * delta
	#limit value between two other values
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	#player animation
	if direction.x !=0:
		$AnimatedSprite2D.animation = "right"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = direction.x < 0
	elif direction.y !=0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = direction.y > 0 

#start	
func start(new_position):
	position = new_position
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	hide()
	$CollisionShape2D.set_deferred("disabled",true)
	emit_signal("hit")
