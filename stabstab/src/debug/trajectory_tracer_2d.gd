extends Node2D
class_name TrajectoryTracer2D

##### Internal Variables #####

var _trajectory: Trajectory;
var _color: Color;

##### Initialization #####

# Creates a new TrajectoryTracer2D instance
static func create(color: Color) -> TrajectoryTracer2D:
	var tracer = TrajectoryTracer2D.new()
	tracer._color = color
	tracer.name = "Debug_TrajectoryTracer"
	return tracer

####### Lifecycle ########

func _enter_tree() -> void:
	Debug.debug_toggled.connect(_on_debug_toggled)

# Triggers redraw on the canvas if the trajectory debug feature is enabled
func _process(_delta: float) -> void:
	queue_redraw()

# Draws the enabled debug gizmos on the canvas
func _draw() -> void:
	draw_line(_trajectory.start, _trajectory.end, _color)

##### Signal handler ######

func _on_debug_toggled() -> void:
	if !Debug.is_enabled(Debug.Gizmo.TRAJECTORY):
		queue_free()
