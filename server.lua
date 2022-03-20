local QBCore = exports['qb-core']:GetCoreObject()

-- Lista de animais

local animals = {
    [1] = {
        model = "a_c_deer",
        hash = -664053099,
        item = "meatdeer",
        name = "Deer Meat",
        id = 35,
        profit = 1
    },
    [2] = {
        model = "a_c_pig",
        hash = -1323586730,
        item = "meatpig",
        name = "Pig Meat",
        id = 36,
        profit = 1
    },
    [3] = {
        model = "a_c_boar",
        hash = -832573324,
        item = "meatboar",
        name = "Boar Meat",
        id = 37,
        profit = 1
    },
    [4] = {
        model = "a_c_mtlion",
        hash = 307287994,
        item = "meatlion",
        name = "Lion Meat",
        id = 38,
        profit = 1
    },
    [5] = {
        model = "a_c_cow",
        hash = -50684386,
        item = "meatcow",
        name = "Cow Meat",
        id = 39,
        profit = 1
    },
    [6] = {
        model = "a_c_coyote",
        hash = 1682622302,
        item = "meatcoyote",
        name = "Coyote Meat",
        id = 40,
        profit = 1
    },
    [7] = {
        model = "a_c_rabbit_01",
        hash = -541762431,
        item = "meatrabbit",
        name = "Rabbit Meat",
        id = 41,
        profit = 1
    },
    [8] = {
        model = "a_c_pigeon",
        hash = 111281960,
        item = "meatbird",
        name = "Bird Meat",
        id = 42,
        profit = 1
    },
    [9] = {
        model = "a_c_seagull",
        hash = -745300483,
        item = "meatseagull",
        name = "Seagull Meat",
        id = 43,
        profit = 1
    },
	[10] = {
        model = "a_c_cormorant",
        hash = 2141914453,
        item = "meatcormorant",
        name = "Cormorant Meat",
        id = 44,
        profit = 1
    },
    [11] = {
        model = "a_c_chickenhawk",
        hash = 942293100,
        item = "meatchickenhawk",
        name = "Chicken Meat",
        id = 45,
        profit = 1
    },
    [12] = {
        model = "a_c_crow",
        hash = 1326389510,
        item = "meatcrow",
        name = "Corw Meat",
        id = 46,
        profit = 1
	}

}

------

-- Eventos de apanhar os animais

RegisterServerEvent("mt-hunting:server:AddItem")
AddEventHandler("mt-hunting:server:AddItem", function (data, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local data = data
    local amount = 1

    for i = 1, #animals do
        if data == animals[i].id then
            Player.Functions.AddItem(animals[i].item, 1)
        end
    end
end)

------

-- Eventos da loja de caça

RegisterServerEvent('mt-hunting:server:ComprarSniper')
AddEventHandler('mt-hunting:server:ComprarSniper', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1
    local price = 1000

    if Player.Functions.RemoveMoney('bank', price) then
        Player.Functions.AddItem('weapon_sniperrifle', quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["weapon_sniperrifle"], "add")
    else
        QBCore.Functions.Notify('Not enough money on bank balance', 'error') -- [text] = message, [type] = primary | error | success, [length] = time till fadeout
    end
end)

RegisterServerEvent('mt-hunting:server:ComprarBalas')
AddEventHandler('mt-hunting:server:ComprarBalas', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1
    local price = 10

    if Player.Functions.RemoveMoney('bank', price) then
        Player.Functions.AddItem('snp_ammo', quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["snp_ammo"], "add")
    else
        QBCore.Functions.Notify('Not enough money on bank balance', 'error') -- [text] = message, [type] = primary | error | success, [length] = time till fadeout
    end
end)

RegisterServerEvent('mt-hunting:server:ComprarFaca')
AddEventHandler('mt-hunting:server:ComprarFaca', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local quantity = 1
    local price = 500

    if Player.Functions.RemoveMoney('bank', price) then
        Player.Functions.AddItem('weapon_knife', quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["weapon_knife"], "add")
    else
        QBCore.Functions.Notify('Not enough money on bank balance', 'error') -- [text] = message, [type] = primary | error | success, [length] = time till fadeout
    end
end)

------

-- Evento para vender carnes/peles

local ItemList = {
    ["meatdeer"] =  10,
    ["meatpig"] =  20,
    ["meatboar"] =  30,
    ["meatlion"] =  40,
    ["meatcoyote"] =  50,
    ["meatrabbit"] =  60,
    ["meatbird"] =  70,
    ["meatseagull"] =  70,
    ["meatcormorant"] =  70,
    ["meatchickenhawk"] =  70,
    ["meatcrow"] =  70,
    ["meatcow"] =  70,
}

RegisterNetEvent('mt-hunting:server:Vender', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    
    local xItem = Player.Functions.GetItemsByName(ItemList)
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)

        Player.Functions.AddMoney("cash", price, "sold-meat")
            TriggerClientEvent('QBCore:Notify', src, "You sell some meat for $"..price)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont/'t have anything to sell..")
    end
end)

------