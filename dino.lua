util = require('util')

local dino = {}

function dino.load()
	DOWN = 0
	RIGHT = 1
	UP = 2
	LEFT = 3

	dino = {}
	for i = 0,3,1 do
		dino[i] = {}
		for j = 0,3,1 do
			dino[i][j] = love.graphics.newImage("pics/dino-" .. i .. "-" .. j .. ".png")
		end
	end
	dino_w = 32
	dino_h = 32

	dir = DOWN
	dino_loop = 1.0
	f_moving = false
	v = 500
	x, y = 100, 100

	dino_tstart = love.timer.getTime()
end

function dino.update(dt)
	if love.keyboard.isDown('left') then
		dir = LEFT
		x = x - dt * v
	elseif love.keyboard.isDown('right') then
		dir = RIGHT
		x = x + dt * v
	elseif love.keyboard.isDown('up') then
		dir = UP
		y = y - dt * v
	elseif love.keyboard.isDown('down') then
		dir = DOWN
		y = y + dt * v
	end
	fixpos()
end

function dino.draw()
	local t_ = love.timer.getTime() - dino_tstart
	t_ = 4 * (t_ % dino_loop)
	i = math.floor(t_)
	love.graphics.draw(dino[dir][i], x, y, 0, 1, 1, dino_w/2, dino_h/2)
end

function fixpos()
	x = util.clamp(x, dino_w/2, win_w - dino_w/2)
	y = util.clamp(y, dino_h/2, win_h - dino_h/2)
end

return dino
