function love.conf(t)
	t.window.width = 800 -- t.screen.width in 0.8.0 and earlier
	t.window.height = 500 -- t.screen.height in 0.8.0 and earlier
	t.window.borderless = false 
	t.window.resizable = true
	t.window.minwidth = 400
	t.window.minheight = 300
	t.modules.physics = false
	t.modules.thread  = false
	t.console = true
end