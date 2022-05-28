local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local State = Fusion.State 
local Computed = Fusion.Computed
local Spring = Fusion.Spring 

local Player = Players.LocalPlayer
local PlayerGui = Player.PlayerGui

local Components = script:WaitForChild("Components")
local ButtonComponent = require(Components:WaitForChild("Button"))

local ShopFrameInstance = require(script:WaitForChild("ShopFrame"))
local InventoryFrameInstance = require(script:WaitForChild("InventoryFrame"))

local ShopState = State(false) -- open: true, closed: false
local InventoryState = State(false) 
local ButtonState = State(false)

local SharedStates = require(script.Parent:WaitForChild("Modules"):WaitForChild("SharedStates"))
local SmoothMoney = Spring(SharedStates.Money)

New "ScreenGui" {
	Name = "TrailShop";
	Parent = PlayerGui;
	ResetOnSpawn = false;
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	IgnoreGuiInset = true;

	[Children] = {
		ButtonComponent {
			Name = "ShopButton";
			BackgroundColor3 = Color3.fromRGB(23, 191, 96);
			ShadowColor = Color3.fromRGB(20, 172, 83);
			Text = "Shop";
			Position = UDim2.fromScale(0.0182, 0.4657);
			HoverPosition = UDim2.fromScale(0.011, 0.466);
			FrameState = ShopState;
			OtherStates = {InventoryState};
			ButtonState = ButtonState;
		};

		ButtonComponent {
			Name = "InventoryButton";
			BackgroundColor3 = Color3.fromRGB(255, 170, 0);
			ShadowColor = Color3.fromRGB(217, 145, 0);
			Text = "Inventory";
			Position = UDim2.fromScale(0.0182, 0.5617);
			HoverPosition = UDim2.fromScale(0.011, 0.565);
			FrameState = InventoryState;
			OtherStates = {ShopState, ButtonState};
		};

		ShopFrameInstance {
			State = ShopState;
			ItemsState = ButtonState;
		};

        InventoryFrameInstance{
            State = InventoryState;
        };

		New "TextButton" {
			Name = "MoneyCounter";
			BackgroundColor3 = Color3.fromRGB(138, 207, 207);
			Position = UDim2.fromScale(0.0113, 0.3602);
			Size = UDim2.fromScale(0.1204, 0.084);
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
					Position = UDim2.fromScale(0.084, 0.1796);
					Size = UDim2.fromScale(0.8255, 0.6341);
					Font = Enum.Font.GothamBold;
					RichText = true;

					Text = Computed(function()
						return '<stroke color=\"#000000\" joins=\"Round\" thickness=\"2.1\" transparency=\"0\">'..'<font color=\"#14ac53\">'.."$"..'</font>'..math.round(SmoothMoney:get())..'</stroke>';
					end);

					TextColor3 = Color3.new(1, 1, 1);
					TextScaled = true;

					[Children] = {
						New "UIStroke" {
							Thickness = 2.1
						}
					}
				};
				New "UIStroke" {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
					Thickness = 3
				}
			}
		};
	}
}

return true