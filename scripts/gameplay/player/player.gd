extends CharacterBody2D
class_name Player

@export var resource:SpaceObjectResource
@export var gravity_controller:GravityController

@export_group("Player Settings")
@export var acceleration: float = 200.0
@export var max_speed: float = 400.0
@export var drag: float = 0.05  ## Drag factor (inertia)

var nearby_objects: Array = []
var detection_radius:int = 100
var angle:float = 0.0
var orbit_center: Node2D = null
var orbit_objects:Array = []
var selected_object:Node2D = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("absorb_body"):
		suck_objects()
		
func _physics_process(delta: float) -> void:
	movement_controller(delta)
	check_nearby_objects()

func movement_controller(delta) -> void:
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	if direction != Vector2.ZERO:
		velocity += direction * acceleration * delta
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

func suck_objects() -> void:
	orbit_objects = orbit_objects.filter(is_instance_valid)
	
	if orbit_objects.size() > 0:
		selected_object = orbit_objects[0]
		
		if is_instance_valid(selected_object):
			var timer = Timer.new()
			add_child(timer)
			timer.wait_time = 0.1
			timer.one_shot = true
			timer.connect("timeout", Callable(self, "_on_timer_timeout"))
			timer.start()

func _on_timer_timeout() -> void:
	if is_instance_valid(selected_object):
		selected_object.queue_free()
		orbit_objects.erase(selected_object)

func _orbit_entered(body: Node2D) -> void:
	if body != self and body is CharacterBody2D:
		if not body in gravity_controller.orbit_objects:
			gravity_controller.orbit_objects.append(body)
			gravity_controller.set_info(self, gravity_controller.orbit_objects)
			$OrbitController.enter_orbit(self, body)

func _orbit_exited(body: Node2D) -> void:
	if body != self and body is CharacterBody2D:
		if body in gravity_controller.orbit_objects:
			gravity_controller.orbit_objects.erase(body)
			
		if gravity_controller.orbit_objects.size() > 0:
			gravity_controller.set_info(self, gravity_controller.orbit_objects)
		else:
			gravity_controller.set_info(self, [])
