local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Teleportservice = game:GetService("TeleportService")

local function OnTeleportRequested(player, id)
	local rsId = Teleportservice:ReserveServer(id)
	Teleportservice:TeleportToPrivateServer(id, rsId, {player})
end

ReplicatedStorage.Teleport.OnServerEvent:Connect(function(player, id)
	OnTeleportRequested(player, id)
end)