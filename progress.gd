
extends RichTextLabel

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	add_text("0/10")
	
func set_value(v,k):
	clear()
	add_text(str(v) + "/" + str(k))