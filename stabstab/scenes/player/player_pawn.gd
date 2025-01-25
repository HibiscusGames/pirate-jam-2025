extends Node2D

var speed: float = 500.0
var velocity: Vector2 = Vector2.ZERO
var decelerationRate: float = 0.1;

# Trail
var current_trail: PlayerTrail

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("projectile.launch")):
		velocity = (get_viewport().get_mouse_position() - global_position).normalized() * speed
		make_trail()

	global_translate(velocity * delta)
	velocity -= velocity * decelerationRate * delta
	
	queue_redraw()

func _draw() -> void:
	draw_line(global_position, get_viewport().get_mouse_position(), Color.AZURE)


# Irvin polluting your code for trail stuff sorry not sorry terry
func make_trail() -> void:
	if current_trail:
		current_trail.stop()
	current_trail = PlayerTrail.create()
	
	#test degueu pour changer la couleur 
	var newTrailColor:Gradient
	var gradient_data := {
	0.0: Color.GREEN,
	0.75: Color(0.0,1.0,0.0,0.75),
	1.0: Color(1,1,1,0),
	}
	newTrailColor = Gradient.new()
	newTrailColor.offsets = gradient_data.keys()
	newTrailColor.colors = gradient_data.values()
	current_trail.gradient = newTrailColor
	
	add_child(current_trail)
