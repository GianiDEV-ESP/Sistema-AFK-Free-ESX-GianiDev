RegisterNetEvent("afk:setStatus")
AddEventHandler("afk:setStatus", function(status, reason)
    local src = source
end)

RegisterNetEvent("afk:kickPlayer")
AddEventHandler("afk:kickPlayer", function()
    local src = source
    DropPlayer(src, "Fuiste kickeado por inactividad (AFK más de 5 minutos sin usar /afk)")
end)
