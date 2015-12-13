
extends RichTextLabel

var Text = [ "This is your sheep. It moves on its\nown, but you can make it jump,\nby pressing 'w'. Try it!",
			"But this game is also about growth\nTo make a new sheep, press 'q'\nover another sheep.",
			"Oh, right, you need another sheep\nfor that. Here you go!",
			"Keep in mind, that those sheep\nare not always 'in the mood'.",
			"The goal of this game is to rescue\na number of sheep, indicated in\nthe top right.",
			"You lose, if you cannot rescue all\nof them. You always need two\nsheep to grow your population!",
			"The arrow indicates the exit.\nGo ahead, rescue them!\nNow try the real challenge!" ]
func _ready():
	pass

func set(i):
	clear()
	add_text(Text[i])