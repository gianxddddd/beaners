extends RigidBody

onready var collision = $"CollisionShape"
onready var explosion_anim = $"ExplosionAnim"

func _on_ExplosionTrigger_body_entered(body):
	if body.is_in_group("Players"):
		for member in get_tree().get_nodes_in_group("Players"):
			var translation = get_translation()
			var member_translation = member.get_translation()
			var member_rotation_degrees = member.get_rotation_degrees()
			member.move_and_collide(Vector3(member_rotation_degrees.x - 10, member_translation.y + 10, member_rotation_degrees.z - 10))
			member.decrease_health(30)

		explosion_anim.play("TNT-Explode")
		collision.set_visible(false)
		yield(get_tree().create_timer(8), "timeout")
		queue_free()
