Person = Core.class(Sprite)



function Person:init(stage, x,y)
	-- create a Bitmap for each frame
	local frameImages = {
		Bitmap.new(Texture.new("images/Walk1.png")),
		Bitmap.new(Texture.new("images/Walk2.png")),
		Bitmap.new(Texture.new("images/Walk3.png")),
		Bitmap.new(Texture.new("images/Walk4.png"))	}
		
	self.aimImage = Bitmap.new(Texture.new("images/StayAttack1.png"))	
		
	self.throwImages = {
		Bitmap.new(Texture.new("images/StayAttack2.png")),
		Bitmap.new(Texture.new("images/StayAttack3.png")),
		Bitmap.new(Texture.new("images/StayAttack4.png"))	}
	
	
	self.stage = stage
	self.maxX = 300
	self.minX = 200
	self.step = 4
	self.rockOffset = 30
	
	self.frames = {}
	for i = 1, #frameImages do
		self.frames[i] = frameImages[i]
	end

	self.nframes = #frameImages

	-- add first Bitmap as a childe
	self.frame = 1
	self.activeFrame = self.frames[1]
	self:addChild(self.activeFrame)
	
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
	self:removeChild(self.activeFrame)

	self.frame = self.frame - 1
	if self.frame < 1 then 
		self.frame = 4
	end

	self.activeFrame = self.frames[self.frame]
	self:addChild(self.activeFrame)
	if self.x < self.minX then
		self.x = self.minX
	end
	
	self:setPosition(self.x, self.y)
end

function Person:moveRight()
	print('move right')
	self.x = self.x + self.step
	self:removeChild(self.activeFrame)

	self.frame = self.frame + 1
	if self.frame > 4 then 
		self.frame = 1
	end
	self.activeFrame = self.frames[self.frame]
	self:addChild(self.activeFrame)
	if self.x > self.maxX then
		self.x = self.maxX
	end
	
	self:setPosition(self.x, self.y)
end

function Person:aim()
	self:removeChild(self.activeFrame)
	self.activeFrame = self.aimImage
	self:addChild(self.aimImage)
end

function Person:throwRock(x, y, velocity)
	print("My touchpoint:",x,y)
	---print("My location:",self.x, self.y)
	local angle4 = calcAngle2(self.x + self.rockOffset, self.y, x, y )
	---print ("calcAngle2 - 180= ", 180 - angle4)
	
	local rock = Rock.new(self.stage, self.x + self.rockOffset, self.y, x, y, 180 - angle4, velocity)

	self:removeChild(self.activeFrame)
	self.activeFrame = self.throwImages[3]
	self:addChild(self.activeFrame)
	
	return rock

end


function Person:onEnterFrame()
end
