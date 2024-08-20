extends Node2D

@onready var main_star = $red_star

func _input(event):
	if Input.is_action_pressed("player_up"):
		main_star.position.y = main_star.position.y - 8
	if Input.is_action_pressed("player_down"):
		main_star.position.y = main_star.position.y + 8
	if Input.is_action_pressed("player_left"):
		main_star.position.x = main_star.position.x - 8
	if Input.is_action_pressed("player_right"):
		main_star.position.x = main_star.position.x + 8
	if Input.is_action_just_pressed("full_screen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
