AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("player_class.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("_config.lua")

include("shared.lua")
include("player_class.lua")
include("sv_rounds.lua")
include("cl_hud.lua")
include("_config.lua")

local plyMeta = FindMetaTable("Player")

function plyMeta:MakeWaiting()

    self:SetTeam(TEAM_WAITING)
    player_manager.SetPlayerClass(self, "Waiting")
    self:KillSilent()
    self:Spawn()
    self:GodDisable()

end

function plyMeta:MakeBuilding()

    self:SetTeam(TEAM_BUILDING)
    player_manager.SetPlayerClass(self, "Building")
    self:KillSilent()
    self:Spawn()
    self:GodEnable()

end

function GM:PlayerInitialSpawn(ply, transition)

    self.Base.PlayerInitialSpawn(self, ply, transition)

    ply:MakeWaiting()
    
end

local function RandomValue(t)
    return t[math.random(#t)] 
end

function GM:PlayerSpawn(ply, transition)

    if ply:IsWaiting() then
        ply:SetPos(RandomValue(self["Maps"][game.GetMap()]["WaitingSpawnpoints"]))
    end

    if ply:IsBuilding() and ply:GetNW2Int("BuildZone", false) then
        ply:SetPos(self["Maps"][game.GetMap()]["BuildZones"][ply:GetNW2Int("BuildZone")]["Spawnpoint"])
    end

    self.Base.PlayerSpawn(self, ply, transition)
    
end

function GM:CanPlayerSuicide(ply)
    return false
end

function GM:PlayerSpawnEffect(ply, model)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowEffects
end

function GM:PlayerSpawnNPC(ply, npc, weapon)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowNPCs
end

function GM:PlayerSpawnProp(ply, model)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return true
end

function GM:PlayerSpawnRagdoll(ply, model)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowRagdolls
end

function GM:PlayerSpawnSENT(ply, class)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowSENTs
end

function GM:PlayerSpawnSWEP(ply, weapon, swep)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowWeapons
end

function GM:PlayerGiveSWEP(ply, weapon, swep)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowWeapons
end

function GM:PlayerSpawnVehicle(ply, model, name, tbl)
    if ply:IsWaiting() or GetGlobal2Bool("Rating") then return false end
    return self.AllowVehicles
end