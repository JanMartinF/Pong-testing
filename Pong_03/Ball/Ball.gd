extends Node2D

class_name Ball

var _radius: float = 10.0
var _color: Color = Color.white
var _speed: Vector2 = Vector2(400.0,0.0)
var _resetSpeed: Vector2
var _resetPos: Vector2
var _pos: Vector2
var _playerServe: bool #this might not be needed

func _init(startPos: Vector2, playerServe:= true):
	_pos = startPos
	_resetPos = startPos # assuming center of screen
	_playerServe = playerServe
	_resetSpeed = _speed
func _draw() -> void:
	draw_circle(_pos, _radius, _color)

func moveBall(delta: float) -> void:
	_pos += _speed * delta
	update()

func resetBall(playerServe: bool) -> void:
	_pos = _resetPos # assuming this is the center of the screen
	_speed = _resetSpeed if playerServe else -_resetSpeed
	update()
	
func inverseYSpeed() -> void:
	_speed.y = -_speed.y
	
func inverseXSpeed() -> void:
	_speed = Vector2(-_speed.x, rand_range(-400,400)) 

func getPosition() -> Vector2:
	return _pos
func getTopPoint() -> Vector2:
	return Vector2(_pos.x, _pos.y - _radius)
func getBottomPoint() -> Vector2:
	return Vector2(_pos.x, _pos.y + _radius)
	
#ball stats
#var ballRadius = 10.0
#var ballColor = Color.white
#
#onready var startingBallPosition = Vector2(screenWidth/2,screenHeight/2)
#onready var ballPosition = startingBallPosition
#
##ball speed
#var startingBallSpeed = Vector2(400.0,0)
#var ballSpeed = startingBallSpeed
#var player Serve
