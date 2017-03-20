Balloon = Core.class(Sprite)

local balloons = {}

function loadBalloonTextures()
	local th = getActiveTheme()

	balloons = {}
	
	for i = 1, #th.images.balloons do
		balloons[i] = {}
		for j = 1, #th.images.balloons[i] do
			balloons[i][j] = Texture.new(th.imageFolder .. th.images.balloons[i][j])
		end
	end

end


local xLow, xHigh = 250, 400
local yLow, yHigh = 230, 300


function Balloon:init()

	local i = math.random(1, #balloons)
	
	self.speedY =  math.random(175, 425)  / 1000

	self.x = math.random(xLow, xHigh)
	self.y = math.random(yLow, yHigh)

	self:setPosition(self.x, self.y)
	
	self.balloonSet = balloons[i]
	self.imageNum = 1
	self.image = Bitmap.new(self.balloonSet[1])
	self:addChild(self.image)
	self.tCount = 1
	self.tInterval = math.random(75, 200)
end

function Balloon:update()
	self.y = self.y - self.speedY
	self:setPosition(self.x, self.y)
	
	self.tCount = self.tCount + 1
	if self.tCount == self.tInterval then
		self.tCount = 1
		self:removeChild(self.image)
		if self.imageNum < #self.balloonSet then
			self.imageNum = self.imageNum + 1
		else
			self.imageNum = 1
		end
		self.image = Bitmap.new(self.balloonSet[self.imageNum])
		self:addChild(self.image)
	end
end

function Balloon:isHit(x,y)
	return self:hitTestPoint(x,y)
end

function Balloon:offScreen()
	return self.y < 0
end
