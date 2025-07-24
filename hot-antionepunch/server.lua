AddEventHandler('weaponDamageEvent', function(sender, data)  
    if data.weaponType == 133987706 then
        CancelEvent()
    end
    if data.weaponType == 133987706 or data.weaponType == -1569615261 and data.weaponDamage > 50 then
        CancelEvent()
    end 
    if Config.AntiCitizenOnePunch and data.weaponType == 2725352035 and data.weaponDamage > 60 then
        CancelEvent()
        TriggerClientEvent("arackontrl", sender)
    end 
    if Config.AntiCitizenOnePunch and data.weaponType == -1569615261 and data.weaponDamage > 60 then
        CancelEvent()
        TriggerClientEvent("arackontrl", sender)
    end 
end)

function banat(source, reason)
    if Config.Fiveguardban then
        Logat(source, "Fiveguard Ban", "Tek Yumruk Algılandı")
        exports[Config.Fiveguardname]:fg_BanPlayer(source, reason)
    else
        Logat(source, "Kick", "Tek Yumruk Algılandı")
        DropPlayer(source, reason)
    end
end


function Logat(source, actionType, reason)
    local ad = GetPlayerName(source) or "N/A"
    local iden = GetPlayerIdentifiers(source)
    local steam = "N/A"
    local license = "N/A"

    for _, id in ipairs(iden) do
        if string.find(id, "steam:") then steam = id end
        if string.find(id, "license:") then license = id end
        if string.find(id, "discord:") then dc = id end
    end

    if Config.LogWebhook and Config.LogWebhook ~= "" then
        PerformHttpRequest(Config.LogWebhook, function(err, text, headers) end, "POST", json.encode({
            username = "HotStudio",
            avatar_url = "https://cdn.discordapp.com/icons/1258920486797054142/edee3338be911fc07ef491726b92503d.webp?size=1024", 
            embeds = {{
                title = " "..actionType.." Log",
                color = actionType == "Ban" and 16711680 or 16753920,
                fields = {
                    { name = "**Name**", value = "`" .. ad .. "`", inline = true },
                    { name = "**Reason**", value = "`" .. reason .. "`", inline = true },
                    { name = "**Steam**", value = "`" .. steam .. "`", inline = false },
                    { name = "**Discord**", value = "`" .. dc .. "`", inline = false },
                    { name = "**License**", value = "`" .. license .. "`", inline = false },
                },
                footer = {
                    text = "HotStudio discord.gg/hotstudio",
                    icon_url = "https://cdn.discordapp.com/icons/1258920486797054142/edee3338be911fc07ef491726b92503d.webp?size=1024"
                },
                timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
            }}
        }), { ["Content-Type"] = "application/json" })
    end
end

RegisterServerEvent("banatmapunch")
AddEventHandler("banatmapunch", function()
    banat(source, "[HotStudio] Tek Yumruk Algılandı ")
end)
