
extends Node2D

var scene
var sheep = []
var eggs = []
var exits = 0 # number of sheep that exited the map

var max_sheep = 10

var keys = ["q","w","a","s","e","r","d","f","t","z","g","h"]
var scans = [KEY_Q, KEY_W, KEY_A, KEY_S, KEY_E, KEY_R, KEY_D, KEY_F, KEY_T, KEY_Z, KEY_G, KEY_H]
var keys_used = []

var ready = 1.5
func first_free_key():
	var id = range(0,keys.size())
	for i in id:
		if !(keys[i] in keys_used):
			keys_used.append(keys[i])
			keys_used.append(keys[i+1])
			return i
	return -1

func _ready():
	# Initialization here
	# spawn 2 sheep
	set_process(true)
	scene = load("res://sheep.scn")
	
	var j = first_free_key()
	sheep.append(scene.instance())
	sheep[0].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j],keys[j+1], scans[j], scans[j+1])
	sheep[0].get_node("KinematicBody2D").setDir(-1)
	sheep[0].set_pos(Vector2(rand_range(70,300),316.5))
	sheep[0].set_z(1)
	add_child(sheep[0])
	
	var j = first_free_key()
	sheep.append(scene.instance())
	sheep[1].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j],keys[j+1], scans[j], scans[j+1])
	sheep[1].get_node("KinematicBody2D").setDir(1)
	sheep[1].set_pos(Vector2(rand_range(500,600),316.5))
	sheep[1].set_z(1)
	add_child(sheep[1])
	
func _process(delta):
	if ready > 0:
		ready -= delta
		get_tree().set_pause(true)
		return
	else:
		get_tree().set_pause(false)

	get_node("background/progress/progress").set_value(float(exits)/max_sheep)

	for v in eggs:
		if not v.get_node("Egg/egganim").is_playing():
			sheep.append(scene.instance())
			var i = sheep.size()-1
			var j = first_free_key()
			if j == -1:
				eggs.remove(eggs.size()-1)
				continue
			sheep[i].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j],keys[j+1], scans[j], scans[j+1])
			sheep[i].get_node("KinematicBody2D").setDir(rand_range(-1,1))
			sheep[i].set_pos(v.get_pos())
			sheep[i].set_z(1)
			
			eggs.remove(eggs.size()-1)
			
			add_child(sheep[i])
	
	var id = range(0,sheep.size())
	for s in id:
		var v = sheep[s]
		var pos = v.get_node("KinematicBody2D").get_global_pos()
		if pos.y > 1080:
			print("removing")
			for j in keys_used:
				if j == v.get_node("KinematicBody2D/SheepCollider/Sheep").k1:
					keys_used.remove(j)
					print("y")
					break
			for j in keys_used:
				if j == v.get_node("KinematicBody2D/SheepCollider/Sheep").k2:
					keys_used.remove(j)
					print("y")
					break
			remove_child(v)
			sheep.remove(s)
			break
		if pos.x < -50:
			print("removing")
			exits += 1
			for j in keys_used:
				if j == v.get_node("KinematicBody2D/SheepCollider/Sheep").k1:
					keys_used.remove(j)
					print("y")
					break
			for j in keys_used:
				if j == v.get_node("KinematicBody2D/SheepCollider/Sheep").k2:
					keys_used.remove(j)
					print("y")
					break
			sheep.remove(s)
			remove_child(v)
			break