local DrillGUI = require("scripts/boring-drill")
local ElevatorGUI = require("scripts/elevator-gui")
local Level = require("scripts/levels")


function OnInit(event)
	if global.boring_drills==nil then global.boring_drills = {} end
    if global.elevators==nil then global.elevators = {} end
end

function convert_drill_to_elevator(drill_unit_number)
    if global.boring_drills==nil then global.boring_drills = {} end
    if global.elevators==nil then global.elevators = {} end
    if global.active_links==nil then global.active_links = {} end

    local drill_data = global.boring_drills[drill_unit_number]


    local drill = drill_data.drill

    local from_surface = drill.surface
    local to_surface = game.get_surface(Level.create_or_get_surface(drill_data.root_surface, drill_data.current_depth + 1))

    local top = from_surface.create_entity{name = "sb-elevator", position = drill.position, force=drill.force, raise_built=true}
    top.destructible = false
    top.minable = false
    local bottom = to_surface.create_entity{name = "sb-elevator", position = drill.position, force=drill.force, raise_built=true}
    bottom.destructible = false
    bottom.minable = false

    local top_pole = from_surface.create_entity{name = "small-electric-pole", position = drill.position, force=drill.force, raise_built=true}

    local bottom_pole = to_surface.create_entity{name = "small-electric-pole", position = drill.position, force=drill.force, raise_built=true}

    top_pole.connect_neighbour(bottom_pole)

    top_pole.destructible = false
    top_pole.minable = false

    bottom_pole.destructible = false
    bottom_pole.minable = false

    drill.destroy()

    local elevator_data = {
        top_entity = top,
        bottom_entity = bottom
    }

    local id = GetUnusedLinkId()
    global.active_links[id] = elevator_data
    top.link_id = id
    bottom.link_id = id

    global.elevators[top.unit_number] = top
    global.elevators[bottom.unit_number] = bottom
end

function GetUnusedLinkId()
    local id = math.random(2000) + 1000
    if global.active_links[id] == nil then
        return id
    end
    return GetUnusedLinkId()
end

function PlayerBuiltEntity(event)
    --local player = game.get_player(event.player_index)
    local name = event.created_entity.name

	if name == "sb-boring-drill" then

        local this_surface = event.created_entity.surface.name
        local root_surface = Level.get_root(this_surface)
        local depth = Level.get_depth_from_root(this_surface)
        local depthplus = 10+ (depth *depth) -- 10,11,14,19

		local data = 
		{
		drill=event.created_entity,
		digs_needed= 5, --50,
        ground_toughness = depthplus/20,
        total_meters = math.floor(math.pow(depthplus,1.1)*10),
        has_finished = false,
        root_surface = root_surface,
        current_depth = depth
		}

        data.digs_needed = math.floor(data.ground_toughness * data.total_meters)
		
        if global.boring_drills==nil then global.boring_drills = {} end

        global.boring_drills[data.drill.unit_number] = data
		data.drill.surface.print("Drill added")
	end

end

function keyboard_toggle_travel_interface(event)
    local player = game.get_player(event.player_index)
    toggle_travel_interface(player)
end

function OnTick(event)

	if global.boring_drills==nil then global.boring_drills = {} end
	for k, data in pairs (global.boring_drills) do 
		local drill = data.drill
		if drill and drill.valid then 
			check_dig_progress(data)
			else
			table.remove (global.boring_drills,k)
			end
		end
    
    if global.boring_drill_guis==nil then global.boring_drill_guis = {} end

    for player_id, open_gui in pairs (global.boring_drill_guis) do
        open_gui.frame.bar.value = get_mining_progress(open_gui.entity_id)
        open_gui.frame.needed.caption = "Digs Left: " .. get_dig_stats(open_gui.entity_id)[3]
        --open_gyu.frame.distance.caption =  "Distance: "
    end
end

function OnGuiClosed(event)
    --game.print(DrillGUI)
    DrillGUI.OnGuiClosed(event)
    ElevatorGUI.OnGuiClosed(event)
end

function OnGuiOpened(event)
    --game.print(DrillGUI)
    DrillGUI.OnGuiOpened(event)
    ElevatorGUI.OnGuiOpened(event)
    --game.print(event.name)
end

function OnGuiClicked(event)
    --game.print(DrillGUI)
   -- DrillGUI.OnGuiOpened(event)
    ElevatorGUI.OnGuiClicked(event)
end

function OnGuiElemChanged(event)
    game.print(event.name)
end 

function get_mining_progress(drill_id)
    local data = global.boring_drills[drill_id]
    if not data then return 0 end
    if not data.drill.valid then return 0 end
    if data.finished then return 1 end

    local entity=data.drill
	local progress=entity.products_finished 
	local max_progress=data.digs_needed

    return progress/max_progress

end

function get_dig_stats(drill_id)
    local data = global.boring_drills[drill_id]
    if not data then return {0,0,0} end
    if not data.drill.valid then return {0,0,0} end
    if data.finished then return {1,1,1} end

    local entity=data.drill
	local progress=entity.products_finished 

    local result= {data.ground_toughness,
    data.total_meters,data.digs_needed-progress}
    return result
end

function check_dig_progress(data)
	local entity=data.drill
	local progress=entity.products_finished 
	local max_progress=data.digs_needed

	if progress>=max_progress then 
	entity.active  = false
	if entity.get_output_inventory().get_item_count()<1 then
        if not data.has_finished then
		    do_big_dig(data) 
		    data.has_finished = true
            end
		end	
	end
end

function do_big_dig(data)
	data.drill.surface.print("Digging down:" .. data.root_surface .. "depth: " .. data.current_depth)
    Level.create_or_get_surface(data.root_surface, data.current_depth + 1)
    
    --[[local tiles_to_add = {}
    local range = {-4,-3,-2,1,0,1,2,3,4}
    for x,i in pairs(range) do
        for y,i in pairs(range) do
            local dig_position = {x = data.drill.position.x+ x-5.5,y= data.drill.position.y+y-5.5}
            local hole_tile = {position = dig_position, name = "sb-ground-hole"}
            table.insert(tiles_to_add,hole_tile)
            data.drill.surface.print("diggin at" .. dig_position.x .. " " ..dig_position.y)
        end
    end

    data.drill.surface.set_tiles(tiles_to_add)]]--

    convert_drill_to_elevator(data.drill.unit_number)

end

script.on_init(OnInit)
script.on_event(defines.events.on_tick, OnTick)
script.on_event(defines.events.on_built_entity, PlayerBuiltEntity)
script.on_event(defines.events.on_robot_built_entity, PlayerBuiltEntity)
script.on_event(defines.events.on_gui_closed, OnGuiClosed)
script.on_event(defines.events.on_gui_opened, OnGuiOpened)
script.on_event(defines.events.on_gui_click, OnGuiClicked)
script.on_event(defines.events.on_gui_elem_changed, OnGuiElemChanged)