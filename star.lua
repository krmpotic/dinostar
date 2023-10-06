util = require "util"

local star = {}
local a = {}
local star_r = 10
local star_polygon = 5
local star_special_chance = 6
local star_vmax = 100

local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

function star.load()
	star_N = 100
	for i=1,star_N do
		a[i] = {}
		a[i].x = math.random(0, win_w)
		a[i].y = math.random(0, win_h)
		a[i].vx = math.random(-star_vmax,star_vmax)
		a[i].vy = math.random(-star_vmax,star_vmax)
		a[i].special = util.chance(star_special_chance)
		a[i].active = true
	end
end

function star.draw()
	for i=1,#a do
		if not a[i].active then
			goto next
		end

		love.graphics.setColor(1,1,1)
		if a[i].special then
			love.graphics.setColor(1, 0, 0)
		end
		love.graphics.circle("fill", a[i].x, a[i].y, star_r, star_polygon)
		::next::
	end
end

-- update star position (bounce off the walls)
function star.update(dt)
	for i=1,#a do
		if not a[i].active then
			goto next
		end

		-- calc next position
		a[i].x = a[i].x + dt * a[i].vx
		a[i].y = a[i].y + dt * a[i].vy

		-- prevent movement outside wall
		local x = util.clamp(a[i].x, star_r, win_w - star_r)
		local y = util.clamp(a[i].y, star_r, win_h - star_r)

		-- on wall hit change direction of star
		if a[i].x ~= x then
			a[i].x = x
			a[i].vx = -a[i].vx
		end
		if a[i].y ~= y then
			a[i].y = y
			a[i].vy = -a[i].vy
		end

		::next::
	end
end

-- make star that is in the star_r vacinity of x, y
-- inactive, and return it (else return nil)
function star.destroy(x, y)
	for i=1,#a do
		if not a[i].active then
			goto next
		end
		local d = util.d(x, y, a[i].x, a[i].y)
		if d < star_r then
			a[i].active = false
			return a[i]
		end
		::next::
	end
	return nil
end

return star
