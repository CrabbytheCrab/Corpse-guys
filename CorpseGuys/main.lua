local mod = RegisterMod("CorpseGuys", 1)
local sound = SFXManager()
local game = Game()
local rng = RNG()




local SkinnyVariant ={
	 ROTTY2 = Isaac.GetEntityVariantByName("Level 2 Rotty")

	 }

function mod:IsDead(npc)
		  if npc.Variant == SkinnyVariant.ROTTY2 then
		local pos = npc.Position
		Isaac.Spawn(853,0,0,pos,Vector(0,0),npc)
		Isaac.Spawn(853,0,0,pos,Vector(0,0),npc)
		Isaac.Spawn(853,0,0,pos,Vector(0,0),npc)
		Isaac.Spawn(853,0,0,pos,Vector(0,0),npc)
		Isaac.Spawn(853,0,0,pos,Vector(0,0),npc)
		Isaac.Spawn(227,60,0,pos,Vector(0,0),npc)
	end
end
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.IsDead, EntityType.ENTITY_SKINNY)
local Level2GaperVariant ={
	 Peel = Isaac.GetEntityVariantByName("Peel")
	 }


	Level2GaperState = {
		WalkHORI = 0, 
		WALKVERT = 1, 
		HEAD = 2,
		HEAD2 = 3
	}


	function mod:onNpc(npc)
		if npc.Variant == Level2GaperVariant.Peel then
			if npc.HitPoints <= 15 then
		npc.Velocity = npc.Velocity * 1.1
		if npc:GetSprite():IsPlaying("WalkVert" or "WalkHori") then
			if npc:GetSprite():GetFrame() == 1 or npc:GetSprite():GetFrame() == 4 or npc:GetSprite():GetFrame() == 7 or npc:GetSprite():GetFrame() == 10 or npc:GetSprite():GetFrame() == 13 or npc:GetSprite():GetFrame() == 16 or npc:GetSprite():GetFrame() == 19 then
		local pos = npc.Position
		Isaac.Spawn(1000,22,0,pos,Vector(0,0),npc)
				end
			end
		end
	end
end
	
	mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onNpc,  EntityType.ENTITY_GAPER_L2)
	
function mod:TookDamage(npc, damageAmount)

	if npc.Type == 850 and npc.Variant == 4 and (npc.HitPoints-damageAmount) <= (npc.MaxHitPoints/2) then
		local sprite = npc:GetSprite()
		 sprite:ReplaceSpritesheet(0, "gfx/monsters/custom/Peel2.png")
		 sprite:LoadGraphics()
		 
		 for i=0, sprite:GetLayerCount() - 1 do
			sprite:ReplaceSpritesheet(i, "gfx/monsters/custom/Peel2.png")
		 end
		sprite:LoadGraphics()
	end	
end


mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , mod.TookDamage, EntityType.ENTITY_GAPER_L2)


	local BoneyVariant ={
	 OLDBONES = Isaac.GetEntityVariantByName("Aged Bony")
	 }

	 local BoneyVariant ={
		OLDERBONES = Isaac.GetEntityVariantByName("Aged Bony(Classic)")
		}
   

function mod:onNpc(npc)
	if npc.Variant == BoneyVariant.OLDBONES then
	npc.Velocity = Vector(0,0)
	npc:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
	npc:AddEntityFlags(EntityFlag.FLAG_NO_KNOCKBACK)
	npc:AddEntityFlags(EntityFlag.FLAG_NO_PHYSICS_KNOCKBACK)
		if npc:GetSprite().FlipX == true then
			if npc:GetSprite():IsPlaying("AttackUp") or 
			npc:GetSprite():IsPlaying("AttackDown") or 
			npc:GetSprite():IsPlaying("WalkHori") or
			npc:GetSprite():IsPlaying("WalkUp") or
			npc:GetSprite():IsPlaying("WalkDown") then
				npc:GetSprite().FlipX = false
			end
		end
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onNpc,  EntityType.ENTITY_BONY)

