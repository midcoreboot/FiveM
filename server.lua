local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableEvent('policeID', function(source)
	TriggerClientEvent('PoliceID:show', source)
end)

RegisterServerEvent('PoliceID:pickup')
AddEventHandler('PoliceID:pickup', function(playerID)
	local xPlayer = ESX.GetPlayerFromId(playerID)
	if(xPlayer.canCarryItem(policeID, 1)) then
		xPlayer.addInventoryItem(policeID, 1)
	else
		xPlayer.showNotification('Kan inte bära id.')
end)

RegisterServerEvent('PoliceID:open')
AddEventHandler('PoliceID:open', function(ownID,targetID)
	local xPlayer = ESX.GetPlayerFromId(ownID)
	local id = xPlayer.identifier
	local _source = ESX.GetPlayerFromId(targetID).source
	local show = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, job FROM users WHERE identifier = @id', {['@id'] = id},
	function(user)
		if(user[1] ~= nil) then 
			if(ESX.GetPlayerFromId(ownID).job.name == 'cop') then -- needs to check for police jobs
				if(xPlayer.getInventoryItem('policeID').count >= 1) then 
					TriggerClientEvent('PoliceID:open',ownID, user)
				end
			end
		end
	end)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	local xPlayer = ESX.GetPlayerFromId(source)
	if(xPlayer.getInventoryItem('policeID').count >= 1) then
		xPlayer.removeInventoryItem('policeID', 1)
end)

Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(1)
		loc = locations[1]
		DrawMarker(
			loc.marker,
			loc.pos.x,
			loc.pos.y,
			loc.pos.z-0.75,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			loc.scale,
			loc.scale,
			loc.scale,
			loc.rgba[1],
			loc.rgba[2],
			loc.rgba[3],
			loc.rgba[4],
			false,
			true,
			2,
			nil,
			nil,
			false
			)
	end
end)

locations = {
	{
		pos={x=, y=, z=},
		marker=,
		rgba={120,255,120,155},
		scale= 2.0
	}
}