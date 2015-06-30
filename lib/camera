
function camInit(x1,y1,x2,y2)
	cam = {x = 0,y = 0, vx = 0, vy = 0, real = {x = 0, y = 0}, scale = 1, a = camera.new(x1, y1, x2, y2), zoom = 100, 
	update = function (dt)
		local check = false
		for i,v in ipairs (craft) do
				if v.control then cam.x, cam.y = v.x+(math.abs(v.vx)*math.sin(v.angle))/3, v.y-(math.abs(v.vy)*math.cos(v.angle))/3 end
		end
		cam.a:setPosition((cam.x),(cam.y))
		cam.real.x,cam.real.y = cam.a:getPosition()
		cam.a:setScale(cam.scale)
		end
	}
end


