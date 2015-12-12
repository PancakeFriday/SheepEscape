
extends Node2D

var scene
var sheep = []
var eggs = []

var keys = ["q","w","a","s","e","r","d","f","t","z","g","h"]
var scans = [KEY_Q, KEY_W, KEY_A, KEY_S, KEY_E, KEY_R, KEY_D, KEY_F, KEY_T, KEY_Z, KEY_G, KEY_H]
var keys_used = []
func first_free_key():
	var id = range(0,keys.size()+1)
	for i in id:
		if !(keys[i] in keys_used):
			keys_used.append(keys[i])
			keys_used.append(keys[i+1])
			return i

func _ready():
	# Initialization here
	# spawn 2 sheep
	set_process(true)
	scene = load("res://sheep.scn")
	
	for i in range(0,2):
		randomize()
		var j = first_free_key()
		sheep.append(scene.instance())
		sheep[i].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j],keys[j+1], scans[j], scans[j+1])
		sheep[i].get_node("KinematicBody2D").setDir(rand_range(-1,1))
		sheep[i].set_pos(Vector2(rand_range(50,500),316.5))
		sheep[i].set_z(1)
		
		add_child(sheep[i])
	
func _process(delta):
	get_node("background/progress/progress").set_value(float(sheep.size())/6)
	
	for v in eggs:
		if not v.get_node("Egg/egganim").is_playing():
			sheep.append(scene.instance())
			var i = sheep.size()-1
			var j = first_free_key()
			print(j)
			sheep[i].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j],keys[j+1], scans[j], scans[j+1])
			sheep[i].get_node("KinematicBody2D").setDir(rand_range(-1,1))
			sheep[i].set_pos(v.get_pos())
			sheep[i].set_z(1)
			
			add_child(sheep[i])
			
			eggs.remove(eggs.size()-1)