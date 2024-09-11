extends Node
class_name GravityController

@export var gravity_strength: float = 1000.0
var orbit_objects: Array = []

var active_gravity: bool = false
var object_center: Node2D

func _physics_process(delta: float) -> void:
	if active_gravity and object_center:
		for obj in orbit_objects:
			gravity_controller(obj, delta)
	else:
		for obj in orbit_objects:
			if obj:
				obj.position += obj.velocity * delta

func gravity_controller(pulled_object: CharacterBody2D, delta: float) -> void:
	var distance = object_center.position.distance_to(pulled_object.position)
	if distance > 0:
		var direction = (object_center.position - pulled_object.position).normalized()
		var force = gravity_strength / distance
		var acceleration = direction * force
		pulled_object.apply_gravity(acceleration, delta)

func set_info(object_center: Node2D, pulled_objects: Array) -> void:
	self.object_center = object_center
	self.orbit_objects = pulled_objects
	active_gravity = true
