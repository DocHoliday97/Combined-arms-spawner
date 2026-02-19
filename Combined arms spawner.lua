--========================================================--
--  D O C ' S   C O M B I N E D   A R M S   S P A W N E R --
--  Spawn a CA-drivable ground vehicle by placing a       --
--  mark on the map and naming it the vehicle type.       --
--========================================================--


---------------------------------------------------------------------
--  F10 MAP LABEL SPAWNER (FIXED)
--  Place a map label, type a vehicle name, spawns at that location.
---------------------------------------------------------------------

local drawings = {}
local spawnPrefix = "F10Spawn_"

---------------------------------------------------------------------
-- Function: Spawn a unit at the label location
---------------------------------------------------------------------
local function spawnUnitAtPosition(unitName, position, coalNum)

    local coalSide = coalNum or coalition.side.BLUE  -- fallback safety

    local groupName = spawnPrefix .. unitName .. "_" .. timer.getTime()

    env.info("SPAWN: Attempting to spawn '" .. unitName .. "' for coalition " .. tostring(coalSide))

    local spawnData = {
        visible = true,
        lateActivation = false,
        tasks = {},
        task = "Ground Nothing",
        uncontrolled = false,
        hidden = false,
        units = {
            [1] = {
                name = groupName .. "_1",
                type = unitName,
                x = position.x,
                y = position.z,
                heading = 0,
                skill = "Excellent",
                playerCanDrive = true   -- ⭐ THIS IS THE FIX
            }
        },
        x = position.x,
        y = position.z,
        name = groupName
    }

    local newGroup = coalition.addGroup(coalSide, Group.Category.GROUND, spawnData)

    if newGroup then
        env.info("SPAWN: SUCCESS '" .. unitName .. "' spawned.")
    else
        env.info("SPAWN: FAILED - Unit type not found: " .. tostring(unitName))
    end
end

---------------------------------------------------------------------
-- Event handler
---------------------------------------------------------------------
world.addEventHandler({
    onEvent = function(self, event)

        -------------------------------------------------------------
        -- MARK ADDED
        -------------------------------------------------------------
        if event.id == world.event.S_EVENT_MARK_ADDED then
            drawings[event.idx] = {
                text = event.text or "",
                pos = event.pos,
                coal = event.coalition
            }
            env.info("DRAW: Added " .. event.idx .. " text='" .. tostring(event.text) .. "'")

        -------------------------------------------------------------
        -- MARK CHANGED (text typed)
        -------------------------------------------------------------
        elseif event.id == world.event.S_EVENT_MARK_CHANGE then
            if drawings[event.idx] then
                drawings[event.idx].text = event.text or ""
                drawings[event.idx].pos = event.pos or drawings[event.idx].pos

                local unitName = drawings[event.idx].text
                local pos      = drawings[event.idx].pos
                local coalNum  = drawings[event.idx].coal

                env.info("DRAW: Updated " .. event.idx .. " text='" .. tostring(unitName) .. "'")

                if unitName ~= "" then
                    spawnUnitAtPosition(unitName, pos, coalNum)
                    trigger.action.removeMark(event.idx)
                    drawings[event.idx] = nil
                end
            end

        -------------------------------------------------------------
        -- MARK REMOVED
        -------------------------------------------------------------
        elseif event.id == world.event.S_EVENT_MARK_REMOVED then
            drawings[event.idx] = nil
        end
    end
})



