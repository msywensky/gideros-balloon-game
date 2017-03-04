GamePlay = Core.class(Sprite)

local rocks = {}
local balloons = {}
local person
local arrows
local pressedCount = 0
local beingPressed =  false
local rockThrown = false
local level

local throwPointX = 0
local throwPointY = 0

function GamePlay:init()

	self:addEventListener("enterBegin", self.onEnterBegin, self)
	self:addEventListener("enterEnd", self.onEnterEnd, self)


	local bitmap = Bitmap.new(Texture.new("bg_cropped.png"))
	local scaleX = application:getContentWidth() / 800
	local scaleY = application:getContentHeight() / 480
	 
	bitmap:setScaleX(scaleX)
	bitmap:setScaleY(scaleY)
	bitmap:setPosition(-800 * scaleX / 2 + application:getContentWidth() / 2, -480 * scaleY / 2 + application:getContentHeight() /2 )
	self:addChild(bitmap)

	person = Person.new(self, 200, 266)
	arrows = Arrows.new(self, person)



	self:addChild(person)
	arrows:draw()

end

function GamePlay:onEnterBegin()
	level = 0
end

function GamePlay:onEnterEnd()
	self:addEventListener("exitBegin", self.onExitBegin, self)
	self:addEventListener(Event.KEY_DOWN, self.onArrowKeyDown, self)
	self:addEventListener(Event.TOUCHES_BEGIN, self.onScreenPressed, self)
	self:addEventListener(Event.TOUCHES_END, self.onScreenPressedFinished, self)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function GamePlay:onExitBegin()
	self:removeEventListener(Event.KEY_DOWN, self.onArrowKeyDown, self)
	self:removeEventListener(Event.TOUCHES_BEGIN, self.onScreenPressed, self)
	self:removeEventListener(Event.TOUCHES_END, self.onScreenPressedFinished, self)
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)

	self:removeEventListener("exitBegin", self.onExitBegin, self)

end
function GamePlay:onArrowKeyDown(event)
	print(event.keyCode)
	if event.keyCode == KeyCode.LEFT then
		person:moveLeft()
	elseif event.keyCode == KeyCode.RIGHT then
		person:moveRight()
	end
end

function GamePlay:onScreenPressed(event)
	print("screen pressed")
	beingPressed = true
	pressedCount = 0
	rockThrown = false
end

function GamePlay:onScreenPressedFinished(event)
	print("screen pressed finished")
	beingPressed = false
	rockThrown = true
	throwPointX = event.touch.x
	throwPointY = event.touch.y
end


function GamePlay:nextLevel()

end

function GamePlay:onEnterFrame()

	pressedCount = pressedCount + 1
	if rockThrown then
		print("Throwing rock")
		table.insert(rocks,person:throwRock(throwPointX, throwPointY, pressedCount))
		rockThrown = false
		pressedCount = 0
	end


	

end

