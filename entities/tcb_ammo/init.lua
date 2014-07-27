/*---------------------------------------------------------------------------
	
	Made By: TheCodingBeast
	This work is licensed under the Creative Commons Attribution 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
	
---------------------------------------------------------------------------*/

AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function ENT:Initialize()

	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )

	self:SetUseType( SIMPLE_USE )

end

function ENT:AcceptInput( key, activator, caller, data )
	if key == "Use" and IsValid( caller ) then
		umsg.Start( "AmmoFrame", caller )
		umsg.End()
	end
end