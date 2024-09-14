extends CharacterBody2D

@export var OrbitController:OrbitingObject

func _physics_process(delta: float) -> void:
	position += velocity * delta

func apply_gravity(acceleration: Vector2, delta: float) -> void:
	velocity += acceleration * delta
	
func _on_collision_detect_body_entered(body: Node2D) -> void:
	if body != self:
		queue_free()
