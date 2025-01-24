extends Node2D

var speed: float = 500.0
var velocity: Vector2 = Vector2.ZERO
var decelerationRate: float = 0.1;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("projectile.launch")):
		velocity = (get_viewport().get_mouse_position() - global_position).normalized() * speed

	global_translate(velocity * delta)
	velocity -= velocity * decelerationRate * delta

	queue_redraw()

func _draw() -> void:
	draw_line(global_position, get_viewport().get_mouse_position(), Color.AZURE)
