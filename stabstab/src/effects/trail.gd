class_name EffectTrail
extends Line2D

const MAX_POINTS: int = 8
const MIN_SPAWN_DISTANCE: float = 10.0 # Minimum distance to spawn new point

signal update_requested(trail: EffectTrail)

####### Exported Variables #######

@export var point_spawn_interval: float = 0.05 # Reduced for smoother trail
@export var trail_length: float = 50.0 # Length of the trail in pixels


######## Internal variables ########

var _last_point: Vector2;
var _points_positions: Array[Vector2] = []
var _is_active: bool = true
var _timer;

######### Initialisation ##########

static func create(parent: Node2D, curve: Curve, grad: Gradient, material: Material) -> EffectTrail:
	var trail = EffectTrail.new()
	trail.z_index = parent.z_index
	trail.width_curve = curve
	trail.gradient = grad
	trail.material = material
	parent.add_child(trail)

	trail._last_point = parent.global_position
	trail.add_point(parent.global_position)
	trail._points_positions.append(parent.global_position)
	trail._start_timer()

	return trail

############ Lifecycle ############

func _init() -> void:
	top_level = true

func _process(_delta: float) -> void:
	if not _is_active:
		return
		
	# Update positions of existing points
	for i in range(_points_positions.size()):
		set_point_position(i, _points_positions[i])

######## Exported functions ########

func update(cur_pos: Vector2) -> void:
	if not _is_active:
		return
		
	var distance = _last_point.distance_to(cur_pos)
	
	# Only spawn new point if we've moved enough
	if distance >= MIN_SPAWN_DISTANCE:
		_points_positions.push_front(cur_pos)
		add_point(cur_pos, 0)
		_last_point = cur_pos
		_update_points()

func stop() -> void:
	_is_active = false
	_fade_out()
	queue_free()

######## Internal functions ########

func _fade_out() -> void:
	var tw := get_tree().create_tween()
	tw.tween_property(self, "modulate:a", 0.0, 1.0)
	await tw.finished

func _start_timer() -> Timer:
	_timer = Timer.new()
	_timer.wait_time = point_spawn_interval
	_timer.connect("timeout", _on_spawn_triggered)
	add_child(_timer)
	_timer.start()
	return _timer

func _update_points() -> void:
	# Remove points that are too far
	while _points_positions.size() > MAX_POINTS:
		_points_positions.pop_back()
		remove_point(get_point_count() - 1)

######### Signal handlers ##########

func _on_spawn_triggered() -> void:
	update_requested.emit(self)
