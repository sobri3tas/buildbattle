include("shared.lua")
include("player_class.lua")
include("cl_hud.lua")
include("_config.lua")

local digits = {
    "slot1",
    "slot2",
    "slot3",
    "slot4",
    "slot5",
}

hook.Add("PlayerBindPress", "PressDigit", function(ply, bind, pressed)
    for v, s in pairs(digits) do
        if string.find(bind, s) and GetGlobal2Bool("Rating") then
            net.Start("RatePlayer")
                net.WriteInt(v, 4)
            net.SendToServer()
            return true
        end
    end
end)