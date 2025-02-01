extends Camera2D

@export var min_speed: float = 0.0
@export var max_speed: float = 50.0

@export_group("Debug")
@export var tracer_factory: TrajectoryTracer2DFactory
@export var position_marker_factory: PositionMarkerFactory2D

var _drag_vector: Vector2 = Vector2.ZERO
var _last_position: Vector2 = Vector2.ZERO
var _direction: Vector2 = Vector2.ZERO

var _velocity: Vector2 = Vector2.ZERO
var _trajectory: Trajectory = Trajectory.new()

################ Lifecycle functions ##################

func _ready() -> void:
	tracer_factory.tracer_added.connect(_on_tracer_added)

func _process(delta: float) -> void:
	if Input.is_action_pressed("camera.drag"):
		var mouse_pos = get_local_mouse_position()
		
		_drag_vector += _last_position.direction_to(mouse_pos) 
		_last_position = mouse_pos
		_direction = (_drag_vector * -1).normalized()
		
	if Input.is_action_just_released("camera.drag"):
		_velocity = _calc_velocity()
	
	if Debug.is_enabled(Debug.Gizmo.TRAJECTORY):
		_trajectory.start = global_position
		_trajectory.end = to_global(_calc_velocity())
	
################### Signal Handlers ###################

func _on_tracer_added(tracer: TrajectoryTracer2D):
	tracer._trajectory = _trajectory
	add_child(tracer)

################ Internal functions ###################

func _calc_velocity() -> Vector2:
	return _direction * clampf(_drag_vector.length(), min_speed, max_speed)

