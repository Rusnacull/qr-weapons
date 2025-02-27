local QRCore = exports['qr-core']:GetCoreObject()
local currentSerial = nil
local UsedWeapons = {}

RegisterNetEvent('qr-weapons:client:UseWeapon', function(weaponData, shootbool)
    local ped = PlayerPedId()
    local weaponName = tostring(weaponData.name)
    local hash = GetHashKey(weaponData.name)
    if not UsedWeapons[tonumber(hash)] then
        UsedWeapons[tonumber(hash)] = {
            name = weaponData.name,
            WeaponHash = hash,
            data = weaponData,
            serie = weaponData.info.serie,
        }
        if weaponName == 'weapon_bow' or weaponName == 'weapon_bow_improved' then
            if weaponData.info.ammo == nil then
				local hasItem = QRCore.Functions.HasItem('ammo_arrow', 1)
                if hasItem then
                    weaponData.info.ammo = Config.AmountArrowAmmo
                    weaponData.info.ammoclip = Config.AmountArrowAmmo
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_arrow')
                else
                    weaponData.info.ammo = 0
                    weaponData.info.ammoclip = 0
					QRCore.Functions.Notify('no arrows in your inventory to load', 'error')
                end
            elseif weaponData.info.ammo == 0 then
				local hasItem = QRCore.Functions.HasItem('ammo_arrow', 1)
                if hasItem then
                    weaponData.info.ammo = Config.AmountArrowAmmo
                    weaponData.info.ammoclip = Config.AmountArrowAmmo
                    TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_arrow')
                else
                    weaponData.info.ammo = 0
                    weaponData.info.ammoclip = 0
					QRCore.Functions.Notify('no arrows in your inventory to load', 'error')
                end
            end
            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 0, false, true)
        else
            if weaponData.info.ammo == nil then
                weaponData.info.ammo = 0
                weaponData.info.ammoclip = 0
            end
            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 0, false, true)
        end
        if weaponName == 'weapon_bow' or weaponName == 'weapon_bow_improved' then
            SetPedAmmo(ped, hash, weaponData.info.ammo)
        else
            SetPedAmmo(ped, hash, weaponData.info.ammo - weaponData.info.ammoclip)
            SetAmmoInClip(ped, hash, weaponData.info.ammoclip)
        end
        SetCurrentPedWeapon(ped,hash,true)
    else
        local ammo = GetAmmoInPedWeapon(PlayerPedId(), hash)
        local ammobool, ammoclip = GetAmmoInClip(PlayerPedId(),hash)
		TriggerServerEvent('qr-weapons:server:SaveAmmo', weaponData.info.serie, ammo, ammoclip)
        RemoveWeaponFromPed(ped,hash)
        UsedWeapons[tonumber(hash)] = nil
    end
	currentSerial = weaponData.info.serie
end)

-- load ammo
RegisterNetEvent('qr-weapons:client:AddAmmo', function(ammotype, amount, ammo)
    local ped = PlayerPedId()
    local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
	local weapongroup = GetWeapontypeGroup(weapon)
	local currentSerial = currentSerial
	if Config.Debug == true then
		print(weapon)
		print(weapongroup)
		print(currentSerial)
	end
	if currentSerial ~= nil then
		if weapongroup == -1101297303 then -- revolver weapon group
			local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
			if total + (amount/2) < Config.MaxRevolverAmmo then
				if QRCore.Shared.Weapons[weapon] then
					Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6)
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_revolver')
				end
			else
				QRCore.Functions.Notify('Max Ammo Capacity', 'error')
			end
		elseif weapongroup == 416676503 then -- pistol weapon group
			local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
			if total + (amount/2) < Config.MaxPistolAmmo then
				if QRCore.Shared.Weapons[weapon] then
					Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6)
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_pistol')
				end
			else
				QRCore.Functions.Notify('Max Ammo Capacity', 'error')
			end
		elseif weapongroup == -594562071 then -- repeater weapon group
			local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
			if total + (amount/2) < Config.MaxRepeaterAmmo then
				if QRCore.Shared.Weapons[weapon] then
					Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6)
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_repeater')
				end
			else
				QRCore.Functions.Notify('Max Ammo Capacity', 'error')
			end
		elseif weapongroup == 970310034 then -- rifle weapon group
			local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
			if total + (amount/2) < Config.MaxRifleAmmo then
				if QRCore.Shared.Weapons[weapon] then
					Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6)
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_rifle')
				end
			else
				QRCore.Functions.Notify('Max Ammo Capacity', 'error')
			end
		elseif weapongroup == -1212426201 then -- sniper rifle weapon group
			local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
			if total + (amount/2) < Config.MaxRifleAmmo then
				if QRCore.Shared.Weapons[weapon] then
					Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6)
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_rifle')
				end
			else
				QRCore.Functions.Notify('Max Ammo Capacity', 'error')
			end
		elseif weapongroup == 860033945 then -- shotgun weapon group
			local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
			if total + (amount/2) < Config.MaxShotgunAmmo then
				if QRCore.Shared.Weapons[weapon] then
					Citizen.InvokeNative(0x106A811C6D3035F3, ped, GetHashKey(ammotype), amount, 0xCA3454E6)
					TriggerServerEvent('qr-weapons:server:removeWeaponAmmoItem', 'ammo_shotgun')
				end
			else
				QRCore.Functions.Notify('Max Ammo Capacity', 'error')
			end
		else
			QRCore.Functions.Notify('wrong ammo for weapon!', 'error')
		end
    else
		QRCore.Functions.Notify('you are not holding a weapon!', 'error')
    end
end)

-- throwable weapons
RegisterNetEvent('qr-weapons:client:usethrowable', function(weapon, ammoCount, attachPoint)
	local ped = PlayerPedId()
    local addReason = GetHashKey('ADD_REASON_DEFAULT')
    local weaponHash = GetHashKey(weapon)
    -- request weapon asset
    Citizen.InvokeNative(0x72D4CB5DB927009C, weaponHash, 0, true)
    Wait(1000)
    -- give weapon to ped
    Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, ammoCount, true, false, attachPoint, true, 0.0, 0.0, addReason, true, 0.0, false)
end)

-- update ammo loop
CreateThread(function()
    while true do
        Wait(1000)
		local ped = PlayerPedId()
		local heldWeapon = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
		local getammo = GetAmmoInPedWeapon(ped, heldWeapon)
		local getammoclip = GetAmmoInClip(ped, heldWeapon)
		if currentSerial ~= nil and heldWeapon ~= -1569615261 then
			TriggerServerEvent('qr-weapons:server:SaveAmmo', currentSerial, tonumber(getammo), tonumber(getammoclip))
		end		
	end
end)
