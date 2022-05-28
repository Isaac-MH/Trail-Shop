local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local State = Fusion.State
local Computed = Fusion.Computed
local Spring = Fusion.Spring 

--[=[
Name (optional): Name of the instance
BackgrounfColor3: The background color of the button
ShadowColor: The shadow color of the button
Text: Text that will appear on the button
Position: Position of the button
HoverPosition: Position of the button when hovering (Used for a propper hover effect)
FrameState: State of a frame that can get opened by the button
OtherStates: used to close frames that are open!
]=]

return function(props)
	local Hover = State(false)
	
	local Size = Computed(function()
		if Hover:get() == true then
			return UDim2.fromScale(0.12, 0.076)
		else
			return UDim2.fromScale(0.106, 0.076)
		end
	end)
	
	local Position = Computed(function()
		if Hover:get() then
			return props.HoverPosition
		else
			return props.Position
		end
	end)
	
	return New "TextButton" {
		Name = props.Name or "Button";
		BackgroundColor3 = props.BackgroundColor3;
		Position = Spring(Position, 25, 0.5);
		Size = Spring(Size, 25, 0.5);
		AutoButtonColor = false;
		Font = Enum.Font.GothamBold;
		Text = "";
		TextColor3 = Color3.new();
		TextSize = 41;
		TextWrapped = true;
		
		[OnEvent "InputBegan"] = function(InputObj)
			if InputObj.UserInputType == Enum.UserInputType.MouseMovement then
				Hover:set(true)
			end
		end;
		
		[OnEvent "InputEnded"] = function(InputObj)
			if InputObj.UserInputType == Enum.UserInputType.MouseMovement then
				Hover:set(false)
			end
		end;
		
		[OnEvent "MouseButton1Click"] = function()
			--Close other frames
			for _, State in pairs(props.OtherStates) do
				State:set(false)    
			end
			
			--Open the new frame
			props.FrameState:set(not props.FrameState:get())  
			
			if props.ButtonState ~= nil then
				task.wait(0.2)
				props.ButtonState:set(props.FrameState:get())
			end
		end;
		
		[Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0.1, 0)
			};
			New "TextLabel" {
				BackgroundColor3 = Color3.new(1, 1, 1);
				BackgroundTransparency = 1;
				Position = UDim2.fromScale(0.1095, 0.2);
				Size = UDim2.fromScale(0.7745, 0.595);
				Font = Enum.Font.GothamBold;
				Text = props.Text;
				TextColor3 = Color3.new(1, 1, 1);
				TextScaled = true;
				
				[Children] = {
					New "UIStroke" {
						Thickness = 2.1
					}
				}
			};
			New "Frame" {
				BackgroundColor3 = props.ShadowColor;
				Position = UDim2.fromScale(0, 0.835);
				Size = UDim2.fromScale(1, 0.165);
				
				[Children] = {
					New "UICorner" {
						CornerRadius = UDim.new(0, 5)
					}
				}
			};
			New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Thickness = 3
			}
		};
	};
end