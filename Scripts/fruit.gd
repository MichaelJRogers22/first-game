extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer



func _on_body_entered(body: Node2D) -> void:
	animation_player.play("powerup_animation")
	print("BOOST")
	queue_free()
