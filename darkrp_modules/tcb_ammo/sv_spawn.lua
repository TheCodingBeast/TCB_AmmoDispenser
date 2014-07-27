/*---------------------------------------------------------------------------
	
	Made By: TheCodingBeast
	This work is licensed under the Creative Commons Attribution 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
	
---------------------------------------------------------------------------*/

-- Network
util.AddNetworkString( "TCBSendAmmo" )
util.AddNetworkString( "TCBBuyAmmo" )

-- Variables
local AmmoSpawns	= GetAmmoSpawns()
local AmmoTypes		= GetAmmoTypes()
local AmmoGroups	= GetAmmoGroups()

-- Spawn
function SpawnAmmo()
	for k,v in pairs(AmmoSpawns) do

		local AmmoMachine = ents.Create( "tcb_ammo" )
		AmmoMachine:SetPos( v['pos'] )
		AmmoMachine:SetAngles( v['ang'] )
		AmmoMachine:SetModel( v['mdl'] )

		AmmoMachine:Spawn()
		AmmoMachine:DropToFloor()

	end
end
hook.Add( "InitPostEntity", "SpawnAmmo", SpawnAmmo )

-- Respawn
function RespawnAmmo( ply )
	if table.HasValue( AmmoGroups, ply:GetNWString( "usergroup" ) ) then

		-- Remove
		for k,v in ipairs( ents.FindByClass( "tcb_ammo" ) ) do
			v:Remove()
		end

		-- Spawn
		SpawnAmmo()

		-- Reload Ammo
		for k,v in ipairs( player.GetAll() ) do
			net.Start( "TCBSendAmmo" )
				net.WriteTable( AmmoTypes )
			net.Broadcast()
		end

	end
end
concommand.Add( "RespawnAmmo", RespawnAmmo )

-- Send Info
function SendPlayerAmmo( ply )

	net.Start( "TCBSendAmmo" )
		net.WriteTable( AmmoTypes )
	net.Send( ply )

end
hook.Add( "PlayerInitialSpawn", "SendPlayerAmmo", SendPlayerAmmo )

-- Buy Ammo
function BuyAmmo( length, ply )

	local BuyTable 	= net.ReadTable()

	local AmmoPrice 	= tonumber(BuyTable[4])
	local AmmoBullets	= tonumber(BuyTable[5])
	local AmmoType 		= tostring(BuyTable[2])

	print(AmmoPrice)

	if ply:canAfford( AmmoPrice ) then

		ply:addMoney( - AmmoPrice )
		ply:GiveAmmo( AmmoBullets, AmmoType, false )

	else
		
		DarkRP.notify( ply, 1, 10, "You don't have enough money!" )

	end

end
net.Receive( "TCBBuyAmmo", BuyAmmo )