craft = {}
bullet = {}
clouds = {}
speed = 1

for i = 1, 300 do 
	local o = {}
	o.x = math.random(1,8000)
	o.y = math.random(1,3000)
	o.s = math.random(100, 500)
	table.insert(clouds,o)
end

function craft.new(x,y,g,b,w,e,team, cont)
	local o = {}
	o.param = {
		gun = tostring(g),
		body = tostring(b),
		wings = tostring(w),
		engine = tostring(e),
	}
	o.id = love.timer.getTime()
	o.control = cont --nil if not use
	o.team = team
	o.x, o.y = x,y
	o.vx,o.vy = 0,0
	o.height, o.width = 32,32
	o.sprite = base.parts.sprite
	o.max_hp = getStat("hp", g,b,w,e)
	o.hp = o.max_hp
	o.pulse = getStat("acc", g,b,w,e)
	o.maxspeed = getStat("spd", g,b,w,e)
	o.hand = getStat("hnd", g,b,w,e)
	o.reg = getStat("reg", g,b,w,e)
	print (o.id.." PUL: "..o.pulse.." SPD: "..o.maxspeed.." HND: "..o.hand)
	o.shot_timer = 0
	o.shot_delay = getStat("frt", g,b,w,e)/10
	o.angle, o.angle_speed = 2,0

	o.img = base.parts.sprite
	o.q = {
		g = {x = getQuad("gun", g, "qx"), y = getQuad("gun", g, "qy")},
		b = {x = getQuad("body", b, "qx"), y = getQuad("body", b, "qy")},
		w = {x = getQuad("wing", w, "qx"), y = getQuad("wing", w, "qy")},
		e = {x = getQuad("engine", e, "qx"), y = getQuad("engine", e, "qy")},
	}

	if not o.control then
		o.ai = function(i,dt)
			for j,b in ipairs (craft) do
				if b.team ~= craft[i].team then
					angle = math.atan2((b.x+b.vx*dt)-craft[i].x, craft[i].y-(b.y+b.vy*dt))
					if angle < craft[i].angle then rotate(i,3,-1,dt)																				--rotate to	\
					else rotate(i,3,1,dt) end																																--enemy			/
					accel(i, craft[i].pulse/2, craft[i].angle)
					local t = love.timer.getTime()
					if t>craft[i].shot_timer+craft[i].shot_delay/speed and craft[i].angle > angle-0.2 and craft[i].angle < angle+0.2  then
					shot(craft[i].x, craft[i].y, craft[i].vx, craft[i].vy, -craft[i].angle+math.random(-0.1,0.1), craft[i].q.g.x, craft[i].param.gun ,craft[i].team) 
					craft[i].shot_timer = t																																								--KILL THE ENEMY
					end
				end
			end
		end
	end
	
	table.insert(craft,o)
end



function craft.draw()
	for i,v in ipairs(craft) do
			local ang, ang_2 = math.cos(math.deg(v.angle/60))*2, math.sin(math.deg(v.angle/60))*2
			gr.setColor(0,0,0, 255)
			gr.draw(v.img, quad[v.q.g.x][v.q.g.y  ].q, v.x, v.y, v.angle,ang,   2,16,16)	--gun
			gr.draw(v.img, quad[v.q.g.x][v.q.g.y+1].q, v.x, v.y, v.angle,ang_2, 2,16,16) 		--gun_2
			gr.draw(v.img, quad[v.q.b.x][v.q.b.y  ].q, v.x, v.y, v.angle,ang,   2,16,16)	--body
			gr.draw(v.img, quad[v.q.b.x][v.q.b.y+1].q, v.x, v.y, v.angle,ang_2, 2,16,16) 		--body_2
			gr.draw(v.img, quad[v.q.w.x][v.q.w.y  ].q, v.x, v.y, v.angle,ang,   2,16,16)	--wings
			gr.draw(v.img, quad[v.q.w.x][v.q.w.y+1].q, v.x, v.y, v.angle,ang_2, 2,16,16) 		--wings_2
			gr.draw(v.img, quad[v.q.e.x][v.q.e.y  ].q, v.x, v.y, v.angle,2    , 2,16,16) 	--engine
			gr.setColor(0,0,0, 200)
			gr.print("hp: "..(v.hp), v.x,v.y)
			gr.setColor(255,255,255, 200)
			love.graphics.circle("line", v.x, v.y, 10)
	end
	
	gr.setColor(100,100,200, 30)
	for i,v in ipairs (clouds) do
		gr.circle("fill", v.x,v.y,v.s)
	end
end

