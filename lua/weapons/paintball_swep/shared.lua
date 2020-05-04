if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if ( CLIENT ) then
	SWEP.Category			= "Fang-GamingRP"
	SWEP.PrintName			= "PaintBall Gun"
	SWEP.Author				= "Redenz"
	SWEP.Contact			= ""
	SWEP.Purpose			= ""
	SWEP.Instructions		= "Shoot with primary and secondary fire."
	SWEP.CSMuzzleFlashes    = true
	SWEP.Slot				= 3
	SWEP.SlotPos			= 8
end

SWEP.data = {}
SWEP.data.newclip = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType			= "pistol"
SWEP.ViewModel			= "models/Weapons/v_blazer.mdl"
SWEP.WorldModel			= "models/Weapons/w_blazer.mdl"
SWEP.ViewModelFlip		= false

SWEP.Drawammo = true
SWEP.DrawCrosshair = true

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound		= Sound( "marker/pbfire.wav" )
SWEP.Primary.Recoil		= 0.03
SWEP.Primary.Damage		= 1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone		= 0.01
SWEP.Primary.ClipSize		= 200
SWEP.Primary.Delay		= 0.30
SWEP.Primary.DefaultClip	= 600
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "ar2"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

function SWEP:SecondaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

		self.Weapon:EmitSound(Sound( "marker/pbfire.wav" ))
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.10 )
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.10 )
		self:ShootEffects()
		self:TakePrimaryAmmo( 1 )
		
		if SERVER then
		
		local pb = ents.Create("paint_ball")

		local shotpos = self.Owner:GetShootPos()
		shotpos = shotpos + self.Owner:GetForward() * 5
		shotpos = shotpos + self.Owner:GetRight() * 9
		shotpos = shotpos + self.Owner:GetUp() * -0.5

		pb:SetPos(shotpos)
		pb:SetAngles(Angle(self.Owner:GetAimVector()))
		pb:SetOwner(self.Owner)
		pb:Spawn()

		local phys = pb:GetPhysicsObject()
		phys:ApplyForceCenter(self.Owner:GetAimVector() * 7000 )
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

		self.Weapon:EmitSound(Sound( "marker/pbfire.wav" ))
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.10 )
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.10 )
		self:ShootEffects()
		self:TakePrimaryAmmo( 1 )
	
		if SERVER then
	
		local pb = ents.Create("paint_ball")

		local shotpos = self.Owner:GetShootPos()
		shotpos = shotpos + self.Owner:GetForward() * 5
		shotpos = shotpos + self.Owner:GetRight() * 9
		shotpos = shotpos + self.Owner:GetUp() * -0.5

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
	self.Owner:MuzzleFlash()
end