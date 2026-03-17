extends Node2D

@onready var energydrinkcounter = get_node("./Energydrinkcount/RichTextLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	energydrinkcounter.text = str(constants.energy_drink_count)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
