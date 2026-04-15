class_name InputComponent extends Node

var move_dir: float
var is_jumping: bool
var is_falling: bool

var heal: bool
var hurt: bool

@onready var coyotee_timer: Timer = $"../../CoyoteeTimer"
@onready var jump_buffer: Timer = $"../../JumpBuffer"
@export var coyotee_time: float = 0.1
@export var jump_buffer_time: float = 0.1

func update(event: InputEvent) -> void:
	move_dir = Input.get_axis("left", "right")
	if event.is_action_pressed("jump"): 
		jump_buffer.start(jump_buffer_time)
	is_falling = event.is_action_released("jump")
	
	heal = event.is_action_pressed("heal")
	hurt = event.is_action_pressed("hurt")

func physics_update(is_on_floor: bool) -> void:
	if is_on_floor:
		coyotee_timer.start(coyotee_time)
	
	if !jump_buffer.is_stopped() and !coyotee_timer.is_stopped():
		is_jumping = true
		jump_buffer.stop()
		coyotee_timer.stop()
