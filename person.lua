Person = Core.class(Sprite)



function Person:init(stage, x,y)
	-- create a Bitmap for each frame
	local th = getActiveTheme()
	
	self.frames = {}
	
	for i = 1, #th.images.character.walk do
		self.frames[i] = Bitmap.new(Texture.new(th.imageFolder .. th.images.character.walk[i]))
	end
	
	self.aimImage = Bitmap.new(Texture.new(th.imageFolder .. th.images.character.aim))	

	self.throwImage = Bitmap.new(Texture.new(th.imageFolder .. th.images.character.throw))	
	
	
	self.stage = stage
	self.maxX = application:getContentWidth() - 50
	self.minX = 50
	self.step = 5
	self.rockOffset = 30
	

	self.nframes = #self.frames

	-- add first Bitmap as a childe
	self.frame = 1
	self.activeFrame = self.frames[1]
	self:addChild(self.activeFrame)
	
	-- set initial position
	self.x = x
	self.y = y
	
	self:setPosition(x, y)

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
	local angle4 = calcAngle2(self.x + self.rockOffset, self.y, x, y )
	
	local rock = Rock.new(self.stage, self.x + self.rockOffset, self.y, x, y, 180 - angle4, velocity)

	self:removeChild(self.activeFrame)
	self.activeFrame = self.throwImage
	self:addChild(self.activeFrame)
	
	return rock

end


