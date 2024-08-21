extends Node2D

func _input(event):
	if Input.is_action_pressed("player_up"):
		position.y = position.y - 8
	if Input.is_action_pressed("player_down"):
		position.y = position.y + 8
	if Input.is_action_pressed("player_left"):
		position.x = position.x - 8
	if Input.is_action_pressed("player_right"):
		position.x = position.x + 8
