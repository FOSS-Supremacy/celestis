extends Node2D
class_name OrbitingObject

#@export var gravity_strength: float = 1000.0
#var orbit_objects: Array = []
#
#func _physics_process(delta: float) -> void:
	#apply_gravity_to_objects(delta)
#
#func apply_gravity_to_objects(delta: float) -> void:
	#for obj in orbit_objects:
		#if obj:
			#apply_gravity(obj, delta)
#
#func apply_gravity(obj: Node2D, delta: float) -> void:
	#var direction = (position - obj.position).normalized()
	#var distance = position.distance_to(obj.position)
	#var force = gravity_strength / (distance * distance)
	#var acceleration = direction * force
	#obj.velocity += acceleration * delta
	#obj.position += obj.velocity * delta
#
#func add_object_to_gravity(obj: Node2D) -> void:
	#if obj not in orbit_objects:
		#orbit_objects.append(obj)
