-- returns the degrees between (0,0) and pt (note: 0 degrees is 'east')
function angleOfPoint( pt )
   local x, y = pt.x, pt.y
   local radian = math.atan2(y,x)
   local angle = radian*180/math.pi
   if angle < 0 then angle = 360 + angle end
   return angle
end

-- returns the degrees between two points (note: 0 degrees is 'east')
function angleBetweenPoints( ax, ay, bx, by )
   local x, y = bx - ax, by - ay
   return angleOfPoint( { x=x, y=y } )
end


function calcAngle2(playerX, playerY, objectX, objectY)
	---return math.deg(math.atan2(playerY - objectY, playerX - objectX))
	return (math.atan2(playerY - objectY, playerX - objectX) * 180) / math.pi
end

function calculateAngle( P1X, P1Y, P2X, P2Y, P3X, P3Y)
	--- P1X,P1Y = touch
	--- P2X, P2Y = person
	---P3X = P1X
	---P3Y = P2Y

	numerator = P2Y*(P1X-P3X) + P1Y*(P3X-P2X) + P3Y*(P2X-P1X)
	denominator = (P2X-P1X)*(P1X-P3X) + (P2Y-P1Y)*(P1Y-P3Y)
	ratio = numerator/denominator

	print("numerator = ", numerator, "denominator = ", denominator, "ratio ", ratio)

	angleRad = math.atan(ratio)
	angleDeg = (angleRad*180)/math.pi

	if (angleDeg<0) then
		angleDeg = 180+angleDeg
	end

	return angleDeg
end