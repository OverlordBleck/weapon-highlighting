-- Includes


local weaponCol = Color( 255, 0, 255 )

-- Helper functions
local uniqueHookPrefix = "bleck_weps_"
local function genHookName( str )
    return uniqueHookPrefix .. str
end

local function getNearbyWeapons( radius )
	local ply = LocalPlayer()
	local nearbyEnts = ents.FindInSphere( ply:GetPos(), radius )
	local weps = {}

	for _, ent in pairs( nearbyEnts ) do
		if not ent:IsWeapon() then continue end
		table.insert( weps, ent )
	end

	return weps
end

-- Hook functions
local function drawHalos()
	local weps = getNearbyWeapons( 500 )
	if #weps == 0 then return end

	halo.Add( weps, weaponCol, 2, 2, 1 )
end

-- Hooks

hook.Remove( "PreDrawHalos", genHookName("halos") )
hook.Add( "PreDrawHalos", genHookName("halos"), drawHalos )
