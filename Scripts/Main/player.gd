class_name player extends CharacterBody2D

@onready var input: InputComponent = %InputComponent
@onready var move: MoveComponent = %MoveComponent
@onready var health: HealthComponent = %HealthComponent
@onready var animator: AnimationComponent = %AnimationComponent

var dead : bool

func _ready() -> void:
	health.connect("died", died)
	health.connect("health_changed", health_changed)

func _unhandled_input(event: InputEvent) -> void:
	if dead: return
	#HandleInput
	input.update(event)
	move.move_direction = input.move_dir
	move.wants_fall = input.is_falling
	
	if input.heal: health.change_health(2)
	elif input.hurt: health.change_health(-2)

func _physics_process(delta: float) -> void:
	if dead: 
		move_and_slide()
		return
	
	#Jump Input
	input.physics_update(is_on_floor())
	move.wants_jump = input.is_jumping
	input.is_jumping = false
	
	#Move The Player Body
	move.update(delta)
	
	#animation
	animator.change_parameter("parameters/GroundMove/blend_position", input.move_dir)
	animator.change_parameter("parameters/conditions/in_air", !is_on_floor())
	animator.change_parameter("parameters/conditions/on_ground", is_on_floor())
	animator.change_parameter("parameters/Air/blend_position", velocity.y)
	if input.move_dir != 0:
		animator.flip_h(input.move_dir < 0)

func died():
	print("you dead")
	rotation = PI/2
	velocity = Vector2.ZERO
	velocity.y = -30
	dead = true

func health_changed():
	print("current health: ", health.health, "/", health.max_health)
