extends Node2D

var crunch_scene = preload("res://scenes/crunch.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in constants.crunch_count:
		add_crunches(constants.crunch_rarities[i],constants.crunch_list[i])
		print(constants.crunch_rarities[i])
		print(constants.crunch_count)
		print(constants.crunch_list[i])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_crunches(new_crunch_rarity: int, new_crunch_name: String) -> void:
	var new_crunch = crunch_scene.instantiate()
	new_crunch.crunch_name = new_crunch_name
	new_crunch.crunch_rarity = new_crunch_rarity
	add_child(new_crunch)
	new_crunch.z_index = 10
	new_crunch.scale = Vector2(0.1, 0.1)
	new_crunch.position.x = randi_range(120, 520)
	new_crunch.position.y = randi_range(260, 290)
	
	new_crunch.get_node("Sprite2D").texture = load("res://media/crunch/crunch_" + new_crunch_name + ".png")
