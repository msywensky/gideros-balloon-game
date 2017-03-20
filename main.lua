


loadSettings()
loadTheme(Theme_Default)


sceneManager = SceneManager.new({
    ["start"] = Home,
    ["game_play"] = GamePlay,
    ["store"] = Store,
    --["level"] = level
})
--add manager to stage
stage:addChild(sceneManager)

sceneManager:changeScene("start", 1, SceneManager.flipWithFade, easing.outBack)

AppRater.new({
	androidRate = "", --link to rate Android app
	iosRate = "",     --link to rate IOS app
	timesUsed = 15,   --times to use before asking to rate
	daysUsed = 30,    --days to use before asking to rate
	version = 0,      --current version of the app
	remindTimes = 15,  --times of use to wait before reminding
	remindDays = 5,    --days of use to wait before reminding
	rateTitle = "Rate My App",
	rateText = "Please rate ZombiePop",
	rateButton = "Rate it now!",
	remindButton = "Remind me later",
	cancelButton = "No, thanks"
})

