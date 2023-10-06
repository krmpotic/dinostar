util = require "util"

local dino = {}
local dir = { DOWN = 0, RIGHT = 1, UP = 2, LEFT = 3 }
local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

function dino.load()
	dino = {}
	for i = 0,3,1 do
		dino[i] = {}
		for j = 0,3,1 do
			dino[i][j] = love.graphics.newImage("pics/dino-" .. i .. "-" .. j .. ".png")
		end
	end
	dino.w = 32
	dino.h = 32

	dino.dir = dir.DOWN
	dino.loop = 1.0
	dino.v = 100
	dino.x = 100
	dino.y = 100

	dino.tstart = love.timer.getTime()
end

function dino.update(dt)
	local L = love.keyboard.isDown('left')
	local R = love.keyboard.isDown('right')
	local U = love.keyboard.isDown('up')
	local D = love.keyboard.isDown('down')

	if L then
		dino.dir = dir.LEFT
		dino.x = dino.x - dt * dino.v
	end
	if R then
		dino.dir = dir.RIGHT
		dino.x = dino.x + dt * dino.v
	end
	if U then
		dino.dir = dir.UP
		dino.y = dino.y - dt * dino.v
	end
	if D then
		dino.dir = dir.DOWN
		dino.y = dino.y + dt * dino.v
	end
	fixpos()
end

function dino.draw()
	local t_ = love.timer.getTime() - dino.tstart
	t_ = 4 * (t_ % dino.loop)
	i = math.floor(t_)
	love.graphics.draw(dino[dino.dir][i], dino.x, dino.y, 0, 1, 1, dino.w/2, dino.h/2)
end

function dino.pos()
	return dino.x, dino.y
end

function dino.boost()
	dino.v = 2 * dino.v
end

function fixpos()
	dino.x = util.clamp(dino.x, dino.w/2, win_w - dino.w/2)
	dino.y = util.clamp(dino.y, dino.h/2, win_h - dino.h/2)
end


return dino
