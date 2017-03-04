Person = Core.class(Sprite)


function Person:init(stage, x,y)
	-- create a Bitmap for each frame
	local frameImages = {
		"Walk1.png",
		"Walk2.png",
		"Walk3.png",
		"Walk4.png"	}
		
	
	self.stage = stage
	self.maxX = 350
	self.minX = 200
	self.step = 3
	
	self.frames = {}
	for i = 1, #frameImages do
		self.frames[i] = Bitmap.new(Texture.new(frameImages[i]))
	end

	self.nframes = #frameImages

	-- add first Bitmap as a child
	self.frame = 1
	self:addChild(self.frames[1])
	
	-- set initial position
	self.x = x
	self.y = y
	
	self:setPosition(x, y)

	-- set the speed of the Person
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)	
	print('after init')
end


function Person:moveLeft()
	print('move left')
	self.x = self.x - self.step
	self:removeChild(self.frames[self.frame])

	self.frame = self.frame - 1
	if self.frame < 1 then 
		self.frame = 4
	end

	self:addChild(self.frames[self.frame])
	if self.x < self.minX then
		self.x = self.minX
	end
	
	self:setPosition(self.x, self.y)
end

function Person:moveRight()
	print('move right')
	self.x = self.x + self.step
	self:removeChild(self.frames[self.frame])

	self.frame = self.frame + 1
	if self.frame > 4 then 
		self.frame = 1
	end
	
	self:addChild(self.frames[self.frame])
	if self.x > self.maxX then
		self.x = self.maxX
	end
	
	self:setPosition(self.x, self.y)
end

function Person:throwRock(x, y, velocity)
	print("My touchpoint:",x,y)
	---print("My location:",self.x, self.y)
	local angle4 = calcAngle2(self.x, self.y, x, y )
	---print ("calcAngle2 - 180= ", 180 - angle4)
	
	local rock = Rock.new(self.stage, self.x, self.y, x, y, 180 - angle4, velocity)
	
	return rock

end


function Person:onEnterFrame()
end
