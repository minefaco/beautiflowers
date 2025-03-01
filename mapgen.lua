local flowers = beautiflowers.flowers



--[[Amount of flowers that you want to be generated 
    5 = normal 
    less than 5= just a little 
    more than 5 = a lot of flowers
]]--

local FLOWERS_AMOUNT = 5

--Maximun height that you want to spawn flowers (min 1, max 30000)
local MAX_HEIGHT = 30000

local function register_pasto(name)

	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass","default:dirt"},
		sidelen = 16,
		noise_params = {
			offset = -0.03,
			scale = 0.07,
			spread = {x = 100, y = 100, z = 100},
			seed = 1602,
			octaves = 3,
			persist = 1,
		},
		y_max = 30000,
		y_min = 1,
		decoration = "beautiflowers:"..name,
        spawn_by = "default:dirt_with_grass"
	})

end

local function register_bonsai(name)

	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:stone","default:cobble","default:mossycobble"},
		sidelen = 16,
		noise_params = {
			offset = -0.006,
			scale = 0.07,
			spread = {x = 250, y = 250, z = 250},
			seed = 2,
			octaves = 3,
			persist = 0.66,
		},
		y_max = 30000,
		y_min = 30,
		decoration = "beautiflowers:"..name,
	})

end

local function register_flower(name)
    local fill = (FLOWERS_AMOUNT/16000)
	minetest.register_decoration({
		name = "beautiflowers:"..name,
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
        fill_ratio = fill,
		y_max = MAX_HEIGHT,
		y_min = 1,
		decoration = "beautiflowers:"..name,
	})

end


minetest.register_decoration({
	name = "beautiflowers:azalea",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.006,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	y_max = 31000,
	y_min = 1,
	decoration = "flowers:azalea",
})

for i = 1, #flowers do
    local name = unpack(flowers[i])
    local aux = unpack(name:split("_"))
    if aux == "pasto" then
        register_pasto(name)
    else
        if aux == "bonsai" then
            register_bonsai(name)
        else
            register_flower(name)
        end

    end


end

