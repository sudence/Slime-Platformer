class_name MoveComponent extends Node

@export var body: CharacterBody2D
@export var speed: float = 200
@export var movement_acceleration: Vector2 = Vector2(20, 20) #(accel, decel)
@export var jump_height: float = 2
@export var gravity: float = 1500
var jump_force: float
var movement_smoothing

var move_direction: float 
var wants_jump: bool
var wants_fall: bool

func _ready() -> void:
	jump_force = sqrt(jump_height * gravity * 16 * 2)

func update(delta: float) -> void:
	#gravity
	if body.is_on_floor():
		body.velocity.y = 0
	else:
		body.velocity.y += gravity * delta
	
	#movement
	if move_direction:
		movement_smoothing = movement_acceleration.x
	else:
		movement_smoothing = movement_acceleration.y
	body.velocity.x = lerpf(body.velocity.x, move_direction * speed, movement_smoothing * delta);
	
	#jump
	if wants_jump:
		body.velocity.y = -jump_force
	wants_jump = false
	
	if wants_fall and body.velocity.y < 0:
		body.velocity.y *= 0.5
	wants_fall = false
	
	#set
	body.move_and_slide()
