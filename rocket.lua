Rocket = Core.class(Sprite)

local shipmaxwidth = application:getContentWidth()


local textures = {
	Texture.new("images/fighter-50px.png"),
	Texture.new("images/tbird-50px.png") }

function Rocket:init()

	local spd = math.random(600, 800)
	self.speedY =  spd  / 1000
	
	
	self.x = math.random(100, 300)
	self.y = 300
	self:setPosition(self.x, self.y)

	local i = math.random(1, #textures)
	self:addChild(Bitmap.new(textures[i]))

end

function Rocket:update()
	self.y = self.y - self.speedY
	self:setPosition(self.x, self.y)
	
end

function Rocket:isHit(x,y)
	return self:hitTestPoint(x,y)
end

function Rocket:offScreen()
	return self.x < -50 or self.x > shipmaxwidth + 50
end