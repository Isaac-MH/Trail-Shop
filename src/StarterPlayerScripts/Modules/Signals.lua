local module = {}

local Player = game.Players.LocalPlayer

local Knit = require(game:GetService('ReplicatedStorage').Packages.Knit)
local DataService = Knit.GetService("DataService")

local SharedStates = require(script.Parent.Parent:WaitForChild("Modules"):WaitForChild("SharedStates"))

DataService.UpdateData:Connect(function(Data)
    SharedStates.Money:set(Data.Money)
    SharedStates.Inventory:set(Data.Inventory)
    SharedStates.EquippedTrail:set(Data.EquippedTrail)
end)

return module