
extends ProgressBar

# member variables here, example:
# var a=2
# var b="textvar"

var num = 0
func _ready():
	# Initialization here
	set_process(true)

func _process(delta):
	set_value(4/10)