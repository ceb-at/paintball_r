if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if ( CLIENT ) then
	SWEP.Category			= "PAINTBALL - Remake"	
	SWEP.PrintName			= "Paintball - Glock 17"
	SWEP.Author				= "remake by Peralta"
	SWEP.Contact			= ""
	SWEP.Purpose			= ""
	SWEP.Instructions		= "PRIMARY FIRE - Shoot"
	SWEP.CSMuzzleFlashes	= true
	SWEP.Slot				= 3
	SWEP.SlotPos			= 8
end

SWEP.data = {}
SWEP.data.newclip = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType			= "pistol"
SWEP.ViewModel			= "models/weapons/v_tigg_glock17.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_p228.mdl"
SWEP.ViewModelFlip		= false
SWEP.UseHands			= true
SWEP.FiresUnderwater = false

SWEP.Drawammo = true
SWEP.DrawCrosshair = false

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound		= Sound( "marker/pbfire.wav" )
SWEP.Primary.Recoil		= 0.9
SWEP.Primary.Damage		= 1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone		= 0.01
SWEP.Primary.ClipSize		= 18
SWEP.Primary.Delay		= 0.30
SWEP.Primary.DefaultClip	= 750
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "ar2"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:IronSight()

	if !self.Owner:KeyDown(IN_USE) then

		if self.Owner:KeyPressed(IN_ATTACK2) then

			self.Owner:SetFOV( 65, 0.15 )

			if CLIENT then return end
 		end
	end

	if self.Owner:KeyReleased(IN_ATTACK2) then

		self.Owner:SetFOV( 0, 0.15 )

		if CLIENT then return end
	end
end

function SWEP:Think()

	self:IronSight()
end

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

function SWEP:SecondaryAttack()
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

		self.Weapon:EmitSound(Sound( "marker/pbfire.wav" ))
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.15 )
		self:ShootEffects()
		self:TakePrimaryAmmo( 1 )
		
		if SERVER then
		
		local pb = ents.Create("paint_ball")

		local shotpos = self.Owner:GetShootPos()
		shotpos = shotpos + self.Owner:GetForward() * 0
		shotpos = shotpos + self.Owner:GetRight() * 0
		shotpos = shotpos + self.Owner:GetUp() * 1

		pb:SetPos(shotpos)
		pb:SetAngles(Angle(self.Owner:GetAimVector()))
		pb:SetOwner(self.Owner)
		pb:Spawn()

		local phys = pb:GetPhysicsObject()
		phys:ApplyForceCenter(self.Owner:GetAimVector() * 7000 )
	end
end

function SWEP:ShootEffects()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end