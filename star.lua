util = require "util"

local star = {}

local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

local a = {}

local star_N = 100
local star_r = 10
local star_polygon = 5
local star_vmax = 100

local xmin = star_r
local xmax = win_w - star_r
local ymin = star_r
local ymax = win_h - star_r

local red_chance = 5
local green_chance = 5
local blue_chance = 5
local yellow_chance = 3

function star.load()
	for i=1,star_N do
		a[i] = {}
		a[i].x = math.random(xmin, xmax)
		a[i].y = math.random(ymin, ymax)
		a[i].vx = math.random(-star_vmax,star_vmax)
		a[i].vy = math.random(-star_vmax,star_vmax)

		if util.chance(red_chance) then
			a[i].typ = 2
		elseif util.chance(green_chance) then
			a[i].typ = 3
		elseif util.chance(blue_chance) then
			a[i].typ = 4
		elseif util.chance(yellow_chance) then
			a[i].typ = 5
		else
			a[i].typ = 1
		end
	end
end

function star.draw()
	for i=1,#a do
		if a[i].typ == 2 then
			love.graphics.setColor(1, 0, 0)
		elseif a[i].typ == 3 then
			love.graphics.setColor(0, 1, 0)
		elseif a[i].typ == 4 then
			love.graphics.setColor(0, 0, 1)
		elseif a[i].typ == 5 then
			love.graphics.setColor(1, 1, 0)
		else
			love.graphics.setColor(1,1,1)
		end
		love.graphics.circle("fill", a[i].x, a[i].y, star_r, star_polygon)
	end
end

-- update star position (bounce off the walls)
function star.update(dt)
	for i=1,#a do
		-- calc next position
		a[i].x = a[i].x + dt * a[i].vx
		a[i].y = a[i].y + dt * a[i].vy

		-- prevent movement outside wall
		local x = util.clamp(a[i].x, xmin, xmax)
		local y = util.clamp(a[i].y, ymin, ymax)

		-- on wall hit change direction of star
		if a[i].x ~= x then
			a[i].x = x
			a[i].vx = -a[i].vx
		end
		if a[i].y ~= y then
			a[i].y = y
			a[i].vy = -a[i].vy
		end
	end
end

function star.eat(hit)
	for i=1,#a do
		if hit(a[i].x, a[i].y) then
			return table.remove(a, i)
		end
	end
	return nil
end

function star.destroy(hit)
	::recheck::
	for i=1,#a do
		if hit(a[i].x, a[i].y) then
			table.remove(a, i)
			goto recheck
		end
	end
end

return star
