
local difficulties = {
	veryeasy = 1,
	easy 	 = 2,
	normal   = 3,
	hard     = 4,
	veryhard = 5,
	epic     = 6,
	--survival = 6,
}

local difficulty = difficulties[Spring.GetModOptions().raptor_difficulty]
local burrowName = 'raptor_hive'

local raptorTurrets
if not Spring.GetModOptions().unit_restrictions_nonukes then
	raptorTurrets = {
		["raptor_turrets"] 			= { minQueenAnger = 0, 		spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 50,},
		["raptor_turrets_antiair"] 	= { minQueenAnger = 0, 		spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 50,},
		["raptor_turrets_acid"] 		= { minQueenAnger = 25, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 75,},
		["raptor_turrets_electric"] 	= { minQueenAnger = 25, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 75,},
		["raptor_turretl"] 			= { minQueenAnger = 50, 	spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 1000,},
		["raptor_turretl_antiair"] 	= { minQueenAnger = 50, 	spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 1000,},
		["raptor_turretl_acid"] 		= { minQueenAnger = 75, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 1000,},
		["raptor_turretl_electric"] 	= { minQueenAnger = 75, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 1000,},
		["raptor_turretxl_meteor"]		= { minQueenAnger = 75, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 1000,},
	}
else
	raptorTurrets = {
		["raptor_turrets"] 			= { minQueenAnger = 0, 		spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 50,},
		["raptor_turrets_antiair"] 	= { minQueenAnger = 0, 		spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 50,},
		["raptor_turrets_acid"] 		= { minQueenAnger = 25, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 75,},
		["raptor_turrets_electric"] 	= { minQueenAnger = 25, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 75,},
		["raptor_turretl"] 			= { minQueenAnger = 50, 	spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 1000,},
		["raptor_turretl_antiair"] 	= { minQueenAnger = 50, 	spawnedPerWave = 2,		spawnOnBurrows = true,	maxQueenAnger = 1000,},
		["raptor_turretl_acid"] 		= { minQueenAnger = 75, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 1000,},
		["raptor_turretl_electric"] 	= { minQueenAnger = 75, 	spawnedPerWave = 1,		spawnOnBurrows = false,	maxQueenAnger = 1000,},
	}
end

local raptorEggs = { -- Specify eggs dropped by unit here, requires useEggs to be true, if some unit is not specified here, it drops random egg colors.
	raptor1       						=   "purple",
	raptor1_mini						=   "purple",
	raptor1b      						=   "pink",
	raptor1c      						=   "purple",
	raptor1d      						=   "purple",
	raptor1x      						=   "pink",
	raptor1y      						=   "pink",
	raptor1z      						=   "pink",
	raptor2       						=   "pink",
	raptor2b      						=   "pink",
	raptora1      						=   "red",
	raptora1b     						=   "red",
	raptora1c     						=   "red",
	raptorallterraina1					=   "red",
	raptorallterraina1b				=   "red",
	raptorallterraina1c				=   "red",
	raptora2      						=   "red",
	raptora2b     						=   "red",
	raptorapexallterrainassault 		=   "red",
	raptorapexallterrainassaultb 		=   "red",
	raptors1      						=   "green",
	raptors2      						=   "green",
	raptor_dodo1  						=   "red",
	raptor_dodo2  						=   "red",
	raptor_dodoair  					=   "red",
	raptorf1_mini      				=   "darkgreen",
	raptorf1      						=   "darkgreen",
	raptorf1b     						=   "darkgreen",
	raptorf1apex      					=   "darkgreen",
	raptorf1apexb     					=   "darkgreen",
	raptorairscout1      				=   "white",
	raptorairscout2      				=   "white",
	raptorairscout3      				=   "white",
	raptorc3      						=   "white",
	raptorc3b     						=   "white",
	raptorc3c     						=   "white",
	raptorr1      						=   "darkgreen",
	raptorr2      						=   "darkgreen",
	raptorhealer1      				=   "white",
	raptorhealer2      				=   "white",
	raptorhealer3      				=   "white",
	raptorhealer4      				=   "white",
	raptorh1b     						=   "white",
	raptorh2      						=   "purple",
	raptorh3      						=   "purple",
	raptorh4      						=   "purple",
	raptorbroodbomberh2 				= 	"purple",
	raptorbroodbomberh3 				= 	"purple",
	raptorbroodbomberh4 				= 	"purple",
	raptorbroodartyh4 					= 	"purple",
	raptorbroodartyh4small 			= 	"purple",
	raptorh5      						=   "white",
	raptorw1      						=   "purple",
	raptorw1_mini      				=   "purple",
	raptorw1b     						=   "purple",
	raptorw1c     						=   "purple",
	raptorw1d     						=   "purple",
	raptorw2      						=   "darkred",
	raptorp1      						=   "darkred",
	raptorp2      						=   "darkred",
	raptorpyroallterrain				=	"darkred",
	raptore1	   						=   "blue",
	raptore2	   						=   "blue",
	raptorearty1  						=   "blue",
	raptorearty2  						=   "blue",
	raptorebomber1 					=   "blue",
	raptorelectricallterrain 			=   "blue",
	raptorelectricallterrainassault	=   "blue",
	raptor_dodo1_electric  			=   "blue",
	raptor_dodo2_electric  			=   "blue",
	raptoracidswarmer 					=   "acidgreen",
	raptoracidassault 					=   "acidgreen",
	raptoracidarty 					=   "acidgreen",
	raptoracidartyxl 					=   "acidgreen",
	raptoracidbomber 					=   "acidgreen",
	raptoracidallterrain				=	"acidgreen",
	raptoracidallterrainassault		=   "acidgreen",
	raptor1x_spectre					=   "yellow",
	raptor2_spectre					=   "yellow",
	raptora1_spectre					=   "yellow",
	raptora2_spectre					=   "yellow",
	raptors2_spectre					=   "yellow",

	raptor_miniqueen_electric			=   "blue",
	raptor_miniqueen_acid				=   "acidgreen",
	raptor_miniqueen_healer			=  	"white",
	raptor_miniqueen_basic 			=  	"pink",
	raptor_miniqueen_fire 				=  	"darkred",
	raptor_miniqueen_spectre 			=  	"yellow",
}

