extends Node

var score = 0
@onready var score_label: Label = $"Score Label"

func add_point():
	score += 1
	score_label.text = "you've collected " + str(score) + " out of 12 coins"
