require "lib/req"
math.randomseed(os.time())
world = {
pos = {x = 5000, y = 4000},
water = {x = 0, y = 3000},
cloud = {x = 0, y = 500},
}
pause = false
state = "menu"
game = {}

function game.init()
	craft.new(100,2500, "rocket","pulse","duck","turbo", 1, true)
	craft.new(150,2500, "srocket","fat","ghost","laser", 2)
	craft.new(180,2500, "tesla","merc","reverce","flaps", 2)
	craft.new(200,2500, "static","ghost","ghost","laser", 2)
end


function love.load()
	love.window.setMode(800, 600, {vsync=true, fullscreen=false})

	base.init()
	camInit(-600,-600,world.pos.x+1000,world.pos.y+1000)
	gr.setBackgroundColor(200,200,200)
	
--	craft.new(100,2500,1,1)
--	craft.new(1000,2500,nil,2)
	menu.init()
end



function love.update(dt)
	if not pause then
		craft.update(dt)
		bullet.update(dt)
		cam.update(dt)
		menu.update()
	end
		gr.setCanvas(canvas)
		canvas:clear()
		menu.draw()
		cam.a:draw(function(l,t,w,h)
		gr.setColor(20,20,50,30)
		gr.rectangle("fill", 0,0,8000,500)			--clouds
		gr.rectangle("fill", 0,3000,8000,500) 	--water
		gr.setColor(255,255,255,255)
		craft.draw(dt)
		bullet.draw(dt)
		end)
		gr.setCanvas()
end

function love.draw()
gr.draw(canvas,0,0,0,1,1)

end


function love.keypressed(key, unicode)
	if key == "escape" then love.event.quit() end	
	if key == "p" then pause = not pause end	
end
