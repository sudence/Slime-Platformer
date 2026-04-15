class_name HealthComponent extends Node

@export var max_health: float = 10
var health: float

signal health_changed
signal died

func _ready() -> void:
	health = max_health

func change_health(value: float):
	health += value
	
	if health <= 0:
		health = 0
		emit_signal("died")
	elif health > max_health:
		health = max_health
	
	emit_signal("health_changed")
