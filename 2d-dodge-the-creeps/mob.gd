extends RigidBody2D

@export var min_speed = 150.0
@export var max_speed = 250.0

#run when monster is added to game scene
func _ready():
	$AnimatedSprite2D.play()
	#list of animation names
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	#selects random mob
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]


func _on_visible_on_screen_notifier_2d_screen_exited():
	#destroying the monster
	queue_free()
