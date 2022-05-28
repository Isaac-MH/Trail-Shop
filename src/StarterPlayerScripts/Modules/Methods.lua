local Knit = require(game:GetService('ReplicatedStorage').Packages.Knit)
local DataService = Knit.GetService("DataService")

local SharedStates = require(script.Parent:WaitForChild("SharedStates"))

local Module = {}

function Module:BuyItem(ItemName)
    return DataService:BuyItem(ItemName)
end

function Module:EquipTrail(TrailName, EquipOrUnequip)
    local Returned = DataService:EquipTrail(TrailName, EquipOrUnequip)

    if typeof(Returned) == "string" then
        SharedStates.EquippedTrail:set(Returned)
    end
end

return Module
