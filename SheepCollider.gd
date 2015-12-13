
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

var ev
var doSexyTime
var area
var menu_start = 0
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
		
	var anmNode = get_node("Sheep/Movement")
		
	if area.get_node("sheep_static/sheep_menu") and not anmNode.get_current_animation() == "sexytime":
		if ev.is_pressed() and ev.type == InputEvent.KEY and (ev.scancode == get_node("Sheep").s1):
			anmNode.play("sexytime")
			area.hide()
			menu_start = 1.5
			return
	
	if area.get_node("sheep_static/sheep_menu"):
		return
	
	if not area.get_node("Sheep").k1:
		return
		
		
	if get_node("Sheep").sexywait > 0 or area.get_node("Sheep").sexywait > 0:
		return
		
	var curAn = anmNode.get_current_animation()
	if curAn == "jump_l" or curAn == "jump_r": # this is the first guy
		return
	if curAn == "falling_l" or curAn == "falling_r": # this is the first guy
		return
	var anmNode = area.get_node("Sheep/Movement")
	var curAn = anmNode.get_current_animation()
	if curAn == "jump_l" or curAn == "jump_r": # this is the second guy
		return
	if curAn == "falling_l" or curAn == "falling_r": # this is the first guy
		return
		
	if ev.is_pressed() and ev.type == InputEvent.KEY and (ev.scancode == get_node("Sheep").s1 or ev.scancode == area.get_node("Sheep").s1):
		if area.get_node("Sheep").sexytime:
			get_node("Sheep").sexytime = true
			get_node("Sheep").sexywait = 3
			get_node("Sheep").hide()
			get_node("Sheep").layedegg = true
			area.get_node("Sheep").layedegg = false
		else:
			get_node("Sheep").sexytime = true
			get_node("Sheep").sexywait = 3
			area.get_node("Sheep").sexytime = true
			area.get_node("Sheep").sexywait = 3
			area.get_node("Sheep").hide()
			area.get_node("Sheep").layedegg = true
			get_node("Sheep").layedegg = false
		pass

func _on_SheepCollider_area_enter( a ):
	randomize()
	var ran = randi() % 2
	if ran == 1 or a.get_node("sheep_static/sheep_menu"): #always sexytime in the menu
		doSexyTime = true
		area = a
		get_node("hearts").show()
		get_node("hearts/hearts/heartsanim").play("love")


func _on_SheepCollider_area_exit( a ):
	doSexyTime = false
	area = a
	get_node("hearts").hide()
	get_node("hearts/hearts/heartsanim").stop()
	pass # replace with function body
