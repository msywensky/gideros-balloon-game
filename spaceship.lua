SpaceShip = Core.class(Sprite)

local shipmaxwidth = application:getContentWidth()

local shipTextures = { }

function loadShipTextures(th)

	for i = 1, #th.images.ships do
		shipTextures[i] = Texture.new(th.imageFolder .. th.images.ships[i])
	end

end

function SpaceShip:init()

	local spd = math.random(500, 700)
	self.speedX =  spd  / 1000
	print ("spd ", spd)
	
	if spd % 2 == 0 then
		self.speedX = -1.0 * self.speedX
		self.x = shipmaxwidth
	else
		self.x = 0
	end
	
	self.y = math.random(20, 50)
	self:setPosition(self.x, self.y)

	local i = math.random(1, #shipTextures)
	self:addChild(Bitmap.new(shipTextures[i]))

end

function SpaceShip:update()
	self.x = self.x + self.speedX
	self:setPosition(self.x, self.y)
	
end

function SpaceShip:isHit(x,y)
	return self:hitTestPoint(x,y)
end

function SpaceShip:offScreen()
	return self.x < -50 or self.x > shipmaxwidth + 50
end