dino = require "dino"
star = require "star"

function love.load()
	love.graphics.setBackgroundColor(204/255, 204/255, 204/255, 1)

	dino.load()
	star.load()
end

function love.draw()
	dino.draw()
	star.draw()
end

function love.update(dt)
	dino.update(dt)
	star.update(dt)

	local s = star.destroy(dino.pos())
	if s ~= nil and s.special then
		dino.boost(1.5)
	end
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' or key == 'q' then
		love.event.quit()
	end
end
