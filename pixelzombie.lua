PixelZombie = Core.class(Sprite)


local maxwidth = application:getContentWidth() - 50
local zombieImages = {}

function loadZombieImages(th)
	for i = 1, #th.images.zombie do
		zombieImages[i] = Bitmap.new(Texture.new(th.imageFolder .. th.images.zombie[i]))
	end
end


function PixelZombie:init(level)
	self.y = 210
	self.imageNumber = 1
	self:respawn(level)
	
	self:addChild(zombieImages[self.imageNumber])
	
end

function PixelZombie:update()
	self.x = self.x + self.speedX
	self:setPosition(self.x, self.y)
	self.stepCount = self.stepCount + 1
	if self.stepCount % 3 == 0 then
		self:removeChild(zombieImages[self.imageNumber])
		self.imageNumber = self.imageNumber + 1
		if self.imageNumber > #zombieImages then
			self.imageNumber = 1
		end
		self:addChild(zombieImages[self.imageNumber])
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

