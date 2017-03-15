Rock = Core.class(Sprite)

local rockmaxwidth = application:getContentWidth()
local rockmaxheight = application:getContentHeight()
local texture_stone = Texture.new("images/stone.png")

function Rock:init(stage, x,y, x2, y2, angle, velocity)
	-- create a Bitmap for each frame

--[[
	mag = math.sqrt((x2 - x) * (x2 - x) + (y2 - y) * (y2 - y));
	sine = (y2 - y) / mag;
	cosine = (x2 - x) / mag;
	print (math.cos(self.angle) * velocity)
	print (math.sin(self.angle) * velocity)
	print (cosine * velocity)
	print (sine * velocity)
]]--
	self.stage = stage
	---self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self.time = 0
	self.x = x
	self.y = y
	self.angle = angle / 180.0 * math.pi
	

	self.xVelocity = math.cos(self.angle) * velocity
    self.yVelocity = math.sin(self.angle) * velocity
	self.gravity = 9.8
	self.wind = 0
	self:setPosition(self.x,self.y)
	self:addChild(Bitmap.new(texture_stone))
	print("Rock created")
end

function Rock:update()
	self.time = self.time + .016667
	self.x = self.x + (self.xVelocity * self.time) + (.5 * (self.wind / 5.0) * self.time ^ 2)
    self.y = self.y + ((-1.0 * (self.yVelocity * self.time)) + (.5 * self.gravity * (self.time ^ 2))) 

	self:setPosition(self.x, self.y)
end

function Rock:offScreen()
	return ( (self.x > rockmaxwidth) or (self.x < 0) or (self.y > rockmaxheight) )
end

function Rock:hitBalloon(balloons)
	local i
	for i=1, #balloons do
		if balloons[i]:isHit(self.x, self.y) then
			return i
		end
	end
	
	return 0
end


