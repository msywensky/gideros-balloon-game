

function Shape:drawPoly(points)
	local drawOp=self.moveTo
	self:beginPath()
	if type(points[1]) == "table" then
		for i,p in ipairs(points) do
			drawOp(self, p[1], p[2])
			drawOp=self.lineTo
		end
	else
		for i = 1, #points, 2 do
			drawOp(self, points[i], points[i+1])
			drawOp=self.lineTo
		end
	end
	self:closePath()
	self:endPath()
	return self
end

--[[ draw rectangle ]]--

function Shape:drawRectangle(width, height)
	print "drawRectangle called"
	return self:drawPoly({
		{0, 0},
		{width, 0},
		{width, height},
		{0, height}
	})
end

local function bezier3(p1,p2,p3,mu)
   local mum1,mum12,mu2
   local p = {}
   mu2 = mu * mu
   mum1 = 1 - mu
   mum12 = mum1 * mum1
   p.x = p1.x * mum12 + 2 * p2.x * mum1 * mu + p3.x * mu2
   p.y = p1.y * mum12 + 2 * p2.y * mum1 * mu + p3.y * mu2
   return p
end

local function quadraticCurve(startx, starty, cpx, cpy, x, y, mu)
	local inc = mu or 0.1 -- need a better default
	local t = {}
	for i = 0,1,inc do
		local p = bezier3(
			{ x=startx, y=starty },
			{ x=cpx, y=cpy },
			{ x=x, y=y },
		i)
		t[#t+1] = p.x
		t[#t+1] = p.y
	end
	return t
end

function Shape:quadraticCurveTo(cpx, cpy, x, y, mu)
	if self._lastPoint then
		local points = quadraticCurve(self._lastPoint[1], self._lastPoint[2], cpx, cpy, x, y, mu)
		for i = 1, #points, 2 do
			self:lineTo(points[i],points[i+1])
		end
	end
	self._lastPoint = { x, y }
	return self
end

function Shape:drawRoundRectangle(width, height, radius)
	self:beginPath()
	self:moveTo(0, radius)
	self:lineTo(0, height - radius)
	self:quadraticCurveTo(0, height,radius, height)
	self:lineTo(width - radius, height)
	self:quadraticCurveTo(width, height, width, height - radius)
	self:lineTo(width, radius)
	self:quadraticCurveTo(width, 0, width - radius, 0)
	self:lineTo(radius, 0)
	self:quadraticCurveTo(0, 0, 0, radius)
	self:closePath()
	self:endPath()
	return self
end