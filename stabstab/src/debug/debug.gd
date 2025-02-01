extends Node

# Using bit flags to allow combining GIZMO_NAME
enum Gizmo {
	NONE = 0b0000,
	TRAJECTORY = 0b0001,
	CAMERA = 0b0010,
	ALL = 0b1111,
}

const GIZMO_NAME: Dictionary = {
	Gizmo.NONE: "NONE",
	Gizmo.TRAJECTORY: "TRAJECTORY",
	Gizmo.CAMERA: "CAMERA",
	Gizmo.ALL: "ALL",
}

# Emitted when a debug feature is toggled on or off.
signal debug_toggled()

var enabled_gizmos: Gizmo = Gizmo.NONE

##### Lifecycle #####

func _unhandled_input(event: InputEvent) -> void:
	var gizmo: Gizmo;
	if event.is_action_pressed("debug.all"): gizmo = Gizmo.ALL
	elif event.is_action_pressed("debug.trajectories"): gizmo = Gizmo.TRAJECTORY
	else:
		return # Ignore any other input

	_toggle(gizmo)
	get_viewport().set_input_as_handled()

##### Exported Functions #####

func is_enabled(gizmo: Gizmo) -> bool:
	var enabled = bool(enabled_gizmos & gizmo)
	return enabled

##### Internal Functions #####

func _toggle(gizmo: Gizmo) -> void:
	if gizmo == Gizmo.ALL && enabled_gizmos != Gizmo.ALL:
		enabled_gizmos = Gizmo.ALL
		print_debug("[debug]: ENABLED all debug gizmos")
	elif enabled_gizmos == Gizmo.ALL:
		enabled_gizmos = Gizmo.NONE
		print_debug("[debug]: DISABLED all debug gizmos")
	else:
		enabled_gizmos = enabled_gizmos ^ gizmo as Gizmo
		print_debug("[debug]: ENABLED %s debug gizmos" % GIZMO_NAME.get(gizmo, "UNKNOWN"))

	debug_toggled.emit()


