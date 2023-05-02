data:extend({
{
    type = "recipe",
    name = "sb-drilling",
    category = "sb-boring",
    icon = "__SoBelow__/graphics/icons/drill-bit.png",
    icon_size = 64, icon_mipmaps = 4,

    energy_required = 10,  
    hidden = true,	
    hidden_from_flow_stats = true,
    hidden_from_player_crafting = true,
    always_show_made_in = false,
    enabled = true,
    subgroup = "raw-resource",
    ingredients = {
        {type = "item", name = "sb-drill-bit", amount = 5},
        {type = "item", name = "copper-cable", amount = 10},
        {type = "item", name = "concrete", amount = 8},

    },
    results = {
        {type = "item", name = "sb-drill-bit", amount_min = 1, amount_max = 3},
        {type = "item", name = "stone", amount_min = 4, amount_max = 8},
        {type = "item", name = "iron-ore", amount_min = 0, amount_max = 4},
        {type = "item", name = "copper-ore", amount_min = 0, amount_max = 4}
    }
},
{
    type = "recipe",
    name = "sb-boring-drill",
    category = "crafting",
    energy_required = 0.5,
    enabled = false,
    ingredients =
    {
        {type = "item", name = "steel-plate", amount = 50},
        {type = "item", name = "iron-gear-wheel", amount = 50},
        {type = "item", name = "concrete", amount = 100},
        {type = "item", name = "electronic-circuit", amount = 50}
    },
    results =
    {
        {type = "item", name = "sb-boring-drill", amount = 1}
    }
},
{
    type = "recipe",
    name = "sb-drill-bit",
    category = "crafting",
    energy_required = 1,
    enabled = true,
    ingredients =
    {
        {type = "item", name = "iron-plate", amount = 3},
        {type = "item", name = "iron-gear-wheel", amount = 3}
    },
    results =
    {
        {type = "item", name = "sb-drill-bit", amount = 1}
    }
}
})


