local resource_autoplace = require("resource-autoplace")

data:extend({
        {
            type = "autoplace-control",
            name = "sulfur",
            richness = true,
            order = "b-e",
            can_be_disabled = true,
            category = "resource"
        }
    })

local sulfur= table.deepcopy(data.raw["resource"]["uranium-ore"])

--stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},

sulfur.name = "sulfur"

sulfur.stages =
{
  sheet =
  {
      filename = "__SoBelow__/graphics/entity/sulfur-res.png",
      priority = "extra-high",
      size = 128,
      frame_count = 8,
      variation_count = 8,
      scale = 0.5
  }
}

sulfur.icon = "__base__/graphics/icons/sulfur.png"
sulfur.stages_effect =
{
  sheet =
  {
      filename = "__SoBelow__/graphics/entity/sulfur-glow.png",
      priority = "extra-high",
      width = 128,
      height = 128,
      frame_count = 8,
      variation_count = 8,
      scale = 0.5,
      blend_mode = "additive",
      flags = {"light"}
  }
}

local color = {r = 0.78, g = 0.8, b = 0.2, a = 1.000}
sulfur.map_color = color
mining_visualisation_tint = color

sulfur.autoplace = resource_autoplace.resource_autoplace_settings
{
  name = "sulfur",
  order = "c",
  base_density = 0.2,
  base_spots_per_km2 = 1.25,
  has_starting_area_placement = true,
  random_spot_size_minimum = 2,
  random_spot_size_maximum = 4,
  regular_rq_factor_multiplier = 1,
  starting_rq_factor_multiplier = 1.2
}

sulfur.minable =
{
  mining_particle = "stone-particle",
  mining_time = 10,
  result = "sulfur"
}

data:extend{sulfur}