function mod:onNpcOld(npc)
	if npc.Variant == BoneyVariant.OLDERBONES then
		npc.Velocity = npc.Velocity * 1.1
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onNpcOld,  EntityType.ENTITY_BONY)
function mod:onUpdateProjectileBone(projectile, parrent)
	if projectile.SpawnerType == 227 and projectile.SpawnerVariant == 60 then
		local sprite = projectile:GetSprite()
		 sprite:ReplaceSpritesheet(0, "gfx/monsters/custom/Bone2.png")
		 sprite:LoadGraphics()
		 
		 for i=0, sprite:GetLayerCount() - 1 do
			sprite:ReplaceSpritesheet(i, "gfx/monsters/custom/Bone2.png")
		 end
		sprite:LoadGraphics()
	end	
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, mod.onUpdateProjectileBone)

local BoneyVariant ={
	CANARY = Isaac.GetEntityVariantByName("Canary")

	}

function mod:canary2(npc)
	local player = Isaac.GetPlayer(rng:RandomInt(game:GetNumPlayers()))
	local pos = npc.Position
	local posi = player.Position.X
	local vec = player.Position - npc.Position
	local canary = npc.Type == 227  and npc.Variant == 55
	x1 = player.Position.X
	x2 = npc.Position.X
	if npc.Type == 227  and npc.Variant == 55 and npc.SubType == 0 then
		if npc:GetSprite():IsEventTriggered("Fire") then
			if npc:GetSprite():IsPlaying("AttackUp") then
				if npc:GetSprite().FlipX == false then
					local laser = EntityLaser.ShootAngle(2, pos, -90, 7,Vector(-12,-30), npc):ToLaser()
					laser.DepthOffset = 0
				else
					local laser = EntityLaser.ShootAngle(2, pos, -90, 7,Vector(12,-30), npc):ToLaser()
					laser.DepthOffset = 0
				end
			end
			if npc:GetSprite():IsPlaying("AttackDown") then
				if npc:GetSprite().FlipX == false then
					local laser = EntityLaser.ShootAngle(2, pos, 90, 7,Vector(12,-30), npc):ToLaser()
					laser.DepthOffset = 20
				else
					local laser = EntityLaser.ShootAngle(2, pos, 90, 7,Vector(-12,-30), npc):ToLaser()
					laser.DepthOffset = 20
				end
			end
			if npc:GetSprite():IsPlaying("AttackHori") then
			local laser = EntityLaser.ShootAngle(2, pos, 0, 7,Vector(0, -25), npc):ToLaser()
			laser.Timeout = 7
			if npc:GetSprite().FlipX == true then
				laser.Angle = 180
				end
			end
		end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.canary2)

function mod:canary3(npc)
	local player = Isaac.GetPlayer(rng:RandomInt(game:GetNumPlayers()))
	local pos = npc.Position
	local posi = player.Position.X
	local vec = player.Position - npc.Position
	local canary = npc.Type == 227  and npc.Variant == 55
	x1 = player.Position.X
	x2 = npc.Position.X
	if npc.Type == 227  and npc.Variant == 55 and npc.SubType == 1 then
		if npc:GetSprite():IsEventTriggered("Fire") then
			if npc:GetSprite():IsPlaying("AttackUp") then
				local laser = EntityLaser.ShootAngle(2, pos, -90, 7,Vector(0,-30), npc):ToLaser()
					laser.DepthOffset = 0
			
			end
			if npc:GetSprite():IsPlaying("AttackDown") then
				local laser = EntityLaser.ShootAngle(2, pos, 90, 7,Vector(0,-30), npc):ToLaser()
				laser.DepthOffset = 20
				laser.CurveStrength = 20
			end	
			if npc:GetSprite():IsPlaying("AttackHori") then
			local laser = EntityLaser.ShootAngle(2, pos, 0, 7,Vector(0, -25), npc):ToLaser()
			laser.Timeout = 7
				if npc:GetSprite().FlipX == true then
					laser.Velocity = Vector(0, -25)
					end
				end
			end
		end
	end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.canary3)


