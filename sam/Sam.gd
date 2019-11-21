extends KinematicBody

var move_speed = 2.0
export var disabled = false
onready var anim = $"Graphics/AnimationPlayer"
func _physics_process(delta):
	if disabled:
		return
	var move_vec = Vector3()
	move_vec.z = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_vec.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vec = move_vec.rotated(Vector3.UP, $CamBase.rotation.y)
	if move_vec != Vector3.ZERO:
		$Graphics.rotation.y = atan2(move_vec.x, move_vec.z)
	move_and_collide(move_speed * move_vec * delta)
	
	if move_vec == Vector3.ZERO:
		set_anim("stand_loop")
	else:
		set_anim("walk_loop")

func set_anim(anim_name):
	if anim.current_animation == anim_name:
		return
	anim.play(anim_name)

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
func step():
	var ind = randi() % $FootStepPlayers.get_child_count()
	$FootStepPlayers.get_child(ind).play()
