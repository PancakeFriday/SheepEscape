
extends KinematicBody2D

var ev
func _ready():
	set_fixed_process(true)
	pass

var mirror = 1
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
	
	# sheep aint movin while eatin'
	var curAn = anmNode.get_current_animation()
	if (curAn == "move_l" or curAn == "move_r"):
		var speed = 200
		var pos = get_pos()
		if is_colliding():
			if get_collider().get_type() == "StaticBody2D":
				mirror *= -1

		if anmNode.get_current_animation_pos() > 0.25:
			if anmNode.get_current_animation_pos() < 0.65:
				var dir = Vector2(mirror*delta*speed,0)
				move(dir)
	pass
	
func setDir(d):
	mirror = sign(d)
	if mirror == 0:
		mirror = 1