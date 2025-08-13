extends StaticBody3D

var is_open = false
var closed_rotation
var open_rotation
@export var open_angle_degrees: float = 90.0
@export var open_time: float = 0.5

func _ready():
	# Store the initial closed rotation
	closed_rotation = rotation_degrees
	open_rotation = closed_rotation + Vector3(0, open_angle_degrees, 0)

func interact():
	if is_open:
		close()
	else:
		open()

func open():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", open_rotation, open_time)
	is_open = true

func close():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "rotation_degrees", closed_rotation, open_time)
	is_open = false
