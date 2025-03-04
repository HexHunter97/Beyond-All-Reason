return {
	scavengerdroppodbeacon = {
		acceleration = 0,
		activatewhenbuilt = true,
		autoheal = 10,
		--bmcode = "0",
		blocking = false,
		brakerate = 0,
		buildcostenergy = 5000,
		buildcostmetal = 500,
		buildpic = "scavengers/SCAVBEACON.DDS",
		buildtime = 5000,
		category = "ALL NOTLAND NOTSUB NOWEAPON NOTSHIP NOTAIR NOTHOVER SURFACE EMPABLE",
		canmove = false,
		canSelfDestruct = false,
		capturable = true,
		cantbetransported = true,
		collisionvolumeoffsets = "0 0 0",
		collisionvolumescales = "32 32 32",
		collisionvolumetype = "CylY",
		energystorage = 10,
		explodeas = "lootboxExplosion2",
		floater = false,
		footprintx = 0,
		footprintz = 0,
		idleautoheal = 10,
		idletime = 90,
		levelground = false,
		mass = 10000,
		maxdamage = 2200,
		maxvelocity = 0,
		noautofire = false,
		objectname = "scavs/scavbeaconbyar.s3o",
		script = "scavs/beaconbyar.cob",
		seismicsignature = 4,
		selfdestructcountdown = 1,
		smoothanim = true,
		tedclass = "ENERGY",
		transportByEnemy = true,
		turninplace = true,
		turninplaceanglelimit = 90,
		turnrate = 0,
		unitname = "scavengerbeacon",
		upright = false,
		yardmap = "",
		reclaimable = true,
		customparams = {
			subfolder = "scavengers",
			normaltex = "unittextures/cor_normal.dds",
		},
		featuredefs = {},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:PurpleLight",
			},
		},
		weapondefs = {
			weapon = {
				alwaysVisible = true,
				areaofeffect = 500,
				avoidfriendly = 0,
				cegtag = "scaspawn-trail",
				collidefriendly = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.3,
				explosiongenerator = "custom:genericshellexplosion",
				firestarter = 70,
				flighttime = 100,
				impulsefactor = 0.1,
				interceptedbyshieldtype = 4,
				metalpershot = 0,
				model = "scavs/scavbeacondroppodbyar.s3o",
				name = "Droppod",
				range = 256,
				reloadtime = 5,
				rgbcolor = "1 0 0",
				smoketrail = 1,
				soundstart = "voice/scavengers/scavspawn",
				soundhit = "voice/scavengers/scavdropspawnbeacon",
				startvelocity = 1,
				targetborder = 0.75,
				turret = 1,
				weaponacceleration = 1800,
				weapontimer = 2,
				weapontype = "MissileLauncher",
				weaponvelocity = 1500,
				wobble = 50,
				damage = {
					raptor = 0,
					default = 0,
				},
			},
		},
		weapons = {
			[1] = {
				def = "WEAPON",
			},
		},
	},
}
