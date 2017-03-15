GamePlay = Core.class(Sprite)

BALLOON_POP @ 1
ZOMBIE_HIT  @ 2
ZOMBIE_LOSE  @ 3
SPACESHIP_FLYING @ 4
SPACESHIP_HIT @ 5
ROCKET_FLYING @ 6
ROCKET_HIT @ 7



local rocks = {}
local person
local arrows
local pressedCount = 0
local beingPressed =  false
local rockThrown = false
local level

local throwPointX = 0
local throwPointY = 0

local personStartX = 200
local personStartY = 266

function GamePlay:init()

	self:addEventListener("enterBegin", self.onEnterBegin, self)
	self:addEventListener("enterEnd", self.onEnterEnd, self)
	self.dogfont20 = Font.new("fonts/gooddog20.txt", "fonts/gooddog20.png")
	self.dogfont25 = Font.new("fonts/gooddog25.txt", "fonts/gooddog25.png")
	self.dogfont30 = Font.new("fonts/gooddog30.txt", "fonts/gooddog30.png")
	self.dogfont40 = Font.new("fonts/gooddog40.txt", "fonts/gooddog40.png")
	self.dogfont50 = Font.new("fonts/gooddog50.txt", "fonts/gooddog50.png")

	local bitmap = Bitmap.new(Texture.new("images/bg_cropped.png"))
	local scaleX = application:getContentWidth() / 800
	local scaleY = application:getContentHeight() / 480
	 
	bitmap:setScaleX(scaleX)
	bitmap:setScaleY(scaleY)
	bitmap:setPosition(-800 * scaleX / 2 + application:getContentWidth() / 2, -480 * scaleY / 2 + application:getContentHeight() /2 )
	self:addChild(bitmap)

	person = Person.new(self, personStartX, personStartY)
	arrows = Arrows.new(self, person)

	self:addChild(person)
	
	self.backgroundMusic = Sound.new("sounds/carousel3.wav")
	self.popSound = Sound.new("sounds/pop.wav")
	self.zombieHitSound = Sound.new("sounds/zombie-roar-5.wav")
	self.zombieLoseSound = Sound.new("sounds/zombie-growl2.wav")
	self.spaceShipFlyingSound = Sound.new("sounds/spaceship.wav")
	self.spaceShipHitSound = Sound.new("sounds/pop.wav")
	self.rocketFlyingSound = Sound.new("sounds/qubodup__rocket-boost-engine-loop.wav")
	self.rocketHitSound = Sound.new("sounds/pop.wav")

end

function GamePlay:updateScore(points)
	self.score = self.score + points
	if self.scoreText == nil then
		self.scoreText = TextField.new(self.dogfont30, "Score: 0")
		self.scoreText:setTextColor(0xffffff)
		self.scoreText:setX(40)
		self.scoreText:setY(60)
		self:addChild(self.scoreText)
	else
		self.scoreText:setText("Score: " .. tostring(self.score))
	end
end

function GamePlay:updateLevelText()
	if self.levelText == nil then
		self.levelText = TextField.new(self.dogfont30, "Level: 1")
		self.levelText:setTextColor(0xffffff)
		self.levelText:setX(40)
		self.levelText:setY(100)
		self:addChild(self.levelText)
	else
		self.levelText:setText("Level: " .. tostring(self.level))
	end
end


function GamePlay:onEnterBegin()
	
end

function GamePlay:onEnterEnd()

	self:restartGame()	
end

function GamePlay:onExitBegin()

	self:endGame()
	
	self:removeEventListener("exitBegin", self.onExitBegin, self)
end

function GamePlay:addListeners()
	self:addEventListener("exitBegin", self.onExitBegin, self)
	self:addEventListener(Event.KEY_DOWN, self.onArrowKeyDown, self)
	self:addEventListener(Event.TOUCHES_BEGIN, self.onScreenPressed, self)
	self:addEventListener(Event.TOUCHES_END, self.onScreenPressedFinished, self)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)

end

function GamePlay:removeListeners()
	self:removeEventListener(Event.KEY_DOWN, self.onArrowKeyDown, self)
	self:removeEventListener(Event.TOUCHES_BEGIN, self.onScreenPressed, self)
	self:removeEventListener(Event.TOUCHES_END, self.onScreenPressedFinished, self)
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end



