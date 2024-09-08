extends Resource
class_name SpaceObjectResource

@export_group("Object Settings")
@export var object_mass:int = 10
@export var gravity_strength: float = 1000.0

@export_group("Orbit Settings")
@export var orbiting: bool = false
@export var orbit_radius: float = 20
@export var orbit_speed: float = 50.0
@export var orbit_delay:float = 1.0
