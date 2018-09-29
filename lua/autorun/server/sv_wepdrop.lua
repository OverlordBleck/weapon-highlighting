-- Includes


local exceptions = {}
exceptions.weapon_physgun       = true
exceptions.weapon_physcannon    = true
exceptions.gmod_tool            = true
exceptions.gmod_camera          = true

-- Helper Functions
local uniqueHookPrefix = "bleck_weps_"
local function genHookName( str )
    return uniqueHookPrefix .. str
end

local function isValidPly( ent )
    return IsValid( ent ) and ent:IsPlayer()
end

local function weaponCanDrop( wep )
    return not exceptions[wep:GetClass()]
end

local function dropPlayerWeapons( ply, weps )
    local plyPos = ply:GetPos()

    for _, wep in ipairs( weps ) do
        if not weaponCanDrop( wep ) then continue end
        
        local gun = ents.Create( wep:GetClass() )
        gun:SetModel( gun:GetWeaponWorldModel() )
        gun:SetPos( plyPos + Vector( 0, 0, 50 ) )
        gun:Spawn()
        gun.despawn = timer.Simple( 10, function()
            if not IsValid( gun ) then return end
            gun:Remove()
        end)
    end
end

-- Hook Functions

local function onPlayerDeath( victim, inflictor, attacker )
    if not isValidPly( victim ) then return end
    local victimsWeapons = victim:GetWeapons()

    dropPlayerWeapons( victim, victimsWeapons )
end

-- Hooks

hook.Remove( "PlayerDeath", genHookName("death") )
hook.Add( "PlayerDeath", genHookName("death"), onPlayerDeath )