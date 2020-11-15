extends KinematicBody2D

class_name Medi

var speed = 40
var jump_power = 650
var stopping_friction = 0.6
var running_friction = 0.9
var gravity = 30

var vel = Vector2()

var jumps_left = 2
var dash_direction = Vector2(1,0)
var can_dash = false
var dashing = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _physics_process(delta):
	run()
	jump()
	friction()
	gravedad()
	vel = move_and_slide(vel, Vector2.UP)


func run():
	if Input.is_action_pressed("ui_right"):
		vel.x += speed
		
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed


func jump():
	# I can jump when I'm on floor or next to the wall
	if is_on_floor() or next_to_wall():
		jumps_left = 2 # Recharge double-jump. 
	
	if Input.is_action_just_pressed("ui_up") and jumps_left > 0:
		if vel.y > 0: vel.y = 0 # if I'm falling - ignore fall velocity
		vel.y -= jump_power
		jumps_left -= 1
		# Jump away from the wall
		if not is_on_floor() and next_to_left_wall():
			vel.x += jump_power
		if not is_on_floor() and next_to_right_wall():
			vel.x -= jump_power
	
	# If I'm still going up and have released the jump button - cut off the jump and start falling down
	if Input.is_action_just_released("ui_up") and vel.y < 0:
		vel.y = 0


func friction():
	# When I hold the key
	var running = Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")
	if not running and is_on_floor():
		vel.x *= stopping_friction
	else:
		vel.x *= running_friction


func gravedad():
	if not dashing:
		vel.y += gravity
	if vel.y > 800: 
		vel.y = 800 # clamp falling speed
	if next_to_wall() and vel.y > 100: 
		vel.y = 100 # wall slide


func next_to_wall():
	return next_to_left_wall() or next_to_right_wall()
	
func next_to_left_wall():
	return $LeftWallRaycast1.is_colliding() or $LeftWallRaycast2.is_colliding()

func next_to_right_wall():
	return $RightWallRaycast1.is_colliding() or $RightWallRaycast2.is_colliding()


func take_damage():
	get_tree().change_scene("res://mapa.tscn")

