util = require "util"

local star = {}

local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

local star_N = 300
local star_r = 10
local star_polygon = 5
local star_vmax = 200

local xmin = star_r
local xmax = win_w - star_r
local ymin = star_r
local ymax = win_h - star_r

local red_chance = 10
local green_chance = 1
local blue_chance = 10
local yellow_chance = 3

function star.load ()
	for i=1,star_N do
		star[i] = {
			x = math.random(xmin, xmax),
			y = math.random(ymin, ymax),
			vx = math.random(-star_vmax,star_vmax),
			vy = math.random(-star_vmax,star_vmax),
			typ = 1,
		}

		if util.chance(red_chance) then
			star[i].typ = 2
		elseif util.chance(green_chance) then
			star[i].typ = 3
		elseif util.chance(blue_chance) then
			star[i].typ = 4
		elseif util.chance(yellow_chance) then
			star[i].typ = 5
		end
	end
end

function star.draw ()
	for i, v in ipairs(star) do
		if v.typ == 2 then
			love.graphics.setColor(1, 0, 0)
		elseif v.typ == 3 then
			love.graphics.setColor(0, 1, 0)
		elseif v.typ == 4 then
			love.graphics.setColor(0, 0, 1)
		elseif v.typ == 5 then
			love.graphics.setColor(1, 1, 0)
		else
			love.graphics.setColor(1,1,1)
		end
		love.graphics.circle("fill", v.x, v.y, star_r, star_polygon)
	end
end

-- update star position (bounce off the walls)
function star.update (dt)
	for i, v in ipairs(star) do
		-- calc next position
		v.x = v.x + dt * v.vx
		v.y = v.y + dt * v.vy

		-- prevent movement outside wall
		local x = util.clamp(v.x, xmin, xmax)
		local y = util.clamp(v.y, ymin, ymax)

		-- on wall hit change direction of star
		if v.x ~= x then
			v.x = x
			v.vx = -v.vx
		end
		if v.y ~= y then
			v.y = y
			v.vy = -v.vy
		end
	end
end

function star.eat (hit)
	for i, v in ipairs(star) do
		if hit(v.x, v.y) then
			return table.remove(star, i)
		end
	end
	return nil
end

function star.destroy (hit)
	::recheck::
	for i, v in ipairs(star) do
		if hit(v.x, v.y) then
			table.remove(star, i)
			goto recheck
		end
	end
end

return star
