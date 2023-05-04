@tool
class_name CSGPlusStaircase3D
extends CSGPolygon3D

const EPSILON = 0.001

# The width of the whole staircase.
@export_range(0.001, 100, 0.001) var staircase_width := 4.0:
	set(value):
		staircase_width = value
		update_polygon()

# The height of the whole staircase.
# The number of steps varies depending on this variable and the step height.
@export_range(0.001, 100, 0.001) var staircase_height := 2.0:
	set(value):
		staircase_height = value
		update_polygon()

# The height of each step.
# The number of steps varies depending on this variable and the staircase height.
@export_range(0.05, 10, 0.0001) var step_height := 0.25:
	set(value):
		step_height = value
		update_polygon()


func _ready() -> void:
	update_polygon()


func update_polygon():
	var new_poly := PackedVector2Array()
	var num_steps := staircase_height / step_height
	var step_width := staircase_width / num_steps

	for i in num_steps:
		# Create individual steps.
		new_poly.push_back(Vector2(i * step_width, i * step_height))
		new_poly.push_back(Vector2(i * step_width, (i + 1) * step_height))

	# Create points for the last step and the other end of the staircase floor.
	# Bias the stepping slightly using an epsilon value,
	# otherwise, the last step could end up being too high at whole increments.
	new_poly.push_back(Vector2(num_steps * step_width, snapped(staircase_height - EPSILON + step_height * 0.5, step_height)))
	new_poly.push_back(Vector2(num_steps * step_width, 0))

	# Assign the new polygon only once at the end.
	# This is required, otherwise it fails.
	polygon = new_poly