function shot(x,y,vx,vy,angle, g, name ,team)
	local o = {}
	o.img = base.parts.sprite
	o.quad = quad[g][1].q
	o.dmg = base.gun[name].dmg
	o.team = team
	o.x, o.y = x-20*math.sin(angle), y-20*math.cos(angle)
	o.speed = 600*speed
	o.vx = -o.speed*math.sin(angle)+vx/5
	o.vy = -o.speed*math.cos(angle)+vy/5
	o.time = love.timer.getTime()
	o.lifetime = 5
	table.insert(bullet,o)
end

function rotate(i, angle, dir, dt)
	craft[i].angle = craft[i].angle +angle*dir*dt*speed
end

function accel(i, pulse, angle)
				local pulse, ang = pulse, angle-math.rad(90)
				local pulse_x, pulse_y = pulse*math.cos(ang),pulse*math.sin(ang)
				craft[i].vx = craft[i].vx+pulse_x
				craft[i].vy = craft[i].vy+pulse_y
end

	function craft.update(dt)
	for i,v in ipairs (craft) do
	if v.angle>=pi then v.angle = -pi end									--save angle	\
	if v.angle<-pi then v.angle = pi end									--properties	/
			if (v.vx^2+v.vy^2)^0.5>v.maxspeed then						--speed limit
				local ang = math.atan2(v.vx,v.vy)
				v.vx = v.maxspeed*math.sin(ang)
				v.vy = v.maxspeed*math.cos(ang)
			end
			v.vx = v.vx-v.vx*0.01															--air resistance
			if v.y>world.water.y then 												--water push (y linit)
				v.vy = v.vy+(-2000*dt)
				if v.angle>=0.2 or v.angle<-0.2 then rotate(i,2*v.angle,-1,dt) end
			elseif v.y<world.cloud.y then 										--cloud push (y limit)
				v.vy = v.vy+(2000*dt)
				if v.angle<=2.5 or v.angle>-2.5  then rotate(i, 5/(v.angle+0.1),1,dt) end
			else 
				v.vy = v.vy+400*dt 															--GRAVITATION
			end
			if v.x<0 then v.x = world.pos.x end								--world		\
			if v.x>world.pos.x then v.x = 0 end								--looping	/
			if v.shot_timer<love.timer.getTime()-dt*v.shot_delay*60 then v.hp = v.hp+v.reg*dt end			--regeneration
			if v.hp>v.max_hp then v.hp = v.max_hp end
		if v.control then	
			if love.keyboard.isDown("x") then 		--Shooting
				local t = love.timer.getTime()
				if t>v.shot_timer+v.shot_delay/speed then
				shot(v.x, v.y, v.vx, v.vy,  -v.angle+math.random(-10,10)/100, v.q.g.x, v.param.gun, 1) 
				v.shot_timer = t
				end
			end
			if love.keyboard.isDown("up") then 		--Acceleration
				accel(i, v.pulse, v.angle)
				if love.keyboard.isDown("left") then rotate(i,2,-1,dt) end		--rotation with acceleration	\
				if love.keyboard.isDown("right") then rotate(i,2,1,dt) end		--realy slow, and it's good		/
			else 
				if love.keyboard.isDown("left") then rotate(i,4,-1,dt) end		--rotetion without acceleration		\
				if love.keyboard.isDown("right") then rotate(i,4,1,dt) end		--work better, and it's good too	/
			end
		end
		v.angle = v.angle+v.angle_speed*dt			--angle acceleration, if it need
		v.x = v.x+v.vx*dt*speed															--confirm x and	\
		v.y = v.y+v.vy*dt*speed															--y vectors			/
		if v.ai then v.ai(i,dt) end
		if v.hp<0 then table.remove(craft,i) end
	end
end

function bullet.update(dt)
	for i,a in ipairs(bullet) do
		a.x = a.x+a.vx*dt*speed
		a.y = a.y+a.vy*dt*speed
		for j,b in ipairs (craft) do
			local dist = ((b.x-a.x)^2+(b.y-a.y)^2)^0.5
			if dist<25 and a.team ~= b.team then 
				b.hp = b.hp-a.dmg
				table.remove(bullet,i)
			end
		end
		if love.timer.getTime()>a.time+a.lifetime then table.remove(bullet,i) end
	end
end

	function bullet.draw(dt)
		gr.setColor(255,255,255,255)
		for i,v in ipairs(bullet) do
			local angle = (math.atan2(v.vx, -v.vy))
			gr.draw(v.img, v.quad, v.x, v.y,angle,3,3,16,16)
		end
	end
	
