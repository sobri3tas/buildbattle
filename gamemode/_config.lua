GM.Maps = {
    bb_buildbattle = {
        WaitingSpawnpoints = {
            Vector(8904, -5151, 160),
            Vector(10089, -3808, 160),
            Vector(11289, -5151, 160),
            Vector(10088, -6495, 160)
        },
        WaitingPosMin = Vector(8550, -6794, -42), 
        WaitingPosMax = Vector(11401, -3633, 994), 
        BuildZones = {
            { -- 1st row
                PosMin = Vector(4816, -5663, 0),
                PosMax = Vector(6271, -4208, 1600),
                Spawnpoint = Vector(5608, -4994, 100)
            },
            {
                PosMin = Vector(2960, -5663, 0),
                PosMax = Vector(4415, -4208, 1600),
                Spawnpoint = Vector(3727, -4994, 100)
            },
            {
                PosMin = Vector(1104, -5663, 0),
                PosMax = Vector(2559, -4208, 1600),
                Spawnpoint = Vector(1831, -4994, 100)
            },
            {
                PosMin = Vector(-815, -5663, 0),
                PosMax = Vector(639, -4208, 1600),
                Spawnpoint = Vector(-88, -4994, 100)
            },
            { -- 2nd row
                PosMin = Vector(4816, -3551, 0),
                PosMax = Vector(6271, -2096, 1600),
                Spawnpoint = Vector(5608, -2823, 100)
            },
            {
                PosMin = Vector(2960, -3551, 0),
                PosMax = Vector(4415, -2096, 1600),
                Spawnpoint = Vector(3727, -2823, 100)
            },
            {
                PosMin = Vector(1104, -3551, 0),
                PosMax = Vector(2559, -2096, 1600),
                Spawnpoint = Vector(1831, -2823, 100)
            },
            {
                PosMin = Vector(-815, -3551, 0),
                PosMax = Vector(639, -2096, 1600),
                Spawnpoint = Vector(-88, -2823, 100)
            },
            { -- 3rd row
                PosMin = Vector(4816, -1359, 0),
                PosMax = Vector(6271, 96, 1600),
                Spawnpoint = Vector(5608, -631, 100)
            },
            {
                PosMin = Vector(2960, -1359, 0),
                PosMax = Vector(4415, 96, 1600),
                Spawnpoint = Vector(3727, -631, 100)
            },
            {
                PosMin = Vector(1104, -1359, 0),
                PosMax = Vector(2559, 96, 1600),
                Spawnpoint = Vector(1831, -631, 100)
            },
            {
                PosMin = Vector(-815, -1359, 0),
                PosMax = Vector(639, 96, 1600),
                Spawnpoint = Vector(-88, -631, 100)
            },
            { -- 4th row
                PosMin = Vector(4816, 768, 0),
                PosMax = Vector(6271, 2223, 1600),
                Spawnpoint = Vector(5608, 1495, 100)
            },
            {
                PosMin = Vector(2960, 768, 0),
                PosMax = Vector(4415, 2223, 1600),
                Spawnpoint = Vector(3727, 1495, 100)
            },
            {
                PosMin = Vector(1104, 768, 0),
                PosMax = Vector(2559, 2223, 1600),
                Spawnpoint = Vector(1831, 1495, 100)
            },
            {
                PosMin = Vector(-815, 768, 0),
                PosMax = Vector(639, 2223, 1600),
                Spawnpoint = Vector(-88, 1495, 100)
            },
        }
    }
}

GM.Themes = {
    "House",
    "Car",
    "Plane",
    "Helicopter",
    "Boat"
}

GM.BuildingTime = 300
GM.RatingTime = 15 -- for each player
GM.ChillTime = 30

GM.AllowEffects = false
GM.AllowNPCs = false
GM.AllowRagdolls = false
GM.AllowSENTs = false
GM.AllowWeapons = false
GM.AllowVehicles = false