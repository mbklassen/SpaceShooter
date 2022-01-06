extends Node


var bullet_scene = preload("res://enemies/enemy1/bullet/Enemy1Bullet.tscn")
var can_shoot = false

var timer

func _ready():
	timer = $TimeBetweenShots
	timer.wait_time = rand_range(0.3, 1)
	timer.start()

func _physics_process(_delta):
	if can_shoot:
		can_shoot = false
		var bullet = bullet_scene.instance()
		# Get level node
		var level_node = get_parent().get_parent().get_parent()
		var firing_position = get_parent().get_parent().get_node("FiringPosition")
		bullet.global_position = firing_position.global_position
		# Add bullet as a child of current level
		level_node.add_child(bullet)

# Enemy spawns bullets between delays
func _on_TimeBetweenShots_timeout():
	can_shoot = true
	timer.wait_time = rand_range(1.5, 2.5)
	timer.start()
