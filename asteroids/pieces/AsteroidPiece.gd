extends RigidBody2D


const ROTATION_DIRECTION_SWITCH = 0.5
const OFF_SCREEN_BOTTOM = 652
const OFF_SCREEN_TOP = -100
const HP_VALUE = 10

var pop_sound_scene = preload("res://sounds/audio-stream-players/AsteroidPiecePop.tscn")
var velocity_counterclockwise = rand_range(-4, -1)
var velocity_clockwise = rand_range(1, 4)
# Will dictate the spin direction
var rotation_direction = rand_range(0, 1)

var level_node

func _ready():
	
	level_node = get_parent()
	# Set rotation speed and direction (clockwise vs counterclockwise)
	if (rotation_direction < ROTATION_DIRECTION_SWITCH):
		angular_velocity = velocity_counterclockwise
	else:
		angular_velocity = velocity_clockwise

func _physics_process(_delta):
	# If asteroid piece goes off bottom or top of screen, destroy it
	if position.y > OFF_SCREEN_BOTTOM or position.y < OFF_SCREEN_TOP:
		queue_free()

# Called when asteroid piece collides with another body
func _on_AsteroidPiece_body_entered(body):
	# Instantiate asteroid pop sound and add it as a child of current level
	var pop_sound = pop_sound_scene.instance()
	level_node.add_child(pop_sound)
	# If collided body is the Player, decrease value of health bar
	if body.name == "Player":
		Global.hp -= HP_VALUE
	# Destroy the asteroid piece
	queue_free()