function mod:canary(npc)
	if npc.Type == 843 then
		if npc.Velocity.X > npc.Velocity.Y then
			if npc.Velocity.X > 0 then
			npc:GetSprite():Play("WalkRight",true)
			else
			npc:GetSprite():Play("WalkLeft",true)
			end
			else
			if npc.Velocity.Y < 0 then
			npc:GetSprite():Play("WalkUp",true)
			else
			npc:GetSprite():Play("WalkDown",false)
			end
			end
			local target = npc:GetPlayerTarget()
			npc.Pathfinder:MoveRandomly(3, true)
			if math.abs(npc.Velocity.X) > 0 then
				npc.Velocity.Y = 0
			end
			if math.abs(npc.Velocity.Y) > 0 then
				npc.Velocity.X = 0
			end
	end
end
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.canary)

local TarBoyVariant ={
	 MINI_HUSH = Isaac.GetEntityVariantByName("Hush Boy")
	 }
function mod:VariantCreep(effect)
	if	effect.SpawnerType == 307 and effect.SpawnerVariant == 1 then
               	 local color = Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36)
					effect:GetSprite().Color = color
	end
end
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.VariantCreep)
	TearVariant.NECRO = 6969
	TearVariant.NECRO = Isaac.GetEntityVariantByName("MiniHushTear")


	function mod:tarboyPostUpdate(npc, projectile, player)
		if npc.Type == 307 and npc.Variant == 1 then
		if npc:GetSprite():IsEventTriggered("Fire") then
			local player = Isaac.GetPlayer(rng:RandomInt(game:GetNumPlayers()))
				local pos = npc.Position
				local vec = player.Position - npc.Position
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(45) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(90) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(135) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(180) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(225) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(270) * 8,npc)
				Isaac.Spawn(9,6,0,pos,vec:Normalized(1,1):Rotated(315) * 8,npc)
		end
	end
end

function mod:ProjectileHush(projectile)
		if projectile.SpawnerType == 307 and projectile.SpawnerVariant == 1 then
			if projectile.Variant == 6 then
            	local color = Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36)
				projectile:GetSprite().Color = color
		end
	end
end
function mod:onUpdateProjectile(projectile, effect, data)
	if projectile.SpawnerType == 307 and projectile.SpawnerVariant == 1 then
		local data = projectile:GetData()
		if projectile.Variant == ProjectileVariant.PROJECTILE_HUSH then
			if (projectile.Height >= -5 or projectile:CollidesWithGrid())
			and data.Gram == nil 
			then
				local pos = projectile.Position + Vector(0,0)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(0,16)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(16,0)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(-16,0)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(0,-16)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(-8,-8)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(8,8)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(8,-8)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)

				local pos = projectile.Position + Vector(-8,8)
				data.Gram = Isaac.Spawn(1000,26,0,pos,Vector(0,0),projectile)
				data.Gram:SetColor(Color(0.2, 0.25, 0.36, 1, 0.2, 0.25, 0.36),0,0,false,false)
			end
		end
	end
end
function mod:tarboyPostUpdate2(npc, projectile, player)
	if npc.Type == 307 and npc.Variant == 1 then
		if npc:GetSprite():IsEventTriggered("Shoot") then
			local pos = npc.Position
			projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0),npc):ToProjectile()
			projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
			projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(120),npc):ToProjectile()
			projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
			projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(240),npc):ToProjectile()
			projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
		end
	end
end

