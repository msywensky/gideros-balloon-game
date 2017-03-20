Home = Core.class(Sprite)

function Home:init()

	self:addEventListener("enterBegin", self.onEnterBegin, self)
	self:addEventListener("enterEnd", self.onEnterEnd, self)
end


function Home:onEnterBegin()
	self:loadBackground()
	self:loadText()
end

function Home:onEnterEnd()

end

function Home:loadBackground()
	local th = getActiveTheme()
	local f = th.imageFolder
	local bitmap = scaleBackground(f .. th.images.home)
	self:addChild(bitmap)
end

function Home:loadText()

	self.playButton = TextButton.new(fonts.font40, "Play", 215, 125)
	self:addChild(self.playButton)
	self.playButton:addEventListener("click", 
		function() 
			print("playButton clicked")
			sceneManager:changeScene("game_play", 1, SceneManager.fade, easing.outBack)
			
		end)

	
	self.storeButton = TextButton.new(fonts.font40, "Store", 208, 190)
	self:addChild(self.storeButton)
	self.storeButton:addEventListener("click", 
		function() 
			print("storeButton clicked")
			sceneManager:changeScene("store", 1, SceneManager.fade, easing.outBack)
			
		end)

	self.soundButton = SoundToggle.new()
	self.soundButton:setPosition(60,200)
	self:addChild(self.soundButton)


	local textField = TextField.new(fonts.font20, settings.totalScore)
	textField:setPosition(103, 275)
	self:addChild(textField)
	self.scoreText = textField
end
