local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local State = Fusion.State 

local States = {
    Money = State(0);
    Inventory = State({});
    EquippedTrail = State("")
}

return States