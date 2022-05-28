local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring 
local OnEvent = Fusion.OnEvent
local State = Fusion.State 

local Methods = require(script.Parent.Parent.Parent:WaitForChild("Modules"):WaitForChild("Methods"))

local SharedStates = require(script.Parent.Parent.Parent:WaitForChild("Modules"):WaitForChild("SharedStates"))
local InventoryState = SharedStates.Inventory

local SharedModules = ReplicatedStorage.Modules
local ItemsInformation = require(SharedModules.ItemsInformation)

return function(props)
    if not ItemsInformation[props.Name].Price then
        warn("Cant find the information for the item: ", props.Name)
        return 
    end
    
    local Price = ItemsInformation[props.Name].Price
    local NoMoneyActivated = State(Color3.new(1,1,1))
    local SmoothColor = Spring(NoMoneyActivated)
    local IsFrameOpen = props.ButtonState
    
    local SizeComputed = Computed(function()
        if IsFrameOpen:get() then
            return UDim2.fromScale(0.2097, 0.5234)
        else
            return UDim2.fromScale(0, 0)
        end       
    end)
    
    local Txt = Computed(function()
        if not table.find(InventoryState:get(), props.Name) then
            return Price.."$"
        else
            return "Owned"
        end    
    end)
    
    return New "Frame" {
        Name = props.Name;
        AnchorPoint = Vector2.new(0.5, 0.5);
        BackgroundColor3 = Color3.new(1, 1, 1);
        Position = props.Position;
        Size = Spring(SizeComputed, 25, 0.5);
        
        [Children] = {
            New "UIStroke" {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                Thickness = 3
            };
            New "UICorner" {
                CornerRadius = UDim.new(0.02, 0)
            };
            New "TextButton" {
                Name = "ShopButton";
                BackgroundColor3 = Color3.fromRGB(23, 191, 96);
                Position = UDim2.fromScale(0.1213, 1.1599);
                Size = UDim2.fromScale(0.7417, 0.3494);
                AutoButtonColor = false;
                Font = Enum.Font.GothamBold;
                Text = "";
                
                TextColor3 = Color3.new();
                
                TextSize = 41;
                TextWrapped = true;
                
                [OnEvent "MouseButton1Click"] = function()
                    if Txt:get() == "Owned" then
                        return
                    end
                    
                    if Methods:BuyItem(props.Name) == false then
                        NoMoneyActivated:set(Color3.new(1,0,0)) --Red color = true, Normal = false
                        task.wait(1)
                        NoMoneyActivated:set(Color3.new(1,1,1))
                    end
                end;
                
                [Children] = {
                    New "UICorner" {
                        CornerRadius = UDim.new(0.1, 0)
                    };
                    New "TextLabel" {
                        BackgroundColor3 = Color3.new(1, 1, 1);
                        BackgroundTransparency = 1;
                        Size = UDim2.fromScale(1, 1);
                        ZIndex = 0;
                        Font = Enum.Font.GothamBold;
                        Text = Txt;
                        TextColor3 = SmoothColor;
                        TextScaled = true;
                        
                        [Children] = {
                            New "UIStroke" {
                                Thickness = 2.1
                            };
                        }
                    };
                    New "UIStroke" {
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                        Thickness = 3
                    };
                }
            };
            New "UIGradient" {
                Color = props.GradientColor;
            };
        }
    }
end

--[[
ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 127));
    ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 255, 189))
})
]]