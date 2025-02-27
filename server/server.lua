local QRCore = exports['qr-core']:GetCoreObject()

-- start of use ammo

QRCore.Functions.CreateUseableItem('ammo_revolver', function(source, item)
    TriggerClientEvent('qr-weapons:client:AddAmmo', source, 'AMMO_REVOLVER', Config.AmountRevolverAmmo, item)
end)

QRCore.Functions.CreateUseableItem('ammo_pistol', function(source, item)
    TriggerClientEvent('qr-weapons:client:AddAmmo', source, 'AMMO_PISTOL', Config.AmountPistolAmmo, item)
end)

QRCore.Functions.CreateUseableItem('ammo_repeater', function(source, item)
    TriggerClientEvent('qr-weapons:client:AddAmmo', source, 'AMMO_REPEATER', Config.AmountRepeaterAmmo, item)
end)

QRCore.Functions.CreateUseableItem('ammo_rifle', function(source, item)
    TriggerClientEvent('qr-weapons:client:AddAmmo', source, 'AMMO_RIFLE', Config.AmountRifleAmmo, item)
end)

QRCore.Functions.CreateUseableItem('ammo_shotgun', function(source, item)
    TriggerClientEvent('qr-weapons:client:AddAmmo', source, 'AMMO_SHOTGUN', Config.AmountShotgunAmmo, item)
end)

-- end of use ammo

-- use throwables

-- dynamitestick
QRCore.Functions.CreateUseableItem('dynamitestick', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_dynamite', 1, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['dynamitestick'], 'remove')
    end
end)

-- poisonbottle
QRCore.Functions.CreateUseableItem('poisonbottle', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_poisonbottle', 1, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['poisonbottle'], 'remove')
    end
end)

-- molotov
QRCore.Functions.CreateUseableItem('molotov', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_molotov', 1, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['molotov'], 'remove')
    end
end)

-- throwing_knives
QRCore.Functions.CreateUseableItem('throwing_knives', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_throwing_knives', 3, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['throwing_knives'], 'remove')
    end
end)

-- tomahawk
QRCore.Functions.CreateUseableItem('tomahawk', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_tomahawk', 3, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['tomahawk'], 'remove')
    end
end)

-- bolas
QRCore.Functions.CreateUseableItem('bolas', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_bolas', 3, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['bolas'], 'remove')
    end
end)

-- bolas_hawkmoth
QRCore.Functions.CreateUseableItem('bolas_hawkmoth', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_bolas_hawkmoth', 3, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['bolas_hawkmoth'], 'remove')
    end
end)

-- bolas_ironspiked
QRCore.Functions.CreateUseableItem('bolas_ironspiked', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_bolas_ironspiked', 3, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['bolas_ironspiked'], 'remove')
    end
end)

-- bolas_intertwined
QRCore.Functions.CreateUseableItem('bolas_intertwined', function(source, item)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('qr-weapons:client:usethrowable', src, 'weapon_thrown_bolas_intertwined', 3, 0)
		TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items['bolas_intertwined'], 'remove')
    end
end)

-- end of use throwables

-- save ammo
RegisterNetEvent('qr-weapons:server:SaveAmmo', function(serie, ammo, ammoclip)
	local src = source
	local Player = QRCore.Functions.GetPlayer(src)
    local svslot = nil
    local itemData
    for v,k in pairs(Player.PlayerData.items) do
		if k.type == 'weapon' then
			if ''..k.info.serie..'' == ''..serie..'' then
				svslot = k.slot
				itemData = Player.Functions.GetItemBySlot(svslot)
				itemData.info.ammo = ammo
				itemData.info.ammoclip = ammoclip
				Player.Functions.RemoveItem(itemData.name, itemData.amount, slot)
				Player.Functions.AddItem(itemData.name, itemData.amount, slot, itemData.info)
			end
		end
    end
end)

-- remove ammo from player
RegisterServerEvent('qr-weapons:server:removeWeaponAmmoItem')
AddEventHandler('qr-weapons:server:removeWeaponAmmoItem', function(ammoitem)
	local src = source
    local Player = QRCore.Functions.GetPlayer(src)
	Player.Functions.RemoveItem(ammoitem, 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QRCore.Shared.Items[ammoitem], 'remove')
	QRCore.Functions.Notify(src, 'Weapon Reloaded', 'success')
end)