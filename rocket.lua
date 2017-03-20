Rocket = Core.class(Sprite)


local rocketTextures = { }

function loadRocketTextures(th)

	for i = 1, #th.images.rockets do
		rocketTextures[i] = Texture.new(th.imageFolder .. th.images.rockets[i])
	end

end


function Rocket:init()

	local spd = math.random(600, 800)
	self.speedY =  spd  / 1000
	
	
	self.x = math.random(100, 300)
	self.y = 300
	self:setPosition(self.x, self.y)

	local i = math.random(1, #rocketTextures)
	self:addChild(Bitmap.new(rocketTextures[i]))

end

function Rocket:update()
	self.y = self.y - self.speedY
	self:setPosition(self.x, self.y)
	
end

function Rocket:isHit(x,y)
	return self:hitTestPoint(x,y)
end

function Rocket:offScreen()
	return self.y < 0
end