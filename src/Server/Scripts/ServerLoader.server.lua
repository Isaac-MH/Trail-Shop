local Knit = require(game:GetService("ReplicatedStorage").Packages.Knit)

-- Load all services and modules:
Knit.Modules = script.Parent.Parent:WaitForChild("Modules")
Knit.SharedModules = game:GetService("ReplicatedStorage"):WaitForChild("Modules")

Knit.AddServices(script.Parent.Parent:waitForChild("Services"))

Knit.Start():andThen(function()
    require(Knit.Modules.DataManager):Init()
end):catch(warn)