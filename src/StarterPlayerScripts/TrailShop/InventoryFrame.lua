local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed 
local Spring = Fusion.Spring
local OnEvent = Fusion.OnEvent
local ComputedPairs = Fusion.ComputedPairs

local Components = script.Parent:WaitForChild("Components")
local ChildComponent = require(Components:WaitForChild("InventoryItem"))

local SharedStates = require(script.Parent.Parent:WaitForChild("Modules"):WaitForChild("SharedStates"))
local InventoryState = SharedStates.Inventory

local SharedModules = ReplicatedStorage.Modules
local ItemsInformation = require(SharedModules.ItemsInformation)

return function(props)
	local Open = props.State 
	
	local PositionComputed = Computed(function()
		if Open:get() then
			return UDim2.fromScale(0.5, 0.498)
		else
			return UDim2.fromScale(0.5, -0.35)
		end
	end)
	
	local Childs = ComputedPairs(InventoryState, function(Key, Value)
		return ChildComponent {
			Name = Value;
			GradientColor = ItemsInformation[Value].GradientColor;
		}
	end)
	
	return New "Frame" {
		Name = "InventoryFrame";
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundColor3 = Color3.fromRGB(255, 170, 0);
		Position = Spring(PositionComputed, 25, 0.5);
		Size = UDim2.fromScale(0.2975, 0.6261);
		
		[Children] = {
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Thickness = 3
			};
			New "TextLabel" {
				Name = "MoneyTrails";
				BackgroundColor3 = Color3.fromRGB(217, 145, 0);
				Position = UDim2.fromScale(0.1707, 0.0545);
				Size = UDim2.fromScale(0.6549, 0.1134);
				Font = Enum.Font.GothamBold;
				Text = "Inventory";
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
			New "Frame" {
				Name = "MoneyTrailsFrame";
				AnchorPoint = Vector2.new(0.5, 0.5);
				BackgroundColor3 = Color3.fromRGB(217, 145, 0);
				Position = UDim2.fromScale(0.5002, 0.5666);
				Size = UDim2.fromScale(0.9224, 0.7463);
				
				[Children] = {
					New "UICorner" {
						CornerRadius = UDim.new(0.02, 0)
					};
					New "UIStroke" {
						ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
						Thickness = 3
					};
					New "ScrollingFrame" {
						Active = true;
						BackgroundColor3 = Color3.new(1, 1, 1);
						BackgroundTransparency = 1;
						BorderColor3 = Color3.new(1, 1, 1);
						BorderSizePixel = 0;
						Size = UDim2.fromScale(1, 1);
						
						[Children] = {
							New "UIGridLayout" {
								SortOrder = Enum.SortOrder.LayoutOrder;
								CellPadding = UDim2.fromScale(0.05, 0.13);
								CellSize = UDim2.new(0.28, 0, 0.15, 9)
							};
							
							New "UIPadding" {
								PaddingLeft = UDim.new(0.03, 0);
								PaddingTop = UDim.new(0.03, 0)
							};

							Childs;
						};
					};
				}
			};
			
			props[Children]
		}
	}
end