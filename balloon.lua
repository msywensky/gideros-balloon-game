Balloon = Core.class(Sprite)

local balloons = {
	Texture.new("images/AJ-balloon-red-50px.png"),
	Texture.new("images/AJ-balloon-yellow-50px.png"),
	Texture.new("images/AJ-balloon-purple-50px.png"),
	Texture.new("images/AJ-balloon-orange-50px.png"),
	Texture.new("images/AJ-balloon-green-50px.png"),
	Texture.new("images/AJ-balloon-blue-50px.png") }

local xLow, xHigh = 250, 400
local yLow, yHigh = 230, 300


function Balloon:init()

	local i = math.random(1, #balloons)
	
	self.speedY =  math.random(200, 400)  / 1000

	self.x = math.random(xLow, xHigh)
	self.y = math.random(yLow, yHigh)

	self:setPosition(self.x, self.y)
	
	self:addChild(Bitmap.new(balloons[i]))

end

function Balloon:update()
	self.y = self.y - self.speedY
	self:setPosition(self.x, self.y)
	
end

function Balloon:isHit(x,y)
	return self:hitTestPoint(x,y)
end

function Balloon:offScreen()
	return self.y < 0
end
