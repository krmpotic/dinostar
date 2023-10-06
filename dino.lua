function dinoload()
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
end

function dinoupdate(dt)
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
	dinofixpos()

	local prev = f_moving
	f_moving = not love.keyboard.isDown('left', 'right', 'up', 'down')
	if f_moving and prev ~= f_moving then
		t = love.timer.getTime()
	end
end

function dinodraw()
	local i = 0
	if f_moving then
		local t_ = love.timer.getTime() - t
		t_ = 4 * (t_ % dino_loop)
		i = math.floor(t_)
	end
	love.graphics.draw(dino[dir][i], x, y, 0, 1, 1, dino_w/2, dino_h/2)
end

function dinofixpos()
	if x < dino_w/2 then
		x = dino_w/2
	end
	if x > win_w - dino_w/2 then
		x = win_w - dino_w/2
	end
	if y < dino_h/2 then
		y = dino_h/2
	end
	if y > win_h - dino_h/2 then
		y = win_h - dino_h/2
	end
end
