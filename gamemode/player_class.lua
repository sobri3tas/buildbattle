local CLASS = {}

function CLASS:Loadout()

    self.Player:RemoveAllAmmo()
    self.Player:Give("weapon_physgun")
    self.Player:Give("gmod_tool")
    self.Player:SwitchToDefaultWeapon()

end

player_manager.RegisterClass("Building", CLASS, "player_sandbox")

local CLASS = {}

function CLASS:Loadout()

    self.Player:RemoveAllAmmo()
    self.Player:SetArmor(100)
    self.Player:Give("weapon_crossbow")
    self.Player:GiveAmmo(99, 6, true)
    self.Player:SwitchToDefaultWeapon()

end

player_manager.RegisterClass("Waiting", CLASS, "player_sandbox")