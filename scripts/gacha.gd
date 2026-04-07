extends Node2D

@onready var energydrinkcounter = get_node("./Energydrinkcount/RichTextLabel")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	energydrinkcounter.text = "[center]" + str(constants.energy_drink_count) + "[/center]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
