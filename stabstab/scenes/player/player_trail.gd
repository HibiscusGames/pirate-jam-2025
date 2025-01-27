class_name PlayerTrail
extends Line2D

const MAX_POINTS: int = 200
var gradient_data := {
	0.0: Color.DEEP_PINK,
	0.75: Color(0.9,0.0,0.6,0.5),
	1.0: Color(1,1,1,0),
}
var trail_gradient : Gradient

@onready var curve := Curve2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trail_gradient = Gradient.new()
	trail_gradient.offsets = gradient_data.keys()
	trail_gradient.colors = gradient_data.values()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#curve stuff
	curve.add_point(get_parent().position)
	if curve.get_baked_points().size() > MAX_POINTS:
		curve.remove_point(0)
	points = curve.get_baked_points()
	
	#color stuff
	#self.gradient = trail_gradient

#to be able to instantiate a trail
static func create() -> PlayerTrail:
	var scene = preload("res://scenes/player/player_trail.tscn")
	return scene.instantiate()
	
# To get the remnant on stop
func stop() -> void:
	set_process(false)
	var tw := get_tree().create_tween()
	tw.tween_property(self,"modulate:a", 0.0, 1.0)
	await tw.finished
	queue_free()
