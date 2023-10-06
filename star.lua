util = require "util"

local star = {}
local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

function star.load()
	star_N = 100
	for i=1,star_N do
		star[i] = {}
		star[i].x = math.random(0, win_w)
		star[i].y = math.random(0, win_h)
		star[i].vx = math.random(-100,100)
		star[i].vy = math.random(-100,100)
		star[i].r = 10
		star[i].n = 5
		star[i].special = (math.random(0, 99) < 90 and 0 or 1) == 1
		star[i].active = true
	end
end

function star.draw()
	for i=1,star_N do
		if not star[i].active then
			goto next
		end
		if star[i].special then
			love.graphics.setColor(1, 0, 0)
		end
		love.graphics.circle("fill", star[i].x, star[i].y, star[i].r, star[i].n)  
		love.graphics.setColor(1, 1, 1)
		::next::
	end
end

function star.update(dt)
	for i=1,star_N do
		if not star[i].active then
			goto next
		end
		star[i].x = star[i].x + dt * star[i].vx
		star[i].y = star[i].y + dt * star[i].vy
		local x = util.clamp(star[i].x, star[i].r, win_w - star[i].r)
		local y = util.clamp(star[i].y, star[i].r, win_h - star[i].r)
		if star[i].x ~= x then
			star[i].x = x
			star[i].vx = -star[i].vx
		end
		if star[i].y ~= y then
			star[i].y = y
			star[i].vy = -star[i].vy
		end
		::next::
	end
end

function star.destroy(x, y)
	for i=1,star_N do
		if not star[i].active then
			goto next
		end
		local d = util.d(x, y, star[i].x, star[i].y)
		if d < 10 then
			star[i].active = false
			if star[i].special then
				return true
			end
		end
		::next::
	end
	return false
end

return star
