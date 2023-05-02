local boring_drill = table.deepcopy(data.raw["item"]["rocket-silo"])

boring_drill.name = "sb-boring-drill"
boring_drill.place_result = "sb-boring-drill"
--fertilizer.icon = "__WhatLiesWithin__/graphics/icons/fertilizer.png"
--fertilizer.stack_size = 1
--fertilizer.subgroup = "raw-resource"
--fertilizer.order = "wlw-fertilizer"

data:extend{boring_drill}