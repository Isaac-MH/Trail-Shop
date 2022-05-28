local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed
local Spring = Fusion.Spring 
local OnEvent = Fusion.OnEvent

local Components = script.Parent:WaitForChild("Components")
local StoreItem = require(Components:WaitForChild("StoreItem"))
local StoreItemLimited = require(Components:WaitForChild("StoreItemLimited"))

return function(props)
	local Open = props.State

	local PositionComputed = Computed(function()
		if Open:get() then
			return UDim2.fromScale(0.5, 0.498)
		else
			return UDim2.fromScale(0.5, -0.35)
		end
	end)

	return New "Frame" {
		Name = "ShopFrame";
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundColor3 = Color3.fromRGB(85, 170, 127);
		Position = Spring(PositionComputed, 25, 0.5);
		Size = UDim2.fromScale(0.2975, 0.6261);
		
		[Children] = {
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Thickness = 3
			};
			New "Frame" {
				Name = "MoneyTrailsFrame";
				AnchorPoint = Vector2.new(0.5, 0.5);
				BackgroundColor3 = Color3.fromRGB(100, 202, 150);
				Position = UDim2.fromScale(0.5002, 0.3899);
				Size = UDim2.fromScale(0.9224, 0.3928);
				
				[Children] = {
					New "UICorner" {
						CornerRadius = UDim.new(0.02, 0)
					};
					New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
						Thickness = 3
					};

					StoreItem {
						ButtonState = props.ItemsState;

						GradientColor = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 127));
							ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 255, 189))
						});

						Position = UDim2.fromScale(0.746, 0.338);
						Name = "Trail1";
					};

					StoreItem {
						ButtonState = props.ItemsState;

						GradientColor = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(151, 236, 255));
							ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 255, 189))
						});

						Position = UDim2.fromScale(0.497, 0.338); 
						Name = "Trail2";
					};

					StoreItem {
						ButtonState = props.ItemsState;

						GradientColor = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 170, 255));
							ColorSequenceKeypoint.new(1, Color3.fromRGB(127, 255, 189))
						});

						Position = UDim2.fromScale(0.236, 0.338);
						Name = "Trail3";
					};
				}
			};
			New "TextLabel" {
				Name = "MoneyTrails";
				BackgroundColor3 = Color3.fromRGB(100, 202, 150);
				Position = UDim2.fromScale(0.1707, 0.0545);
				Size = UDim2.fromScale(0.6549, 0.1134);
				Font = Enum.Font.GothamBold;
				Text = "Trails";
				TextColor3 = Color3.new(1, 1, 1);
				TextScaled = true;
				
				[Children] = {
					New "UICorner" {
						CornerRadius = UDim.new(0.05, 0)
					};
					New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
						Thickness = 3
					};
					New "UIStroke" {
						Thickness = 2.1
					};
				}
			};
			New "Frame" {
				Name = "RobuxTraIls";
				AnchorPoint = Vector2.new(0.5, 0.5);
				BackgroundColor3 = Color3.fromRGB(100, 202, 150);
				Position = UDim2.fromScale(0.5002, 0.7913);
				Size = UDim2.fromScale(0.9224, 0.3298);
				
				[Children] = {
					StoreItemLimited {
						ButtonState = props.ItemsState;

						GradientColor = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0));
							ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 127))
						});

						Price = 100;
						Position = UDim2.fromScale(0.416, 0.653);
					};
					
					New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
						Thickness = 3
					};
					New "UICorner" {
						CornerRadius = UDim.new(0.05, 0)
					};
					New "TextLabel" {
						Name = "MoneyTrails";
						BackgroundColor3 = Color3.fromRGB(105, 182, 122);
						BackgroundTransparency = 1;
						Position = UDim2.fromScale(0.1176, 0.0766);
						Size = UDim2.fromScale(0.7638, 0.24);
						ZIndex = 2;
						Font = Enum.Font.GothamBold;
						RichText = true;
						Text = "<stroke color=\"#000000\" joins=\"Round\" thickness=\"2.1\" transparency=\"0\"><font color=\"#ffff00\">LIMITED</font> TIME!</stroke>";
						TextColor3 = Color3.new(1, 1, 1);
						TextScaled = true
					};
				}
			};
			New "UICorner" {
				CornerRadius = UDim.new(0.02, 0)
			};
			New "TextButton" {
				Name = "CloseButton";
				BackgroundColor3 = Color3.fromRGB(255, 0, 0);
				Position = UDim2.fromScale(0.8901, 0.035);
				Size = UDim2.fromScale(0.0928, 0.0758);
				AutoButtonColor = false;
				Font = Enum.Font.GothamBold;
				Text = "";
				TextColor3 = Color3.new();
				TextSize = 41;
				TextWrapped = true;
				
				[OnEvent "MouseButton1Click"] = function()
					Open:set(false)	
					props.ItemsState:set(false)
				end;

				[Children] = {
					New "UICorner" {
						CornerRadius = UDim.new(0.1, 0)
					};
					New "TextLabel" {
						BackgroundColor3 = Color3.new(1, 1, 1);
						BackgroundTransparency = 1;
						Size = UDim2.fromScale(1, 1);
						Font = Enum.Font.GothamBold;
						Text = "X";
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
			
			props[Children]
		}
	}
end