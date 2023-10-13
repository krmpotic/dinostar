local util = {}

function util.clamp (x, min, max)
	return x < min and min or x > max and max or x
end

function util.d (x1, y1, x2, y2)
	return math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
end

function util.chance (p)
	return (math.random(0,99) < p and 1 or 0) == 1
end

return util
