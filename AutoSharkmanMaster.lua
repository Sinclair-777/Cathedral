local Players = game:GetService("Players")
local player = Players.LocalPlayer
local enabled = false
local inset = 0.35

local function getObjects()
    local pg = player:FindFirstChildOfClass("PlayerGui")
    if not pg then return end
    local fs = pg:FindFirstChild("FishSlapMinigame")
    if not fs then return end
    local bar = fs:FindFirstChild("Bar")
    if not bar then return end
    local tick = bar:FindFirstChild("Tick")
    local zone = bar:FindFirstChild("GreenZone")
    if tick and zone then return tick, zone end
end

local function isInZone(tick, zone)
    local tp = tick.AbsolutePosition
    local ts = tick.AbsoluteSize
    local zp = zone.AbsolutePosition
    local zs = zone.AbsoluteSize
    local ix = zs.X * inset
    local iy = zs.Y * inset
    local cx = tp.X + ts.X / 2
    local cy = tp.Y + ts.Y / 2
    return cx >= zp.X + ix and cx <= zp.X + zs.X - ix
        and cy >= zp.Y + iy and cy <= zp.Y + zs.Y - iy
end

task.spawn(function()
    while true do
        task.wait(0.016)
        if not enabled then continue end
        local tick, zone = getObjects()
        if not tick or not zone then continue end
        local ok, hit = pcall(isInZone, tick, zone)
        if ok and hit then
            keypress(0x20)
            task.wait(0.05)
            keyrelease(0x20)
        end
    end
end)

UI.AddTab("Auto Sharkman Master", function(tab)
    local sec = tab:Section("Auto Sharkman Master", "Left")

    sec:Toggle("active", "Enable", false, function(v)
        enabled = v
    end)
    sec:Tip("Slaps when the tick is inside greenzone")

    sec:Spacing()

    sec:SliderInt("inset", "Hit Depth (%)", 0, 80, 35, function(v)
        inset = v / 100
    end)
    sec:Tip("How far inside greenzone the tick must be before triggering. 50 = center. changing might fix if urs is missing idk")
end)