extends Resource

class_name BoundingBox
var _box: Rect2
var _topBound: float
var _bottomBound: float
var _leftBound: float
var _rightBound: float

func _init(rect: Rect2) -> void:
	_box = rect
	_topBound = _box.position.y
	_bottomBound = _topBound + _box.size.y
	_leftBound = _box.position.x
	_rightBound = _leftBound + _box.size.x
	
func getRect() -> Rect2:
	return _box
	
func getBox() -> BoundingBox:
	return self
	
func getSize() -> Vector2:
	return _box.size
	
func getPosition() -> Vector2:
	return _box.position

func getCenter() -> Vector2:
	return _box.size/2

func isPassLeftBound(position: Vector2) -> bool:
	return position.x <= _leftBound	
func isPassrightBound(position: Vector2) -> bool:
	return position.x >= _rightBound	
func isPassTopBound(position: Vector2) -> bool:
	return position.y <= _topBound	
func isPassBottomBound(position: Vector2) -> bool:
	return position.y >= _bottomBound
