local Level = {}


global.LevelTree = {}
global.Levels = {}

function Level.get_root(surface_name)
    global.LevelTree = global.LevelTree or {}
    global.Levels = global.Levels or {}


    if global.LevelTree[surface_name] == nil then
        if global.Levels[surface_name] == nil then

            --If current surface not in leveltree or levels then it is a new root
            global.LevelTree[surface_name] = {}
            return surface_name
        else
            return global.Levels[surface_name].root
        end
    else
        return surface_name
    end
end

function Level.get_depth_from_root(surface_name)
    --global.LevelTree = global.LevelTree or {}
    global.Levels = global.Levels or {}

    if global.Levels[surface_name] == nil then return 0 end

    return global.Levels[surface_name].depth
end

function Level.create_or_get_surface(root_surface_name, depth)

    global.LevelTree = global.LevelTree or {}
    global.Levels = global.Levels or {}

    if global.LevelTree[root_surface_name] == nil then
        global.LevelTree[root_surface_name] = {}
        global.LevelTree[root_surface_name][depth] = {name = nil}
        print("Adding root to level tree")
    end

    local surface = global.LevelTree[root_surface_name][depth]


    if surface == nil then
        new_surface_name = Level.create_surface_below(root_surface_name,depth)
        local level = {name = new_surface_name, depth = depth, root = root_surface_name}
        global.LevelTree[root_surface_name][depth] = level
        global.Levels[new_surface_name] = level
        return new_surface_name
    end

    return surface.name
end

function Level.create_surface_below(surface_name, depth)
    local root = game.get_surface(surface_name)
    local root_map_settings = root.map_gen_settings

    local new_surface_name = surface_name .. " level " .. depth

    local map_settings = root_map_settings


    map_settings.water = 0
    
    map_settings.autoplace_controls["sulfur"] = {frequency = 1, size = 1, richness = 1}
    map_settings.autoplace_controls["trees"] = {frequency = 0, size = 0, richness = 0}
    map_settings.cliff_settings.richness = (1.1* depth)+2

    map_settings.seed = math.random(4294967295)
    local surface = game.create_surface(new_surface_name, map_settings)
    game.print("Created surface: " .. new_surface_name)
    Level.configure_surface(surface)
    
   

    return new_surface_name
end

function Level.configure_surface(surface)
     surface.morning = 0.55
     surface.dawn = 0.75
     surface.dusk = 0.25
     surface.evening = 0.45
 
     surface.daytime = 0.35
     surface.freeze_daytime = true
     surface.show_clouds = false
     surface.brightness_visual_weights = {1/0.85, 1/0.85, 1/0.9}
 
     surface.solar_power_multiplier = 0
end
return Level