function mod:tarboyPostUpdate3(npc, projectile, player)
	if npc.Type == 307 and npc.Variant == 1 then
		if npc:GetSprite():IsEventTriggered("Shoot2") then
			local pos = npc.Position
			projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(60),npc):ToProjectile()
			projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
			projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(180),npc):ToProjectile()
			projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
			projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(300),npc):ToProjectile()
			projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, mod.onUpdateProjectile)
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, mod.ProjectileHush) 

	mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, mod.Variant, ProjectileVariant.PROJECTILE_HUSH)
	mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.tarboyPostUpdate3)
	mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.tarboyPostUpdate2)
	mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.tarboyPostUpdate)

	function mod:delShot(npc, projectile, player)
		if npc.Type == 284 and npc.Variant == 888 then
			if npc:GetSprite():IsOverlayPlaying("Attack") then
				if npc:GetSprite():GetOverlayFrame() == 4 then
				local pos = npc.Position
				projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0),npc):ToProjectile()
				projectile:AddScale(1)
				projectile:AddProjectileFlags(ProjectileFlags.DECELERATE)
				projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
				projectile:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
				projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(90),npc):ToProjectile()
				projectile:AddScale(1)
				projectile:AddProjectileFlags(ProjectileFlags.DECELERATE)
				projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
				projectile:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
				projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(180),npc):ToProjectile()
				projectile:AddScale(1)
				projectile:AddProjectileFlags(ProjectileFlags.DECELERATE)
				projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
				projectile:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
				projectile = Isaac.Spawn(9,0,0,pos,Vector(5,0):Rotated(270),npc):ToProjectile()
				projectile:AddScale(1)
				projectile:AddProjectileFlags(ProjectileFlags.DECELERATE)
				projectile:AddProjectileFlags(ProjectileFlags.WIGGLE)
				projectile:AddProjectileFlags(ProjectileFlags.LASER_SHOT)
			end
		end
	end
end
	mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.delShot)

	function mod:white(projectile)
		if	projectile.SpawnerType == 284 and projectile.SpawnerVariant == 888 then
			if projectile.Type == 9 then
			local color = Color(1, 1, 1, 1, 0, 0, 0)
			color:SetColorize(3, 3, 3, 1)
			projectile:GetSprite().Color = color
		end
	end
end

mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, mod.white)
	
local CloggyVariant ={
	ROTMET = Isaac.GetEntityVariantByName("Dead Meat")
}

CloggyState = {
	HOP = 0, 
	IDLE = 1, 
	APPEAR = 2,
	ATTACK = 3
}

function mod:cloggyPostUpdate(npc)
	if npc.Type == 872 and npc.Variant == 777 then
	if npc:GetSprite():IsEventTriggered("Fire") then

			local pos = npc.Position
			Isaac.Spawn(18,0,0,pos,Vector(8,0),npc)
			Isaac.Spawn(18,0,0,pos,Vector(0,8),npc)
			Isaac.Spawn(18,0,0,pos,Vector(-8,0),npc)
			Isaac.Spawn(18,0,0,pos,Vector(0,-8),npc)
		end
	end
end


function mod:heartPostUpdate(npc, projectile)
	if npc.Type == 92 and npc.Variant == 100 then
	if npc:GetSprite():IsEventTriggered("Fire") then
			local pos = npc.Position
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(0),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(45),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(90),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(135),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(180),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(225),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(270),npc)
			Isaac.Spawn(9,6,0,pos,Vector(8,0):Rotated(315),npc)
			local color = Color(1, 0.5, 0, 1, 1, 0.5, 0)
			if npc.HitPoints <= 28 then
				local pos = npc.Position
				Isaac.Spawn(903,20,2,pos,Vector(8,0),npc)
			end
		end
	end
end

function mod:onUpdateProjectile2(projectile)
	if	projectile.SpawnerType == 92 and projectile.SpawnerVariant == 100 then
				if projectile.Type == 9 and projectile.Variant == 6 then
                	local color = Color(1, 0.25, 0, 1, 1, 0.125, 0)
					projectile:GetSprite().Color = color
		end
	end
end


mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.heartPostUpdate)
mod:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, mod.onUpdateProjectile2)

local MaskVariant ={
	Musk = Isaac.GetEntityVariantByName("VisMask")
	}



	function mod:onUpdateNpc(npc, player, effect)
		if npc.Type == 93 then 
			if npc.Variant == 100 then
				if npc:CollidesWithGrid() then
					local pos = npc.Position
					 Isaac.Spawn(1000,148,0,pos,Vector(0,0):Rotated(0),npc):ToEffect().Rotation = 90
					 Isaac.Spawn(1000,148,0,pos,Vector(0,0):Rotated(0),npc):ToEffect().Rotation = 180
					 Isaac.Spawn(1000,148,0,pos,Vector(0,0):Rotated(0),npc):ToEffect().Rotation = 270
					 Isaac.Spawn(1000,148,0,pos,Vector(0,0):Rotated(0),npc):ToEffect().Rotation = 360
				end
			end
		end
	end

	mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.onUpdateNpc)

