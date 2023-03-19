extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var camera = get_node("..")
export var boid_camera_path:NodePath
onready var boid_camera = get_node(boid_camera_path) 

export var boid_path:NodePath
onready var boid = get_node(boid_path) 


enum Mode { Free, Follow}

export var mode = Mode.Follow

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.move = false
	pass # Replace with function body.
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if mode == Mode.Free:
			camera.move = false
			mode = Mode.Follow
		else:
			camera.move = true
			mode = Mode.Free

func _physics_process(delta):
	if mode == Mode.Follow:	
		camera.global_transform.origin = lerp(camera.global_transform.origin, boid_camera.global_transform.origin, delta * 5.0)

		var desired = camera.global_transform.looking_at(boid.global_transform.origin, Vector3.UP)		
		camera.global_transform.basis = camera.global_transform.basis.slerp(desired.basis, delta).orthonormalized()
		# camera.global_transform.basis.slerp(desired, delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DebugDraw.set_text("mode", mode)
	pass
