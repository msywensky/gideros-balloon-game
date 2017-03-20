ShadowText = Core.class(Sprite)

fonts = {}

function loadFonts(th)
	fonts = {}
	f = th.fontFolder

	fonts.font20 = Font.new(f .. th.fonts.font20 .. ".txt", f .. th.fonts.font20 .. ".png")
	fonts.font25 = Font.new(f .. th.fonts.font25 .. ".txt", f .. th.fonts.font25 .. ".png")
	fonts.font30 = Font.new(f .. th.fonts.font30 .. ".txt", f .. th.fonts.font30 .. ".png")
	fonts.font40 = Font.new(f .. th.fonts.font40 .. ".txt", f .. th.fonts.font40 .. ".png")
	fonts.font50 = Font.new(f .. th.fonts.font50 .. ".txt", f .. th.fonts.font50 .. ".png")

end

function ShadowText:init(font, text, textColor, shadowColor)

	textColor = textColor or  0xffffff --0xff0000
	shadowColor = shadowColor or 0x0000

	_text = TextField.new(font, text)
	_shadow = TextField.new(font, text)
	_shadow:setPosition(1, 1)

	self:addChild(_shadow)
	self:addChild(_text)

	_text:setTextColor(textColor)
	_shadow:setTextColor(shadowColor)

	self.textField = _text
	self.shadowField = _shadow

end

function ShadowText:setText(text)
	self.textField:setText(text)
	self.shadowField:setText(text)

end