function mod:TookDamage(npc, damageAmount)
	if npc.Type == 92 and npc.Variant == 100 and (npc.HitPoints-damageAmount) <= (npc.MaxHitPoints/2) then
		local sprite = npc:GetSprite()
		 sprite:ReplaceSpritesheet(0, "gfx/monsters/custom/VOOS2.png")
		 sprite:ReplaceSpritesheet(1, "gfx/bosses/repentance/visage_glow.png")
		 sprite:LoadGraphics()
		 
		 for i=0, sprite:GetLayerCount() - 1 do
			sprite:ReplaceSpritesheet(i, "gfx/monsters/custom/VOOS2.png")
		 end

		 for i=1, sprite:GetLayerCount() - 1 do
			sprite:ReplaceSpritesheet(i, "gfx/monsters/custom/VOOS2.png")
			sprite:ReplaceSpritesheet(i, "gfx/bosses/repentance/visage_glow.png")
		 end
		sprite:LoadGraphics()
	end	
end

function mod:visPostUpdate(npc, parent)
	if npc.Type == 903 and npc.Variant == 20 and npc.SubType == 2 then
		if npc:GetSprite():GetFrame() == 60 then
			npc:Remove()
		end
	end
end

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG , mod.TookDamage, EntityType.ENTITY_HEART)
mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.visPostUpdate)


local HiveVariant ={
	Del = Isaac.GetEntityVariantByName("Delirious Cultist")
}


HiveState = {
	WalkHORI = 0, 
	WALKVERT = 1, 
	HEADWalk = 2,
	APPEAR = 3,
	HEADATTACK = 4
}

function mod:hivePostUpdate(npc)
	if npc.Variant == HiveVariant.Del then
		if npc:GetSprite():IsOverlayPlaying("HeadAttack") then
			if npc:GetSprite():GetOverlayFrame() == 5 then
				local pos = npc.Position
				Isaac.Spawn(306,0,0,pos,Vector(0,0),npc)
			end
		end
	end
end

function mod:knightPostUpdate(npc)
	if npc.Type == 41 and npc.Variant == 5599 then
	if npc:GetSprite():IsEventTriggered("Spawn") then
			local pos = npc.Position
			Isaac.Spawn(1000,23,0,pos,Vector(0,0):Rotated(0),npc)
		end
	end
end

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.knightPostUpdate)

function mod:IsDead2(npc, explode)
	if npc.Type == 41 and npc.Variant == 5599 then
		local pos = npc.Position
		Isaac.Explode(pos,npc,1)
		Isaac.Spawn(1000,0,0,pos,Vector(0,0),npc )

		local pos = npc.Position + Vector(0,0)
		Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	  
	  local pos = npc.Position + Vector(0,24)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	   
	  local pos = npc.Position + Vector(24,0)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)

	  local pos = npc.Position + Vector(-24,0)
		Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	  
	  local pos = npc.Position + Vector(0,-24)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	   
	  local pos = npc.Position + Vector(-12,-12)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	   
	  local pos = npc.Position + Vector(12,12)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	   
	  local pos = npc.Position + Vector(12,-12)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)

	  local pos = npc.Position + Vector(-12,12)
		 Isaac.Spawn(1000,23,0,pos,Vector(0,0),npc)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, mod.IsDead2)

PortalState = {
	IDLE = 0, 
	APPEAR = 1, 
	DEATH = 2
}

local PortalVariant ={
	RIFT = Isaac.GetEntityVariantByName("Rift")
}

