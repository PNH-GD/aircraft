base = {}


function base.init()
	base = { 
		parts = {sprite = gr.newImage("/sprites/png/craft_parts.png"), gridsize = 32},
		gun = { 
				classic = 	{title = "Classic",					qx = 1, qy = 2, dmg =  5, frt = 10, mas = 5},
				boomstick =	{title = "Boom stick", 			qx = 2, qy = 2, dmg =  5, frt = 10, mas = 5},
				srocket = 	{title = "Rocket swarm", 		qx = 3, qy = 2, dmg =  5, frt = 10, mas = 5},
				tesla = 		{title = "Tesla gun", 			qx = 4, qy = 2, dmg =  3, frt = 10, mas = 5},
				laser = 		{title = "Laser beam", 			qx = 5, qy = 2, dmg =  3, frt = 10, mas = 5},
				rocket = 		{title = "Rocket launcher", qx = 6, qy = 2, dmg =  3, frt = 10, mas = 5},
				static = 		{title = "Static gun", 			qx = 7, qy = 2, dmg =  3, frt = 10, mas = 5},
				gauss = 		{title = "Gauss gun", 			qx = 8, qy = 2, dmg =  3, frt = 10, mas = 5},
				ion = 			{title = "Ion gun", 				qx = 9, qy = 2, dmg =  3, frt = 10, mas = 5},
				},
		body = {
			classic = 		{title = "Classic", 				qx = 1, qy = 4, hp = 15, reg = 5, acc = nil, spd = 20,},
			fat = 				{title = "Fatty", 					qx = 2, qy = 4, hp = 25, reg = 6, acc = -20, spd = 00,},
			melee = 			{title = "Berserk", 				qx = 3, qy = 4, hp = 10, reg = 6, acc = 10,  spd = 30,},
			pulse = 			{title = "Nova", 						qx = 4, qy = 4, hp = 15, reg = 6, acc = -10, spd = 10,},
			tin = 				{title = "Can", 						qx = 5, qy = 4, hp = 10, reg = 7, acc = nil, spd = 20,},
			merc = 				{title = "Mercenary", 			qx = 6, qy = 4, hp = 20, reg = 7, acc = -10, spd = 20,},
			ghost = 			{title = "Ghost", 					qx = 7, qy = 4, hp = 15, reg = 5, acc = nil, spd = 30,},
			},
		wing = {
			classic = 		{title = "Classic",					qx = 1, qy = 6, hp =  5, spd = 200, hnd = 20},
			duck = 				{title = "Duck",						qx = 2, qy = 6, hp =  7, spd = 230, hnd = 20},
			tin = 				{title = "Tin",							qx = 3, qy = 6, hp =  4, spd = 200, hnd = 20},
			arrow = 			{title = "Arrow",						qx = 4, qy = 6, hp =  6, spd = 220, hnd = 20},
			reverce = 		{title = "Arrow Back",			qx = 5, qy = 6, hp =  7, spd = 200, hnd = 20},
			batman = 			{title = "Batman",					qx = 6, qy = 6, hp =  8, spd = 220, hnd = 20},
			ghost = 			{title = "Ghost", 					qx = 7, qy = 6, hp =  5, spd = 190, hnd = 20},
			},
		engine = {
			classic = 		{title = "Classic",					qx = 1, qy = 8, hp =  5, spd = 150, acc = 50},
			flaps = 			{title = "Flappy",					qx = 2, qy = 8, hp =  5, spd = 200, acc = 60},
			skrew = 			{title = "Screw",						qx = 3, qy = 8, hp =  5, spd = 150, acc = 40},
			laser = 			{title = "Laser",						qx = 4, qy = 8, hp =  5, spd = 150, acc = 30},
			turbo = 			{title = "FTL",							qx = 5, qy = 8, hp =  5, spd = 350, acc = 95},
			batman = 			{title = "Batman",					qx = 6, qy = 8, hp =  5, spd = 200, acc = 60},
			ghost = 			{title = "Ghost",						qx = 7, qy = 8, hp =  5, spd = 150, acc = 50},
			},
	}
	base.parts.sprite:setFilter( "nearest" )
	quad.init(base.parts.sprite, base.parts.gridsize)
	canvas = gr.newCanvas(800,600)
canvas:setFilter( "linear", "nearest", 15)
end
