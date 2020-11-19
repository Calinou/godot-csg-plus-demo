tool
extends CSGPolygon
class_name CSGPlusStaircase

# The number of steps in the staircase.
export(int, 1, 128) var steps := 4 setget set_steps

# The width of each step.
export(float, 0.001, 10) var step_width := 1.0 setget set_step_width

# The height of each step.
export(float, 0.001, 10) var step_height := 1.0 setget set_step_height


func _ready() -> void:
	update_polygon()


func update_polygon():
	var new_poly := PoolVector2Array()

	for i in steps:
		# Create individual steps.
		new_poly.push_back(Vector2(i * step_width, i * step_height))
		new_poly.push_back(Vector2(i * step_width, (i + 1) * step_height))

	# Create points for the last step and the other end of the staircase floor.
	new_poly.push_back(Vector2(steps * step_width, steps * step_height))
	new_poly.push_back(Vector2(steps * step_width, 0))

	# Assign the new polygon only once at the end.
	# This is required, otherwise it fails.
	polygon = new_poly

func set_steps(p_steps: int) -> void:
	steps = p_steps
	update_polygon()


func set_step_width(p_step_width: float) -> void:
	step_width = p_step_width
	update_polygon()


func set_step_height(p_step_height: float) -> void:
	step_height = p_step_height
	update_polygon()