function mod:portalPostUpdate(npc)
	if npc.Type == 306 and npc.Variant == 10 and npc.SubType == 1 then
		print("a")
			if npc:GetSprite():IsEventTriggered("Fire") then
				print("b")
				local roll = npc:GetDropRNG():RandomInt(9)
				if roll == 1 then
					local pos = npc.Position
					Isaac.Spawn(10,0,0,pos,Vector(0,0),npc)
				end

				if roll == 2 then
					local pos = npc.Position
					Isaac.Spawn(10,1,0,pos,Vector(0,0),npc)
				end

				if roll == 3 then
					local pos = npc.Position
					Isaac.Spawn(12,0,0,pos,Vector(0,0),npc)
				end

				if roll == 4 then
					local pos = npc.Position
					Isaac.Spawn(281,0,0,pos,Vector(0,0),npc)
				end

				if roll == 6 then
					local pos = npc.Position
					Isaac.Spawn(222,0,0,pos,Vector(0,0),npc)
					Isaac.Spawn(222,0,0,pos,Vector(0,0),npc)
					Isaac.Spawn(222,0,0,pos,Vector(0,0),npc)
				end

				if roll == 7 then
					local pos = npc.Position
					Isaac.Spawn(868,0,0,pos,Vector(0,0),npc)
					Isaac.Spawn(868,0,0,pos,Vector(0,0),npc)
					Isaac.Spawn(868,0,0,pos,Vector(0,0),npc)
				end

				if roll == 8 then
					local pos = npc.Position
					Isaac.Spawn(14,1,0,pos,Vector(0,0),npc)
				end
		end
	end
end

function mod:portalPostUpdate2(npc)
	if npc.Type == 306 and npc.Variant == 10 and npc.SubType == 2 then
		print("a")
			if npc:GetSprite():IsEventTriggered("Fire") then
				print("b")
				local roll = npc:GetDropRNG():RandomInt(13)
				if roll == 1 then
					local pos = npc.Position
					Isaac.Spawn(14,2,0,pos,Vector(0,0),npc)
				end

				if roll == 2 then
					local pos = npc.Position
					Isaac.Spawn(22,3,0,pos,Vector(0,0),npc)
				end
			
				if roll == 3 then
					local pos = npc.Position
					Isaac.Spawn(25,6,0,pos,Vector(0,0),npc)
				end

				if roll == 4 then
					local pos = npc.Position
					Isaac.Spawn(29,3,0,pos,Vector(0,0),npc)
				end

				if roll == 5 then
					local pos = npc.Position
					Isaac.Spawn(31,1,0,pos,Vector(0,0),npc)
				end

				if roll == 6 then
					local pos = npc.Position
					Isaac.Spawn(61,7,0,pos,Vector(0,0),npc)
				end
				
				if roll == 7 then
					local pos = npc.Position
					Isaac.Spawn(240,3,0,pos,Vector(0,0),npc)
				end

				if roll == 8 then
 					local pos = npc.Position
					Isaac.Spawn(244,2,0,pos,Vector(0,0),npc)
				end

				if roll == 9 then
					local pos = npc.Position
				   Isaac.Spawn(244,3,0,pos,Vector(0,0),npc)
			   end

			   if roll == 10 then
				local pos = npc.Position
			   Isaac.Spawn(812,1,0,pos,Vector(0,0),npc)
		   end

			   if roll == 11 then
				local pos = npc.Position
			   Isaac.Spawn(827,1,0,pos,Vector(0,0),npc)
			end

			if roll == 12 then
				local pos = npc.Position
			   Isaac.Spawn(855,1,0,pos,Vector(0,0),npc)
			end

		end
	end
end

function mod:portalPostUpdate3(npc)
	if npc.Type == 306 and npc.Variant == 10 and npc.SubType == 3 then
		print("a")
			if npc:GetSprite():IsEventTriggered("Fire") then
				print("b")
				local roll = npc:GetDropRNG():RandomInt(10)
				if roll == 1 then
					local pos = npc.Position
					Isaac.Spawn(885,1,0,pos,Vector(0,0),npc)
				end

				if roll == 2 then
					local pos = npc.Position
					Isaac.Spawn(891,0,0,pos,Vector(0,0),npc)
				end

				if roll == 3 then
					local pos = npc.Position
					Isaac.Spawn(891,1,0,pos,Vector(0,0),npc)
				end

				if roll == 4 then
					local pos = npc.Position
					Isaac.Spawn(41,4,0,pos,Vector(0,0),npc)
				end

				if roll == 5 then
					local pos = npc.Position
					Isaac.Spawn(892,0,0,pos,Vector(0,0),npc)
				end

				if roll == 6 then
					local pos = npc.Position
					Isaac.Spawn(864,0,0,pos,Vector(0,0),npc)
				end

				if roll == 7 then
					local pos = npc.Position
					Isaac.Spawn(863,0,0,pos,Vector(0,0),npc)
				end
				
				if roll == 8 then
					local pos = npc.Position
					Isaac.Spawn(212,3,0,pos,Vector(0,0),npc)
				end

				if roll == 9 then
					local pos = npc.Position
					Isaac.Spawn(890,0,0,pos,Vector(0,0),npc)
				end
		end
	end
