local ground_hole = table.deepcopy(data.raw["tile"]["out-of-map"])

ground_hole.name = "sb-ground-hole"
ground_hole.collision_mask =
{
  "water-tile",
  "resource-layer",
  "item-layer"
}
data:extend{ground_hole}