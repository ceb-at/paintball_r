AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

paintrocketdamage = tonumber(1)

concommand.Add("paintrocket_damage",SetRocketDamage)

function SetPaintDamage(ply,cmd,args)
	if cmd == "paintrocket_damage" then
		paintrocketdamage = tonumber(args[1])
	end
end

function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	
	local ent = ents.Create( "paint_ball_rocket" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent
	
end

function ENT:Initialize()
	
	self.Entity:SetModel( "models/props/cs_italy/orange.mdl" )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	 
	local phys = self.Entity:GetPhysicsObject()
	
		  if (phys:IsValid()) then
			phys:Wake()
		  end
end

function ENT:OnTakeDamage( dmginfo )

	// React physically when shot/getting blown
	self.Entity:TakePhysicsDamage( dmginfo )

end

function ENT:PhysicsCollide(data,phy)
	local trace = {}
	trace.filter = {self.Entity}
	data.HitNormal = data.HitNormal * -1
	local start = data.HitPos + data.HitNormal
	local endpos = data.HitPos - data.HitNormal
  
	util.Decal("splat"..math.random(1,12),start,endpos)
	self.Entity:EmitSound(Sound( "marker/pbhit.wav" ))

	util.BlastDamage(self.Entity:GetOwner(),self.Entity:GetOwner(),data.HitPos,1,paintballdamage)
	// if 
		// ( data.HitEntity:IsValid() && data.HitEntity:IsPlayer() ) then data.HitEntity:TakeDamage( 1, self.Owner ) 
	// end
	self.Entity:Fire("kill", "", 0)
end

function ENT:Touch(ent)
if ent:IsValid() then	
	self.Entity:Fire("kill", "", 0)
	end
end

function ENT:Use( activator, caller )
end

function ENT:Think()
end


