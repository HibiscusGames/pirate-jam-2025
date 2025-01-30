extends PhysicsBody2D
class_name PlayerPawn

## Exported variables ##
@export_group("Movement")
@export var speed: float = 500.0
@export var deceleration_rate: float = 0.1;
@export var bounce_factor: float = 0.1;

@export_group("Effects")
@export var trail_starting_point: Node2D = self
@export var trail_width_curve: Curve
@export var trail_color: Gradient = _new_gradient({
	0.0: Color.GREEN,
	0.75: Color(0.0, 1.0, 0.0, 0.75),
	1.0: Color(1, 1, 1, 0),
});

@export_group("Debug")
@export var trajectory_tracer: TrajectoryTracer2DFactory;

## Internal variables ##

var _velocity: Vector2 = Vector2.ZERO
var _trajectory: Trajectory = Trajectory.create(global_position, global_position)
var _cur_trail: EffectTrail

##### Lifecycle #####

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	assert(trajectory_tracer != null, "trajectory_tracer must not be null")
	trajectory_tracer.tracer_added.connect(_on_tracer_ready)

func _process(delta: float) -> void:
	if (not Engine.is_editor_hint()):
		_tick(delta)
	
###### Signal handlers #######

func _on_tracer_ready(tracer: TrajectoryTracer2D) -> void:
	tracer._trajectory = _trajectory
	add_child(tracer)

func _on_trail_update_requested(trail: EffectTrail) -> void:
	trail.update(trail_starting_point.global_position)

######## Internal functions ########

func _tick(delta: float) -> void:
	_trajectory.end = get_local_mouse_position()

	if (Input.is_action_just_pressed("projectile.launch")):
		_velocity = _trajectory.get_direction() * speed
		_spawn_trail()

	if (_velocity.length() < 1 && _cur_trail != null):
		_cur_trail.stop()
		_cur_trail = null

	var _collision: KinematicCollision2D = move_and_collide(_velocity * delta)
	if _collision != null:
		_velocity = _velocity.bounce(_collision.get_normal()) * bounce_factor

	_velocity = lerp(_velocity, Vector2.ZERO, deceleration_rate * delta) # TODO: Need a different kind of interpolation that tapers off sharply instead of slowing down over time

func _spawn_trail():
	if (_cur_trail == null):
		_cur_trail = EffectTrail.create(trail_starting_point, trail_width_curve, trail_color)
		_cur_trail.update_requested.connect(_on_trail_update_requested)

func _new_gradient(data: Dictionary) -> Gradient:
	var g = Gradient.new()
	
	g.offsets = data.keys()
	g.colors = data.values()
	
	return g
