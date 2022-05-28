local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)
local DataService = Knit.CreateService{Name = "DataService"; Client = {UpdateData = Knit.CreateSignal();}}

local DataManager = require(Knit.Modules.DataManager)
local TrailMethods = require(Knit.SharedModules.TrailSystem)

function DataService.Client:BuyItem(Player, ItemName)
    local ItemInfo = require(Knit.SharedModules.ItemsInformation)[ItemName]
    assert(ItemInfo ~= nil, "Cant find the item information ("..ItemName..")")
    
    return DataManager:BuyItem(Player, ItemName)
end

function DataService.Client:EquipTrail(Player, TrailName, EquipOrUnequipp)
    local PlayerInventory = DataManager:GetPlayerInv(Player)
    assert(PlayerInventory ~= nil, "Server: get the player inventory")
    
    if table.find(PlayerInventory, TrailName) then
        local Returned = TrailMethods:TrailMethod(Player, EquipOrUnequipp, TrailName)
        DataManager:UpdateEquipedTrail(Player, Returned)
        TrailMethods:TrailMethod(Player, EquipOrUnequipp, Returned)
        return Returned
    end
end

return DataService 