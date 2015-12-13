
extends Node2D

var scene
var sheep = []
var eggs = []
var exits = 0 # number of sheep that exited the map

var max_sheep = 1

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
	
	get_node("background/progress/progress").set_value(0,max_sheep)
	
var gameOverScene
var gameOverInst
var gameOverTime = 0
var clearScene
var clearInst
var clearTime = 0
var dialoguetime = 0
var spawnsheep = false
var removecrate = false
func _process(delta):
	var dia = get_node("dialogue/label")
	dialoguetime += delta
	if dialoguetime < 5:
		dia.set(0)
	elif dialoguetime < 10:
		dia.set(1)
	elif dialoguetime < 15:
		dia.set(2)
		if not spawnsheep:
			var j = first_free_key()
			sheep.append(scene.instance())
			sheep[1].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j],keys[j+1], scans[j], scans[j+1])
			sheep[1].get_node("KinematicBody2D").setDir(-1)
			sheep[1].set_pos(Vector2(rand_range(70,300),316.5))
			sheep[1].set_z(1)
			add_child(sheep[1])
			spawnsheep=true
	elif dialoguetime < 20:
		dia.set(3)
	elif dialoguetime < 25:
		dia.set(4)
	elif dialoguetime < 30:
		dia.set(5)
	elif dialoguetime < 35:
		dia.set(6)
		max_sheep = 3
		if not removecrate:
			remove_child(get_node("crate_mid"))
			remove_child(get_node("crate_top"))
			removecrate = true
		
	if gameOverTime > 0:
		gameOverTime -= delta
		if gameOverTime <= 0:
			get_tree().reload_current_scene()
			
	if clearTime > 0:
		clearTime -= delta
		if clearTime <= 0:
			get_tree().change_scene("res://Level1.scn")
		
	if sheep.size() + eggs.size() < 2 and exits + sheep.size() + eggs.size() < max_sheep and not gameOverInst:
		gameOverScene = load("res://gameover.scn")
		gameOverInst = gameOverScene.instance()
		gameOverInst.set_pos(Vector2(350,150))
		add_child(gameOverInst)
		gameOverTime = 2
		
	if sheep.size() == 0 and exits >= max_sheep and not clearInst:
		clearScene = load("res://clear.scn")
		clearInst = clearScene.instance()
		clearInst.set_pos(Vector2(350,150))
		add_child(clearInst)
		clearTime = 2

	get_node("background/progress/progress").set_value(float(exits),max_sheep)

	for v in eggs:
		if not v.get_node("Egg/egganim").is_playing():
			sheep.append(scene.instance())
			var i = sheep.size()-1
			var j = first_free_key()
			if j == -1:
				eggs.remove(eggs.size()-1)
				continue
			sheep[i].get_node("KinematicBody2D/SheepCollider/Sheep").setKeys(keys[j], keys[j+1], scans[j], scans[j+1])
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
			remove_child(v)
			sheep.remove(s)
			break
		if pos.x < -50:
			exits += 1
			remove_child(v)
			sheep.remove(s)
			break
			
	var id = range(0,sheep.size())
	keys_used = []
	for s in id:
		var v = sheep[s]
		var k1 = v.get_node("KinematicBody2D/SheepCollider/Sheep").k1
		var k2 = v.get_node("KinematicBody2D/SheepCollider/Sheep").k2
		keys_used.append(k1)
		keys_used.append(k2)