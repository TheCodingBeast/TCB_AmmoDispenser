/*---------------------------------------------------------------------------
	
	Creator: TheCodingBeast - TheCodingBeast.com
	This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. 
	To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
	
---------------------------------------------------------------------------*/

include( "shared.lua" )

-- Ammo Types
local AmmoTypes = {}

function ReceiveAmmoTypes( length, ply )
	AmmoTypes = net.ReadTable()
end
net.Receive( "TCBSendAmmo", ReceiveAmmoTypes )

-- Add Ammo
local Frame, PanelList

function AddAmmo( AmmoName, AmmoType, AmmoModel, AmmoPrice, AmmoBullets )

	local AmmoPanel	= vgui.Create( "DPanel" )
	AmmoPanel:SetSize( PanelList:GetWide(), 95 )
	AmmoPanel.Paint = function()

		draw.RoundedBox( 0, 0, 0, AmmoPanel:GetWide(), AmmoPanel:GetTall(), Color( 0, 0, 0, 100 ) )

	end

	local AmmoIcon = vgui.Create( "SpawnIcon", AmmoPanel )
	AmmoIcon:SetPos( 10, 10 )
	AmmoIcon:SetSize( 75, 75 )
	AmmoIcon:SetModel( AmmoModel )
	AmmoIcon.Paint = function()

		draw.RoundedBox( 0, 0, 0, AmmoIcon:GetWide(), AmmoIcon:GetTall(), Color( 0, 0, 0, 150 ) )

	end

	local AmmoInfoPanel = vgui.Create( "DPanel", AmmoPanel )
	AmmoInfoPanel:SetPos( 95, 10 )
	AmmoInfoPanel:SetSize( 400 - 114, 75 )	--  - 105
	AmmoInfoPanel.Paint = function() 

		draw.RoundedBox( 0, 0, 0, AmmoInfoPanel:GetWide(), AmmoInfoPanel:GetTall(), Color( 0, 0, 0, 100 ) ) 

		draw.DrawText( AmmoName.." ( $"..AmmoPrice.." )", "DermaDefault", AmmoInfoPanel:GetWide()/2+1, 14+1, Color( 0, 0, 0, 255 ), 1)
		draw.DrawText( AmmoName.." ( $"..AmmoPrice.." )", "DermaDefault", AmmoInfoPanel:GetWide()/2+0, 14+0, Color( 255, 255, 255, 255 ), 1)

	end

	local SendTable = { AmmoName, AmmoType, AmmoModel, AmmoPrice, AmmoBullets }

	local AmmoBuy = vgui.Create( "DButton", AmmoInfoPanel )
	AmmoBuy:SetSize( AmmoInfoPanel:GetWide() - 20, 30 )
	AmmoBuy:SetPos( 10, 35 )
	AmmoBuy:SetText( "Purchase" )
	AmmoBuy.DoClick = function() net.Start( "TCBBuyAmmo") net.WriteTable( SendTable ) net.SendToServer() end

	PanelList:AddItem( AmmoPanel )

end

-- Frame
function AmmoFrame()

	local Frame = vgui.Create( "DFrame" )
	Frame:SetSize( 400, 428 )
	Frame:SetTitle( "Buy Ammo" )
	Frame:SetVisible( true )
	Frame:SetDraggable( true )
	Frame:ShowCloseButton( true )
	Frame:MakePopup()
	Frame:Center()

	PanelList = vgui.Create( "DPanelList", Frame )
	PanelList:Dock( FILL )
	PanelList:EnableVerticalScrollbar( true )
	PanelList:SetSpacing( 4 )

	for k,v in pairs(AmmoTypes) do
		AddAmmo( v['AmmoName'], v['AmmoType'], v['AmmoModel'], v['AmmoPrice'], v['AmmoBullets'] )
	end

end
usermessage.Hook( "AmmoFrame", AmmoFrame )