function love.load()
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

	dir = DOWN
	still = true
	dino_loop = 1.0
	v = 150
	x, y = 100, 100

	love.graphics.setBackgroundColor(204/255, 204/255, 204/255, 1)
end

function love.draw()
	love.graphics.print("dir = ".. dir .." x = " .. x .. " y = " .. y, 10, 10)

	local i
	if still then  
		i = 0
	else 
		local t_ = love.timer.getTime() - t
		t_ = 4 * (t_ % dino_loop)
		i = math.floor(t_)
	end
	love.graphics.draw(dino[dir][i], x, y, 0, 1, 1, 16, 16)
end

function love.update(dt)
	local prev = still

	still = false
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
	else
		still = true
	end

	if still == false and prev ~= still then
		t = love.timer.getTime()
	end
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' or key == 'q' then
		love.event.quit()
	end
end
