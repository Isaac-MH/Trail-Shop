local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed 
local Spring = Fusion.Spring 

return function(props)
    local IsFrameOpen = props.ButtonState

    local SizeComputed = Computed(function()
        if IsFrameOpen:get() then
            return UDim2.fromScale(0.2097, 0.5234)
        else
            return UDim2.fromScale(0, 0)
        end       
    end)

    return New "Frame" {
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
				Position = UDim2.fromScale(1.2672, 0.3188);
				Size = UDim2.fromScale(0.7417, 0.3494);
				AutoButtonColor = false;
				Font = Enum.Font.GothamBold;
				Text = "";
				TextColor3 = Color3.new();
				TextSize = 41;
				TextWrapped = true;
				
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
						Text = props.Price.."RBX";
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