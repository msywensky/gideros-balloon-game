RestartButton = Core.class(Sprite)

local upColor = 0xffffff
local downColor = 0x0000ff

function RestartButton:init(font, text)

---	local background = Bitmap.new(Texture.new("images/Barbed-Wire-Rounded-Rectangle-Frame-Border-150px.png"))
	local background = Bitmap.new(Texture.new("images/blue-square-button-100px.png"))

	resizeBitmap(background,100,50)

	self:addChild(background)
	self:setPosition(300, 200)

	local textField = TextField.new(font, text)
	
	textField:setTextColor(0xffffff)
	textField:setPosition(12, 35)
	self:addChild(textField)

	self.textField = textField

	-- register to all mouse and touch events
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)

	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesCancel, self)
end

function RestartButton:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		self.focus = true
		self:updateVisualState(true)
		event:stopPropagation()
	end
end

function RestartButton:onMouseMove(event)
	if self.focus then
		if not self:hitTestPoint(event.x, event.y) then	
			self.focus = false
			self:updateVisualState(false)
		end
		event:stopPropagation()
	end
end

function RestartButton:onMouseUp(event)
	if self.focus then
		self.focus = false
		self:updateVisualState(false)
		self:dispatchEvent(Event.new("click"))	-- button is clicked, dispatch "click" event
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function RestartButton:onTouchesBegin(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function RestartButton:onTouchesMove(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function RestartButton:onTouchesEnd(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if touches are cancelled, reset the state of the button
function RestartButton:onTouchesCancel(event)
	if self.focus then
		self.focus = false;
		self:updateVisualState(false)
		event:stopPropagation()
	end
end

-- if state is true show downState else show upState
function RestartButton:updateVisualState(state)
	if state then
		self.textField:setTextColor(downColor)
	else
		self.textField:setTextColor(upColor)
	end
end
