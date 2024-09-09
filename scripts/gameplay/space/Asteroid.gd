extends Node2D
class_name Asteoroid

@export var resource: SpaceObjectResource
@export var orbit_delay: float = 3.0
var orbit_center: Node2D = null

var angle: float = 0.0
var orbit_timer: Timer

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Timer
	orbit_timer = Timer.new()
	orbit_timer.one_shot = false
	orbit_timer.autostart = false
	orbit_timer.wait_time = orbit_delay
	add_child(orbit_timer)
	orbit_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))

func _physics_process(delta: float) -> void:
	orbit_controller(delta)
	
	if not resource.orbiting:
		apply_gravity(delta)

func enter_orbit(center: Node2D) -> void:
	if not resource.orbiting:
		orbit_center = center
		orbit_timer.start()

func orbit_controller(delta: float) -> void:
	if resource.orbiting and orbit_center:
		angle += (resource.orbit_speed / resource.orbit_radius) * delta
		angle = wrap_angle(angle)
		var offset_x = resource.orbit_radius * cos(angle)
		var offset_y = resource.orbit_radius * sin(angle)
		position = orbit_center.position + Vector2(offset_x, offset_y)

func apply_gravity(delta: float) -> void:
	if not resource.orbiting and orbit_center:
		var direction = (orbit_center.position - position).normalized()
		var distance = position.distance_to(orbit_center.position)
		var force = orbit_center.resource.gravity_strength / (distance * distance)
		var acceleration = direction * force
		velocity += acceleration * delta
		position += velocity * delta
	
		if distance < resource.orbit_radius * 0.95:
			orbit_timer.start()

# Ensures the angle is in the range [0, 2*PI]
func wrap_angle(angle: float) -> float:
	var two_pi = 2 * PI
	while angle < 0:
		angle += two_pi
	while angle >= two_pi:
		angle -= two_pi
	return angle

# When the Timer ends, start the orbit
func _on_Timer_timeout() -> void:
	resource.orbiting = true
	resource.orbit_radius = position.distance_to(orbit_center.position)
	orbit_timer.stop()
