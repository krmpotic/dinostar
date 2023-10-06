util = require "util"

local dino = {}
local w = 32
local h = 32
local loop = 1.0
local v0 = 100

local dir = { DOWN = 0, RIGHT = 1, UP = 2, LEFT = 3 }
local win_w = love.graphics.getWidth()
local win_h = love.graphics.getHeight()

function dino.load()
	dino = {}
	for i = 0,3 do
		dino[i] = {}
		for j = 0,3 do
			dino[i][j] = love.graphics.newImage("pics/dino-" .. i .. "-" .. j .. ".png")
		end
	end

	dino.dir = dir.DOWN
	dino.loop = 1.0
	dino.v = v0
	dino.x = win_w/2
	dino.y = win_h/2

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
	i = math.floor(4 * ((love.timer.getTime() % dino.loop) / dino.loop))
	love.graphics.draw(dino[dino.dir][i], dino.x, dino.y, 0, 1, 1, w/2, h/2)
end

function dino.pos()
	return dino.x, dino.y
end

function dino.boost()
	dino.v = 1.5 * dino.v
end

function fixpos()
	dino.x = util.clamp(dino.x, w/2, win_w - w/2)
	dino.y = util.clamp(dino.y, h/2, win_h - h/2)
end


return dino
