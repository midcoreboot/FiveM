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
		xPlayer.showNotification('Could not carry id')
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
					TriggerClientEvent('PoliceID:open', _source, user)
				end
			end
		end
	end)
end)