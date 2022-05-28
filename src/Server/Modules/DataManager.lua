local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)
local DataService 

local TrailMethods = require(Knit.SharedModules.TrailSystem)

local DataTemplate = {
	["Money"] = 100;
	["Inventory"] = {}; --The trails get stored here!
    ["EquippedTrail"] = ""; --Last equiped trail
}

local ProfileService = require(Knit.SharedModules.ProfileService)
local ProfileStore = ProfileService.GetProfileStore("PlayerDatav1.1", DataTemplate)

local Manager = {}
local Profiles = {}

local function LoadData(Player, Profile)
    --Profiles[Player].Data = DataTemplate

	local PlayerData = Profile.Data
	DataService.Client.UpdateData:Fire(Player, PlayerData) --Sync the data with the client
end

function Manager:GetPlayerInv(Player)
    local PlayerProfile = Profiles[Player]
    return PlayerProfile.Data.Inventory or nil     
end

function Manager:UpdateEquipedTrail(Player, TrailName)
    Profiles[Player].Data.EquippedTrail = TrailName
end

function Manager:BuyItem(Player, ItemName)
	local PlayerProfile = Profiles[Player]
	local ItemInfo = require(Knit.SharedModules.ItemsInformation)[ItemName]

	if not table.find(PlayerProfile.Data, ItemName) and PlayerProfile.Data.Money >= ItemInfo.Price then -- if the item is not in the plr inventory and have the money
		PlayerProfile.Data.Money -= ItemInfo.Price 
		table.insert(PlayerProfile.Data.Inventory, ItemName)

		LoadData(Player, PlayerProfile)
		return true
	elseif not (PlayerProfile.Data.Money >= ItemInfo.Price) and not table.find(PlayerProfile.Data.Inventory, ItemName) then --if player dont have money and not own the item
		return false
	else 
		return nil --Player already own the item 
	end
end

function Manager:LoadProfile(Player)
	local PlayerProfile = ProfileStore:LoadProfileAsync("Player_"..Player.UserId)

	if PlayerProfile ~= nil then
		PlayerProfile:AddUserId(Player.UserId)

		PlayerProfile:ListenToRelease(function()
			Profiles[Player] = nil
			Player:Kick()-- The profile could've been loaded on another Roblox server:
		end)

		if Player:IsDescendantOf(Players) == true then
			Profiles[Player] = PlayerProfile

			-- A profile has been successfully loaded:            
			LoadData(Player, PlayerProfile)
		else
			-- Player left before the profile loaded:
			PlayerProfile:Release()
		end
	else
		Player:Kick("Your data is still loaded on another server, please re-join")
	end
end

function Manager:UnloadProfile(Player)
	local PlayerProfile = Profiles[Player]
	PlayerProfile:Release()
end

function Manager:Init()
	DataService = Knit.GetService("DataService")

	-- In case Players have joined the server earlier than this script ran
	for _, Player in pairs(Players:GetPlayers()) do
		task.spawn(function()
			Manager:LoadProfile(Player)
		end)
	end

	Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAppearanceLoaded:Connect(function(Character)
            local PlayerProfile = Profiles[Player]

            if PlayerProfile.Data.EquippedTrail ~= "" then
                TrailMethods:TrailMethod(Player, true, PlayerProfile.Data.EquippedTrail)
                LoadData(Player, PlayerProfile)
            end
        end)

        Manager:LoadProfile(Player)
	end) 

	Players.PlayerRemoving:Connect(function(Player)
		Manager:UnloadProfile(Player)
	end)    
end

return Manager