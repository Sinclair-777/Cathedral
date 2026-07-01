local Lighting = game:GetService("Lighting")

local function FoggyWoggyGoAwayUwU()
    local atmos = Lighting:FindFirstChildOfClass("Atmosphere")
    if atmos then
        local addr = tonumber(atmos.Address)
        if addr and addr > 4096 then
            pcall(memory_write, "float", addr + 0xd0, 0) -- Density
            pcall(memory_write, "float", addr + 0xd8, 0) -- Haze
        end
    end
end

while true do
    FoggyWoggyGoAwayUwU()
    task.wait(0.1)
end
