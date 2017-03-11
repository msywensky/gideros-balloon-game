SpaceShip = Core.class(Sprite)

local shipmaxwidth = application:getContentWidth()


local textures = {
	Texture.new("images/UFO-50px.png"),
	Texture.new("images/UFO_1-50px.png"),
	Texture.new("images/UFO_2-50px.png") }

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

	local i = math.random(1, #textures)
	self:addChild(Bitmap.new(textures[i]))

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