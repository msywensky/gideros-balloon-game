SoundToggle = Core.class(Sprite)

local soundOnImage = nil
local soundOffImage = nil

function loadSoundImages(th)
	
	local f = th.imageFolder
	
	soundOnImage = Bitmap.new(Texture.new(f .. th.images.soundOn))
	soundOffImage = Bitmap.new(Texture.new(f .. th.images.soundOff))

end


function SoundToggle:init()
	self:loadImage()

	-- register to all mouse and touch events
	self:addEventListener(Event.MOUSE_DOWN, self.onMouseDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onMouseMove, self)
	self:addEventListener(Event.MOUSE_UP, self.onMouseUp, self)

	self:addEventListener(Event.TOUCHES_BEGIN, self.onTouchesBegin, self)
	self:addEventListener(Event.TOUCHES_MOVE, self.onTouchesMove, self)
	self:addEventListener(Event.TOUCHES_END, self.onTouchesEnd, self)
	self:addEventListener(Event.TOUCHES_CANCEL, self.onTouchesCancel, self)
	
end

function SoundToggle:loadImage()
	local image
	if settings.soundEnabled then
		image = soundOnImage
	else
		image = soundOffImage
	end

	self:addChild(image)
	self.image = image
end

function SoundToggle:toggle()
	self:removeChild(self.image)
	settings.soundEnabled = not settings.soundEnabled
	self:loadImage()
end

function SoundToggle:onMouseDown(event)
	if self:hitTestPoint(event.x, event.y) then
		self.focus = true
		self:updateVisualState(true)
		event:stopPropagation()
	end
end

function SoundToggle:onMouseMove(event)
	if self.focus then
		if not self:hitTestPoint(event.x, event.y) then	
			self.focus = false
			self:updateVisualState(false)
		end
		event:stopPropagation()
	end
end

function SoundToggle:onMouseUp(event)
	if self.focus then
		self.focus = false
		self:updateVisualState(false)
		self:toggle()
		---self:dispatchEvent(Event.new("click"))	-- button is clicked, dispatch "click" event
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function SoundToggle:onTouchesBegin(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function SoundToggle:onTouchesMove(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if button is on focus, stop propagation of touch events
function SoundToggle:onTouchesEnd(event)
	if self.focus then
		event:stopPropagation()
	end
end

-- if touches are cancelled, reset the state of the button
function SoundToggle:onTouchesCancel(event)
	if self.focus then
		self.focus = false;
		self:updateVisualState(false)
		event:stopPropagation()
	end
end

-- if state is true show downState else show upState
function SoundToggle:updateVisualState(state)
--[[
	if state then
		if self:contains(self.upState) then
			self:removeChild(self.upState)
		end
		
		if not self:contains(self.downState) then
			self:addChild(self.downState)
		end
	else
		if self:contains(self.downState) then
			self:removeChild(self.downState)
		end
		
		if not self:contains(self.upState) then
			self:addChild(self.upState)
		end
	end
]]
end