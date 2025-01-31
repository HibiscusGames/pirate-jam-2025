extends Resource
class_name EnergyPool

################## Signals #######################

signal depleted(pool: EnergyPool)
signal updated(pool: EnergyPool)

############### Internal state ###################

@export var max_energy: int = 5;
@export var current_energy: int = 5;
@export var default_increase: int = 1;
@export var default_decrease: int = 1;

############# Exported functions ##################

func replendish(amount: int = default_increase): _adjust(amount)
func consume(amount: int = default_decrease): _adjust(-amount)

############## Internal functions ##################

func _adjust(amount: int) -> void:
	current_energy = clamp(current_energy + amount, 0, max_energy)
	updated.emit(self)

	if current_energy == 0:
		depleted.emit(self)
