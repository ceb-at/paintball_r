-- Read the weapon_real_base if you really want to know what each action does

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName 		= "Paintball Sniper"
	SWEP.ViewModelFOV		= 60
	SWEP.Slot 			= 3
	SWEP.SlotPos 		= 8
	SWEP.IconLetter 		= "r"
  SWEP.DrawCrosshair	= true

	killicon.AddFont("weapon_real_cs_awp", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
end

/*---------------------------------------------------------
Muzzle Effect + Shell Effect
---------------------------------------------------------*/
SWEP.MuzzleEffect			= "rg_muzzle_highcal" -- This is an extra muzzleflash effect
-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none

SWEP.ShellEffect			= "rg_shelleject_rifle" -- This is a shell ejection effect
-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none

SWEP.MuzzleAttachment		= "1" -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellEjectAttachment	= "2" -- Should be "2" for CSS models or "1" for hl2 models

SWEP.EjectDelay			= 0.6
/*-------------------------------------------------------*/

SWEP.Category			= "Fang-GamingRP"

SWEP.Instructions 		= "Shoot with left-click, scope with right-click."

SWEP.Base 				= "paintball_sniper_base"
SWEP.HoldType 			= "ar2"

SWEP.Spawnable 			= true
SWEP.AdminSpawnable 	= true

SWEP.ViewModel 			= "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel 		= "models/weapons/w_snip_awp.mdl"
SWEP.UseHands 			= true

SWEP.Primary.Sound 		= Sound("marker/pbfire.wav")
SWEP.Primary.Damage 		= 100
SWEP.Primary.Recoil 		= 2
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 		= 0.0001
SWEP.Primary.ClipSize 		= 10
SWEP.Primary.Delay 		= 1
SWEP.Primary.DefaultClip 	= 10
SWEP.Primary.Automatic 		= false
SWEP.Primary.Ammo 		= "ar2"

---------------------------
-- Ironsight/Scope --
---------------------------
-- IronSightsPos and IronSightsAng are model specific paramaters that tell the game where to move the weapon viewmodel in ironsight mode.

SWEP.IronSightsPos 			= Vector (5.6111, -3, 2.092)
SWEP.IronSightsAng 			= Vector (0, 0, 0)
SWEP.IronSightZoom			= 1.3 -- How much the player's FOV should zoom in ironsight mode. 
SWEP.UseScope				= true -- Use a scope instead of iron sights.
SWEP.ScopeScale 				= 0.4 -- The scale of the scope's reticle in relation to the player's screen size.
SWEP.ScopeZooms				= {5} -- The possible magnification levels of the weapon's scope.   If the scope is already activated, secondary fire will cycle through each zoom level in the table.
SWEP.DrawParabolicSights		= false -- Set to true to draw a cool parabolic sight (helps with aiming over long distances)