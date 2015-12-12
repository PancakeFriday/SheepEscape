
extends KinematicBody2D

func _ready():
	set_fixed_process(true)
	pass

var mirror = 1
func _fixed_process(delta):
	var anmNode = get_node("Sheep").get_node("Movement")
	if is_colliding():
		print("ya")
		mirror *= -1
	#else:
	#	print("nope")
	if not anmNode.is_playing():
		if mirror == 1:
			anmNode.play("move_r")
		else:
			anmNode.play("move_l")
	
	var speed = 200
	if anmNode.get_current_animation_pos() > 0.25:
		if anmNode.get_current_animation_pos() < 0.65:
			var dir = Vector2(mirror*delta*speed,0)
			print(get_pos())
			move(dir)
	pass
