
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var maxWidth = 12
var maxHeight = 18
func _ready():
	# Initialization here
	pass
	
func set_value(v):
	set_region_rect(Rect2(0,0,maxWidth,maxHeight*v))