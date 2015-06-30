quad = {}

function getStat(stat, g, b, w, e)
	local coll = 0
	if base.gun[g][stat] then coll = coll + base.gun[g][stat] end
	if base.body[b][stat] then coll = coll + base.body[b][stat] end
	if base.wing[w][stat] then coll = coll + base.wing[w][stat] end
	if base.engine[e][stat] then coll = coll + base.engine[e][stat] end
	return coll
end

function getFunc(type, name)
	return base[type][name].func
end

function getQuad(type, name, s)
	local m = 0
	if base[type][name][s] then m = base[type][name][s] end
	return m
end

function quad.init(image, spritesize)																	--получение имени картинки и размер одного кусочка
	local x,y = image:getDimensions()																		--находим размеры оригинального спрайта
	x,y = math.floor(x/spritesize), math.floor(y/spritesize)		--находим размер сетки (x спрайтов по горизонтали, y спрайтов по вертикали)
	quad = {}																																									--инициализация массива квадов (структура нарезки)
	for i = 1, y do																																					--цикл по вертикали
		table.insert(quad,{})																														--вставляем пустой квад для заполнения его бла-бла
		for j=1,x do																																						--цикл по горизонтали
			local o = {}																																					
			o.x,o.y = i-1,j-1
			o.q = gr.newQuad(o.x*spritesize,o.y*spritesize,spritesize,spritesize, image:getDimensions())
			table.insert(quad[i],o)
		end
	end
end
