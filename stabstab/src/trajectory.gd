extends RefCounted
class_name Trajectory

var start: Vector2
var end: Vector2

static func create(start_pos: Vector2, end_pos: Vector2) -> Trajectory:
	var trajectory: Trajectory = Trajectory.new()
	trajectory.start = start_pos
	trajectory.end = end_pos
	return trajectory

static func from_global_mouse_position(start_position: Vector2, camera: Camera2D) -> Trajectory:
	return create(start_position, camera.get_global_mouse_position())

func get_direction() -> Vector2:
	return (end - start).normalized()

func get_distance() -> float:
	return (end - start).length()

func get_angle() -> float:
	return (end - start).angle()

func _draw_debug(canvas: CanvasItem, color: Color = Color.AZURE) -> void:
	canvas.draw_line(start, end, color)
