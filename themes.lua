
Theme_Default = {}

Theme_Default.folder = "themes/default/"
Theme_Default.imageFolder = "themes/default/images/"
Theme_Default.soundFolder = "themes/default/sounds/"
Theme_Default.fontFolder = "themes/default/fonts/"

Theme_Default.images = {
	background = "background.png",
	home = "home.png",
	leftArrow = "arrow_left.png",
	rightArrow = "arrow_right.png",
	soundOn = "sound_on.png",
	soundOff = "sound_off.png",
	button = "button.png",
	rock = "stone.png", balloons = { 
	{ "balloon_1.png", "balloon_1a.png" },
	{ "balloon_2.png", "balloon_2a.png" },
	{ "balloon_3.png", "balloon_3a.png" },
	{ "balloon_4.png", "balloon_4a.png" },
	{ "balloon_5.png", "balloon_5a.png" },
	{ "balloon_6.png", "balloon_6a.png" } }, 
	rockets = { "rocket_1.png" },
	ships = { "ufo_1.png", "ufo_2.png", "ufo_3.png" },
	zombie = { "zombie/walk_1.png", "zombie/walk_2.png", "zombie/walk_3.png" },
	character = { aim = "character/aim_1.png", throw = "character/throw_1.png",
		walk = { "character/walk_1.png", "character/walk_2.png", 
		"character/walk_3.png", "character/walk_4.png" } 
	}
}

Theme_Default.sounds = {
	background = "background.wav",
	balloonPop = "balloon_pop.wav",
	rocketFlying = "rocket_flying.wav",
	rocketHit = "rocket_hit.wav",
	shipFlying = "ship_flying.wav",
	shipHit = "ship_hit.wav",
	zombieHit = "zombie_hit.wav",
	zombieLose = "zombie_lose.wav"
}

Theme_Default.fonts = {
	font20 = "gooddog20",
	font25 = "gooddog25",
	font30 = "gooddog30",
	font40 = "gooddog40",
	font50 = "gooddog50"
}


function loadTheme(theme)
	settings:setActiveTheme(theme)
	loadFonts(theme)
	loadBalloonTextures(theme)
	loadRockTexture(theme)
	loadRocketTextures(theme)
	loadShipTextures(theme)
	loadZombieImages(theme)
	loadArrowImages(theme)
	loadSoundImages(theme)
end	
	
function getActiveTheme()

	return settings.activeTheme
end
	