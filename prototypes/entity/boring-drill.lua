local boring_drill = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])

boring_drill.name = "sb-boring-drill"
boring_drill.type = "assembling-machine"
boring_drill.crafting_categories = {"sb-boring"}
boring_drill.fixed_recipe = "sb-drilling"

boring_drill.energy_usage = "1MW"

boring_drill.gui_mode = "all"
boring_drill.collision_mask = { "item-layer", "object-layer", "player-layer", "water-tile"}
    -- for collision box one tile is 0.4 x 0.4
boring_drill.dying_explosion = "rocket-silo-explosion"
boring_drill.collision_box = {{-4.40, -4.40}, {4.40, 4.40}}
boring_drill.selection_box = {{-4.5, -4.5}, {4.5, 4.5}}
boring_drill.drawing_box = {{-4.5, -4.5}, {4.5, 4.5}}
boring_drill.allow_copy_paste = true
boring_drill.minable = {mining_time = 1, result = boring_drill.name}
boring_drill.max_health = 400
boring_drill.is_military_target = false
boring_drill.create_ghost_on_death = true



local rocket_silo_sprite =
    {
      filename = "__SoBelow__/graphics/entity/elevator.png",
      width = 300,
      height = 300,
      shift = util.by_pixel(2, -2),
      [[hr_version =
      {
        filename = "__base__/graphics/entity/rocket-silo/hr-06-rocket-silo.png",
        width = 608,
        height = 596,
        shift = util.by_pixel(3, -1),
        scale = 0.5
      }]]
    }

local rocket_silo_hole_sprite =
    {
      filename = "__base__/graphics/entity/rocket-silo/01-rocket-silo-hole.png",
      width = 202,
      height = 136,
      shift = util.by_pixel(-6, 16),
      hr_version =
      {
        filename = "__base__/graphics/entity/rocket-silo/hr-01-rocket-silo-hole.png",
        width = 400,
        height = 270,
        shift = util.by_pixel(-5, 16),
        scale = 0.5
      }
    }



boring_drill.animation = {layers= {rocket_silo_hole_sprite, rocket_silo_sprite}}
--boring_drill.icon = ""
--boring_drill.icon_size = 64
boring_drill.corpse = "big-remnants"
boring_drill.next_upgrade = nil
boring_drill.crafting_speed= 1.0

data:extend{boring_drill}