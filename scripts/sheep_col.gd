
extends KinematicBody2D

var ev
func _ready():
	set_fixed_process(true)
	set_process_input(true)
	
	var anmNode = get_node("SheepCollider/Sheep").get_node("Movement")
	anmNode.play("eat_r")
	pass

var mirror = 1
var vspeed = 250
func _fixed_process(delta):
	# display keys
	if get_node("SheepCollider/Sheep").k1:
		get_node("Label_1/Text").add_text(get_node("SheepCollider/Sheep").k1)
	if get_node("SheepCollider/Sheep").k2:
		get_node("Label_2/Text").add_text(get_node("SheepCollider/Sheep").k2)
	
	var anmNode = get_node("SheepCollider/Sheep").get_node("Movement")
	var num = rand_range(0,5)
	var eating = false
	if num > 4:
		eating = true
		
	if get_node("SheepCollider/Sheep").sexytime:
		anmNode.play("sexytime")
		get_node("SheepCollider/Sheep").sexytime = false
	
	# sheep aint movin while eatin'
	var curAn = anmNode.get_current_animation()

	if is_colliding():
		print(get_collision_normal())
		if get_collision_normal().y > -0.6: #not a ground collision
			if get_collider().get_type() == "StaticBody2D":
				mirror *= -1
		if get_collision_normal().y > 0.6: #ceiling
			anmNode.stop()
			anmNode.play("falling")
			print("ya")

	# falling down
	if curAn != "jump_l" and curAn != "jump_r":
		var hspeed = 200
		if vspeed <= 100:
			vspeed = 100
		vspeed += 270*delta
		
		var x = mirror*delta*hspeed
		var y = delta*vspeed
		
		var dir = Vector2(0,y)
		
		# actually falling
		if not test_move(dir):
			#if not anmNode.is_playing():
			if mirror == 1:
				anmNode.play("falling_r")
			else:
				anmNode.play("falling_l")
			
			move(Vector2(x,y))
		else:
			vspeed -= 270*delta

	if not anmNode.is_playing():
		# sexy time is over
		get_node("SheepCollider/Sheep").show()
		
		# sometimes, a sheep just wants to eat
		if mirror == 1:	
			if eating:
				anmNode.play("eat_r")
			else:
				anmNode.play("move_r")
		else:
			if eating:
				anmNode.play("eat_l")
			else:
				anmNode.play("move_l")
			
	if (curAn == "move_l" or curAn == "move_r"):
		var speed = get_node("SheepCollider/Sheep").speed
		vspeed = 250

		var dir = Vector2(mirror*delta*speed*((anmNode.get_current_animation_pos())+0.3),0)
		move(dir)
	
	# jump takes 1s
	if curAn == "jump_l" or curAn == "jump_r":
		var hspeed = 200
		vspeed -= 270*delta
		
		var dir = Vector2(mirror*delta*hspeed,-delta*vspeed)
		move(dir)
	
func _input(ev):
	var anmNode = get_node("SheepCollider/Sheep").get_node("Movement")
	var curAn = anmNode.get_current_animation()
	if curAn == "sexytime":
		return
	if curAn == "falling_l" or curAn == "falling_r":
		return
	if curAn == "jump_l" or curAn == "jump_r":
		return
	if get_node("SheepCollider/Sheep").jumpwait > 0:
		return

	if ev.is_pressed() and ev.type == InputEvent.KEY and ev.scancode == get_node("SheepCollider/Sheep").s2:
		get_node("SheepCollider/Sheep").jumpwait = 0
		if mirror == 1:
			anmNode.play("jump_r")
		else:
			anmNode.play("jump_l")
	pass
	
func setDir(d):
	mirror = sign(d)
	if mirror == 0:
		mirror = 1