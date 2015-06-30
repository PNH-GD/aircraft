--NEED FUNCTION game.init()
--NEED DRAW SOME STUFF IN MENU
key = ""

menu = {
	main = { 
	{title = "Play!", Kreturn = function (i) state = "game"; game.init(); menu.item = 1 end,  },
	{title = "Aircraft", Kreturn = function (i) menu.current = menu.craft; menu.item = 1 end,  },
	{title = "Options", Kreturn = function (i) menu.current = menu.options; menu.item = 1 end,  },
	{title = "Stats", Kreturn = function (i) menu.current = menu.stats; menu.item = 1 end,  },
	{title = "Exit", Kreturn = function (i) love.event.quit() end,  },
	nil,
	Kescape = function() love.event.quit() end,
	Kdown = function() if menu.item >= #menu.current then menu.item = 1 else menu.item = menu.item+1 end end,
	Kup = function() if menu.item <=1 then menu.item = #menu.current else menu.item = menu.item-1 end end,
	},

	craft = { 

	{title = "Gun", 
		Kreturn = function (i) menu.current[i].drawing_stuff = not menu.current[i].drawing_stuff;  end, 
		drawing_stuff = false, 
		draw_stuff = function(i) local m = 0 for j,v in pairs(base.gun) do gr.print(tostring(v.title),100,m*20); m=m+1 end end,
		},

	{title = "Body", 
		Kreturn = function (i) menu.current[i].drawing_stuff = not menu.current[i].drawing_stuff;  end, 
		drawing_stuff = false, 
		draw_stuff = function(i) local m = 0 for j,v in pairs(base.body) do gr.print(tostring(v.title),100,m*20); m=m+1 end end,
	},

	{title = "Wings", 
		Kreturn = function (i) menu.current[i].drawing_stuff = not menu.current[i].drawing_stuff;  end, 
		drawing_stuff = false, 
		draw_stuff = function(i) local m = 0 for j,v in pairs(base.wing) do gr.print(tostring(v.title),100,m*20); m=m+1 end end, 
	},

	{title = "Engine", 
		Kreturn = function (i) menu.current[i].drawing_stuff = not menu.current[i].drawing_stuff;  end, 
		drawing_stuff = false, 
		draw_stuff = function(i) local m = 0 for j,v in pairs(base.engine) do gr.print(tostring(v.title),100,m*20); m=m+1 end end,
	},

	{title = "Back", Kreturn = function (i) menu.current = menu.main; menu.item = 1 end,  },
	nil,
	Kescape = function() menu.current = menu.main; menu.item = 1 end,
	Kdown = function() if menu.item >= #menu.current then menu.item = 1 else menu.item = menu.item+1 end end,
	Kup = function() if menu.item <=1 then menu.item = #menu.current else menu.item = menu.item-1 end end,	
	},
	
	
}


function menu.init ()
menu.current = {}
menu.item = 1
menu.current = menu.main
end



function menu.draw()
	local screen_center_x, screen_center_y = 400,300
	if state == "menu" then
		for i,v in ipairs(menu.current) do
		if i == menu.item then gr.setColor(150,150,150) 
		else gr.setColor(100,100,100) end
			gr.print(tostring(v.title), 0,i*20)
			if menu.current[menu.item].drawing_stuff then
				menu.current[menu.item].draw_stuff(i)
			end
		end
	end
end

function menu.update()
	if state == "menu" then
		function love.keypressed(key,unicode)
			if key then 
				local bt = "K"..key
				if menu.current[menu.item][bt] ~= nil then
					menu.current[menu.item][bt](menu.item)
					elseif menu.current[bt] ~= nil then
					menu.current[bt]()
					end
				end
			end
		end
	end


