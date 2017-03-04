Balloon = Core.class(Sprite)

local balloons = {
	Bitmap.new(Texture.new("AJ-balloon-red-50px.png")),
	Bitmap.new(Texture.new("AJ-balloon-red-50px.png")) }

local xLow, xHigh = 200, 300
local yLow, yHigh = 200, 300


function Balloon:init()

	local i = math.random(1, #balloons)
	
	self.speedY = math.random(1, 5)

	self.x = math.random(xLow, xHigh)
	self.y = math.random(yLow, yHigh)

	self:setPosition(self.x, self.y)
	self:addChild(balloons[i])

end

function Balloon:update()
	self.y = self.y - self.speedY
	self:setPosition(self.x, self.y)
	
end

function Balloon:hitTestPoint(