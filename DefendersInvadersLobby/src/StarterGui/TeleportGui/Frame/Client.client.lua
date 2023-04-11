local remote = game.ReplicatedStorage.Teleport
local MapIds = {
	Map1 = 11792418740,
}

for i, Maps in pairs(script.Parent.ScrollingFrame:GetChildren()) do
	if Maps:IsA("TextButton") then
		Maps.MouseButton1Down:Connect(function()
			script.Parent.TextLabel.Text = "Selected Map: "..Maps.Name
			script.Parent.TextLabel.Name = Maps.Name
		end)
	end
end

script.Parent.Play.MouseButton1Down:Connect(function()
	if script.Parent:FindFirstChildOfClass("TextLabel").Name == "TextLabel" then else
		local SelectedMap = script.Parent:FindFirstChildOfClass("TextLabel").Name
		local id = MapIds[SelectedMap]
		
		remote:FireServer(id)
		
	end
end)