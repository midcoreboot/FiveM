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
	local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestPlayerDistance > 3.0 then
		ESX.ShowNotification('Inga spelare nära dig')
	else
		TriggerServerEvent('PoliceId:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
	end
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)

--CHANGE KEY
