extends PanelContainer
class_name CustomPanelContainer


func _ready():
	print("_ready PanelContainer")

	# The following two lines should clearly be a no-op but they aren't.
	if position.x == 0:
		position.x = 0

	# print(self.margin_right)
	# print(self.margin_bottom)
