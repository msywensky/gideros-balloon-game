Store = Core.class(Sprite)

function Store:init()
--[[
	local myShape = Shape.new() -- create the shape object assigned to variable myShape
	myShape:beginPath()         -- We have to tell shape to begin a path
	myShape:setLineStyle(2)     -- set the line width = 2
	myShape:setFillStyle(Shape.SOLID, 0xFF0000) -- solid red fill color
	myShape:moveTo(0,0)     -- move pen to start of line
	myShape:lineTo(100,0)     -- draw top of rectangle
	myShape:lineTo(100,100)     -- draw right side of rectangle
	myShape:lineTo(0,100)     -- draw bottom of rectangle
	myShape:lineTo(0,0)     -- draw left side of rectangle
	myShape:endPath()           -- end the path
	-- now we apply some transformations to the shape we created
	myShape:setPosition(100,100) -- move the entire shape to 100,100
	myShape:setScale(1.2,1.5) -- scale x by 1.2 and y by 1.5. The shape wont be rectangle anymore
	myShape:setRotation(40) -- rotate shape by 40 degrees	self:addChild(myShape ) 
	self:addChild(myShape)
]]	
	local myRect = Shape.new()
	myRect:setLineStyle(2)     -- set the line width = 2
	myRect:setFillStyle(Shape.SOLID, 0xFF0000) -- solid red fill color
	myRect = myRect:drawRectangle(425,260)
	myRect:setPosition(25,25)
	self:addChild(myRect)
	self:createReturnButton()
end

function Store:createReturnButton()
	-- create the button
	local button = RestartButton.new(fonts.font30, "Return")

	-- register to "click" event
	local click = 0
	button:addEventListener("click", 
		function() 
			print("restartGame clicked")
			
			---self:restartGame()
			sceneManager:changeScene("start", 1, SceneManager.fade, easing.outBack)
			
		end)

	---button:setPosition(40, 150)
	button:setPosition(200, 10)
	self:addChild(button)
	self.returnButton = button
	

end