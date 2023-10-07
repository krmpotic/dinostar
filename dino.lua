util = require "util"

local dino = {}
local w = 32
local h = 32
local v0 = 100

local img_n = 4
local img_loop = 100 / v0

local dir = { DOWN = 0, RIGHT = 1, UP = 2, LEFT = 3 }
local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

function dino.load()
	dino = {}
	for i = 0,3 do
		dino[i] = {}
		for j = 0,(img_n-1) do
			dino[i][j] = love.graphics.newImage("pics/dino-" .. i .. "-" .. j .. ".png")
		end
	end

	dino.dir = dir.DOWN
	dino.v = v0
	dino.x = win_w/2
	dino.y = win_h/2

	dino.tstart = love.timer.getTime()
end

function dino.update(dt)
	local key = love.keyboard.isDown
	if key('left') then
		dino.dir = dir.LEFT
		dino.x = dino.x - dt * dino.v
	end
	if key('right') then
		dino.dir = dir.RIGHT
		dino.x = dino.x + dt * dino.v
	end
	if key('up') then
		dino.dir = dir.UP
		dino.y = dino.y - dt * dino.v
	end
	if key('down') then
		dino.dir = dir.DOWN
		dino.y = dino.y + dt * dino.v
	end
	fixpos()
end

function dino.draw()
	i = math.floor(img_n * ((love.timer.getTime() % img_loop) / img_loop))
	love.graphics.setColor(1,1,1)
	love.graphics.draw(dino[dino.dir][i], dino.x, dino.y, 0, 1, 1, w/2, h/2)
end

function dino.pos()
	return dino.x, dino.y
end

function dino.boost(k)
	dino.v = k * dino.v
	img_loop = img_loop / k
end

function dino.hitbox()
	return function(x, y)
		return util.d(dino.x,dino.y,x,y) < w/2
	end
end

function fixpos()
	dino.x = util.clamp(dino.x, w/2, win_w - w/2)
	dino.y = util.clamp(dino.y, h/2, win_h - h/2)
end

return dino
