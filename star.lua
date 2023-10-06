function starload()
	star_N = 5
	star = {}
	for i=1,star_N,1 do
		star[i] = {}
		star[i].x = math.random(0, win_w)
		star[i].y = math.random(0, win_h)
		star[i].vx = math.random(50,100)
		star[i].vy = math.random(50,100)
		star[i].r = 10
		star[i].n = 5
	end
end

function stardraw()
	for i=1,star_N,1 do
		-- love.graphics.setColor(1, 0, 0)
		love.graphics.circle("fill", star[i].x, star[i].y, star[i].r, star[i].n)  
	end
end

function starupdate(dt)
	for i=1,star_N,1 do
		star[i].x = star[i].x + dt * star[i].vx
		star[i].y = star[i].y + dt * star[i].vy
		if star[i].x < star[i].r then
			star[i].x = star[i].r
			star[i].vx = -star[i].vx
		end
		if star[i].x > win_w - star[i].r then
			star[i].x = win_w - star[i].r
			star[i].vx = -star[i].vx
		end
		if star[i].y < star[i].r then
			star[i].y = star[i].r
			star[i].vy = -star[i].vy
		end
		if star[i].y > win_h - star[i].r then
			star[i].y = win_h - star[i].r
			star[i].vy = -star[i].vy
		end
	end
end
