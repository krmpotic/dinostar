util = require "util"

local star = {}
local star_r = 10
local star_polygon = 5
local star_special_chance = 6
local star_vmax = 100

local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

function star.load()
	star_N = 100
	for i=1,star_N do
		star[i] = {}
		star[i].x = math.random(0, win_w)
		star[i].y = math.random(0, win_h)
		star[i].vx = math.random(-star_vmax,star_vmax)
		star[i].vy = math.random(-star_vmax,star_vmax)
		star[i].special = util.chance(star_special_chance)
		star[i].active = true
	end
end

function star.draw()
	for i=1,star_N do
		if not star[i].active then
			goto next
		end

		local r,g,b,a
		r,g,b,a = love.graphics.getColor()

		if star[i].special then
			love.graphics.setColor(1, 0, 0)
		end
		love.graphics.circle("fill", star[i].x, star[i].y, star_r, star_polygon)
		love.graphics.setColor(r,g,b,a)
		::next::
	end
end

function star.update(dt)
	for i=1,star_N do
		if not star[i].active then
			goto next
		end

		-- calc next position
		star[i].x = star[i].x + dt * star[i].vx
		star[i].y = star[i].y + dt * star[i].vy

		-- prevent movement outside wall
		local x = util.clamp(star[i].x, star_r, win_w - star_r)
		local y = util.clamp(star[i].y, star_r, win_h - star_r)

		-- on wall hit change direction of star
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
