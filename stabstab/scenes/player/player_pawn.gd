extends Node2D
class_name PlayerPawn

## Exported variables ##
@export_group("Movement")
@export var speed: float = 500.0
@export var deceleration_rate: float = 0.1;

@export_group("Debug")
@export var trajectory_tracer: TrajectoryTracer2DFactory;

## Internal variables ##

var _velocity: Vector2 = Vector2.ZERO
var _trajectory: Trajectory = Trajectory.create(global_position, global_position)

##### Lifecycle #####

func _ready() -> void:
	assert(trajectory_tracer != null, "trajectory_tracer must not be null")
	trajectory_tracer.tracer_added.connect(_on_tracer_ready)

func _process(delta: float) -> void:	
	_trajectory.end = get_local_mouse_position()

	if (Input.is_action_just_pressed("projectile.launch")):
		_velocity = _trajectory.get_direction() * speed

	global_translate(_velocity * delta)
	_velocity -= _velocity * deceleration_rate * delta

###### Signal handlers #######

func _on_tracer_ready(tracer: TrajectoryTracer2D) -> void:
	tracer._trajectory = _trajectory
	add_child(tracer)
