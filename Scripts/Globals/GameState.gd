extends Node

signal resource_changed(res: String, value: int)

var resources := {
	"gold": 500,
	"shards": 0,
	"soldiers": 0,
	"miners": 0,
}

func add(res: String, amount: int = 1) -> void:
	resources[res] += amount
	resource_changed.emit(res, resources[res])

func spend(res: String, amount: int) -> bool:
	if resources[res] < amount:
		return false
	add(res, -amount)
	return true
