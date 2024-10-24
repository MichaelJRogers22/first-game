extends Area2D


@onready var timer: Timer = $Timer
@onready var die_animation: AnimationPlayer = $die_animation
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D





func _on_body_entered(body: Node2D) -> void:
	print("you died!")
	die_animation.play("die_animation")
	Engine.time_scale = 0.25
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
