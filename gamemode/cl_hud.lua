local noDrawForBuilding = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudDamageIndicator"] = true,
    ["CHudPoisonDamageIndicator"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudSquadStatus"] = true,
    ["CHudSuitPower"] = true,
}

hook.Add("HUDShouldDraw", "HideHUD", function(name)
	if noDrawForBuilding[name] and LocalPlayer().IsBuilding and LocalPlayer():IsBuilding() then
		return false
	end
end)

hook.Add("HUDPaint", "BuildBattleHud", function()

    local ply, w, h = LocalPlayer(), ScrW(), ScrW()

    if ply:IsWaiting() then
        if GetGlobal2Bool("Building") or GetGlobal2Bool("Rating") then
            draw.SimpleText("Round is active, wait for next one", "CloseCaption_Bold", w * .5, h *.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif player.GetCount() < 2 then
            draw.SimpleText("Waiting for second player...", "CloseCaption_Bold", w * .5, h *.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("Wait for round start", "CloseCaption_Bold", w * .5, h *.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    if ply:IsBuilding() then
        if GetGlobal2Bool("Building") then
            draw.SimpleText("Theme: " .. GetGlobal2String("Theme", ""), "CloseCaption_Bold", w * .5, h *.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif GetGlobal2Bool("Rating") then
            draw.SimpleText("Rate time! Press 1-5", "CloseCaption_Bold", w * .5, h *.05, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

end)