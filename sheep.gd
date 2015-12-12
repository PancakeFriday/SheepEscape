
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var sexytime = 0
func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if sexytime > 0:
		sexytime -= delta
	print(sexytime)