function GamePlay:onArrowKeyDown(event)
	if not self.gameOver then
		if event.keyCode == KeyCode.LEFT then
			person:moveLeft()
		elseif event.keyCode == KeyCode.RIGHT then
			person:moveRight()
		end
	end
end

function GamePlay:onScreenPressed(event)
	beingPressed = true
	pressedCount = 0
	person:aim()
end

function GamePlay:onScreenPressedFinished(event)
	beingPressed = false
	throwPointX = event.touch.x
	throwPointY = event.touch.y
	local rock = person:throwRock(throwPointX, throwPointY, pressedCount)
	table.insert(rocks,rock)
	self:addChild(rock)
	pressedCount = 0
end

function GamePlay:drawGameOver()
	if self.restartButton == nil then
		self:createRestartButton()
	end
	self:addChild(self.restartButton)
	
	if self.gameOverText == nil then
		local textfield = TextField.new(self.dogfont40, "GAME OVER")
		textfield:setTextColor(0xffffff)
		textfield:setX(180)
		textfield:setY(180)
		self.gameOverText = textfield
	end
	self:addChild(self.gameOverText)
end

function GamePlay:removeGameOver()

	if self.gameOverText ~= nil then
		self:removeChild(self.gameOverText)
	end
end

function GamePlay:restartGame()

	self:addListeners()
	
	if self.restartButton ~= nil then
		self:removeChild(self.restartButton)
	end
	arrows:draw()
	self.level = 0
	self.score = 0
	self.nextLevelInit = false
	self.balloons = {}
	rocks = {}
	self.zombieCount = 0
	self:updateScore(0)
	self:updateLevelText()
	self:createZombie()
	person:setX(personStartX)
	person:setY(personStartY)
	self:nextLevel()
	self.gameOver = false
	self:removeGameOver()
	
	self.backgroundMusicChannel = self.backgroundMusic:play(0, true)
	
end

function GamePlay:createRestartButton()
	-- create the button
	local button = RestartButton.new(self.dogfont30, "Restart")

	-- register to "click" event
	local click = 0
	button:addEventListener("click", 
		function() 
			print("restartGame clicked")
			self:restartGame()
			
		end)

	---button:setPosition(40, 150)
	self.restartButton = button

end

function GamePlay:createZombie()
	self.zombieCount = self.zombieCount + 1 
	if self.zombie == nil then	
		self.zombie = PixelZombie.new(self.zombieCount)
		self:addChild(self.zombie)
	else
		self.zombie:respawn(self.zombieCount)
	end
end

