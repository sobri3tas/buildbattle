local metaPly = FindMetaTable("Player")

function metaPly:AssignBuildZone()

    local buildZones = GAMEMODE["Maps"][game.GetMap()]["BuildZones"]

    for i, _ in ipairs(buildZones) do
        local isFree = true
        for _, ply in ipairs(player.GetAll()) do
            if ply:GetNW2Int("BuildZone") == i then
                isFree = false
                break
            end
        end
        if isFree then
            self:SetNW2Int("BuildZone", i)
        else
            self:MakeWaiting()
        end
    end
    
end

function GM:StartRound()

    timer.Create("TryToStartRound", 1, 0, function()
        if player.GetCount() >= 2 then

            timer.Remove("TryToStartRound")
            SetGlobal2Bool("Building", true)

            for _, ply in ipairs(player.GetAll()) do
                ply:AssignBuildZone()
                ply:MakeBuilding()
            end

            local themes = GAMEMODE.Themes
            SetGlobal2String("Theme", themes[math.random(#themes)])

            timer.Simple(GAMEMODE.BuildingTime, GAMEMODE.StartRating)

        end
    end)

end

function GM:StartRating()

    SetGlobal2Bool("Building", false)
    SetGlobal2Bool("Rating", true)

    for _, ply in ipairs(player.GetAll()) do
        ply:SetNW2Int("Points", 0)
    end

    GAMEMODE:RateNextPlayer(player.GetAll())

end

function GM:RateNextPlayer(t)

    if table.IsEmpty(t) then
        return self:EndRound()
    end

    local ply = t[1]

    if IsValid(ply) and ply:IsBuilding() and ply:GetNW2Int("BuildZone", false) then
        SetGlobal2Int("RateZone", ply:GetNW2Int("BuildZone"))
        SetGlobal2Entity("RateThisPlayer", ply)
        for _, v in ipairs(player.GetAll()) do
            v:SetPos(self["Maps"][game.GetMap()]["BuildZones"][ply:GetNW2Int("BuildZone")]["Spawnpoint"])
            v:SetNW2Bool("AlreadyRated", false)
        end
        timer.Simple(self.RatingTime, function()
            table.RemoveByValue(t, ply)
            self:RateNextPlayer(t)
        end)
    else
        table.RemoveByValue(t, ply)
        return self:RateNextPlayer(t)
    end

end

function GM:EndRound()

    game.CleanUpMap()

    local tbl = {}
    for _, v in ipairs(player.GetAll()) do
        if v:IsBuilding() then
            table.insert(tbl, v)
        end
    end
    table.sort(tbl, function(a, b) return a:GetNW2Int("Points", 0) > b:GetNW2Int("Points", 0) end)
    
    SetGlobal2Bool("Rating", false)
    for _, ply in ipairs(player.GetAll()) do
        if ply:IsWaiting() then continue end
        ply:MakeWaiting()
        ply:ChatPrint("Winner is "..tbl[1]:Name())
        local place = tostring(table.KeyFromValue(tbl, ply))
        if place == "1" then
            place = place .. "st"
        elseif place == "2" then
            place = place .. "nd"
        elseif place == "3" then
            place = place .. "rd"
        else
            place = place .. "th"
        end
        ply:ChatPrint("You took the ".. place .. " place")
    end

    timer.Simple(self.ChillTime, self.StartRound)
    
end

util.AddNetworkString("RatePlayer")
net.Receive("RatePlayer", function(_, ply)
    local ratePly = GetGlobal2Entity("RateThisPlayer")
    if not IsValid(ratePly) then return end
    if ratePly == ply then
        ply:ChatPrint("You cannot rate yourself!")
        return
    end
    if ply:GetNW2Bool("AlreadyRated", false) then
        ply:ChatPrint("You are already rated that masterpiece!")
        return
    end
    ply:SetNW2Bool("AlreadyRated", true)
    local points = net.ReadInt(4)
    ratePly:SetNW2Int("Points", ratePly:GetNW2Int("Points", 0) + math.Clamp(points, 1, 5))
    ply:ChatPrint("You gave that a "..points)
end)