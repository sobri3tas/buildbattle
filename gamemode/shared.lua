GM.Name = "Build Battle"
GM.Author = "sobri3tas"
GM.Email = "sobri3tas@gmail.com"

DeriveGamemode("sandbox")

GM.Sandbox = baseclass.Get("gamemode_sandbox")
GM.Base = baseclass.Get("gamemode_base")

TEAM_BUILDING = 1
TEAM_WAITING = 2

function GM:CreateTeams()

    team.SetUp(TEAM_BUILDING, "Building", Color(0, 235, 0), true)
    team.SetUp(TEAM_WAITING, "Waiting", Color(255, 230, 0), true)

    self.Sandbox.CreateTeams(self)

end

function GM:Initialize()

    if SERVER then
        self:StartRound()
    end

    self.Sandbox.Initialize(self)
    
end

local plyMeta = FindMetaTable("Player")

function plyMeta:IsWaiting()
    return self:Team() == TEAM_WAITING
end

function plyMeta:IsBuilding()
    return self:Team() == TEAM_BUILDING
end

function GM:PlayerNoClip(ply, desiredState)
    return ply:IsBuilding()
end

function plyMeta:ShouldStayInCube(v1, v2)

    local x, y, z = self:GetPos():Unpack()
    local x1, y1, z1 = v1:Unpack()
    local x2, y2, z2 = v2:Unpack()

    self:SetPos(Vector(math.Clamp(x, x1, x2), math.Clamp(y, y1, y2), math.Clamp(z, z1, z2)))

end

function GM:PlayerPostThink(ply)

    local mapTbl = self["Maps"][game.GetMap()]

    if ply:IsWaiting() then
        local v1, v2 = mapTbl["WaitingPosMin"], mapTbl["WaitingPosMax"]  
        ply:ShouldStayInCube(v1, v2)
    end

    if ply:IsBuilding() and ply:GetNW2Int("BuildZone", false) then
        if GetGlobal2Bool("Building") then
            local plyBuildZone = mapTbl["BuildZones"][ply:GetNW2Int("BuildZone")]
            if plyBuildZone then
                local v1, v2 = plyBuildZone.PosMin, plyBuildZone.PosMax
                ply:ShouldStayInCube(v1, v2)
            end
        end
        if GetGlobal2Bool("Rating") then
            local plyBuildZone = mapTbl["BuildZones"][GetGlobal2Int("RateZone")]
            if plyBuildZone then
                local v1, v2 = plyBuildZone.PosMin, plyBuildZone.PosMax
                ply:ShouldStayInCube(v1, v2)
            end
        end
    end
    
end

