extends Resource
class_name PositionMarkerFactory2D

##### Exported Variables #####

@export var color: Color = Color.GOLD
@export var toggle: Debug.Gizmo

signal marker_added(marker: PositionMarker2D)

######### Lifecycle ##########

func _init() -> void:
	Debug.debug_toggled.connect(_on_debug_toggled)

###### Exported Methods ######

func _on_debug_toggled() -> void:
	if Debug.is_enabled(toggle):
		var tracer = PositionMarker2D.new()
		marker_added.emit(tracer)

