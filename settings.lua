Settings = Core.class()

settings = nil

function loadSettings()
	settings = Settings.new()
end

function Settings:init()
	self.soundEnabled = true
	self.totalScore = 0
	self.activeTheme = Theme_Default

end

function Settings:setActiveTheme(theme)
	self.activeTheme = theme
end



function Settings:updateTotalScore(score)
	self.totalScore = self.totalScore + score
	
end