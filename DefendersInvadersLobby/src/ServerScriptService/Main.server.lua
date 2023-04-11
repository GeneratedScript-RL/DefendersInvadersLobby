local DataStore = game:GetService("DataStoreService")
local PlayerGameInfo = DataStore:GetDataStore("PlayerGameInfo")
local replicated = game.ReplicatedStorage
local module = require(replicated.Troops)
local TroopsTable = module.Troops

game.Players.PlayerAdded:Connect(function(player)
	
	local Info = {
		Credits = 0,
		Slot1 = "Soldier",
		Slot2 = "Empty",
		Slot3 = "Empty",
		Slot4 = "Empty",
		Slot5 = "Empty",
		Inventory = {}
	}
	
	local success, err = pcall(function()
		Info = PlayerGameInfo:GetAsync(player.UserId)
	end)
	if not Info then
		Info = {
			Credits = 0,
			Slot1 = "Soldier",
			Slot2 = "Empty",
			Slot3 = "Empty",
			Slot4 = "Empty",
			Slot5 = "Empty",
			Inventory = {}
		}
	end
	
	local Credits = Instance.new("NumberValue")
	Credits.Name = 'Credits'
	Credits.Parent = player
	Credits.Value = Info.Credits
	
	for i, v in ipairs(Info.Inventory) do
		local TroopOwned = Instance.new("BoolValue")
		TroopOwned.Value = true
		TroopOwned.Parent = player
		TroopOwned.Name = v
	end
	
	local SlotsCreated = 1
	repeat 
		
		local Slot = Instance.new("StringValue")
		Slot.Name = 'Slot'..SlotsCreated
		Slot.Parent = player
		Slot.Value = Info[Slot.Name]
		SlotsCreated = SlotsCreated + 1
		
	until SlotsCreated == 6
	
	
	
end)

game.Players.PlayerRemoving:Connect(function(player)
	local playerInventory = {}
	
	for i, v in ipairs(TroopsTable) do
		if player:FindFirstChild(v) then
			table.insert(playerInventory, v)
		end
	end
	
	local savedInfo = {
		Credits = player:FindFirstChild("Credits").Value,
		Slot1 = player:FindFirstChild("Slot1").Value,
		Slot2 = player:FindFirstChild("Slot2").Value,
		Slot3 = player:FindFirstChild("Slot3").Value,
		Slot4 = player:FindFirstChild("Slot4").Value,
		Slot5 = player:FindFirstChild("Slot5").Value,
		Inventory = playerInventory,
	}
	
	local success, errorMessage = pcall(function()
		PlayerGameInfo:SetAsync(player.UserId, savedInfo)
	end)
	
	if not success then
		print(errorMessage)
	end
	
end)