local flowers = beautiflowers.flowers
local FLOWERS_AMOUNT = 5
local MAX_HEIGHT = 30000

-- Función genérica para registrar decoraciones
local function register_decoration(name, place_on, y_min, y_max, noise_params, fill_ratio)
    minetest.register_decoration({
        name = "beautiflowers:" .. name,
        deco_type = "simple",
        place_on = place_on,
        sidelen = 16,
        noise_params = noise_params,
        y_min = y_min,
        y_max = y_max,
        fill_ratio = fill_ratio,
        decoration = "beautiflowers:" .. name,
    })
end

-- Registro de tipos de decoraciones
for _, name in ipairs(flowers) do
    local type, number = name:match("([^_]+)_([^_]+)")
    local place_on, y_min, y_max, noise_params, fill_ratio

    if type == "pasto" then
        place_on = {"default:dirt_with_grass", "default:dirt"}
        y_min = 1
        y_max = MAX_HEIGHT
        noise_params = {
            offset = -0.03,
            scale = 0.07,
            spread = {x = 100, y = 100, z = 100},
            seed = 1602,
            octaves = 3,
            persist = 1,
        }
        fill_ratio = 1 / 16000 * FLOWERS_AMOUNT

    elseif type == "bonsai" then
        place_on = {"default:stone", "default:cobble", "default:mossycobble"}
        y_min = 30
        y_max = MAX_HEIGHT
        noise_params = {
            offset = -0.006,
            scale = 0.07,
            spread = {x = 250, y = 250, z = 250},
            seed = 2,
            octaves = 3,
            persist = 0.66,
        }
        fill_ratio = 1

    else  -- Assuming type == "flower"
        place_on = {"default:dirt_with_grass"}
        y_min = 1
        y_max = MAX_HEIGHT
        noise_params = nil  -- No noise_params for flowers
        fill_ratio = 1 / 16000 * FLOWERS_AMOUNT

    end

    register_decoration(name, place_on, y_min, y_max, noise_params, fill_ratio)
end

-- Función para la propagación de bonsáis
local function bonsai_spread(pos, node)
    if minetest.get_node_light(pos, 0.5) > 3 then
        if minetest.get_node_light(pos, nil) == 15 then
            minetest.remove_node(pos)
        end
        return
    end

    local positions = minetest.find_nodes_in_area_under_air(
        {x = pos.x - 1, y = pos.y - 2, z = pos.z - 1},
        {x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
        {"group:stone"}
    )

    if #positions > 0 then
        local pos2 = positions[math.random(#positions)]
        pos2.y = pos2.y + 1
        if minetest.get_node_light(pos2, 0.5) <= 3 then
            minetest.set_node(pos2, {name = node.name})
        end
    end
end

-- Registro del ABM para la propagación de bonsáis
minetest.register_abm({
    label = "Bonsai spread",
    nodenames = {"beautiflowers:bonsai_1", "beautiflowers:bonsai_2", "beautiflowers:bonsai_3", "beautiflowers:bonsai_4", "beautiflowers:bonsai_5"},
    interval = 11,
    chance = 150,
    action = function(...)
        bonsai_spread(...)
    end,
})
