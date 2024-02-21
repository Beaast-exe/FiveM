local jobGrade = ''
local job = ''
local playerName = ''
local playerLoaded = false
local firstSpawn = true

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	playerLoaded = true
end)

AddEventHandler('playerSpawned', function()
	if firstSpawn then
		for _, v in pairs(Config.Buttons) do
			SetDiscordRichPresenceAction(v.index, v.name, v.url)
		end
		
		firstSpawn = false
	end
end)

RegisterNetEvent('DiscordRPC:SetPresence')
AddEventHandler('DiscordRPC:SetPresence', function(data)
	local data = data
	local player = PlayerId()

	if Config.UseJobs then
		SetDiscordRichPresenceAssetSmall(data['Job'].jobName)
		SetDiscordRichPresenceAssetSmallText(data['Job'].jobLabel .. ' - ' .. data['Job'].jobGrade)
	end

	SetDiscordAppId(Config.ClientID)
	SetDiscordRichPresenceAsset(Config.Image)
	SetDiscordRichPresenceAssetText(Config.ImageText)

	if Config.UseESXIdentity then
		SetRichPresence((Config.RichPresence):format(GetPlayerServerId(player), data['IdentityName'], Config.PlayerText, data['ActivePlayers'], tostring(Config.PlayerCount)))
	else
		SetRichPresence((Config.RichPresence):format(GetPlayerServerId(player), data['PlayerName'], Config.PlayerText, data['ActivePlayers'], tostring(Config.PlayerCount)))
	end
end)

Citizen.CreateThread(function()
	while not playerLoaded do
		Citizen.Wait(5)
	end

	while true do
		TriggerServerEvent('DiscordRPC:UpdatePresence')
		Citizen.Wait(Config.ResourceTimer * 1000)
	end
end)