local VorpCore = {}
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

VORP = exports.vorp_core:vorpAPI()
local VORP_API = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_hunting:giveReward")
AddEventHandler("vorp_hunting:giveReward", function(givenItem, money, gold, rolPoints, xp, givenAmount)
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    if #givenItem ~= #givenAmount then 
        print('Error: Please ensure givenItem and givenAmount have the same length in the items config.')
    elseif givenItem ~= nil then
        for k,v in pairs(givenItem) do 
            local nmb = 0
            
            if givenAmount[k] > 0 then
                nmb = qty
            else
                nmb = math.random(Config.ItemQuantity.Min, Config.ItemQuantity.Max)
            end

            VorpInv.addItem(_source, v, nmb)
        end
        if money ~= 0 then 
            Character.addCurrency(0, money)
        end
        if gold ~= 0 then 
            Character.addCurrency(1, gold)
        end
        if rolPoints ~= 0 then 
            Character.addCurrency(2, rolPoints)
        end
        if xp ~= 0 then 
            Character.addXp(xp)
        end
    end
end)


VORP.addNewCallBack('vorp_hunting:getjob', function(source, cb)
    local _source = source
    local User = VorpCore.getUser(source) -- Return User with functions and all characters
    local Character = VorpCore.getUser(source).getUsedCharacter
    local job = Character.job
    cb(job)
end)