function GamePlay:nextLevel()
	self.nextLevelInit = true
	self.level = self.level + 1
	self:updateLevelText()
	print("Starting level ", self.level)
	local i
	local maxballoons = self.level * 1
	for i = 1, maxballoons do
		local balloon = Balloon.new()
		self.balloons[#self.balloons + 1] = balloon
		
		self:addChild(balloon)
	end
	
	if self.level == 1 or self.level % 3 == 0 then
		if self.spaceShip == nil then
			self.spaceShip = SpaceShip.new()
			self:addChild(self.spaceShip)
			self:playSound(SPACESHIP_FLYING)
		end
	end

	if self.level % 5 == 0 then
		if self.Rocket == nil then
			self.rocket = Rocket.new()
			self:addChild(self.rocket)
			self:playSound(ROCKET_FLYING)
		end
	end
	print("Ending level ", self.level)
	
	self.nextLevelInit = false
end

function GamePlay:endGame()
	if not self.gameOver then

		local i = 1
		while i <= #self.balloons do
			self:removeChild(self.balloons[i])
			table.remove(self.balloons, i)
		end
		i = 1
		while i <= #rocks do
			self:removeChild(rocks[i])
			table.remove(rocks, i)
		end
		
		if self.spaceShip ~= nil then
			self:removeChild(self.spaceShip)
			self.spaceShip = nil
			self:stopSound(SPACESHIP_FLYING)
		end

		if self.rocket ~= nil then
			self:removeChild(self.rocket)
			self.rocket = nil
			self:stopSound(ROCKET_FLYING)
		end

		if self.zombie ~= nil then
			self:removeChild(self.zombie)
			self.zombie = nil
		end
		self.gameOver = true

		arrows:remove()
		self:drawGameOver()
		self:removeListeners()
		self.backgroundMusicChannel:stop()
		
	end
end

function GamePlay:playSound(sound)

	if sound == BALLOON_POP then
		self.popSound:play()
	elseif sound == ZOMBIE_HIT then
		self.zombieHitSound:play()
	elseif sound == ZOMBIE_LOSE then
		self.zombieLoseSound:play()
	elseif sound == SPACESHIP_FLYING then
		self.spaceShipFlyingSoundChannel = self.spaceShipFlyingSound:play(0,true)
	elseif sound == SPACESHIP_HIT then
		self.spaceShipFlyingSoundChannel:stop()
		self.spaceShipHitSound:play()
	elseif sound == ROCKET_FLYING then
		self.rocketFlyingSoundChannel = self.rocketFlyingSound:play(0,true)
	elseif sound == ROCKET_HIT then
		self.rocketFlyingSoundChannel:stop()
		self.rocketHitSound:play()
	end
end

function GamePlay:stopSound(sound)

	if sound == SPACESHIP_FLYING then
		self.spaceShipFlyingSoundChannel:stop()
	elseif sound == ROCKET_FLYING then
		if self.rocketFlyingSoundChannel ~= nil then
			self.rocketFlyingSoundChannel:stop()
		end
	
	end
end

function GamePlay:onEnterFrame()

	pressedCount = pressedCount + 1

---	if pressedCount < 10 or pressedCount % 30 == 0 then
---		print("PressedCount", pressedCount, "balloons: ", #self.balloons)
---	end

	local i=1
	while i <= #self.balloons do
		self.balloons[i]:update()
		if self.balloons[i]:offScreen() then
			self:endGame()
			i = #self.balloons + 1
		else
			i = i + 1
		end
	end

	if not self.gameOver then

		self.zombie:update()
		if self.zombie:isHit(person.x, person.y) then
			self:playSound(ZOMBIE_LOSE)
			print("zombie got you")
			self:endGame()
		end
	end
	
	if not self.gameOver then

		if self.spaceShip ~= nil then
			self.spaceShip:update()
			if self.spaceShip:offScreen() then
				self:stopSound(SPACESHIP_FLYING)
				self:removeChild(self.spaceShip)
				self.spaceShip = nil
			end
		end

		if self.rocket ~= nil then
			self.rocket:update()
			if self.rocket:offScreen() then
				self:stopSound(ROCKET_FLYING)
				self:removeChild(self.rocket)
				self.rocket = nil
			end
		end

		local j = 1
		local continue = true
		while j <= #rocks do
			rocks[j]:update()
			
			if self.zombie:isHit(rocks[j].x, rocks[j].y) then
				self:createZombie()										
				self:removeChild(rocks[j])
				table.remove(rocks,j)					
				self:updateScore(20)
				self:playSound(ZOMBIE_HIT)
				continue = false
			end
			
			if continue and self.spaceShip ~= nil then
				if self.spaceShip:isHit(rocks[j].x, rocks[j].y) then
					self:removeChild(self.spaceShip)
					self:removeChild(rocks[j])
					table.remove(rocks,j)
					self:updateScore(100)
					self:playSound(SPACESHIP_HIT)
					continue = false
					self.spaceShip = nil
				end
			end

			if continue and self.rocket ~= nil then
				if self.rocket:isHit(rocks[j].x, rocks[j].y) then
					self:removeChild(self.rocket)
					self:removeChild(rocks[j])
					table.remove(rocks,j)
					self:updateScore(50)
					self:playSound(ROCKET_HIT)
					continue = false
					self.rocket = nil
				end
			end
			
			if continue then
				t_balloon = rocks[j]:hitBalloon(self.balloons)
				if rocks[j]:offScreen() then
					self:removeChild(rocks[j])
					table.remove(rocks,j)
				elseif t_balloon > 0 then
					self:removeChild(rocks[j])
					self:removeChild(self.balloons[t_balloon])

					table.remove(rocks,j)
					table.remove(self.balloons,t_balloon)
					self:updateScore(1)
					self:playSound(BALLOON_POP)
				else
					j = j + 1
				end
			end
			continue = true
		end
		if #self.balloons == 0 and not self.nextLevelInit then
			self:nextLevel()
		end

	end
end

