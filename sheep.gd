
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var sexytime = 0
var sexywait = 0
var jumpwait = 0
#keys
var k1
var k2
#scancodes
var s1
var s2
func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if sexywait > 0:
		sexywait -= delta
		get_parent().get_parent().get_node("Label_1/progress").set_value(1-sexywait/10)
	else:
		get_parent().get_parent().get_node("Label_1/progress").set_value(1)
		
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