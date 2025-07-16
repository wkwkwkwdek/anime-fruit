-- Anime Fruit Simulator GUI Script (GUI Toggle Versi)
-- DISCLAIMER: Gunakan untuk pembelajaran. Resiko ditanggung pengguna.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Anti-AFK
local vu = game:GetService("VirtualUser")
player.Idled:Connect(function()
    vu:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Settings
local Settings = {
    AutoQuest = false,
    AutoFarm = false,
    AutoSkill = false,
    AutoBoss = false,
    AutoFruit = false
}

-- Auto Skill Spam
spawn(function()
    while wait(0.2) do
        if Settings.AutoSkill then
            for i = 1, 4 do
                ReplicatedStorage.Remotes.Skill:FireServer("Skill"..i)
                wait(0.1)
            end
        end
    end
end)

-- Auto Farm
spawn(function()
    while wait(0.5) do
        if Settings.AutoFarm then
            for _, mob in pairs(Workspace:WaitForChild("Mobs"):GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    player.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
                end
            end
        end
    end
end)

-- Auto Quest
spawn(function()
    while wait(5) do
        if Settings.AutoQuest then
            ReplicatedStorage.Remotes.Quest:FireServer("AcceptQuest", "Kill 10 Bandits") -- Ganti sesuai quest tersedia
        end
    end
end)

-- Auto Boss
spawn(function()
    while wait(1) do
        if Settings.AutoBoss then
            local boss = Workspace:FindFirstChild("Boss")
            if boss and boss:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)
            end
        end
    end
end)

-- Auto Fruit Collect
spawn(function()
    while wait(2) do
        if Settings.AutoFruit then
            for _, drop in pairs(Workspace:WaitForChild("Drops"):GetChildren()) do
                if drop:IsA("Tool") and drop:FindFirstChild("Handle") then
                    firetouchinterest(player.Character.HumanoidRootPart, drop.Handle, 0)
                    wait()
                    firetouchinterest(player.Character.HumanoidRootPart, drop.Handle, 1)
                end
            end
        end
    end
end)

-- GUI
local screen = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", screen)
frame.Position = UDim2.new(0,50,0,200)
frame.Size = UDim2.new(0,180,0,230)
frame.BackgroundTransparency = 0.4
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)

local function makeToggle(name, index)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Position = UDim2.new(0, 5, 0, 10 + index * 35)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.MouseButton1Click:Connect(function()
        Settings[name] = not Settings[name]
        btn.Text = name .. (Settings[name] and ": ON" or ": OFF")
        btn.BackgroundColor3 = Settings[name] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(40,40,40)
    end)
end

makeToggle("AutoQuest", 0)
makeToggle("AutoFarm", 1)
makeToggle("AutoSkill", 2)
makeToggle("AutoBoss", 3)
makeToggle("AutoFruit", 4)

print("[Anime Fruit GUI Script] Loaded Successfully ✅")
