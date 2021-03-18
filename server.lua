

RegisterServerEvent('PoliceID:open')
AddEventHandler('PoliceID:open', function(ownID,targetID)
	local id = getplayerfromid(ownID).identifier --change for your implementation
	local _source = getplayerfromid(targetID).source --change
	local show = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, job FROM users WHERE identifier = @id', {['@id'] = id},
	function(user)
		if(user[1] ~= nil) then 
			if(job == 'cop' and checkifplayerhasitem(id) == true ) then --change checkifplayerhasitem for your inventory system
				TriggerClientEvent('PoliceID:open', _source, user)
			end
		end
	end)
end)