end

function mod:portalPostUpdate4(npc)
	if npc.Type == 306 and npc.Variant == 10 and npc.SubType == 4 then
		print("a")
			if npc:GetSprite():IsEventTriggered("Fire") then
				print("b")
				local roll = npc:GetDropRNG():RandomInt(10)
				if roll == 1 then
					local pos = npc.Position
					Isaac.Spawn(805,0,0,pos,Vector(0,0),npc)
				end

				if roll == 2 then
					local pos = npc.Position
					Isaac.Spawn(227,1,0,pos,Vector(0,0),npc)
				end

				if roll == 3 then
					local pos = npc.Position
					Isaac.Spawn(833,1,0,pos,Vector(0,0),npc)
				end

				if roll == 4 then
					local pos = npc.Position
					Isaac.Spawn(60,2,0,pos,Vector(0,0),npc)
				end

				if roll == 5 then
					local pos = npc.Position
					Isaac.Spawn(22,2,0,pos,Vector(0,0),npc)
				end

				if roll == 6 then
					local pos = npc.Position
					Isaac.Spawn(253,0,0,pos,Vector(0,0),npc)
				end

				if roll == 7 then
					local pos = npc.Position
					Isaac.Spawn(26,2,0,pos,Vector(0,0),npc)
				end
				
				if roll == 8 then
					local pos = npc.Position
					Isaac.Spawn(55,2,0,pos,Vector(0,0),npc)
				end

				if roll == 9 then
					local pos = npc.Position
					Isaac.Spawn(38,1,0,pos,Vector(0,0),npc)
				end
		end
	end
end


mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.portalPostUpdate4)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.portalPostUpdate3)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.portalPostUpdate)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.portalPostUpdate2)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.hivePostUpdate)

mod:AddCallback(ModCallbacks.MC_NPC_UPDATE, mod.cloggyPostUpdate)


local HOLY_CHANCE = 50

BeggarState = {
	IDLE = 0,
	PAYNOTHING = 1,
	PAYPRIZE = 2,
	PRIZE = 3,
	TELEPORT = 4
}

local CurStage
local RoomConfig

local Register

local SlotVariant ={
	 HOLYBEG = Isaac.GetEntityVariantByName("Holy Beggar")

	 }
