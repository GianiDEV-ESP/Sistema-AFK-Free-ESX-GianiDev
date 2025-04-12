local afk = false
local afkReason = ""
local lastPosition = nil


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
        SetEntityAlpha(ped, 150, false)
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


