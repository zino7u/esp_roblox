--[[ 
    -ESP MADE BY Z-Aℹ️
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera

-- ESP
local function CreateESPBox(player)
    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local Box = Drawing.new("Square")
        Box.Visible = true
        Box.Color = Color3.new(1, 0, 0) 
        Box.Thickness = 2
        Box.Transparency = 1
        Box.Filled = false

        local DistanceText = Drawing.new("Text")
        DistanceText.Visible = true
        DistanceText.Color = Color3.new(1, 1, 1) 
        DistanceText.Size = 20
        DistanceText.Center = true
        DistanceText.Outline = true
        DistanceText.Text = "0m"

        local function Update()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local rootPart = player.Character.HumanoidRootPart
                local vector, onScreen = Camera:WorldToViewportPoint(rootPart.Position)

                if onScreen then
                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - rootPart.Position).magnitude
                    Box.Size = Vector2.new(2000 / vector.Z, 3000 / vector.Z)
                    Box.Position = Vector2.new(vector.X - Box.Size.X / 2, vector.Y - Box.Size.Y / 2)
                    Box.Visible = true

                    DistanceText.Position = Vector2.new(vector.X, vector.Y - Box.Size.Y / 2 - 20)
                    DistanceText.Text = string.format("%.0fm", distance)
                    DistanceText.Visible = true
                else
                    Box.Visible = false
                    DistanceText.Visible = false
                end
            else
                Box.Visible = false
                DistanceText.Visible = false
            end
        end

        RunService.RenderStepped:Connect(Update)
    end
end


for _, player in pairs(Players:GetPlayers()) do
    CreateESPBox(player)
end


Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        CreateESPBox(player)
    end)
end)


Players.PlayerRemoving:Connect(function(player)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then

        Box.Visible = false
        DistanceText.Visible = false
    end
end)
