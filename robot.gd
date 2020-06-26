
extends KinematicBody2D

onready var ground_ray = get_node("ground_ray")

const ACCEL = 1500
const MAX_SPEED = 500
const FRICTION = -500
const GRAVITY = 4000
const JUMP_SPEED = -1400
const MIN_JUMP = -500

var acc = Vector2()
var vel = Vector2()



func _input(event):
	if event.is_action_pressed("ui_up") and ground_ray.is_colliding():
		vel.y = JUMP_SPEED
	if event.is_action_released("ui_up"):
		vel.y = clamp(vel.y, MIN_JUMP, vel.y)

func _fixed_process(delta):
	acc.y = GRAVITY
	acc.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	acc.x *= ACCEL
	if acc.x == 0:
		acc.x = vel.x * FRICTION * delta

	vel += acc * delta
	vel.x = clamp(vel.x, -MAX_SPEED, MAX_SPEED)

	vel = move_and_slide(vel * delta)
	