raptorBehaviours = {
	SKIRMISH = { -- Run away from target after target gets hit
		[UnitDefNames["raptors1"].id] = { distance = 270, chance = 0.5 },
		[UnitDefNames["raptors2"].id] = { distance = 250, chance = 0.5 },
		[UnitDefNames["raptorr1"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptorr2"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptore1"].id] = { distance = 300, chance = 1 },
		[UnitDefNames["raptore2"].id] = { distance = 200, chance = 0.01 },
		[UnitDefNames["raptorelectricallterrainassault"].id] = { distance = 200, chance = 0.01 },
		[UnitDefNames["raptorearty1"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptorearty2"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptorelectricallterrain"].id] = { distance = 300, chance = 1 },
		[UnitDefNames["raptoracidswarmer"].id] = { distance = 300, chance = 1 },
		[UnitDefNames["raptoracidassault"].id] = { distance = 200, chance = 1 },
		[UnitDefNames["raptoracidallterrainassault"].id] = { distance = 200, chance = 1 },
		[UnitDefNames["raptoracidarty"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptoracidartyxl"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptoracidallterrain"].id] = { distance = 300, chance = 1 },
		[UnitDefNames["raptorh2"].id] = { distance = 500, chance = 0.25 },
		[UnitDefNames["raptorbroodartyh4small"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorbroodartyh4"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptor1x_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptor2_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptors2_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptora1_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptora2_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptor_miniqueen_spectre"].id] = {distance = 500, chance = 0.01, teleport = true, teleportcooldown = 2 },
		[UnitDefNames["raptor_miniqueen_electric"].id] = {distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_acid"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_healer"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_basic"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_fire"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["ve_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["e_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["n_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["h_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["vh_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["epic_raptorq"].id] = { distance = 500, chance = 0.005 },
	},
	COWARD = { -- Run away from target after getting hit by enemy
		[UnitDefNames["raptorhealer1"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorhealer2"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorhealer3"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorhealer4"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorh1b"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptors1"].id] = { distance = 270, chance = 0.5 },
		[UnitDefNames["raptors2"].id] = { distance = 250, chance = 0.5 },
		[UnitDefNames["raptorr1"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorr2"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptorearty1"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorearty2"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptoracidarty"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptoracidartyxl"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptorbroodartyh4small"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorbroodartyh4"].id] = { distance = 500, chance = 0.1 },
		[UnitDefNames["raptorh2"].id] = { distance = 500, chance = 1 },
		[UnitDefNames["raptorh3"].id] = { distance = 500, chance = 0.25 },
		[UnitDefNames["raptor1x_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptor2_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptors2_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptora1_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptora2_spectre"].id] = { distance = 500, chance = 0.25, teleport = true, teleportcooldown = 2,},
		[UnitDefNames["raptor_miniqueen_spectre"].id] = { distance = 500, chance = 0.01, teleport = true, teleportcooldown = 2 },
		[UnitDefNames["raptor_miniqueen_electric"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_acid"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_healer"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_basic"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_fire"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["ve_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["e_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["n_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["h_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["vh_raptorq"].id] = { distance = 500, chance = 0.005 },
		[UnitDefNames["epic_raptorq"].id] = { distance = 500, chance = 0.005 },
	},
	BERSERK = { -- Run towards target after getting hit by enemy or after hitting the target
		[UnitDefNames["raptors2"].id] = {chance = 0.2, distance = 750},
		[UnitDefNames["raptora1"].id] = { chance = 0.2, distance = 1500 },
		[UnitDefNames["raptora1b"].id] = { chance = 0.2, distance = 1500 },
		[UnitDefNames["raptora1c"].id] = { chance = 0.2, distance = 1500 },
		[UnitDefNames["raptorallterraina1"].id] = { chance = 0.2, distance = 1500 },
		[UnitDefNames["raptorallterraina1b"].id] = { chance = 0.2, distance = 1500 },
		[UnitDefNames["raptorallterraina1c"].id] = { chance = 0.2, distance = 1500 },
		[UnitDefNames["raptora2"].id] = { chance = 0.2, distance = 3000 },
		[UnitDefNames["raptora2b"].id] = { chance = 0.2, distance = 3000 },
		[UnitDefNames["raptorapexallterrainassault"].id] = { chance = 0.2, distance = 3000 },
		[UnitDefNames["raptorapexallterrainassaultb"].id] = { chance = 0.2, distance = 3000 },
		[UnitDefNames["raptore2"].id] = { chance = 0.05 },
		[UnitDefNames["raptorelectricallterrainassault"].id] = { chance = 0.05 },
		[UnitDefNames["raptoracidassault"].id] = { chance = 0.05 },
		[UnitDefNames["raptoracidallterrainassault"].id] = { chance = 0.05 },
		[UnitDefNames["raptoracidswarmer"].id] = { chance = 0.01 },
		[UnitDefNames["raptoracidallterrain"].id] = { chance = 0.01 },
		[UnitDefNames["raptorp1"].id] = { chance = 0.2 },
		[UnitDefNames["raptorp2"].id] = { chance = 0.2 },
		[UnitDefNames["raptorpyroallterrain"].id] = { chance = 0.2 },
		[UnitDefNames["raptorh4"].id] = { chance = 1 },
		[UnitDefNames["raptor1x_spectre"].id] = { distance = 1000, chance = 0.25},
		[UnitDefNames["raptor2_spectre"].id] = { distance = 1000, chance = 0.25},
		[UnitDefNames["raptora1_spectre"].id] = { distance = 1000, chance = 0.25},
		[UnitDefNames["raptora2_spectre"].id] = { distance = 1000, chance = 0.25},
		[UnitDefNames["raptors2_spectre"].id] = { distance = 1000, chance = 0.25},
		[UnitDefNames["raptor_miniqueen_spectre"].id] = {distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_electric"].id] = {distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_acid"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_healer"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_basic"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["raptor_miniqueen_fire"].id] = { distance = 500, chance = 0.01 },
		[UnitDefNames["ve_raptorq"].id] = { chance = 0.05 },
		[UnitDefNames["e_raptorq"].id] = { chance = 0.05 },
		[UnitDefNames["n_raptorq"].id] = { chance = 0.05 },
		[UnitDefNames["h_raptorq"].id] = { chance = 0.05 },
		[UnitDefNames["vh_raptorq"].id] = { chance = 0.05 },
		[UnitDefNames["epic_raptorq"].id] = { chance = 0.05 },
	},
	HEALER = { -- Getting long max lifetime and always use Fight command. These units spawn as healers from burrows and queen
		[UnitDefNames["raptorhealer1"].id] = true,
		[UnitDefNames["raptorhealer2"].id] = true,
		[UnitDefNames["raptorhealer3"].id] = true,
		[UnitDefNames["raptorhealer4"].id] = true,
		[UnitDefNames["raptorh1b"].id] = true,
	},
	ARTILLERY = { -- Long lifetime and no regrouping, always uses Fight command to keep distance, friendly fire enabled (assuming nothing else in the game stops it)
		[UnitDefNames["raptorr1"].id] = true,
		[UnitDefNames["raptorr2"].id] = true,
		[UnitDefNames["raptorearty1"].id] = true,
		[UnitDefNames["raptorearty2"].id] = true,
		[UnitDefNames["raptoracidarty"].id] = true,
		[UnitDefNames["raptoracidartyxl"].id] = true,
		[UnitDefNames["raptorbroodartyh4"].id] = true,
		[UnitDefNames["raptorbroodartyh4small"].id] = true,
		[UnitDefNames["raptor_turretxl_meteor"].id] = true,
	},
	KAMIKAZE = { -- Long lifetime and no regrouping, always uses Move command to rush into the enemy
		[UnitDefNames["raptor_dodo1"].id] = true,
		[UnitDefNames["raptor_dodo2"].id] = true,
		[UnitDefNames["raptor_dodo1_electric"].id] = true,
		[UnitDefNames["raptor_dodo2_electric"].id] = true,
	},
	PROBE_UNIT = UnitDefNames["raptor2"].id, -- tester unit for picking viable spawn positions - use some medium sized unit
}

local optionValues = {

	[difficulties.veryeasy] = {
		gracePeriod       = 8 * Spring.GetModOptions().raptor_graceperiodmult * 60,
		queenTime      	  = 50 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
		raptorSpawnRate  = 120,
		burrowSpawnRate   = 480,
		turretSpawnRate   = 240,
		queenSpawnMult    = 1,
		angerBonus        = 1,
		maxXP			  = 0.5,
		spawnChance       = 0.1,
		damageMod         = 0.4,
		maxBurrows        = 1000,
		minRaptors		  = 5,
		maxRaptors		  = 25,
		raptorPerPlayerMultiplier = 0.25,
		queenName         = 've_raptorq',
		queenResistanceMult   = 0.5,
	},

	[difficulties.easy] = {
		gracePeriod       = 7 * Spring.GetModOptions().raptor_graceperiodmult * 60,
		queenTime      	  = 45 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
		raptorSpawnRate  = 90,
		burrowSpawnRate   = 420,
		turretSpawnRate   = 210,
		queenSpawnMult    = 1,
		angerBonus        = 1,
		maxXP			  = 1,
		spawnChance       = 0.2,
		damageMod         = 0.6,
		maxBurrows        = 1000,
		minRaptors		  = 5,
		maxRaptors		  = 30,
		raptorPerPlayerMultiplier = 0.25,
		queenName         = 'e_raptorq',
		queenResistanceMult   = 0.75,
	},
	[difficulties.normal] = {
		gracePeriod       = 6 * Spring.GetModOptions().raptor_graceperiodmult * 60,
		queenTime      	  = 40 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
		raptorSpawnRate  = 60,
		burrowSpawnRate   = 360,
		turretSpawnRate   = 180,
		queenSpawnMult    = 3,
		angerBonus        = 1,
		maxXP			  = 1.5,
		spawnChance       = 0.3,
		damageMod         = 0.8,
		maxBurrows        = 1000,
		minRaptors		  = 5,
		maxRaptors		  = 35,
		raptorPerPlayerMultiplier = 0.25,
		queenName         = 'n_raptorq',
		queenResistanceMult   = 1,
	},
	[difficulties.hard] = {
		gracePeriod       = 5 * Spring.GetModOptions().raptor_graceperiodmult * 60,
		queenTime      	  = 40 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
		raptorSpawnRate  = 50,
		burrowSpawnRate   = 300,
		turretSpawnRate   = 150,
		queenSpawnMult    = 3,
		angerBonus        = 1,
		maxXP			  = 2,
		spawnChance       = 0.4,
		damageMod         = 1,
		maxBurrows        = 1000,
		minRaptors		  = 5,
		maxRaptors		  = 40,
		raptorPerPlayerMultiplier = 0.25,
		queenName         = 'h_raptorq',
		queenResistanceMult   = 1.33,
	},
	[difficulties.veryhard] = {
		gracePeriod       = 4 * Spring.GetModOptions().raptor_graceperiodmult * 60,
		queenTime      	  = 35 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
		raptorSpawnRate  = 40,
		burrowSpawnRate   = 240,
		turretSpawnRate   = 120,
		queenSpawnMult    = 3,
		angerBonus        = 1,
		maxXP			  = 2.5,
		spawnChance       = 0.5,
		damageMod         = 1.2,
		maxBurrows        = 1000,
		minRaptors		  = 5,
		maxRaptors		  = 45,
		raptorPerPlayerMultiplier = 0.25,
		queenName         = 'vh_raptorq',
		queenResistanceMult   = 1.67,
	},
	[difficulties.epic] = {
		gracePeriod       = 3 * Spring.GetModOptions().raptor_graceperiodmult * 60,
		queenTime      	  = 30 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
		raptorSpawnRate  = 30,
		burrowSpawnRate   = 180,
		turretSpawnRate   = 90,
		queenSpawnMult    = 3,
		angerBonus        = 1,
		maxXP			  = 3,
		spawnChance       = 0.6,
		damageMod         = 1.4,
		maxBurrows        = 1000,
		minRaptors		  = 5,
		maxRaptors		  = 50,
		raptorPerPlayerMultiplier = 0.25,
		queenName         = 'epic_raptorq',
		queenResistanceMult   = 2,
	},

	-- [difficulties.survival] = {
	-- 	gracePeriod       = 8 * Spring.GetModOptions().raptor_graceperiodmult * 60,
	-- 	queenTime      	  = 50 * Spring.GetModOptions().raptor_queentimemult * 60, -- time at which the queen appears, frames
	-- 	raptorSpawnRate  = 120,
	-- 	burrowSpawnRate   = 480,
	-- 	turretSpawnRate   = 240,
	-- 	queenSpawnMult    = 1,
	-- 	angerBonus        = 1,
	-- 	maxXP			  = 0.5,
	-- 	spawnChance       = 0.1,
	-- 	damageMod         = 0.4,
	-- 	maxBurrows        = 1000,
	-- 	minRaptors		  = 5,
	-- 	maxRaptors		  = 25,
	-- 	raptorPerPlayerMultiplier = 0.25,
	-- 	queenName         = 've_raptorq',
	-- 	queenResistanceMult   = 0.5,
	-- },
}


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

local squadSpawnOptionsTable = {
	basic = {}, -- 67% spawn chance
	special = {}, -- 33% spawn chance, there's 1% chance of Special squad spawning Super squad, which is specials but 30% anger earlier.
	air = {}, -- Air waves
	healer = {}, -- Healers/Medics
}

local function addNewSquad(squadParams) -- params: {type = "basic", minAnger = 0, maxAnger = 100, units = {"1 raptor1"}, weight = 1}
	if squadParams then -- Just in case
		if not squadParams.units then return end
		if not squadParams.minAnger then squadParams.minAnger = 0 end
		if not squadParams.maxAnger then squadParams.maxAnger = 100 end -- Eliminate squads 100% after they're introduced by default, can be overwritten
		if squadParams.maxAnger >= 100 then squadParams.maxAnger = 1000 end -- basically infinite
		if not squadParams.weight then squadParams.weight = 1 end

		for _ = 1,squadParams.weight do
			table.insert(squadSpawnOptionsTable[squadParams.type], {minAnger = squadParams.minAnger, maxAnger = squadParams.maxAnger, units = squadParams.units, weight = squadParams.weight})
		end
	end
end

-- addNewSquad({type = "basic", minAnger = 0, units = {"1 raptor1"}}) -- Minimum
-- addNewSquad({type = "basic", minAnger = 0, units = {"1 raptor1"}, weight = 1, maxAnger = 100}) -- Full

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MiniBoss Squads ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local miniBosses = { -- Units that spawn alongside queen
	"raptor_miniqueen_electric", 	-- Electric Miniqueen
	"raptor_miniqueen_acid", 		-- Acid Miniqueen
	"raptor_miniqueen_healer", 	-- Healer Miniqueen
	"raptor_miniqueen_basic",		-- Basic Miniqueen
	"raptor_miniqueen_fire",		-- Pyro Miniqueen
	"raptor_miniqueen_spectre",	-- Spectre Miniqueen
}

local raptorMinions = { -- Units spawning other units
	["raptor_miniqueen_electric"] = {
		"raptore1",
		"raptore2",
		--"raptorearty1",
		"raptorelectricallterrain",
		"raptorelectricallterrainassault",
	},
	["raptor_miniqueen_acid"] = {
		"raptoracidswarmer",
		"raptoracidassault",
		--"raptoracidarty",
		"raptoracidallterrain",
		"raptoracidallterrainassault",
	},
	["raptor_miniqueen_healer"] = {
		"raptorhealer1",
		"raptorhealer2",
		"raptorhealer3",
		"raptorhealer4",
		--"raptorh1b",
	},
	["raptor_miniqueen_basic"] = {
		"raptor1",
		"raptor1x",
		"raptor2",
		"raptor2b",
		"raptorc3c",
	},
	["raptor_miniqueen_fire"] = {
		"raptorp1",
		"raptorp2",
		"raptorpyroallterrain",
	},
	["raptor_miniqueen_spectre"] = {
		"raptors2_spectre",
		"raptor1x_spectre",
		"raptor2_spectre",
		"raptora1_spectre",
		"raptora2_spectre",
	},
	["raptorh2"] = {
		"raptorh3",
		"raptorh4",
	},
	["raptorh3"] = {
		"raptorh4",
	},
	["raptorbroodartyh4"] = {
		"raptorh4",
		"raptorbroodartyh4small",
	},
	["ve_raptorq"] = {
		"raptorh2",
		"raptorh3",
		"raptorh4",
	},
	["e_raptorq"] = {
		"raptorh2",
		"raptorh3",
		"raptorh4",
		"raptorbroodartyh4small",
	},
	["n_raptorq"] = {
		"raptorh2",
		"raptorh3",
		"raptorh4",
		"raptorbroodartyh4small",
	},
	["h_raptorq"] = {
		"raptorh2",
		"raptorh3",
		"raptorh4",
		"raptorbroodartyh4small",
	},
	["vh_raptorq"] = {
		"raptorh2",
		"raptorh3",
		"raptorh4",
		"raptorbroodartyh4small",
	},
	["epic_raptorq"] = {
		"raptorh2",
		"raptorh3",
		"raptorh4",
		"raptorbroodartyh4small",
	},
}

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Squads -------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------
-- Basic --
-----------

-- Basic Swarmer
addNewSquad({ type = "basic", minAnger = 0, units = { "4 raptor1_mini" }, weight = 5, maxAnger = 30 })
addNewSquad({ type = "basic", minAnger = 5, units = { "4 raptor1" }, maxAnger = 70 })
addNewSquad({ type = "basic", minAnger = 5, units = { "4 raptor1b" }, maxAnger = 70 })
addNewSquad({ type = "basic", minAnger = 5, units = { "4 raptor1c" }, maxAnger = 70 })
addNewSquad({ type = "basic", minAnger = 5, units = { "4 raptor1d" }, maxAnger = 70 })

-- Better Swarmer
addNewSquad({ type = "basic", minAnger = 25, units = { "4 raptor1x" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 25, units = { "4 raptor1y" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 25, units = { "4 raptor1z" }, maxAnger = 1000 })

-- Brawlers
addNewSquad({ type = "basic", minAnger = 35, units = { "3 raptora1" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 35, units = { "3 raptora1b" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 35, units = { "3 raptora1c" }, maxAnger = 1000 })

-- Apex Swarmer and  Apex Brawler
addNewSquad({ type = "basic", minAnger = 65, units = { "4 raptor2b" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 65, units = { "4 raptor2" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 65, units = { "1 raptora2" }, maxAnger = 1000 })
addNewSquad({ type = "basic", minAnger = 65, units = { "1 raptora2b" }, maxAnger = 1000 })

-------------
-- Special --
-------------
addNewSquad({ type = "special", minAnger = 0, units = { "1 raptor1" }, maxAnger = 15 })
addNewSquad({ type = "special", minAnger = 0, units = { "1 raptor1b" }, maxAnger = 15 })
addNewSquad({ type = "special", minAnger = 0, units = { "1 raptor1c" }, maxAnger = 15 })
addNewSquad({ type = "special", minAnger = 0, units = { "1 raptor1d" }, maxAnger = 15 })

addNewSquad({ type = "special", minAnger = 10, units = { "1 raptor1x" }, maxAnger = 25 })
addNewSquad({ type = "special", minAnger = 10, units = { "1 raptor1y" }, maxAnger = 25 })
addNewSquad({ type = "special", minAnger = 10, units = { "1 raptor1z" }, maxAnger = 25 })

addNewSquad({ type = "special", minAnger = 20, units = { "5 raptorp1" } })
addNewSquad({ type = "special", minAnger = 20, units = { "3 raptore1" } })
addNewSquad({ type = "special", minAnger = 20, units = { "4 raptor1x" }, maxAnger = 40 })
addNewSquad({ type = "special", minAnger = 20, units = { "4 raptor1y" }, maxAnger = 40 })
addNewSquad({ type = "special", minAnger = 20, units = { "4 raptor1z" }, maxAnger = 40 })

addNewSquad({ type = "special", minAnger = 30, units = { "5 raptors1" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 30, units = { "10 raptorp1" } })

addNewSquad({ type = "special", minAnger = 30, units = { "15 raptor_dodo1_electric" } })
addNewSquad({ type = "special", minAnger = 30, units = { "15 raptorc3" }, weight = 3 })

addNewSquad({ type = "special", minAnger = 40, units = { "3 raptore2" } })
addNewSquad({ type = "special", minAnger = 40, units = { "10 raptoracidswarmer" } })
addNewSquad({ type = "special", minAnger = 40, units = { "10 raptor1x_spectre" } })
addNewSquad({ type = "special", minAnger = 40, units = { "10 raptorc3b" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 40, units = { "15 raptor_dodo1" } })
addNewSquad({ type = "special", minAnger = 40, units = { "10 raptor_dodo1", "10 raptor_dodo1_electric" } })

addNewSquad({ type = "special", minAnger = 50, units = { "10 raptorpyroallterrain" } })
addNewSquad({ type = "special", minAnger = 50, units = { "10 raptorelectricallterrain" } })
addNewSquad({ type = "special", minAnger = 50, units = { "5 raptore1", "5 raptoracidswarmer" } })
addNewSquad({ type = "special", minAnger = 50, units = { "3 raptorr1" } })
addNewSquad({ type = "special", minAnger = 50, units = { "3 raptoracidarty" } })
addNewSquad({ type = "special", minAnger = 50, units = { "3 raptorearty1" } })
addNewSquad({ type = "special", minAnger = 50, units = { "3 raptorbroodartyh4small" } })
addNewSquad({ type = "special", minAnger = 50, units = { "5 raptorc3c" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 50, units = { "6 raptorallterraina1" }, weight = 2 })
addNewSquad({ type = "special", minAnger = 50, units = { "6 raptorallterraina1b" }, weight = 2 })
addNewSquad({ type = "special", minAnger = 50, units = { "6 raptorallterraina1c" }, weight = 2 })
addNewSquad({ type = "special", minAnger = 50, units = { "6 raptora1_spectre" } })
addNewSquad({ type = "special", minAnger = 50, units = { "5 raptorelectricallterrain", "5 raptoracidallterrain" } })
addNewSquad({ type = "special", minAnger = 50, units = { "5 raptorh4" } })

addNewSquad({ type = "special", minAnger = 60, units = { "8 raptorp2" } })
addNewSquad({ type = "special", minAnger = 60, units = { "3 raptore2" } })
addNewSquad({ type = "special", minAnger = 60, units = { "3 raptorelectricallterrainassault" } })
addNewSquad({ type = "special", minAnger = 60, units = { "10 raptors2" }, weight = 2 })
addNewSquad({ type = "special", minAnger = 60, units = { "5 raptorh4" } })
addNewSquad({ type = "special", minAnger = 60, units = { "25 raptor_dodo2_electric" } })

addNewSquad({ type = "special", minAnger = 70, units = { "25 raptor_dodo2" } })
addNewSquad({ type = "special", minAnger = 70, units = { "20 raptor_dodo2", "20 raptor_dodo2_electric" } })
addNewSquad({ type = "special", minAnger = 70, units = { "10 raptoracidallterrain" } })
addNewSquad({ type = "special", minAnger = 70, units = { "4 raptoracidassault" } })
addNewSquad({ type = "special", minAnger = 70, units = { "3 raptore2" } })
addNewSquad({ type = "special", minAnger = 70, units = { "4 raptoracidallterrainassault" } })
addNewSquad({ type = "special", minAnger = 70, units = { "3 raptorh3" } })
addNewSquad({ type = "special", minAnger = 70, units = { "5 raptorh4" } })
addNewSquad({ type = "special", minAnger = 70, units = { "5 raptor2_spectre" } })
addNewSquad({ type = "special", minAnger = 70, units = { "10 raptors2_spectre" } })
addNewSquad({ type = "special", minAnger = 70, units = { "1 raptorr2" } })
addNewSquad({ type = "special", minAnger = 70, units = { "1 raptorearty2" } })
addNewSquad({ type = "special", minAnger = 70, units = { "1 raptoracidartyxl" } })
addNewSquad({ type = "special", minAnger = 70, units = { "1 raptorbroodartyh4" } })

addNewSquad({ type = "special", minAnger = 80, units = { "2 raptorapexallterrainassault" } })
addNewSquad({ type = "special", minAnger = 80, units = { "2 raptorapexallterrainassaultb" } })
addNewSquad({ type = "special", minAnger = 80, units = { "4 raptora2_spectre" } })
addNewSquad({ type = "special", minAnger = 80, units = { "3 raptorr1" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 80, units = { "3 raptorh3" } })
addNewSquad({ type = "special", minAnger = 80, units = { "10 raptorh4" } })
addNewSquad({ type = "special", minAnger = 80, units = { "1 raptorr2" } })
addNewSquad({ type = "special", minAnger = 80, units = { "1 raptorearty2" } })
addNewSquad({ type = "special", minAnger = 80, units = { "1 raptoracidartyxl" } })
addNewSquad({ type = "special", minAnger = 80, units = { "1 raptorbroodartyh4" } })

addNewSquad({ type = "special", minAnger = 90, units = { "2 raptorapexallterrainassault" } })
addNewSquad({ type = "special", minAnger = 90, units = { "2 raptorapexallterrainassaultb" } })
addNewSquad({ type = "special", minAnger = 90, units = { "4 raptora2_spectre" } })
addNewSquad({ type = "special", minAnger = 90, units = { "3 raptorr1" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 90, units = { "2 raptorh2" } })
addNewSquad({ type = "special", minAnger = 90, units = { "3 raptorh3" } })
addNewSquad({ type = "special", minAnger = 90, units = { "10 raptorh4" } })
addNewSquad({ type = "special", minAnger = 90, units = { "1 raptorr2" } })
addNewSquad({ type = "special", minAnger = 90, units = { "1 raptorearty2" } })
addNewSquad({ type = "special", minAnger = 90, units = { "1 raptoracidartyxl" } })
addNewSquad({ type = "special", minAnger = 90, units = { "1 raptorbroodartyh4" } })

addNewSquad({ type = "special", minAnger = 100, units = { "5 raptorapexallterrainassault" } })
addNewSquad({ type = "special", minAnger = 100, units = { "5 raptorapexallterrainassaultb" } })
addNewSquad({ type = "special", minAnger = 100, units = { "10 raptora2_spectre" } })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptorr1" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptorearty1" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptoracidarty" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptorbroodartyh4small" }, weight = 3 })
addNewSquad({ type = "special", minAnger = 100, units = { "2 raptorh2" } })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptore2" } })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptorelectricallterrainassault" } })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptoracidassault" } })
addNewSquad({ type = "special", minAnger = 100, units = { "3 raptoracidallterrainassault" } })
addNewSquad({ type = "special", minAnger = 100, units = { "25 raptor_dodo2" } })
addNewSquad({ type = "special", minAnger = 100, units = { "25 raptor_dodo2_electric" } })
addNewSquad({ type = "special", minAnger = 100, units = { "20 raptor_dodo2", "20 raptor_dodo2_electric" } })
addNewSquad({ type = "special", minAnger = 100, units = { "10 raptorp2" } })
addNewSquad({ type = "special", minAnger = 100, units = { "10 raptors2" }, weight = 2 })
addNewSquad({ type = "special", minAnger = 100, units = { "10 raptors2_spectre" } })
addNewSquad({ type = "special", minAnger = 100, units = { "2 raptorr2" } })
addNewSquad({ type = "special", minAnger = 100, units = { "2 raptorearty2" } })
addNewSquad({ type = "special", minAnger = 100, units = { "2 raptoracidartyxl" } })
addNewSquad({ type = "special", minAnger = 100, units = { "2 raptorbroodartyh4" } })

for j = 1, #miniBosses do
	addNewSquad({ type = "special", minAnger = 70, units = { "1 " .. miniBosses[j] }})
	addNewSquad({ type = "special", minAnger = 100, units = { "1 " .. miniBosses[j] }})
end

---------
-- Air --
---------

local airStartAnger = 0 -- needed for air waves to work correctly.

addNewSquad({ type = "air", minAnger = 0, units = { "1 raptorairscout1" }, maxAnger = 40 })

addNewSquad({ type = "air", minAnger = 20, units = { "4 raptorw1_mini" } })
addNewSquad({ type = "air", minAnger = 20, units = { "4 raptorf1_mini" } })

addNewSquad({ type = "air", minAnger = 33, units = { "1 raptorairscout2" }, maxAnger = 80 })

addNewSquad({ type = "air", minAnger = 40, units = { "4 raptorw1", } })
addNewSquad({ type = "air", minAnger = 40, units = { "4 raptorw1b", } })
addNewSquad({ type = "air", minAnger = 40, units = { "4 raptorw1c", } })
addNewSquad({ type = "air", minAnger = 40, units = { "4 raptorw1d", } })
addNewSquad({ type = "air", minAnger = 40, units = { "4 raptorf1", }, weight = 2 })
addNewSquad({ type = "air", minAnger = 40, units = { "4 raptorf1b", }, weight = 2 })

addNewSquad({ type = "air", minAnger = 50, units = { "2 raptorbroodbomberh4" } })

addNewSquad({ type = "air", minAnger = 60, units = { "4 raptorebomber1" } })
addNewSquad({ type = "air", minAnger = 60, units = { "4 raptoracidbomber" } })

addNewSquad({ type = "air", minAnger = 66, units = { "1 raptorairscout3" } })

addNewSquad({ type = "air", minAnger = 70, units = { "10 raptor_dodoair" }, weight = 2 })
addNewSquad({ type = "air", minAnger = 70, units = { "2 raptorbroodbomberh3" } })
addNewSquad({ type = "air", minAnger = 70, units = { "2 raptorbroodbomberh4" } })

addNewSquad({ type = "air", minAnger = 80, units = { "2 raptorf1apex" } })
addNewSquad({ type = "air", minAnger = 80, units = { "2 raptorf1apexb" } })
addNewSquad({ type = "air", minAnger = 80, units = { "6 raptorw2" }, weight = 2 })

addNewSquad({ type = "air", minAnger = 90, units = { "10 raptor_dodoair" }, weight = 2 })
addNewSquad({ type = "air", minAnger = 90, units = { "2 raptorbroodbomberh2" } })
addNewSquad({ type = "air", minAnger = 90, units = { "2 raptorbroodbomberh3" } })
addNewSquad({ type = "air", minAnger = 90, units = { "2 raptorbroodbomberh4" } })

addNewSquad({ type = "air", minAnger = 100, units = { "3 raptorf1apex" } })
addNewSquad({ type = "air", minAnger = 100, units = { "3 raptorf1apexb" } })
addNewSquad({ type = "air", minAnger = 100, units = { "8 raptorw2" }, weight = 2 })
addNewSquad({ type = "air", minAnger = 100, units = { "10 raptor_dodoair" }, weight = 2 })
addNewSquad({ type = "air", minAnger = 100, units = { "4 raptorbroodbomberh4" } })
addNewSquad({ type = "air", minAnger = 100, units = { "4 raptorbroodbomberh3" } })
addNewSquad({ type = "air", minAnger = 100, units = { "4 raptorbroodbomberh2" } })

------------
-- Healer --
------------

addNewSquad({ type = "healer", minAnger = 0, units = { "1 raptorhealer1" }, maxAnger = 35 })

addNewSquad({ type = "healer", minAnger = 25, units = { "2 raptorhealer1" }, maxAnger = 60 })
addNewSquad({ type = "healer", minAnger = 25, units = { "1 raptorhealer2" }, maxAnger = 60 })

addNewSquad({ type = "healer", minAnger = 50, units = { "2 raptorhealer2" }, maxAnger = 85 })
addNewSquad({ type = "healer", minAnger = 50, units = { "1 raptorhealer3" }, maxAnger = 85 })


addNewSquad({ type = "healer", minAnger = 75, units = { "2 raptorhealer3" }})
addNewSquad({ type = "healer", minAnger = 75, units = { "1 raptorhealer4" }})

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Settings -- Adjust these
local useEggs = true -- Drop eggs (requires egg features from Beyond All Reason)
local useScum = true -- Use scum as space where turrets can spawn (requires scum gadget from Beyond All Reason)
local useWaveMsg = true -- Show dropdown message whenever new wave is spawning
local spawnSquare = 90 -- size of the raptor spawn square centered on the burrow
local spawnSquareIncrement = 2 -- square size increase for each unit spawned
local minBaseDistance = 256 -- Minimum distance of new burrows from players and other burrows
local burrowTurretSpawnRadius = 80
local bossFightWaveSizeScale = 25 -- Percentage
local defaultRaptorFirestate = 3 -- 0 - Hold Fire | 1 - Return Fire | 2 - Fire at Will | 3 - Fire at everything

local ecoBuildingsPenalty = { -- Additional queen hatch per second from eco buildup (for 60 minutes queen time. scales to queen time)
	--[[
	-- T1 Energy
	[UnitDefNames["armsolar"].id] 	= 0.0000001,
	[UnitDefNames["corsolar"].id] 	= 0.0000001,
	[UnitDefNames["armwin"].id] 	= 0.0000001,
	[UnitDefNames["corwin"].id] 	= 0.0000001,
	[UnitDefNames["armtide"].id] 	= 0.0000001,
	[UnitDefNames["cortide"].id] 	= 0.0000001,
	[UnitDefNames["armadvsol"].id] 	= 0.000005,
	[UnitDefNames["coradvsol"].id] 	= 0.000005,

	-- T2 Energy
	[UnitDefNames["armwint2"].id] 	= 0.000075,
	[UnitDefNames["corwint2"].id] 	= 0.000075,
	[UnitDefNames["armfus"].id] 	= 0.000125,
	[UnitDefNames["armckfus"].id] 	= 0.000125,
	[UnitDefNames["corfus"].id] 	= 0.000125,
	[UnitDefNames["armuwfus"].id] 	= 0.000125,
	[UnitDefNames["coruwfus"].id] 	= 0.000125,
	[UnitDefNames["armafus"].id] 	= 0.0005,
	[UnitDefNames["corafus"].id] 	= 0.0005,

	-- T1 Metal Makers
	[UnitDefNames["armmakr"].id] 	= 0.00005,
	[UnitDefNames["cormakr"].id] 	= 0.00005,
	[UnitDefNames["armfmkr"].id] 	= 0.00005,
	[UnitDefNames["corfmkr"].id] 	= 0.00005,

	-- T2 Metal Makers
	[UnitDefNames["armmmkr"].id] 	= 0.0005,
	[UnitDefNames["cormmkr"].id] 	= 0.0005,
	[UnitDefNames["armuwmmm"].id] 	= 0.0005,
	[UnitDefNames["coruwmmm"].id] 	= 0.0005,
	]]--
}

local highValueTargets = { -- Priority targets for Raptors. Must be immobile to prevent issues.
	-- T2 Energy
	[UnitDefNames["armwint2"].id] 	= true,
	[UnitDefNames["corwint2"].id] 	= true,
	[UnitDefNames["armfus"].id] 	= true,
	[UnitDefNames["armckfus"].id] 	= true,
	[UnitDefNames["corfus"].id] 	= true,
	[UnitDefNames["armuwfus"].id] 	= true,
	[UnitDefNames["coruwfus"].id] 	= true,
	[UnitDefNames["armafus"].id] 	= true,
	[UnitDefNames["corafus"].id] 	= true,
	-- T2 Metal Makers
	[UnitDefNames["armmmkr"].id] 	= true,
	[UnitDefNames["cormmkr"].id] 	= true,
	[UnitDefNames["armuwmmm"].id] 	= true,
	[UnitDefNames["coruwmmm"].id] 	= true,

	[UnitDefNames["cormoho"].id] 	= true,
	[UnitDefNames["armmoho"].id] 	= true,
}

local config = { -- Don't touch this! ---------------------------------------------------------------------------------------------------------------------------------------------
	useEggs 				= useEggs,
	useScum					= useScum,
	difficulty             	= difficulty,
	difficulties           	= difficulties,
	raptorEggs			   	= table.copy(raptorEggs),
	burrowName             	= burrowName,   -- burrow unit name
	burrowDef              	= UnitDefNames[burrowName].id,
	raptorSpawnMultiplier 	= Spring.GetModOptions().raptor_spawncountmult,
	burrowSpawnType        	= Spring.GetModOptions().raptor_raptorstart,
	swarmMode			   	= Spring.GetModOptions().raptor_swarmmode,
	spawnSquare            	= spawnSquare,
	spawnSquareIncrement   	= spawnSquareIncrement,
	minBaseDistance        	= minBaseDistance,
	raptorTurrets			= table.copy(raptorTurrets),
	miniBosses			   	= miniBosses,
	raptorMinions			= raptorMinions,
	raptorBehaviours 		= raptorBehaviours,
	difficultyParameters   	= optionValues,
	useWaveMsg 				= useWaveMsg,
	burrowTurretSpawnRadius = burrowTurretSpawnRadius,
	squadSpawnOptionsTable	= squadSpawnOptionsTable,
	airStartAnger			= airStartAnger,
	ecoBuildingsPenalty		= ecoBuildingsPenalty,
	highValueTargets		= highValueTargets,
	bossFightWaveSizeScale  = bossFightWaveSizeScale,
	defaultRaptorFirestate = defaultRaptorFirestate,
}

for key, value in pairs(optionValues[difficulty]) do
	config[key] = value
end

return config
