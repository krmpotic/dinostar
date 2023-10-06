dino = require("dino")
star = require("star")

function love.load()
	love.graphics.setBackgroundColor(204/255, 204/255, 204/255, 1)
	win_w = love.graphics.getWidth()
	win_h = love.graphics.getHeight()

	dino.load()
	star.load()
end

function love.draw()
	love.graphics.print("dir = ".. dir .." x = " .. x .. " y = " .. y, 10, 10)
	dino.draw()
	star.draw()
end

function love.update(dt)
	dino.update(dt)
	star.update(dt)
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' or key == 'q' then
		love.event.quit()
	end
end
