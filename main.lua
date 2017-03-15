
sceneManager = SceneManager.new({
    --["start"] = GamePlay,
    ["game_play"] = GamePlay,
    --["level_select"] = level_select,
    --["level"] = level
})
--add manager to stage
stage:addChild(sceneManager)

sceneManager:changeScene("game_play", 1, SceneManager.flipWithFade, easing.outBack)

AppRater.new({
	androidRate = "", --link to rate Android app
	iosRate = "",     --link to rate IOS app
	timesUsed = 15,   --times to use before asking to rate
	daysUsed = 30,    --days to use before asking to rate
	version = 0,      --current version of the app
	remindTimes = 15,  --times of use to wait before reminding
	remindDays = 5,    --days of use to wait before reminding
	rateTitle = "Rate My App",
	rateText = "Please rate ZombiePop",
	rateButton = "Rate it now!",
	remindButton = "Remind me later",
	cancelButton = "No, thanks"
})


--[[
--- load texture, create bitmap from it and set as background
local bitmap = Bitmap.new(Texture.new("bg_cropped.png"))
local scaleX = application:getContentWidth() / 800
local scaleY = application:getContentHeight() / 480
 
bitmap:setScaleX(scaleX)
bitmap:setScaleY(scaleY)
bitmap:setPosition(-800 * scaleX / 2 + application:getContentWidth() / 2, -480 * scaleY / 2 + application:getContentHeight() /2 )
stage:addChild(bitmap)
 

print('starting...')
local dWidth = application:getDeviceWidth()

local person = Person.new(200, 266)
local arrows = Arrows.new(person)
print('after person')

local function onKeyDown(event)

	print(event.keyCode)
	if event.keyCode == KeyCode.LEFT then
		person:moveLeft()
	elseif event.keyCode == KeyCode.RIGHT then
		person:moveRight()
	end
	
end

---local function onTouch(event)


stage:addEventListener(Event.KEY_DOWN, onKeyDown)
stage:addChild(person)
arrows:draw()


pressedCount = 0
beingPressed =  false
rockThrown = false

throwPointX = 0
throwPointY = 0

local function onScreenPressed(event)
	print("screen pressed")
	beingPressed = true
	pressedCount = 0
	rockThrown = false
end

local function onScreenPressedFinished(event)
	print("screen pressed finished")
	beingPressed = false
	rockThrown = true
	throwPointX = event.touch.x
	throwPointY = event.touch.y
end

local function onEnterFrame()

	pressedCount = pressedCount + 1
	if rockThrown then
		print("Throwing rock")
		person:throwRock(throwPointX, throwPointY, pressedCount)
		rockThrown = false
		pressedCount = 0
	end

end

stage:addEventListener(Event.TOUCHES_BEGIN, onScreenPressed)
stage:addEventListener(Event.TOUCHES_END, onScreenPressedFinished)
stage:addEventListener(Event.ENTER_FRAME, onEnterFrame)
--]]

--[[
print (application:getLogicalWidth())
print (application:getLogicalHeight())
print (application:getDeviceWidth())
print (application:getDeviceHeight())
]]--
