local alchemical_plant = table.deepcopy(data.raw["item"]["chemical-plant"])

alchemical_plant.name = "sb-alchemical-plant"
alchemical_plant.place_result = "sb-alchemical-plant"
--fertilizer.icon = "__WhatLiesWithin__/graphics/icons/fertilizer.png"
--fertilizer.stack_size = 1
--fertilizer.subgroup = "raw-resource"
--fertilizer.order = "wlw-fertilizer"

data:extend{alchemical_plant}