extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		$AnimationPlayer.play("click")
		get_tree().change_scene_to_file("res://scenes/home.tscn")
		
func _on_area_2d_mouse_entered() -> void:
	$AnimationPlayer.play("hover")

func _on_area_2d_mouse_exited() -> void:
	$AnimationPlayer.play("end_hover")
