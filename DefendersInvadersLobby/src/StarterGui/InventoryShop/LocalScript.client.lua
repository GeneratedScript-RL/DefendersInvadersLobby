local ReplicatedS = game:GetService("ReplicatedStorage")
local player = game.Players.LocalPlayer
local module = require(ReplicatedS.Troops)
local TroopsTable = module.Troops
local TroopsStats = module.TroopsStats
local SelectedTroop = "None"
local shopframe = script.Parent.ShopFrame
local SlotsButtons = {
	script.Parent.Slot1,
	script.Parent.Slot2,
	script.Parent.Slot3,
	script.Parent.Slot4,
	script.Parent.Slot5
}
local Slots = {"Slot1", "Slot2", "Slot3", "Slot4", "Slot5"}

function FindSlot(player, findto)
	for i,v in pairs(player:GetChildren()) do
		if v:IsA("StringValue") then
			if v.Value == findto then
				return v
			end
		end
	end
end

for i, v in ipairs(SlotsButtons) do
	
	v.Text = player:WaitForChild(v.Name).Value
	
	player:WaitForChild(v.Name):GetPropertyChangedSignal("Value"):Connect(function()
		v.Text = player:WaitForChild(v.Name).Value
	end)
	
	v.MouseButton1Down:Connect(function()
		if v.Text == "Empty" then else
			
			if v.Text == SelectedTroop then
				shopframe.TextButton.Text = "Equip"
			end
			ReplicatedS.EmptySlot:FireServer(v.Name)
			
		end
	end)
	
end

for _, troops in pairs(script.Parent.Frame.ScrollingFrame:GetChildren()) do
	if troops:IsA("TextButton") then
		troops.MouseButton1Down:Connect(function()
			
			shopframe.Label.Text = troops.Name
			
			shopframe.Attack.Text = "Attack: "..TroopsStats[troops.Name].Attack
			shopframe.Firerate.Text = "Firerate: "..TroopsStats[troops.Name].Firerate
			shopframe.Range.Text = "Range: "..TroopsStats[troops.Name].Range
			shopframe.Cost.Text = "Cost: "..TroopsStats[troops.Name].Cost
			shopframe.HireCost.Text = "HireCost: "..TroopsStats[troops.Name].HireCost
			SelectedTroop = troops.Name
			
			if player:FindFirstChild(SelectedTroop) then
				shopframe.TextButton.Text = "Equip"
				
				for ___, vv in ipairs(SlotsButtons) do
					task.spawn(function()
						while wait(0.1) do
							if vv.Text == SelectedTroop then
								shopframe.TextButton.Text = "Equipped"
							end
						end
					end)
				end
			else
				shopframe.TextButton.Text = "Purchase"
			end
			
		end)
	end
end

shopframe.TextButton.MouseButton1Down:Connect(function()
	if shopframe.TextButton.Text == "Equip" then
		
		ReplicatedS.EquipTroop:FireServer(SelectedTroop)
		
	elseif shopframe.TextButton.Text == "Purchase" then
		
		ReplicatedS.Purchase:FireServer(SelectedTroop)
		
	elseif  shopframe.TextButton.Text == "Equipped" then
		
		shopframe.TextButton.Text = "Equip"
		script.Parent[FindSlot(SelectedTroop)].Text = "Empty"
		ReplicatedS.EmptySlot:FireServer(FindSlot(SelectedTroop))
		
	end
end)

player.ChildAdded:Connect(function(child)
	if child.Name == SelectedTroop then
		shopframe.TextButton.Text = "Equip"
	end
end)