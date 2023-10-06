require("dino")
require("star")

function love.load()
	love.graphics.setBackgroundColor(204/255, 204/255, 204/255, 1)
	win_w = love.graphics.getWidth()
	win_h = love.graphics.getHeight()

	dinoload()
	starload()
end

function love.draw()
	love.graphics.print("dir = ".. dir .." x = " .. x .. " y = " .. y, 10, 10)
	dinodraw()
	stardraw()
end

function love.update(dt)
	dinoupdate(dt)
	starupdate(dt)
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' or key == 'q' then
		love.event.quit()
	end
end