function mod:beggarPostUpdate()
	for i = 1, game:GetNumPlayers(), 1 do
		local player=game:GetPlayer(i)
			for f, entity in pairs(Isaac.GetRoomEntities()) do
				if entity.Type == 6 and entity.Variant == 555 then
					local beggarFlags = EntityFlag.FLAG_NO_TARGET | EntityFlag.FLAG_NO_STATUS_EFFECTS
					if entity:GetEntityFlags() ~= beggarFlags then
					print("setting flags")
					entity:ClearEntityFlags(entity:GetEntityFlags())
					entity:AddEntityFlags(beggarFlags)
					entity.EntityCollisionClass = EntityCollisionClass.ENTCOLL_PLAYERONLY
					entity.SpriteOffset = Vector(0,4)
				end
				if entity:GetData().beggarstate == nil then
					entity:GetData().beggarstate = 0
					entity:GetData().blownup = false
				end
				if entity:GetData().beggarstate == 0 then
					if not entity:GetSprite():IsPlaying("Idle") then
						entity:GetSprite():Play("Idle", true)
					else
						local distance1 = (player.Position - entity.Position):Length()
						local distance2 = (player.Size + entity.Size)
						if distance1 < distance2 then
							if player:GetNumCoins() > 1 then
								player:AddCoins(-2)
								sound:Play(SoundEffect.SOUND_SCAMPER, 1, 0, false, 1)
								local prizerng = entity:GetDropRNG():RandomInt(100)
								if prizerng < HOLY_CHANCE then
									entity:GetData().beggarstate = 2
									entity:GetSprite():Play("PayPrize", true)
								else
									entity:GetData().beggarstate = 1
									entity:GetSprite():Play("PayNothing",true)
								end
							end
						end
					end
				end
				if entity:GetData().beggarstate == 1 then
					if entity:GetSprite():IsFinished("PayNothing") then
						entity:GetData().beggarstate = 0
					end
				end
				if entity:GetData().beggarstate == 2 then
					if entity:GetSprite():IsFinished("PayPrize") then
						entity:GetSprite():Play("Prize", true)
					end
					if entity:GetSprite():IsEventTriggered("Prize") then
						local pos = entity.Position
						local roll = entity:GetDropRNG():RandomInt(21)
						if roll < 7 then
							Isaac.Spawn(5,10,8,pos,Vector(0,3), entity)
						end
						if roll >= 8 and roll < 14 then
							Isaac.Spawn(5,10,3,pos,Vector(0,3), entity)
						end
						if roll >= 14 and roll < 17 then
							Isaac.Spawn(5,10,4,pos,Vector(0,3), entity)
						end
						if roll >= 17 then
							local pos = entity.Position
							local roll = entity:GetDropRNG():RandomInt(4)
							if roll == 1 then
							Isaac.Spawn(EntityType.ENTITY_PICKUP,
							PickupVariant.PICKUP_COLLECTIBLE,
							CollectibleType.COLLECTIBLE_HOLY_MANTLE,
							entity.Position + Vector(0,32),
							Vector(0,0),nil )
						entity:GetData().Payout = true
						end
						if roll == 2 then
							Isaac.Spawn(EntityType.ENTITY_PICKUP,
							PickupVariant.PICKUP_COLLECTIBLE,
							CollectibleType.COLLECTIBLE_HOLY_GRAIL,
							entity.Position + Vector(0,32),
							Vector(0,0),nil )
						entity:GetData().Payout = true
						end
						if roll == 3 then
							Isaac.Spawn(EntityType.ENTITY_PICKUP,
							PickupVariant.PICKUP_COLLECTIBLE,
							CollectibleType.COLLECTIBLE_HOLY_LIGHT,
							entity.Position + Vector(0,32),
							Vector(0,0),nil )
						entity:GetData().Payout = true
						end
					end
				end
					if entity:GetSprite():IsFinished("Prize") then
						SFXManager():Play(SoundEffect.SOUND_SLOTSPAWN, 1.0, 0, false, 1.0)
						if entity:GetData().Payout == true then
							entity:GetData().beggarstate = 3
							entity:GetSprite():Play("Teleport", true)
						sound:Play(SoundEffect.SOUND_SLOTSPAWN, 1, 0, false, 1)
						else entity:GetData().beggarstate = 0
							entity:GetSprite():Play("Idle", true)
					end
				end
			end
		end

				if entity:GetData().beggarstate == 3 then
					if entity:GetSprite():IsFinished("Teleport") then
						entity:Remove()
					end
				end
				if entity.GridCollisionClass == EntityGridCollisionClass.GRIDCOLL_GROUND then
				if entity:GetData().blownup==false then
					local pos = player.Position
					Isaac.Spawn(1000,19,0,pos,Vector(0,0),entity)
						for i = 1, math.random(5) do
							Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN,CoinSubType.COIN_PENNY,
								entity.Position, Vector((math.random(41)-21)/4,(math.random(41)-21)/4), nil)
						end
						entity:GetData().blownup=true
						entity:Remove()
						game:GetLevel():SetStateFlag(LevelStateFlag.STATE_BUM_KILLED, true)
						end

						if entity.Variant == SlotVariant.Beggar then
							local pos = entity.Position
							local roll = entity:GetRNG():RandomInt(21)
								if roll == 20 then
									Isaac.Spawn(6,555,0,pos,Vector(0,0), entity)
									entity:Remove()
								end
							end
					end
				end
				
			end
		end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.beggarPostUpdate)


