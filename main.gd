
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var scene
var instr_scene
var sheep
func _ready():	
	scene = load("res://sheep.scn")
	sheep = scene.instance()
	sheep.get_node("KinematicBody2D/SheepCollider/Sheep").setKeys("q","w",KEY_Q,KEY_W)
	sheep.get_node("KinematicBody2D").setDir(1)
	sheep.set_pos(Vector2(220,316.5))
	sheep.set_z(1)
	add_child(sheep)
	
	instr_scene = load("res://instr.scn")
	
	set_process(true)
	pass

var instr_inst
var instr_anim = false
var instr_time = 0
func _process(delta):
	if instr_time > 0:
		instr_time -= delta
		if instr_time <= 0:
			get_tree().change_scene("res://Tutorial.scn")
	
	if sheep.get_node("KinematicBody2D/SheepCollider").menu_start > 0:
		sheep.get_node("KinematicBody2D/SheepCollider").menu_start -= delta
		if sheep.get_node("KinematicBody2D/SheepCollider").menu_start <= 0:
			instr_anim = true
	
	if instr_anim and not instr_inst:
		instr_inst = instr_scene.instance()
		instr_inst.set_pos(Vector2(320,180))
		add_child(instr_inst)
		get_node("title").hide()
		get_node("start").hide()
		get_node("Area2D").set_pos(Vector2(-1000,-1000)) # off you go!
		sheep.get_node("KinematicBody2D/Label_1").hide()
		sheep.get_node("KinematicBody2D/Label_2").hide()
		instr_time = 7