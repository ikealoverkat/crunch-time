extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0

var is_moving = false
var random_walk_direction = 0

func _ready() -> void:
		random_walk()

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
	
	#if Input.is_action_just_pressed("click") and is_on_floor() and mouse_entered:
		#velocity.y = JUMP_VELOCITY
		#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right") #it's -1.0 or 1.0, and 0.0 when not doing anything
	#if direction:
		#velocity.x = direction * SPEED
		#is_moving = true
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#is_moving = false
#
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


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				velocity.y = JUMP_VELOCITY
