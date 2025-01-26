extends Resource
class_name TrajectoryTracer2DFactory

##### Exported Variables #####

@export var color: Color = Color.AZURE

signal tracer_added(tracer: TrajectoryTracer2D)

######### Lifecycle ##########

func _init() -> void:
	Debug.debug_toggled.connect(_on_debug_toggled)

###### Exported Methods ######

func _on_debug_toggled() -> void:
	if Debug.is_enabled(Debug.Gizmo.TRAJECTORIES):
		var tracer = TrajectoryTracer2D.create(color)
		tracer_added.emit(tracer)
