extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0

var is_moving = false
var random_walk_direction = 0
var time_per_drink = 10

@onready var energydrinkcount_text = $"../../Energydrinkcount/RichTextLabel"
@onready var particle_emitter = $AnimatedSprite2D/CPUParticles2D

@export var crunch_rarity: int = 1

func _ready() -> void:
		random_walk()
		energy_drink_getter()
		print(energydrinkcount_text)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_moving == true:
		$AnimationPlayer.play("walk")
		velocity.x = random_walk_direction * SPEED
	else:
		$AnimationPlayer.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED) #stop moving
		
	move_and_slide()
#
func random_walk() -> void:
		randomize()		
		while true:
			await get_tree().create_timer(randf_range(0.5, 3.0)).timeout #wait to walk
			random_walk_direction = [-1.0, 1.0].pick_random()
			is_moving = true
			await get_tree().create_timer(randf_range(0.3, 1.5)).timeout #walk
			is_moving = false

func energy_drink_getter() -> void:
	while true:
		await get_tree().create_timer(time_per_drink).timeout #wait for the drink to appear before increasing energy drink count
		constants.energy_drink_count += 1 * crunch_rarity
		$EnergyDrink.show()
		$EnergyDrink/AnimationPlayer.play("anim")
		await $EnergyDrink/AnimationPlayer.animation_finished
		$EnergyDrink.hide()
		energydrinkcount_text.text = str(constants.energy_drink_count)
		#print("crunch got you an energy drink! you have " + str(constants.energy_drink_count) + " energy drinks")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				velocity.y = JUMP_VELOCITY
				particle_emitter.restart()
				particle_emitter.emitting = true
