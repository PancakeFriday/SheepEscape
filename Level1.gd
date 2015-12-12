
extends Node2D

var scene
var s1
var s2
func _ready():
	# Initialization here
	# spawn 2 sheep
	scene = load("res://sheep.scn")
	s1 = scene.instance()
	s2 = scene.instance()
	s1.set_pos(Vector2(100,316.5))
	s2.set_pos(Vector2(400,316.5))
	
	add_child(s1)
	add_child(s2)
	
	pass


