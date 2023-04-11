wait(1)
local player = game.Players.LocalPlayer
script.Parent.Credits.Text = player:WaitForChild("Credits").Value

player:WaitForChild("Credits"):GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Credits.Text = player:WaitForChild("Credits").Value
end)