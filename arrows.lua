Arrows = Core.class(Sprite)
arrowFrameCount = 0

arrowImages = {}

function loadArrowImages(th)
	local f = th.imageFolder
	
	arrowImages.leftArrow = Bitmap.new(Texture.new(f .. th.images.leftArrow))
	arrowImages.rightArrow = Bitmap.new(Texture.new(f .. th.images.rightArrow))

end

function Arrows:init(stage, person)
	
	self.stage = stage
	self.leftArrow = Sprite.new()
	self.rightArrow = Sprite.new()
	
	self.leftArrow:addChild(arrowImages.leftArrow)
	self.rightArrow:addChild(arrowImages.rightArrow)
	

	self.leftArrow:setPosition(25,180)
	self.rightArrow:setPosition(90,180)
	self.direction = 0

	self:setPerson(person)

end

function Arrows:setPerson(person)
	self.person = person
end

function Arrows:onArrowPressed(event)
	if self.leftArrow:hitTestPoint(event.touch.x, event.touch.y) then
		print ("left arrow pressed ")
		self.direction = -1
		event:stopPropagation()
	elseif self.rightArrow:hitTestPoint(event.touch.x, event.touch.y) then
		print ("right arrow pressed ")
		self.direction = 1
		event:stopPropagation()
	end
end

function Arrows:onArrowPressedFinished(event)
	if self.leftArrow:hitTestPoint(event.touch.x, event.touch.y) or self.rightArrow:hitTestPoint(event.touch.x, event.touch.y) then
		print ("Arrow finished ")
		self.direction = 0
		event:stopPropagation()
	end
end

function Arrows:draw()
	self.leftArrow:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
	self.leftArrow:addEventListener(Event.TOUCHES_BEGIN,self.onArrowPressed, self)
	self.leftArrow:addEventListener(Event.TOUCHES_END, self.onArrowPressedFinished, self)
	
	self.stage:addChild(self.leftArrow)
	self.stage:addChild(self.rightArrow)
end

function Arrows:remove()
	print("removing arrows")
	self.stage:removeChild(self.leftArrow)
	self.stage:removeChild(self.rightArrow)

	self.leftArrow:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
	self.leftArrow:removeEventListener(Event.TOUCHES_BEGIN,self.onArrowPressed, self)
	self.leftArrow:removeEventListener(Event.TOUCHES_END, self.onArrowPressedFinished, self)
end

function Arrows:onEnterFrame()
	arrowFrameCount = arrowFrameCount + 1
	
	if self.direction == -1 and arrowFrameCount % 2 == 0 then
		self.person:moveLeft()
		arrowFrameCount = 0
	elseif self.direction == 1  and arrowFrameCount % 2 == 0 then
		self.person:moveRight()
		arrowFrameCount = 0
	end
end