extends Spatial

export var mouse_sensitivity = 0.150

onready var player = get_parent()
onready var first_person_camera = $"FirstPersonCamera"
onready var third_person_camera = $"ThirdPersonCamera"

var camera_rotation_x = 0

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.is_action_just_pressed("ui_perspective"):
		if first_person_camera.is_current():
			third_person_camera.make_current()
		elif third_person_camera.is_current():
			first_person_camera.make_current()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		player.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		
		if camera_rotation_x + x_delta > -90 and camera_rotation_x + x_delta < 90:
			first_person_camera.rotate_x(deg2rad(-x_delta))
			camera_rotation_x += x_delta