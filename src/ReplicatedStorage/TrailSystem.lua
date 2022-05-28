local Module = {}
local Trails = game:GetService("ServerStorage"):WaitForChild("Trails")

local function UnequipTrails(Player)
    if not Player.Character then
        return 
    end
    
    for _, Trail in pairs(Player.Character:GetChildren()) do
        if Trail:IsA("Trail") then
            Trail:Destroy()
        end
    end

    task.spawn(function()
        for _, Att in pairs(Player.Character.HumanoidRootPart:GetChildren()) do
            if Att.Name == "TrailAtt" then
                Att:Destroy()
            end
        end    
    end)    
    
    return ""     
end

function Module:TrailMethod(Player, Action, TrailName)
    if Action then --Equip the trail
        UnequipTrails(Player)
        
        local Trail = Trails:FindFirstChild(TrailName)
        
        if Trail then
            local Character = Player.Character
            local NewTrail = Trail:Clone()
            
            NewTrail.Parent = Character
            
            local Attachment0 = Instance.new("Attachment")
            Attachment0.Parent = Character.HumanoidRootPart
            Attachment0.Name = "TrailAtt"
            
            local Attachment1 = Instance.new("Attachment")
            Attachment1.Parent = Character.HumanoidRootPart
            Attachment1.Name = "TrailAtt"
            Attachment1.Position = Attachment1.Position + Vector3.new(0,1,0)
            
            NewTrail.Attachment0 = Attachment0
            NewTrail.Attachment1 = Attachment1
            
            return TrailName
        else
            print("SERVER: cant get the trail asset ".."("..TrailName..")")
        end
    else --Unequip the trail
        return UnequipTrails(Player)
    end    
end

return Module