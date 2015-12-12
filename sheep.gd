
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var sexytime = 0
var sexywait = 0
var layedegg = false
var jumpwait = 0
#keys
var k1
var k2
#scancodes
var s1
var s2

var egg_scene
func _ready():
	set_fixed_process(true)
	egg_scene = load("res://egg.scn")
	pass

func _fixed_process(delta):
	if sexywait > 0:
		sexywait -= delta
		get_parent().get_parent().get_node("Label_1/progress").set_value(1-sexywait/10)
	else:
		get_parent().get_parent().get_node("Label_1/progress").set_value(1)
	
	if sexywait > 2 and layedegg == false and is_visible():
		var Level = get_node("../../../../")
		var eggs = Level.eggs
		eggs.append(egg_scene.instance())
		var pos = get_pos() + get_parent().get_pos() + get_node("../../").get_pos() + get_node("../../../").get_pos() + Vector2(0,5)
		eggs[eggs.size()-1].set_pos(pos)
		eggs[eggs.size()-1].get_node("Egg/egganim").play("hatch")
		print(eggs[eggs.size()-1].get_pos())
		Level.add_child(eggs[eggs.size()-1])
		layedegg = true
		
	if jumpwait > 0:
		jumpwait -= delta
		get_parent().get_parent().get_node("Label_2/progress").set_value(1-jumpwait/5)
	else:
		get_parent().get_parent().get_node("Label_2/progress").set_value(1)
		
func setKeys(key1, key2, scan1, scan2):
	k1 = key1
	k2 = key2
	s1 = scan1
	s2 = scan2