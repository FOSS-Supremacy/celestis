extends Camera2D

func _input(event):
	if Input.is_action_pressed("camera_up"):
		position.y = position.y - 8
	if Input.is_action_pressed("camera_down"):
		position.y = position.y + 8
	if Input.is_action_pressed("camera_left"):
		position.x = position.x - 8
	if Input.is_action_pressed("camera_right"):
		position.x = position.x + 8
