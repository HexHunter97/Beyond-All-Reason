return {
	raptor1c = {
		acceleration = 0.1725,
		bmcode = "1",
		brakerate = 0.575,
		buildcostenergy = 53,
		buildcostmetal = 25,
		builder = false,
		buildpic = "raptors/raptor1c.DDS",
		buildtime = 1200,
		canattack = true,
		canguard = true,
		canmove = true,
		canpatrol = true,
		canstop = "1",
		capturable = false,
		category = "BOT MOBILE WEAPON ALL NOTSUB NOTSHIP NOTAIR NOTHOVER SURFACE CHICKEN EMPABLE",
		collisionvolumeoffsets = "0 -3 -3",
		collisionvolumescales = "18 40 40",
		collisionvolumetype = "box",
		defaultmissiontype = "Standby",
		explodeas = "BUG_DEATH",
		floater = false,
		footprintx = 1,
		footprintz = 1,
		leavetracks = true,
		maneuverleashlength = 640,
		mass = 40,
		maxdamage = 470,
		maxslope = 18,
		maxvelocity = 3.5,
		maxwaterdepth = 0,
		movementclass = "CHICKSMALLHOVER",
		noautofire = false,
		nochasecategory = "VTOL",
		objectname = "Raptors/raptor1c.s3o",
		script = "Raptors/raptor1c.cob",
		seismicsignature = 0,
		selfdestructas = "BUG_DEATH",
		side = "THUNDERBIRDS",
		sightdistance = 200,
		smoothanim = true,
		steeringmode = "2",
		tedclass = "BOT",
		trackoffset = 0,
		trackstrength = 3,
		trackstretch = 1,
		tracktype = "RaptorTrack",
		trackwidth = 18,
		turninplace = true,
		turninplaceanglelimit = 90,
		turnrate = 1840,
		unitname = "raptor1c",
		upright = false,
		waterline = 19,
		workertime = 0,
		customparams = {
			subfolder = "other/raptors",
			model_author = "KDR_11k, Beherith",
			normalmaps = "yes",
			normaltex = "unittextures/raptor_s_normals.png",
			--treeshader = "no",
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
			weapon = {
				areaofeffect = 24,
				collidefriendly = 0,
				collidefeature = 0,
				avoidfeature = 0,
				avoidfriendly = 0,
				craterboost = 0,
				cratermult = 0,
				edgeeffectiveness = 0.3,
				explosiongenerator = "custom:raptorspike-small-sparks-burn",
				firesubmersed = true,
				impulseboost = 2.2,
				impulsefactor = 1,
				interceptedbyshieldtype = 0,
				model = "Raptors/spike.s3o",
				name = "Claws",
				noselfdamage = true,
				range = 200,
				reloadtime = 1.2,
				soundstart = "smallraptorattack",
				targetborder = 1,
				tolerance = 5000,
				turret = true,
				waterweapon = true,
				weapontimer = 0.1,
				weapontype = "Cannon",
				weaponvelocity = 1000,
				damage = {
					default = 90,
				},
			},
		},
		weapons = {
			[1] = {
				def = "WEAPON",
				maindir = "0 0 1",
				maxangledif = 180,
				--onlytargetcategory = "NOTAIR",
			},
		},
	},
}
