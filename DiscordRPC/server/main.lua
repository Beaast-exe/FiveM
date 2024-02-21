RegisterServerEvent('DiscordRPC:UpdatePresence')
AddEventHandler('DiscordRPC:UpdatePresence', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local data = {
        ['PlayerName']  = GetPlayerName(_source),
        ['IdentityName'] = xPlayer.getName(),
        ['ActivePlayers'] = GetNumPlayerIndices(),
        ['Job'] = {
            jobName = xPlayer.getJob(),
            jobGrade = xPlayer.getJob().grade_label,
            jobLabel = xPlayer.getJob().label
        }
    }

    TriggerClientEvent('DiscordRPC:SetPresence', _source, data)
end)