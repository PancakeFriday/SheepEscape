
extends Sprite

var s = []
var t = []
func _ready():
	randomize()
	for i in range(1,11):
		s.append(Sprite.new())
		t.append(ImageTexture.new())
		t[i-1].load("res://img/clouds/"+str(i)+".png")
		s[i-1].set_texture(t[i-1])
		s[i-1].set_offset(Vector2(rand_range(-400,400), rand_range(-150,0)))
		add_child(s[i-1])
	pass