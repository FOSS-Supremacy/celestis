extends Node
class_name OrbitController

@export var gravity_strength: float = 1000.0 # Gravitational force
@export var orbit_speed: float = 50.0  # Orbital speed
@export var max_orbiting_objects: int = 5  # Maximum limit of objects in orbit
@export var orbit_delay: float = 1.0  # Delay before starting orbit

var orbiting_objects: Array = []  # Stores objects currently in orbit
var orbit_center: Node2D = null  # The center of the orbit
@onready var orbit_timer: Timer = Timer.new()

func _ready() -> void:
	orbit_timer.set_wait_time(orbit_delay)
	orbit_timer.set_one_shot(true)
	orbit_timer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	add_child(orbit_timer)

# Initialize the orbit around the given center
func enter_orbit(center: Node2D, object: Node2D) -> void:
	if center and object:
		if len(orbiting_objects) < max_orbiting_objects:
			orbit_center = center
			
			# Calculate the orbit radius and initial angle
			var orbit_data = {
				"object": object,
				"radius": object.position.distance_to(center.position),
				"angle": (object.position - center.position).angle(),
				"orbiting": false
			}
			
			orbiting_objects.append(orbit_data)
			orbit_timer.start()
		else:
			print("Limite de objetos em órbita atingido.")

# Called when the Timer expires and activates orbit for objects
func _on_Timer_timeout() -> void:
	print("Começando a orbitar após o delay.")
	for orbit_data in orbiting_objects:
		orbit_data["orbiting"] = true

# Remove an object from orbit
#func exit_orbit(object: Node2D) -> void:
	#for orbit_data in orbiting_objects:
		#if orbit_data["object"] == object:
			#orbiting_objects.erase(orbit_data)
			#print("Objeto saiu da órbita.")
			#break

func _physics_process(delta: float) -> void:
	print(len(orbiting_objects))
	#// Something strange is happening here, for some reason the number of 
	#// objects in orbit is not accurate and is messing with the orbiting object limit system.
	
	if orbit_center:
		# Scroll through the list backwards
		for i in range(orbiting_objects.size() - 1, -1, -1):
			var orbit_data = orbiting_objects[i]
			if is_instance_valid(orbit_data["object"]):
				if orbit_data["orbiting"]: # Only orbits after the delay
					# Update angle based on orbit speed and time
					orbit_data["angle"] += (orbit_speed / orbit_data["radius"]) * delta
					orbit_data["angle"] = wrap_angle(orbit_data["angle"])
					
					# Calculate the new position of the object
					var offset_x = orbit_data["radius"] * cos(orbit_data["angle"])
					var offset_y = orbit_data["radius"] * sin(orbit_data["angle"])
					orbit_data["object"].position = orbit_center.position + Vector2(offset_x, offset_y)
			else:
				# If the object is no longer valid, remove it from the list
				orbiting_objects.remove_at(i)

# Helper function to keep the angle in the correct range
func wrap_angle(angle: float) -> float:
	var two_pi = 2 * PI
	while angle < 0:
		angle += two_pi
	while angle >= two_pi:
		angle -= two_pi
	return angle
