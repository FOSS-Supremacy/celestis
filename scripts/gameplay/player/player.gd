extends CharacterBody2D

@export var player_mass:int = 100

@export_group("Player Settings")
@export var acceleration: float = 200.0
@export var max_speed: float = 400.0
@export var drag: float = 0.05  ## Drag factor (inertia)

var nearby_objects: Array = []
var detection_radius:int = 100

func _physics_process(delta: float) -> void:
	movement_controller(delta)
	
	check_nearby_objects()
	destroy_objects()

func movement_controller(delta) -> void:
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	if direction != Vector2.ZERO:
		velocity += direction * acceleration * delta  # Aplica aceleração baseada na direção
	else:
		velocity = velocity.lerp(Vector2.ZERO, drag * delta)
		
	if velocity.length() > acceleration:
		velocity = velocity.normalized() * acceleration
		
	move_and_slide()

func check_nearby_objects() -> void:
	nearby_objects.clear()
	
	var root = get_tree().root
	var current_scene = root.get_child(root.get_child_count() - 1)
	
	for node in current_scene.get_children():
		if node is CharacterBody2D or node is RigidBody2D:
			var distance = self.global_position.distance_to(node.global_position)
			
			if distance <= detection_radius and node != self:
				nearby_objects.append(node)
				#print("Objeto próximo detectado: ", node.name, " a ", distance, " metros")

func destroy_objects() -> void:
	for obj in nearby_objects:
		var distance = self.global_position.distance_to(obj.global_position)
		
		if distance <= 15 and obj != self:
			if player_mass >= obj.resource.object_mass:
				print(obj.resource.object_mass)
				obj.queue_free()
