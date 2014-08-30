/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

-- Respawn Groups
RespawnGroups = { "superadmin", "admin" }

-- Spawns
AmmoSpawns = {
	
	{ pos = Vector( -6310.218750, -9666.718750, 130 ), ang = Angle( 0, 0, 0 ), mdl = "models/props_interiors/VendingMachineSoda01a.mdl" },
	{ pos = Vector( -6327.812500, -9184.875000, 130 ), ang = Angle( 0, 0, 0 ), mdl = "models/props_interiors/VendingMachineSoda01a_door.mdl" },

}

-- Ammo
AmmoTypes = {
	
	{
		AmmoName	= "SMG Ammo",
		AmmoType 	= "smg1",
		AmmoModel	= "models/items/boxmrounds.mdl",
		AmmoPrice	= 100,
		AmmoBullets	= 60,
	},

	{
		AmmoName	= "Pistol Ammo",
		AmmoType 	= "pistol",
		AmmoModel	= "models/items/boxsrounds.mdl",
		AmmoPrice	= 30,
		AmmoBullets	= 6,
	},

}

-- Send Info
function GetAmmoSpawns()
	return AmmoSpawns
end

function GetAmmoTypes()
	return AmmoTypes
end

function GetAmmoGroups()
	return RespawnGroups
end