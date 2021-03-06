extends Spatial

export var mouse_sensitivity = 0.150

onready var player = $".."
onready var pmenu = load("res://Scene/ui/PauseMenu.tscn")
onready var hud_overlay_target = $"HUDOverlay/Target"
onready var hud_overlay_health = $"HUDOverlay/Health"
onready var hud_overlay_ammo = $"HUDOverlay/Ammo"
onready var first_person_camera = $"FirstPersonCamera"
onready var third_person_camera = $"ThirdPersonCamera"
onready var pistol = $"FirstPersonCamera/Pistol"

var camera_rotation_x = 0

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel") and is_visible():
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().root.add_child(pmenu.instance())
		hud_overlay_target.set_visible(false)
		hud_overlay_health.set_visible(false)
		hud_overlay_ammo.set_visible(false)
		set_visible(false)
		
		if player.get_weapon() == 1:
			pistol.set_process(false)
	
	if Input.is_action_just_pressed("ui_perspective"):
		if first_person_camera.is_current():
			hud_overlay_target.set_visible(false)
			third_person_camera.make_current()
		elif third_person_camera.is_current():
			hud_overlay_target.set_visible(true)
			first_person_camera.make_current()
	
	if Input.is_action_pressed("game_secondary_fire"):
		first_person_camera.set_fov(lerp(first_person_camera.fov, 50, 0.3))
	else:
		first_person_camera.set_fov(lerp(first_person_camera.fov, 70, 0.3))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		player.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		
		if camera_rotation_x + x_delta > -90 and camera_rotation_x + x_delta < 90:
			first_person_camera.rotate_x(deg2rad(-x_delta))
			camera_rotation_x += x_delta
