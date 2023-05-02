local elevator = table.deepcopy(data.raw["rocket-silo"]["rocket-silo"])

elevator.name = "sb-elevator"
elevator.type = "linked-container"

elevator.gui_mode = "none"
elevator.collision_mask = { "item-layer", "object-layer", "player-layer", "water-tile"}
elevator.inventory_type = "with_filters_and_bar"

    -- for collision box one tile is 0.4 x 0.4
elevator.dying_explosion = "rocket-silo-explosion"
elevator.collision_box = {{-4.40, -4.40}, {4.40, 4.40}}
elevator.selection_box = {{-4.5, -4.5}, {4.5, 4.5}}
elevator.drawing_box = {{-4.5, -4.5}, {4.5, 4.5}}
elevator.allow_copy_paste = false
--elevator.minable = {mining_time = 1, result = elevator.name}
elevator.max_health = 400
elevator.is_military_target = false
elevator.create_ghost_on_death = true
elevator.circuit_wire_connection_point = circuit_connector_definitions["chest"].points
elevator.circuit_connector_sprites = circuit_connector_definitions["chest"].sprites
elevator.circuit_wire_max_distance = default_circuit_wire_max_distance
elevator.inventory_size = 5


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



elevator.picture = {layers= {rocket_silo_hole_sprite, rocket_silo_sprite}}
--elevator.icon = ""
--elevator.icon_size = 64
elevator.corpse = "big-remnants"
elevator.next_upgrade = nil
--elevator.crafting_speed= 1.0

data:extend{elevator}