local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent 
local Computed = Fusion.Computed

local Methods = require(script.Parent.Parent.Parent:WaitForChild("Modules"):WaitForChild("Methods"))

local SharedStates = require(script.Parent.Parent.Parent:WaitForChild("Modules"):WaitForChild("SharedStates"))
local EquippedTrailState = SharedStates.EquippedTrail

return function(props)
	local Txt = Computed(function()
		if EquippedTrailState:get() == props.Name then
			return "UNEQUIP"
		else
			return "EQUIP"	
		end
	end)
	
	return New "Frame" {
		Name = props.Name;
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundColor3 = Color3.new(1, 1, 1);
		Position = UDim2.fromScale(0.1244, 0.0741);
		Size = UDim2.fromScale(0.2488, 0.1481);
		
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
					if Txt:get() == "UNEQUIP" then
						Methods:EquipTrail(props.Name, false)
					elseif Txt:get() == "EQUIP" then
						Methods:EquipTrail(props.Name, true)
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
						TextColor3 = Color3.new(1, 1, 1);
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
			
			props[Children]
		}
	}
end