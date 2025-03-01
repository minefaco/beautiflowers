--Generar los nombres
local generate_pasto = function()
    local number = math.random(6,15)
    local name, dye, box = unpack(beautiflowers.flowers[number])
    local name = "beautiflowers:"..name..""
    return name
end

local generate_flowers = function()
    local number = math.random(16,99)
    
    if number == 99 then
        aux = "beautiflowers:azalea"
    else
        local name, dye, box = unpack(beautiflowers.flowers[number])
        aux = "beautiflowers:"..name
    end
    return aux
end

--Funciones spread
function beautiflowers.spread_pasto(pos) --pasto
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"group:soil", "group:dirt"})

	if #positions == 0 then
		return
	end
	local pos0 = vector.subtract(pos, 8)
	local pos1 = vector.add(pos, 8)
	if #minetest.find_nodes_in_area(pos0, pos1, "group:beautiflowers") > 3 then
		return
	end
	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) >= 10 then
		minetest.set_node(pos2, {name = generate_pasto()})
	end
end

function beautiflowers.spread_flowers(pos) --flores
	local positions = minetest.find_nodes_in_area_under_air(
		{x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
		{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
		{"group:soil", "group:dirt"})

	if #positions == 0 then
		return
	end
	local pos0 = vector.subtract(pos, 6)
	local pos1 = vector.add(pos, 6)
	if #minetest.find_nodes_in_area(pos0, pos1, "group:beautiflowers") > 3 then
		return
	end

	local pos2 = positions[math.random(#positions)]
	pos2.y = pos2.y + 1
	if minetest.get_node_light(pos2, 0.5) >= 11 then
		minetest.set_node(pos2, {name = generate_flowers()})
	end
end

minetest.register_abm({
	label = "pasto_spread",
	nodenames = {"default:dirt_with_grass"},
	interval = 30,
	chance = 500,
	action = function(...)
        beautiflowers.spread_pasto(...)
	end,
})

minetest.register_abm({
	label = "flowers_spread",
	nodenames = {"default:dirt_with_grass"},
	interval = 30,
	chance = 300,
	action = function(...)
        
        beautiflowers.spread_flowers(...)
	end,
})
