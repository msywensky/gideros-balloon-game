PixelZombie = Core.class(Sprite)

local appearImages = {
	Bitmap.new(Texture.new("images/pixelzombie/1.png")),
	Bitmap.new(Texture.new("images/pixelzombie/2.png")),
	Bitmap.new(Texture.new("images/pixelzombie/3.png")) }

local maxwidth = application:getContentWidth() - 50


function PixelZombie:init(level)
	self.y = 210
	self.imageNumber = 1
	self:respawn(level)
	
	self:addChild(appearImages[self.imageNumber])
	
end

function PixelZombie:update()
	self.x = self.x + self.speedX
	self:setPosition(self.x, self.y)
	self.stepCount = self.stepCount + 1
	if self.stepCount % 3 == 0 then
		self:removeChild(appearImages[self.imageNumber])
		self.imageNumber = self.imageNumber + 1
		if self.imageNumber > 3 then
			self.imageNumber = 1
		end
		self:addChild(appearImages[self.imageNumber])
	end
	
end

function PixelZombie:respawn(level)
	self.speedX =  -0.05 * level
	self.x = maxwidth
	self.stepCount = 1
	self:setPosition(self.x, self.y)

end

function PixelZombie:isHit(x,y)
	return self:hitTestPoint(x-25,y)
end

