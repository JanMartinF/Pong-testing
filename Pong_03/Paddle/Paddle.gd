extends Node2D

class_name Paddle

var _color: Color = Color.white
var _size: Vector2 = Vector2(10.0, 100.0)
var _padding: float = 10.0
var _speed: Vector2 = Vector2 (0.0, 400.0)
var _resetSpeed: Vector2 = _speed
var _halfHeight: float = _size.y/2


#handled by subclass
var _rect: Rect2 
var _pos: Vector2
var _resetPos: Vector2
var _boundingBox: BoundingBox 

func _draw() -> void:
	draw_rect(_rect, _color)

func getHeight() -> float:
	return _size.y
	
func getRect() -> Rect2:
	return _rect
	
func resetPosition() -> void:
	_pos = _resetPos
	_rect = Rect2(_pos, _size)

func updatePos() -> void:
	_pos.y = clamp(_pos.y, _boundingBox.getPosition().y, _boundingBox.getSize().y - _size.y)
	_rect = Rect2(_pos, _size)
	update()

#overwrite classes
func moveUp(delta: float) -> void:
	assert(false, "Method MoveUp has not been overwritten")	
		
func moveDown(delta: float) -> void:
	assert(false, "Method MoveDown has not been overwritten")	

	
	
	
