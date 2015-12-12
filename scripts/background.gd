
extends Sprite

var num_clouds = 10
var s = []
var t = []
var speeds = []
func _ready():
	# stuff
	set_process(true)
	randomize()
	# clouds
	for i in range(1,num_clouds):
		s.append(Sprite.new())
		t.append(ImageTexture.new())
		speeds.append(rand_range(1,10))
		t[i-1].load("res://img/clouds/"+str(i)+".png")
		s[i-1].set_texture(t[i-1])
		s[i-1].set_pos(Vector2(rand_range(-400,400), rand_range(-150,0)))
		add_child(s[i-1])
	pass
	
func _process(delta):
	var pos
	var dir
	var f = 2
	for i in range(0,get_child_count()):
		pos = get_child(i).get_pos()
		dir = Vector2((speeds[i]*delta*f),0)
		if pos.x > 700:
			pos.x -= 1400
		get_child(i).set_pos(pos+dir)
	pass