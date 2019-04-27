extends KinematicBody2D

var SPEED = 175
var movedir = Vector2()

func _physics_process(delta):
	movement_loop()
	
	#change the animation state based off of if we are moving
	if movedir != Vector2(0, 0):
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")
	#grab all possible inputs for our player
	var LEFT	= Input.is_action_pressed("ui_left")
	var RIGHT	= Input.is_action_pressed("ui_right")
	var UP		= Input.is_action_pressed("ui_up")
	var DOWN	= Input.is_action_pressed("ui_down")
	
	#flip sprite if on x axis if we're facing a left or right
	if (LEFT):
		$AnimatedSprite.flip_h = true
	elif (RIGHT):
		$AnimatedSprite.flip_h = false
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)
	
func movement_loop():
	var motion = movedir.normalized() * SPEED
	move_and_slide(motion, Vector2(0, 0))

func _on_ghost_timer_timeout():
	#get the ghost node
	var this_ghost = preload("res://Scenes/ghost.tscn").instance()
	#give ghost a parent
	get_parent().add_child(this_ghost)
	this_ghost.position = position;
	this_ghost.texture = $AnimatedSprite.frames.get_frame($AnimatedSprite.animation, $AnimatedSprite.frame)
	this_ghost.flip_h = $AnimatedSprite.flip_h
