local DrillGUI = {}


function DrillGUI.OnGuiOpened(event)
    if event.gui_type == defines.gui_type.entity and event.entity.name == "sb-boring-drill" then
        --print("Opening dr")
        local player = game.get_player(event.player_index)
        local anchor = {gui=defines.relative_gui_type.assembling_machine_gui, position=defines.relative_gui_position.bottom}
        --game.print("Opening GUI")
        
        local frame = player.gui.relative.add{type="frame", anchor=anchor, direction = "horizontal"}
        frame.style.horizontally_stretchable= "stretch_and_expand"

        frame.add{
            type="label",
            caption="Dig Progress:",
            style="frame_title"
        }

        frame.add{
            type= "progressbar",
            style= "production_progressbar",
            value = get_mining_progress(event.entity.unit_number),
            name = "bar"
        }

        frame.add{
            type="label",
            caption="Toughness: ".. get_dig_stats(event.entity.unit_number)[1],
            name= "toughness"
        }

        frame.add{
            type="label",
            caption="Distance: ".. get_dig_stats(event.entity.unit_number)[2],
            name="distance"
        }

        frame.add{
            type="label",
            caption="Digs Left: ".. get_dig_stats(event.entity.unit_number)[3],
            name="needed"
        }

        if global.boring_drill_guis==nil then global.boring_drill_guis = {} end

        if global.boring_drill_guis[event.player_index] ~= nil then
            DrillGUI.OnGuiClosed(event) --Force close any other drill GUI
        end 

        global.boring_drill_guis[event.player_index] = {frame=frame,entity_id = event.entity.unit_number}

    end
end

function DrillGUI.OnGuiClosed(event)
    if event.gui_type == defines.gui_type.entity and event.entity.name == "sb-boring-drill" then
        local frame = global.boring_drill_guis[event.player_index].frame
        global.boring_drill_guis[event.player_index] = nill
        --game.print("Closing GUI")
        frame.destroy()
    end
end

return DrillGUI