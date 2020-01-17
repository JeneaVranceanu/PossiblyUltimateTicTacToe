extends Label

var font_shadow_color_generator =  RandomNumberGenerator.new()
var current_shadow_color = Color.aliceblue
var next_shadow_color = Color.aliceblue

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	font_shadow_color_generator.set_seed(0.1233198239)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if current_shadow_color == next_shadow_color: 
	#	generate_new_color()
	#else: 
	#	current_shadow_color = Color()
	#font_color_shadow = current_shadow_color

func generate_new_color():
	var r = font_shadow_color_generator.randf_range(0.0, 1.0)
	var g = font_shadow_color_generator.randf_range(0.0, 1.0)
	var b = font_shadow_color_generator.randf_range(0.0, 1.0)
	
	next_shadow_color = Color(r, g, b)