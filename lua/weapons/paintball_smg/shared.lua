if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if ( CLIENT ) then
	SWEP.Category			= "Fang-GamingRP"
	SWEP.PrintName			= "PaintBall SMG"
	SWEP.Author				= "Redenz"
	SWEP.Contact			= ""
	SWEP.Purpose			= ""
	SWEP.Instructions		= 	"Shoot with primary fire."
	SWEP.CSMuzzleFlashes    = true
	SWEP.Slot				= 3
	SWEP.SlotPos			= 8
end

SWEP.data = {}
SWEP.data.newclip = false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType			= "pistol"
SWEP.ViewModel			= "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_tmp.mdl"
SWEP.ViewModelFlip		= false
SWEP.UseHands 			= true

SWEP.Drawammo = true
SWEP.DrawCrosshair = true

SWEP.Weight			= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound		= Sound( "marker/pbfire.wav" )
SWEP.Primary.Recoil		= 0.9
SWEP.Primary.Damage		= 1
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone		= 0.01
SWEP.Primary.ClipSize		= 200
SWEP.Primary.Delay		= 0.30
SWEP.Primary.DefaultClip	= 600
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "ar2"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Reload()
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
end

function SWEP:SecondaryAttack()
	if not bZoomed then
	if (SERVER) then
		self.Weapon:GetOwner():SetFOV(45,0.35)
	end
	self.Weapon:EmitSound(Sound("weapons/zoom.wav"))
	bZoomed = true
	else
		bZoomed = false
		if (SERVER) then
			self.Owner:SetFOV( 0, 0.35 )
		end
		self.Weapon:EmitSound(Sound("weapons/zoom.wav"))
	end
end 

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

		self.Weapon:EmitSound(Sound( "marker/pbfire.wav" ))
		self.Weapon:SetNextPrimaryFire( CurTime() + 0.10 )
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
		phys:ApplyForceCenter(self.Owner:GetAimVector() * 30000 )
	end
end

function SWEP:ShootEffects()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end