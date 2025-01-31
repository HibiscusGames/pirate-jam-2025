extends Node

var energy_pool: EnergyPool = preload("res://res/default_energy_pool.tres")

################ Exported functions ################

# TODO: Fail state

# TODO: Pause menu

# TODO: Level transition

func reset():
	# TODO: Respawn the player
	energy_pool.replenish(energy_pool.max_energy)

################ Internal functions ################
