local afk = false
local afkReason = ""
local lastPosition = nil
local lastMoveTime = GetGameTimer()

RegisterCommand("afk", function(source, args)
    local ped = PlayerPedId()

    if #args == 0 then
        afk = false
        afkReason = ""
        ResetEntityAlpha(ped)
        SetEntityCollision(ped, true, true)
        FreezeEntityPosition(ped, false)
        TriggerServerEvent("afk:setStatus", false, "")
        TriggerEvent("chat:addMessage", {
            color = {255, 255, 0},
            args = {"AFK", "Has salido del modo AFK."}
        })
    else
        afkReason = table.concat(args, " ")
        afk = true
        SetEntityAlpha(ped, 150, false) -- Opaco
        SetEntityCollision(ped, false, false)
        FreezeEntityPosition(ped, true)
        TriggerServerEvent("afk:setStatus", true, afkReason)
        TriggerEvent("chat:addMessage", {
            color = {255, 255, 0},
            args = {"AFK", "Ahora estás en modo AFK: " .. afkReason}
        })
    end
end, false)

RegisterNetEvent("afk:resetStatus")
AddEventHandler("afk:resetStatus", function()
    afk = false
    afkReason = ""
    
    local ped = PlayerPedId()
    ResetEntityAlpha(ped)
    SetEntityCollision(ped, true, true)
    FreezeEntityPosition(ped, false)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if afk then
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            DrawText3D(coords.x, coords.y, coords.z + 1.0, "[AFK] " .. afkReason)
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if lastPosition then
            if #(coords - lastPosition) > 0.1 then
                lastMoveTime = GetGameTimer()
                if afk then
                    TriggerEvent("afk:resetStatus")
                    TriggerServerEvent("afk:setStatus", false, "")
                end
            end
        end
        lastPosition = coords
        if not afk and (GetGameTimer() - lastMoveTime > 5 * 60 * 1000) then
            TriggerServerEvent("afk:kickPlayer")
        end
    end
end)
