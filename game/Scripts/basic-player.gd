extends CharacterBody3D

const DEBUG = false

var mouse_sensitivity = 0.002
const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const RAY_LENGTH = 1.5
var interaction_ray_cast_from = Vector3(0, 0, 0)
var interaction_ray_cast_to = Vector3(0, 0, 0)
var speedModifier = 1

func _input(event):
	# Camera rotation for mouse movement
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Camera3D.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))

	# Update interaction raycast for any input
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var mouse_pos = get_viewport().get_mouse_position()
		interaction_ray_cast_from = $Camera3D.project_ray_origin(mouse_pos)
		interaction_ray_cast_to = interaction_ray_cast_from + $Camera3D.project_ray_normal(mouse_pos) * RAY_LENGTH

func _physics_process(delta: float) -> void:
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Movement
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var movement_dir = transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED * speedModifier
		velocity.z = direction.z * SPEED * speedModifier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	var collision_result = interaction_collision_check()
	if Input.is_action_just_pressed("interact"):
		if collision_result && collision_result.has_method("interact"):
			collision_result.interact()
	move_and_slide()

func interaction_collision_check():
	# Interaction raycast check collition. This needs to be in psysics_process
	var space_state = get_world_3d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters3D.create(interaction_ray_cast_from, interaction_ray_cast_to, collision_mask, [self])
	var result = space_state.intersect_ray(query)
	if DEBUG:
		print(result)
	if result and result.has("collider"):
		return result["collider"]
	return null
