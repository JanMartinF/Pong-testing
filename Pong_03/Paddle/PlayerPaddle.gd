extends Paddle

class_name PlayerPaddle

func _init(box: BoundingBox) -> void:
	_boundingBox = box
	_pos = Vector2(_padding, _boundingBox.getSize().y/2 - _size.y/2)
	_resetPos = _pos
	_rect = Rect2(_pos, _size)
	
func checkMovement(delta: float):
	if(Input.is_key_pressed(KEY_UP)):
		moveUp(delta)
		updatePos()
	if(Input.is_key_pressed(KEY_DOWN)):
		moveDown(delta)
		updatePos()
func moveUp(delta: float) ->void:
	_pos.y -= _speed.y * delta
func moveDown(delta: float) ->void:
	_pos.y += _speed.y * delta
