local Knit = require(game:GetService('ReplicatedStorage').Packages.Knit)

Knit.Start({ServicePromises = false}):andThen(function()
    for _, Module in pairs(script.Parent:WaitForChild("Modules"):GetChildren()) do
        require(Module)
    end

    --Create the gui
    require(script.Parent:WaitForChild("TrailShop"))
end):catch(warn)