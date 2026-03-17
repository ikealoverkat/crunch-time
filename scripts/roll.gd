extends Sprite2D

@onready var energydrinkcount_text = $"../Energydrinkcount/RichTextLabel"
@onready var brokeScreen = get_node("../brokeScreen")
@onready var gambleScreen = get_node("../gambleScreen")
@onready var gambleAnimationPlayer = get_node("../gambleScreen/AnimationPlayer")
@onready var crunchRarityText = get_node("../gambleScreen/gambleText/crunchRarityText")
@onready var crunchTypeText = get_node("../gambleScreen/gambleText/crunchTypeText")
@onready var crunch = get_node("../gambleScreen/crunch")
var crunch_rarity = 1
var crunch_name: String
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _crunch_gamble() -> void:
	randomize()
	var crunch_rarity_chooser = randi_range(1, 100)
	if crunch_rarity_chooser <= 60: #60% chance of common crunch
		crunch_rarity = 1
	elif crunch_rarity_chooser > 60 and crunch_rarity_chooser <= 83: #23% of uncommon crunch
		crunch_rarity = 2
	elif crunch_rarity_chooser > 83 and crunch_rarity_chooser <= 93: #10% chance of rare crunch 
		crunch_rarity = 3
	elif crunch_rarity_chooser > 93 and crunch_rarity_chooser < 98: #5% chance of SR crunch
		crunch_rarity = 4
	else: #2% chance of SSR crunch
		crunch_rarity = 5	
	
	if crunch_rarity == 1:
		crunchRarityText.text = "common"
		var random_crunch_in_category = randi_range(1, 4)
		if random_crunch_in_category == 1:
			crunch_name = "og"
		elif random_crunch_in_category == 2:
			crunch_name = "blue"
		elif random_crunch_in_category == 3:
			crunch_name = "silly"
		else:
			crunch_name = "pink"
	elif crunch_rarity == 2:
		crunchRarityText.text = "uncommon"
		var random_crunch_in_category = randi_range(1, 3)
		if random_crunch_in_category == 1:
			crunch_name = "tangerine"
		elif random_crunch_in_category == 2:
			crunch_name = "blueberry"
		else:
			crunch_name = "ipad"
	elif crunch_rarity == 3:
		crunchRarityText.text = "rare"
		var random_crunch_in_category = randi_range(1, 3)
		if random_crunch_in_category == 1:
			crunch_name = "cattatime"
		elif random_crunch_in_category == 2:
			crunch_name = "glitter"
		else:
			crunch_name = "child"	
	elif crunch_rarity == 4:
		crunchRarityText.text = "SR"
		var random_crunch_in_category = randi_range(1, 3)
		if random_crunch_in_category == 1: 
			crunch_name = "work"
		elif random_crunch_in_category == 2:
			crunch_name = "guitar"
		else:
			crunch_name = "money"
	else:
		crunchRarityText.text = "SSR"
		var random_crunch_in_category = randi_range(1, 2)
		if random_crunch_in_category == 1:
			crunch_name = "joy"
		elif random_crunch_in_category == 2:
			crunch_name = "crunchychee"	
			
	crunchTypeText.text = "a " + crunch_name + " crunch!"
	crunch.texture = load("res://media/crunch/crunch_" + crunch_name + ".png")
	constants.crunch_count += 1
	constants.crunch_list.append(crunch_name)
	constants.crunch_rarities.append(crunch_rarity)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		$AnimationPlayer.play("click")
		if constants.energy_drink_count >= 10:
			constants.energy_drink_count -= 10
			energydrinkcount_text.text = str(constants.energy_drink_count)
			gambleScreen.show()
			gambleAnimationPlayer.play("shake")
			await gambleAnimationPlayer.animation_finished
			$"../gambleScreen/CPUParticles2D".emitting = true
			_crunch_gamble()
			gambleAnimationPlayer.play("open")
		else:
			brokeScreen.show()
		
func _on_area_2d_mouse_entered() -> void:
	$AnimationPlayer.play("hover")

func _on_area_2d_mouse_exited() -> void:
	$AnimationPlayer.play("end_hover")
