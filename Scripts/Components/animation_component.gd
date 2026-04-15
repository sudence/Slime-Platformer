class_name AnimationComponent extends Node

@onready var sprite: Sprite2D = $"../../Sprite2D"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"

func flip_h(flip: bool) -> void:
	sprite.flip_h = flip

func change_parameter(para_name: String, value) -> void:
	animation_tree.set(para_name, value)
