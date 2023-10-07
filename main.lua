dino = require "dino"
star = require "star"

function love.load()
	math.randomseed(os.time())

	love.window.setTitle("DinoStar")
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
	if s ~= nil then
		if s.typ == 2 then
			dino.boost(1.5)
		elseif s.typ == 3 then
			love.event.quit()
		elseif s.typ == 4 then
			dino.boost(0.8)
		end
	end
end

function love.keypressed(key, scancode, isrepeat)
	if key == 'escape' or key == 'q' then
		love.event.quit()
	end
end
