require("prototypes.entity.alchemical-plant")
require("prototypes.entity.boring-drill")
require("prototypes.entity.elevator")
require("prototypes.entity.sulfur-res")

require("prototypes.item.alchemical-plant")
require("prototypes.item.boring-drill")
require("prototypes.item.drill-progress")
require("prototypes.item.drill-bit")

require("prototypes.tile.ground-hole")

require("prototypes.recipes.recipes")

require("prototypes.recipe-categories")


local chem_prereqs = data.raw["technology"]["chemical-science-pack"].prerequisites
local index={}
for k,v in pairs(chem_prereqs) do
   index[v]=k
end
table.remove(data.raw["technology"]["chemical-science-pack"].prerequisites,index["sulfur_processing"])

table.insert(data.raw["technology"]["sulfur-processing"].prerequisites,"chemical-science-pack")
table.insert(data.raw["technology"]["sulfur-processing"].unit.ingredients,{ "chemical-science-pack", 1 })

local landfill_tech = data.raw["technology"]["landfill"].effects

table.insert(landfill_tech,{
    type = "unlock-recipe",
    recipe = "sb-boring-drill"
})
