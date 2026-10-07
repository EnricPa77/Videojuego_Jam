extends CanvasLayer

@onready var value_labels := {
	"gold": %GoldValue,
	"shards": %ShardsValue,
	"soldiers": %SoldiersValue,
	"miners": %MinersValue,
}

func _ready() -> void:
	GameState.resource_changed.connect(_on_resource_changed)
	for res in value_labels:
		_on_resource_changed(res, GameState.resources[res])

func _on_resource_changed(res: String, value: int) -> void:
	value_labels[res].text = str(value)
