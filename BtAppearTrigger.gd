extends Area

onready var bt1 = $BT/Body/Armature/BT

func _ready():
	connect("body_entered", self, "display_bts")
	bt1.get_surface_material(0).set_shader_param("alpha_scissor_threshold", 1.0)

func display_bts(body):
	if body.name == "Sam":
		start_showing = true

var start_showing = false
export var end_alpha = 0.62
var cur_alpha = 1.0
func _process(delta):
	if start_showing:
		cur_alpha -= delta / 1.5
		if cur_alpha < end_alpha:
			cur_alpha = end_alpha
		bt1.get_surface_material(0).set_shader_param("alpha_scissor_threshold", cur_alpha)