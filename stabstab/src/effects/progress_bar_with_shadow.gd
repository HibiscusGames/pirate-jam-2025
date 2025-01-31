@tool
extends ProgressBar
class_name ProgressBarWithShadow

@export var shadow: CanvasItem

func _ready() -> void:
	value_changed.connect(_on_value_changed)

func _on_value_changed(val: float) -> void:
	var offset = val * size.x / 100.0
	shadow.position = Vector2(offset, 0)
