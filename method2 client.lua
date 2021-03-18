local open = false

RegisterNetEvent('PoliceID:open')
AddEventHandler('PoliceID:open', function(data)
	open = true
	SendNUIMessage({
		action = "open",
		user = data
	})
end)

--Commands	
RegisterNetEvent('PoliceID:show')
AddEventHandler("PoliceID:show", function(source)
		if(getplayerjob() == 'police') then --change
			local ped = GetPedInFront()
			if ped ~= 0 then
				local target = GetPlayerFromPed(ped)
				if target ~= -1 then
					local targetSID = GetPlayerFromServerId(target)
					TriggerServerEvent('PoliceID:open', GetPlayerFromServerId(PlayerId()), GetPlayerFromServerId(targetSID))
				else
					--no target
				end
			else
				--notarget
			end
		end
	end) --change



function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function GetPlayerFromPed(ped)
	for a = 0, 64 do
		if GetPlayerPed(a) == ped then
			return a
		end
	end
	return -1
end