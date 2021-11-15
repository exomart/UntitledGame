extends CustomDelimiter2D

class_name AutoCustomDelimiter2D

func _ready():
	var x = $TopLeft.position.x + $BottomRight.position.x
	var y = $TopLeft.position.y + $BottomRight.position.y
	var area_center = Vector2(x / 2, y / 2)
	$Area2D.position = area_center
	var rect: RectangleShape2D = $Area2D/CollisionShape2D.shape
	rect.extents = Vector2(x - area_center.x, y - area_center.y)

func _on_Area2D_body_entered(body):
	if body == Globals.GetPlayerActor():
		TransitionsManager.CameraTransitionToDelimiter(self)
