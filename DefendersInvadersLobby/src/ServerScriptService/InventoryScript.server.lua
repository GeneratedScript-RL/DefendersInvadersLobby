local RS = game.ReplicatedStorage
local remoteEmpty = RS:WaitForChild("EmptySlot")
local troopsmodule = require(RS.Troops)

local Slots = {"Slot1", "Slot2", "Slot3", "Slot4", "Slot5"}

function FindEmptySlot(player)
	for i, v in ipairs(Slots) do
		if player:WaitForChild(v).Value == "Empty" then
			return v
		end
	end
end

function FindSlot(player, str)
	local hasfound = false
	for i_, v_ in ipairs(Slots) do
		if player:WaitForChild(v_).Value == str then
			hasfound = true
		end
	end
	return hasfound
end

remoteEmpty.OnServerEvent:Connect(function(player, slot)
	player:FindFirstChild(slot).Value = "Empty"
end)

RS.Purchase.OnServerEvent:Connect(function(player, Troop)
	
	if troopsmodule.TroopsStats[Troop].Cost == "Free" then

		local TroopOwned = Instance.new("BoolValue")
		TroopOwned.Value = true
		TroopOwned.Parent = player
		TroopOwned.Name = Troop
		
	else
		if player.Credits.Value >= troopsmodule.TroopsStats[Troop].Cost then
			player.Credits.Value -= troopsmodule.TroopsStats[Troop].Cost

			local TroopOwned = Instance.new("BoolValue")
			TroopOwned.Value = true
			TroopOwned.Parent = player
			TroopOwned.Name = Troop
		end
	end
	
end)

RS.EquipTroop.OnServerEvent:Connect(function(player, Troop)
	
	if player:FindFirstChild(Troop) then
		if FindSlot(player, Troop) == false then
			player:FindFirstChild(FindEmptySlot(player)).Value = Troop
		end
	end
	
end)