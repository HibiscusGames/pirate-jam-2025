extends CanvasItem

@export var energy_bar: ProgressBarWithShadow

func _ready() -> void:
	energy_bar.max_value = GameState.energy_pool.max_energy
	energy_bar.min_value = 0
	energy_bar.value = GameState.energy_pool.current_energy

	GameState.energy_pool.updated.connect(_update_energy_bar)

func _update_energy_bar(pool: EnergyPool) -> void:
	energy_bar.value = pool.current_energy
