Bat = Core.class(Sprite)

local batpack = TexturePack.new("images/batextures.txt", "images/batextures.png")
local batImages = { 
	batpack:getTextureRegion("bat1.png"), 
	batpack:getTextureRegion("bat2.png"), 
	batpack:getTextureRegion("bat3.png"), 
	batpack:getTextureRegion("bat4.png"), 
	batpack:getTextureRegion("bat5.png") } 

local batmaxwidth = application:getContentWidth()
local batmaxheight = application:getContentHeight()


function Bat:init()

---	self.x = math.random(0, batmaxwidth)  / 1000
---	self.y = batmaxheight

	self.x = 200 
	self.y = 200 

	self:setPosition(self.x, self.y)
	self.image = Bitmap.new(batImages[1])
	self:addChild(self.image)
	self.imageNum = 1
	self.imageDirection = 1
	
end

function Bat:update()
	if (self.imageNum == 5 and self.imageDirection == 1) or (self.imageNum == 1 and self.imageDirection == -1)  then
		self.imageDirection = self.imageDirection * -1
	end
	self.imageNum = self.imageNum + self.imageDirection
	self.x = self.x + math.random(-5, 5)
	self.y = self.y + math.random(-5, 5)

	self:removeChild(self.image)
	self.image = Bitmap.new(batImages[self.imageNum])
	self:addChild(self.image)
	self:setPosition(self.x, self.y)
end
