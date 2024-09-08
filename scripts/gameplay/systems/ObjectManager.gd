extends Node2D

@export var resource:SpaceObjectResource
var orbit_center: Node2D = null

var angle:float = 0.0
var orbit_timer: Timer
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Inicializa o Timer
	orbit_timer = Timer.new()
	orbit_timer.one_shot = false
	orbit_timer.autostart = false
	add_child(orbit_timer)
	
	orbit_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	#print("Timer configurado com um delay de ", resource.orbit_delay, " segundos.")
	
func _physics_process(delta: float) -> void:
	orbit_controller(delta)
	
	if orbit_center:
		orbit_timer.wait_time = orbit_center.resource.orbit_delay
	
	if not resource.orbiting:
		apply_gravity(delta)

func enter_orbit(center:Node2D) -> void:
	#resource.orbiting = true
	if not resource.orbiting:
		orbit_center = center
		resource.orbit_radius = position.distance_to(center.position)
		angle = (position - orbit_center.position).angle()
		orbit_timer.start()
		
		#print("Timer iniciado para entrar em órbita.")
	
func orbit_controller(delta):
	if resource.orbiting and orbit_center:
		angle += (resource.orbit_speed / resource.orbit_radius) * delta
		angle = wrap_angle(angle)
		
		# new position around the central body
		var offset_x = orbit_center.resource.orbit_radius * cos(angle)
		var offset_y = orbit_center.resource.orbit_radius * sin(angle)
		position = orbit_center.position + Vector2(offset_x, offset_y)

func apply_gravity(delta: float) -> void:
	if not resource.orbiting and orbit_center:
		var direction = (orbit_center.position - position).normalized()
		var distance = position.distance_to(orbit_center.position)
		var force = orbit_center.resource.gravity_strength / (distance * distance)
		var acceleration = direction * force
		velocity += acceleration * delta
		position += velocity * delta
		
# Function to ensure that the angle is within the range [0, 2*PI]
func wrap_angle(angle: float) -> float:
	var two_pi = 2 * PI
	while angle < 0:
		angle += two_pi
	while angle >= two_pi:
		angle -= two_pi
	return angle

func _on_Timer_timeout() -> void:
	resource.orbiting = true
	
	if orbit_center is Player:
		orbit_center.orbit_objects.append(self)
	#print("Tempo acabou!")
