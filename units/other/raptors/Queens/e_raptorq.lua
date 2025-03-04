return {
	e_raptorq = {
		acceleration = 0.1,
		airsightdistance = 2400,
		autoheal = 10,
		bmcode = "1",
		brakerate = 0.1,
		buildcostenergy = 2000000,
		buildcostmetal = 50000,
		builder = false,
		buildpic = "raptors/e_raptorq.DDS",
		buildtime = 1500000,
		canattack = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canstop = "1",
		cantbetransported = true,
		capturable = false,
		category = "BOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE CHICKEN EMPABLE",
		collisionspherescale = 1.75,
		collisionvolumeoffsets = "0 30 15",
		collisionvolumescales = "110 180 190",
		collisionvolumetest = 1,
		collisionvolumetype = "box",
		defaultmissiontype = "Standby",
		explodeas = "crawl_blastsmlscavboss",
		footprintx = 3,
		footprintz = 3,
		leavetracks = true,
		maneuverleashlength = 2000,
		mass = 2000000,
		maxdamage = 750000,
		maxslope = 40,
		maxvelocity = 2.5,
		maxwaterdepth = 0,
		movementclass = "CHICKQUEENHOVER",
		noautofire = false,
		nochasecategory = "VTOL",
		objectname = "Raptors/epic_raptorq.s3o",
		pushresistant = true,
		script = "Raptors/epic_raptorq.cob",
		seismicsignature = 0,
		selfdestructas = "crawl_blastsmlscavboss",
		side = "THUNDERBIRDS",
		sightdistance = 1000,
		smoothanim = true,
		steeringmode = "2",
		tedclass = "BOT",
		trackoffset = 18,
		trackstrength = 3,
		trackstretch = 1,
		tracktype = "RaptorTrack",
		trackwidth = 85,
		turninplace = true,
		turninplaceanglelimit = 1,
		turnrate = 100,
		unitname = "e_raptorq",
		upright = false,
		waterline = 80,
		workertime = 0,
		customparams = {
			subfolder = "other/raptors",
			model_author = "KDR_11k, Beherith",
			normalmaps = "yes",
			normaltex = "unittextures/raptor_l_normals.png",
			treeshader = "yes",
		},
		sfxtypes = {
			explosiongenerators = {
				[1] = "custom:blood_spray",
				[2] = "custom:blood_explode",
				[3] = "custom:dirt",
			},
			pieceexplosiongenerators = {
				[1] = "blood_spray",
				[2] = "blood_spray",
				[3] = "blood_spray",
			},
		},
		weapondefs = {
			goo = {
				accuracy = 300,
				areaofeffect = 200,
				avoidfeature = 0,
				avoidfriendly = 0,
				burst = 8,
				burstrate = 0.03333,
				cegtag = "nuketrail-roost",
				collidefriendly = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.63,
				explosiongenerator = "custom:genericshellexplosion-large",
				firesubmersed = true,
				impulseboost = 0,
				impulsefactor = 0,
				intensity = 0.7,
				interceptedbyshieldtype = 1,
				model = "Raptors/SGreyRock1.S3O",
				name = "Blob",
				noselfdamage = true,
				proximitypriority = -4,
				range = 1000,
				reloadtime = 10,
				rgbcolor = "0.1 0.6 1",
				size = 8,
				sizedecay = 0,
				soundhit = "e16",
				soundstart = "bigraptorroar",
				sprayangle = 4096,
				tolerance = 5000,
				turret = true,
				weapontimer = 0.2,
				weaponvelocity = 400,
				damage = {
					default = 750,
				},
			},
			melee = {
				areaofeffect = 60,
				avoidfeature = 0,
				avoidfriendly = 0,
				camerashake = 0,
				collidefriendly = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.3,
				explosiongenerator = "custom:raptorspike-large-sparks-burn",
				firesubmersed = true,
				impulseboost = 1.5,
				impulsefactor = 1.5,
				interceptedbyshieldtype = 4,
				model = "Raptors/spike.s3o",
				name = "RaptorClaws",
				noselfdamage = true,
				range = 400,
				reloadtime = 1,
				soundstart = "bigraptorbreath",
				tolerance = 5000,
				turret = true,
				waterweapon = true,
				weapontype = "Cannon",
				weaponvelocity = 2500,
				damage = {
					default = 7500,
				},
			},
			yellow_missile = {
				areaofeffect = 128,
				avoidfriendly = false,
				burnblow = true,
				--cegtag = "sporetrail-large",
				collidefriendly = false,
				craterboost = 0,
				cratermult = 0,
				cameraShake = 700,
				dance = 20,
				edgeeffectiveness = 0.35,
				explosiongenerator = "custom:genericshellexplosion-huge-bomb",
				firestarter = 0,
				flighttime = 4,
				firesubmersed = true,
				impulseboost = 0,
				impulsefactor = 0.4,
				interceptedbyshieldtype = 4,
				metalpershot = 0,
				model = "SimpleFlareXL.s3o",
				name = "Deadly Defensive Spores",
				noselfdamage = true,
				range = 2000,
				reloadtime = 2.5,
				smoketrail = true,
				smokePeriod = 2,
				smoketime = 45,
				smokesize = 10.5,
				smokecolor = 1.0,
				soundhit = "spore_explo",
				soundstart = "spore_xl",
				soundstartvolume = 9,
				startvelocity = 1000,
				texture1 = "orangenovaexplo",
				texture2 = "sporetrail_xl",
				tolerance = 60000,
				tracks = true,
				trajectoryheight = 2,
				turnrate = 60000,
				turret = true,
				waterweapon = true,
				weaponacceleration = 40,
				weapontype = "MissileLauncher",
				weaponvelocity = 2000,
				wobble = 32000,
				damage = {
					default = 10,
					bombers = 1000,
					fighters = 1000,
					vtol = 1000,
				},
			},
		},
		weapons = {
			[1] = {
				def = "MELEE",
				maindir = "0 0 1",
				maxangledif = 155,
			},
			[2] = {
				onlytargetcategory = "VTOL",
				def = "yellow_missile",
			},
			[3] = {
				onlytargetcategory = "VTOL",
				def = "yellow_missile",
			},
			[4] = {
				onlytargetcategory = "VTOL",
				def = "yellow_missile",
			},
			[5] = {
				def = "GOO",
				maindir = "0 0 1",
				maxangledif = 180,
			},
		},
	},
}
