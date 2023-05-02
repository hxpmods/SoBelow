local ElevatorGUI = {}

function ElevatorGUI.OnGuiOpened(event)

    if event.gui_type == defines.gui_type.entity and event.entity.name == "sb-elevator" then
        local player = game.get_player(event.player_index)
        local anchor = {gui=defines.relative_gui_type.linked_container_gui, position=defines.relative_gui_position.bottom}
        --game.print("Opening GUI")
        
        local frame = player.gui.relative.add{type="frame", anchor=anchor, direction = "horizontal"}
        frame.style.horizontally_stretchable= "stretch_and_expand"

        frame.add{
            type="button",
            caption="Travel",
            style="green_button",
            name= "sb-travel-button"
        }


        if global.elevator_guis==nil then global.elevator_guis = {} end

        global.elevator_guis[event.player_index] = {frame=frame,entity_id = event.entity.unit_number}

    end
end

function ElevatorGUI.OnGuiClosed(event)
    if event.gui_type == defines.gui_type.entity and event.entity.name == "sb-elevator" then
        local frame = global.elevator_guis[event.player_index].frame
        global.elevator_guis[event.player_index] = nill
        --game.print("Closing GUI")
        frame.destroy()
    end
end

function ElevatorGUI.OnGuiClicked(event)
        if event.element.name == "sb-travel-button" then
            --game.print("Descending")
            local player = game.get_player(event.player_index)
            local entity = global.elevators[global.elevator_guis[event.player_index].entity_id]

            local link_id =entity.link_id
            local link = global.active_links[link_id]
            local travel_entity= nil

            if entity == link.top_entity then
                travel_entity = link.bottom_entity
            else
                travel_entity = link.top_entity
            end

            player.teleport(player.position,travel_entity.surface.name)
            --Can infinitely toggle, Huzzah!
            player.opened = travel_entity
        end
end
return ElevatorGUI