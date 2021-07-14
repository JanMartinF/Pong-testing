extends Node2D


#screen values
onready var screen: Rect2 = get_tree().get_root().get_visible_rect()
onready var screenBox: BoundingBox = BoundingBox.new(screen)
# object instancing
onready var ball: Ball = Ball.new(screenBox.getCenter())
onready var playerPaddle: PlayerPaddle = PlayerPaddle.new(screenBox)


#states
enum GAME_STATE {MENUE, SERVE, PLAY}
var isPlayerServ = true

#currentstate
var currentGameState = GAME_STATE.MENUE


#paddle variables 
var paddleColor = Color.white
var paddleSize = Vector2(10.0,100.0)
var halfPaddleHeight = paddleSize.y/2.0
var paddlePadding = 10.0


#npc
onready var npcPosition = Vector2(screenBox.getSize().x - (paddlePadding + paddleSize.x), screenBox.getSize().y/2.0 - halfPaddleHeight)
onready var npcRectangle = Rect2(npcPosition, paddleSize)

#fonts
var font = DynamicFont.new()
var robotoFile = load("Roboto-Light.ttf")
var fontSize = 24
var halfWidthFont
var heightFont
var stringPosition
var stringValue = "Press Spacebar to start the Game"

#delta key
const RESET_DELTA_KEY = 0.0
const DELTA_KEY_PRESS_DELAY = 0.5
var deltaKeyPress = RESET_DELTA_KEY
#misc

#scoring
var playerScore = 0
var playerScoreText = playerScore as String
var playerTextHalfWidth
var playerScorePosition

var npcScore = 0
var npcScoreText = npcScore as String
var npcTextHalfWidth
var npcScorePosition

const MAX_SCORE = 3
var isPlayerWin

func _ready() -> void:
	add_child(ball)
	add_child((playerPaddle))
	
	font.font_data = robotoFile
	font.size = fontSize
	halfWidthFont = font.get_string_size(stringValue).x/2
	heightFont = font.get_height()
	stringPosition = Vector2(screenBox.getSize().x/2.0 - halfWidthFont, heightFont)
	
	playerTextHalfWidth = font.get_string_size(playerScoreText).x/2
	playerScorePosition = Vector2(screenBox.getSize().x/4.0 - playerTextHalfWidth, heightFont + 50)
	
	npcTextHalfWidth = font.get_string_size(npcScoreText).x/2
	npcScorePosition = Vector2((screenBox.getSize().x/4.0)*3 - npcTextHalfWidth, heightFont + 50)

func _physics_process(delta: float) -> void:
	deltaKeyPress += delta
	match currentGameState:
		GAME_STATE.MENUE:
			if(isPlayerWin):
				changeString("You won! Press Spacebar to play again.")
			if(isPlayerWin == false):
				changeString("NPC won! Press Spacebar to play again.")
			if(Input.is_key_pressed(KEY_SPACE) and deltaKeyPress > DELTA_KEY_PRESS_DELAY):
				deltaKeyPress = RESET_DELTA_KEY
				currentGameState = GAME_STATE.SERVE
				playerScoreText = playerScore as String
				npcScoreText = npcScore as String
		GAME_STATE.SERVE:
			setStartingPosition()
			update()
			if(MAX_SCORE == playerScore):
				currentGameState = GAME_STATE.MENUE
				playerScore = 0
				npcScore = 0
				isPlayerWin = true
			if(MAX_SCORE == npcScore):
				currentGameState = GAME_STATE.MENUE
				playerScore = 0
				npcScore = 0
				isPlayerWin = false
			
			if isPlayerServ:
#				ball.resetBall(isPlayerServ)
				changeString("It's your serve")
			if !isPlayerServ:
#				ball.resetBall(isPlayerServ)
				changeString("It's your opponents serve")
			if(Input.is_key_pressed(KEY_SPACE) and deltaKeyPress > DELTA_KEY_PRESS_DELAY):
				deltaKeyPress = RESET_DELTA_KEY
				currentGameState = GAME_STATE.PLAY
		GAME_STATE.PLAY:
			playerPaddle.checkMovement(delta)
			changeString("You're playing!")
			if(Input.is_key_pressed(KEY_SPACE) and deltaKeyPress > DELTA_KEY_PRESS_DELAY):
				deltaKeyPress = RESET_DELTA_KEY
				currentGameState = GAME_STATE.MENUE
			ball.moveBall(delta)
			if screenBox.isPassLeftBound(ball.getPosition()):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServ = true
				npcScore += 1
				npcScoreText = npcScore as String
			if screenBox.isPassrightBound(ball.getPosition()):
				currentGameState = GAME_STATE.SERVE
				deltaKeyPress = RESET_DELTA_KEY
				isPlayerServ = false	
				playerScore += 1
				playerScoreText = playerScore as String

			if(Collisions.pointToRectangle(ball.getPosition(), playerPaddle.getRect())):
				ball.inverseXSpeed()
				
			if(Collisions.pointToRectangle(ball.getPosition(), Rect2(npcPosition, paddleSize))):
				ball.inverseXSpeed()
						
					
			if(screenBox.isPassTopBound(ball.getTopPoint()) or screenBox.isPassBottomBound(ball.getBottomPoint())):
				ball.inverseYSpeed()
			
			if ball.getPosition().y > npcPosition.y + (paddleSize.y/2 + 10):
				npcPosition.y += 250 * delta
			if ball.getPosition().y < npcPosition.y + (paddleSize.y/2 - 10):
				npcPosition.y -= 250 * delta
	
			npcPosition.y = clamp(npcPosition.y, paddlePadding, screenBox.getSize().y - (paddleSize.y + paddlePadding))
			npcRectangle = Rect2(npcPosition, paddleSize)
				
			
			update()
func _draw() -> void:
	draw_rect(npcRectangle, paddleColor)
	draw_string(font, stringPosition, stringValue)
	draw_string(font, playerScorePosition, playerScoreText)
	draw_string(font, npcScorePosition, npcScoreText)

func setStartingPosition():

	npcPosition = Vector2(screenBox.getSize().x - (paddlePadding + paddleSize.x), screenBox.getSize().y/2 - halfPaddleHeight)
	npcRectangle = Rect2(npcPosition, paddleSize)
	playerPaddle.resetPosition()
	ball.resetBall(isPlayerServ)
	
func changeString(newStringVlaue):
	stringValue = newStringVlaue
	halfWidthFont = font.get_string_size(stringValue).x/2
	stringPosition = Vector2(screenBox.getSize().x/2 - halfWidthFont, heightFont)
	update()









