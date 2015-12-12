
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

var ev
var doSexyTime
var area
func _ready():
	# Initialization here
	doSexyTime = false
	set_process_input(true)
	pass

func _input(ev):
	if doSexyTime == false:
		return
	
	if not get_node("Sheep").k1:
		return
	if not area:
		return
	if not area.get_node("Sheep").k1:
		return
		
	if get_node("Sheep").sexywait > 0 or area.get_node("Sheep").sexywait > 0:
		return
		
	var anmNode = get_node("Sheep/Movement")
	var curAn = anmNode.get_current_animation()
	print(curAn)
	if curAn == "jump_l" or curAn == "jump_r": # this is the first guy
		return
	var anmNode = area.get_node("Sheep/Movement")
	var curAn = anmNode.get_current_animation()
	if curAn == "jump_l" or curAn == "jump_r": # this is the second guy
		return
		
	if ev.is_pressed() and ev.type == InputEvent.KEY:
		print(ev.scancode)

	if ev.is_pressed() and ev.type == InputEvent.KEY and (ev.scancode == get_node("Sheep").s1 or ev.scancode == area.get_node("Sheep").s1):
		if area.get_node("Sheep").sexytime:
			get_node("Sheep").sexytime = true
			get_node("Sheep").sexywait = 10
			get_node("Sheep").hide()
		else:
			get_node("Sheep").sexytime = true
			get_node("Sheep").sexywait = 10
			area.get_node("Sheep").sexytime = true
			area.get_node("Sheep").sexywait = 10
			area.get_node("Sheep").hide()
		pass

func _on_SheepCollider_area_enter( a ):
	doSexyTime = true
	area = a


func _on_SheepCollider_area_exit( a ):
	doSexyTime = false
	area = a
	pass # replace with function body
