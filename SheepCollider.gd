
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass

func _on_SheepCollider_area_enter( area ):
	get_node("Sheep").sexytime = 5
	pass