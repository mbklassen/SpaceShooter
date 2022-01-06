extends Area2D


# This node/script is needed to handle collision for this kinematic body

var explosion_scene = preload("res://particles/PlayerExplosion.tscn")
var being_hit = false

var player
var player_sprite
var hit_effect_timer
var explosion_color


func _ready():
	player = get_parent()
	player_sprite = player.get_node("Sprite")
	hit_effect_timer = $HitEffectTimer


func _on_CollisionArea_body_entered(_body):
	if !being_hit:
		# Change color of ship briefly when hit
		being_hit = true
		player_sprite.self_modulate = Color(0.5, 0.5, 0.5)
		
		# Instantiate Explosion node
		var explosion = explosion_scene.instance()
		explosion.global_position = global_position
		# Set explosion colour to be same as asteroid's
		explosion_color = Color(0.3, 0.7, 0.95, 1)
		explosion.process_material.color = explosion_color
		# Explosion particles are now emitting
		explosion.emitting = true
		# Get current level
		var level_node = get_parent().get_parent()
		# Add explosion as a child of current level
		level_node.add_child(explosion)
		
		hit_effect_timer.wait_time = 0.13
		hit_effect_timer.start()

# After a brief delay, change ship color back to original
func _on_HitEffectTimer_timeout():
	being_hit = false
	player_sprite.self_modulate = Color(1, 1, 1)
