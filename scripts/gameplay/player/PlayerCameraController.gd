extends Camera2D
class_name PlayerCameraController

@export var active_zoom:bool = true
@export var max_zoom: float = 3.0
@export var min_zoom: float = 0.5
@export var zoom_speed: float = 0.1

func _ready() -> void:
	if not active_zoom:
		zoom.x = min_zoom
		zoom.y = min_zoom
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and active_zoom:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			zoom_out()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			zoom_in()

func zoom_in() -> void:
	# (closer)
	zoom.x = clamp(zoom.x * (1 - zoom_speed), min_zoom, max_zoom)
	zoom.y = clamp(zoom.y * (1 - zoom_speed), min_zoom, max_zoom)

func zoom_out() -> void:
	# (further away)
	zoom.x = clamp(zoom.x * (1 + zoom_speed), min_zoom, max_zoom)
	zoom.y = clamp(zoom.y * (1 + zoom_speed), min_zoom, max_zoom)
