function widget:GetInfo()
	return {
		name      = "Notifications",
		desc      = "Does various voice/text notifications",
		author    = "Doo, Floris",
		date      = "2018",
		license   = "GNU GPL, v2 or later",
		version   = 1,
		layer     = 5,
		enabled   = true
	}
end

local silentTime = 0.7	-- silent time between queued notifications
local globalVolume = 0.7
local playTrackedPlayerNotifs = false
local muteWhenIdle = true
local idleTime = 10		-- after this much sec: mark user as idle
local displayMessages = true
local spoken = true
local idleBuilderNotificationDelay = 10 * 30	-- (in gameframes)
local lowpowerThreshold = 7		-- if there is X secs a low power situation
local tutorialPlayLimit = 2		-- display the same tutorial message only this many times in total (max is always 1 play per game)

--------------------------------------------------------------------------------

local LastPlay = {}

local Sound = {}
local soundList = {}
local SoundOrder = {}
local spGetGameFrame = Spring.GetGameFrame
local gameframe = spGetGameFrame()

local lockPlayerID
local gaiaTeamID = Spring.GetGaiaTeamID()
function addSound(name, file, minDelay, duration, messageKey, unlisted)
	Sound[name] = {
		file = file,
		delay = minDelay,
		duration = duration,
		messageKey = messageKey,
	 }

	soundList[name] = true
	if not unlisted then
		SoundOrder[#SoundOrder + 1] = name
	end
end

local voiceSet = Spring.GetConfigString('voiceset', 'allison')
local voiceSetFound = false
local files = VFS.SubDirs('sounds/voice', '*')
for k, file in ipairs(files) do
	local dirname = string.sub(file, 14, string.len(file)-1)
	if dirname == voiceSet then
		voiceSetFound = true
		break
	end
end
if not voiceSetFound then
	voiceSet = 'allison'
end

soundFolder = "Sounds/voice/"..voiceSet.."/"
VFS.Include(soundFolder .. 'config.lua')

unitsOfInterest = {}
unitsOfInterest[UnitDefNames['armemp'].id] = 'EMPmissilesiloDetected'
unitsOfInterest[UnitDefNames['cortron'].id] = 'TacticalNukeSiloDetected'
unitsOfInterest[UnitDefNames['armsilo'].id] = 'NuclearSiloDetected'
unitsOfInterest[UnitDefNames['corsilo'].id] = 'NuclearSiloDetected'
unitsOfInterest[UnitDefNames['corint'].id] = 'LrpcDetected'
unitsOfInterest[UnitDefNames['armbrtha'].id] = 'LrpcDetected'
unitsOfInterest[UnitDefNames['corbuzz'].id] = 'LrpcDetected'
unitsOfInterest[UnitDefNames['armvulc'].id] = 'LrpcDetected'
unitsOfInterest[UnitDefNames['armliche'].id] = 'NuclearBomberDetected'
unitsOfInterest[UnitDefNames['corjugg'].id] = 'JuggernautDetected'
unitsOfInterest[UnitDefNames['corkorg'].id] = 'KorgothDetected'
unitsOfInterest[UnitDefNames['armbanth'].id] = 'BanthaDetected'
unitsOfInterest[UnitDefNames['armepoch'].id] = 'FlagshipDetected'
unitsOfInterest[UnitDefNames['corblackhy'].id] = 'FlagshipDetected'
unitsOfInterest[UnitDefNames['cormando'].id] = 'CommandoDetected'
unitsOfInterest[UnitDefNames['armthovr'].id] = 'TransportDetected'
unitsOfInterest[UnitDefNames['corthovr'].id] = 'TransportDetected'
unitsOfInterest[UnitDefNames['corintr'].id] = 'TransportDetected'
unitsOfInterest[UnitDefNames['armatlas'].id] = 'AirTransportDetected'
unitsOfInterest[UnitDefNames['corvalk'].id] = 'AirTransportDetected'
unitsOfInterest[UnitDefNames['armdfly'].id] = 'AirTransportDetected'
unitsOfInterest[UnitDefNames['corseah'].id] = 'AirTransportDetected'
unitsOfInterest[UnitDefNames['armtship'].id] = 'SeaTransportDetected'
unitsOfInterest[UnitDefNames['cortship'].id] = 'SeaTransportDetected'

-- added this so they wont get immediately triggered after gamestart
LastPlay['YouAreOverflowingMetal'] = spGetGameFrame()+1200
--LastPlay['YouAreOverflowingEnergy'] = spGetGameFrame()+300
--LastPlay['YouAreWastingMetal'] = spGetGameFrame()+300
--LastPlay['YouAreWastingEnergy'] = spGetGameFrame()+300
LastPlay['WholeTeamWastingMetal'] = spGetGameFrame()+1200
LastPlay['WholeTeamWastingEnergy'] = spGetGameFrame()+2000

local soundQueue = {}
local nextSoundQueued = 0
local hasBuildMex = false
local hasBuildEnergy = false
local taggedUnitsOfInterest = {}
local lowpowerDuration = 0
local idleBuilder = {}
local commanders = {}
local commandersDamages = {}
local passedTime = 0
local sec = 0

local windNotGood = ((Game.windMin + Game.windMax) / 2) < 5.5

local spIsUnitAllied = Spring.IsUnitAllied
local spGetUnitDefID = Spring.GetUnitDefID
local spIsUnitInView = Spring.IsUnitInView
local spGetUnitHealth = Spring.GetUnitHealth

local isIdle = false
local lastUserInputTime = os.clock()
local lastMouseX, lastMouseY = Spring.GetMouseState()

local isSpec = Spring.GetSpectatingState()
local isReplay = Spring.IsReplay()
local myTeamID = Spring.GetMyTeamID()
local myPlayerID = Spring.GetMyPlayerID()
local myAllyTeamID = Spring.GetMyAllyTeamID()
local myRank = select(9,Spring.GetPlayerInfo(myPlayerID))

local spGetTeamResources = Spring.GetTeamResources
local e_currentLevel, e_storage, e_pull, e_income, e_expense, e_share, e_sent, e_received = spGetTeamResources(myTeamID,'energy')
local m_currentLevel, m_storage, m_pull, m_income, m_expense, m_share, m_sent, m_received = spGetTeamResources(myTeamID,'metal')

local tutorialMode = (myRank == 0)
local doTutorialMode = tutorialMode
local tutorialPlayed = {}		-- store the number of times a tutorial event has played across games
local tutorialPlayedThisGame = {}	-- log that a tutorial event has played this game

local vulcanDefID = UnitDefNames['armvulc'].id
local buzzsawDefID = UnitDefNames['corbuzz'].id

local isFactoryAir = {[UnitDefNames['armap'].id] = true, [UnitDefNames['corap'].id] = true}
local isFactoryAirSea = {[UnitDefNames['armplat'].id] = true, [UnitDefNames['corplat'].id] = true}
local isFactoryVeh = {[UnitDefNames['armvp'].id] = true, [UnitDefNames['corvp'].id] = true}
local isFactoryBot = {[UnitDefNames['armlab'].id] = true, [UnitDefNames['corlab'].id] = true}
local isFactoryHover = {[UnitDefNames['armhp'].id] = true, [UnitDefNames['corhp'].id] = true}
local isFactoryShip = {[UnitDefNames['armsy'].id] = true, [UnitDefNames['corsy'].id] = true}
local numFactoryAir = 0
local numFactoryAirSea = 0
local numFactoryVeh = 0
local numFactoryBot = 0
local numFactoryHover = 0
local numFactoryShip = 0

local hasMadeT2 = false

local isCommander = {}
local isBuilder = {}
local isMex = {}
local isEnergyProducer = {}
local isWind = {}
local isAircraft = {}
local isT2 = {}
local isT3mobile = {}
local isMine = {}
for udefID,def in ipairs(UnitDefs) do
	-- not critter/raptor/object
	if not string.find(def.name, 'critter') and not string.find(def.name, 'raptor') and (not def.modCategories or not def.modCategories.object) then
		if def.canFly then
			isAircraft[udefID] = true
		end
		if def.customParams.techlevel then
			if def.customParams.techlevel == '2' and not def.customParams.iscommander then
				isT2[udefID] = true
			end
			if def.customParams.techlevel == '3' and not def.isBuilding then
				isT3mobile[udefID] = true
			end
		end
		if def.modCategories.mine then
			isMine[udefID] = true
		end
		if def.customParams.iscommander then
			isCommander[udefID] = true
		end
		if def.isBuilder and def.canAssist then
			isBuilder[udefID] = true
		end
		if def.windGenerator and def.windGenerator > 0 then
			isWind[udefID] = true
		end
		if def.extractsMetal > 0 then
			isMex[udefID] = true
		end
		if def.energyMake > 10 then
			isEnergyProducer[udefID] = def.energyMake
		end
	end
end

local function updateCommanders()
	local units = Spring.GetTeamUnits(myTeamID)
	for i=1,#units do
		local unitID = units[i]
		local unitDefID = spGetUnitDefID(unitID)
		if isCommander[unitDefID] then
			local health,maxHealth,paralyzeDamage,captureProgress,buildProgress = spGetUnitHealth(unitID)
			commanders[unitID] = maxHealth
		end
	end
end

local function isInQueue(event)
	for i,v in pairs(soundQueue) do
		if v == event then
			return true
		end
	end
	return false
end

local function queueNotification(event, forceplay)
	if Spring.GetGameFrame() > 20 or forceplay then
		if not isSpec or (isSpec and playTrackedPlayerNotifs and lockPlayerID ~= nil) or forceplay then
			if soundList[event] and Sound[event] then
				if not LastPlay[event] or (spGetGameFrame() >= LastPlay[event] + (Sound[event].delay * 30)) then
					if not isInQueue(event) then
						soundQueue[#soundQueue+1] = event
					end
				end
			end
		end
	end
end

local function queueTutorialNotification(event)
	if doTutorialMode and (not tutorialPlayed[event] or tutorialPlayed[event] < tutorialPlayLimit) then
		queueNotification(event)
	end
end

function widget:PlayerChanged(playerID)
	isSpec = Spring.GetSpectatingState()
	myTeamID = Spring.GetMyTeamID()
	myPlayerID = Spring.GetMyPlayerID()
	myAllyTeamID = Spring.GetMyAllyTeamID()
	doTutorialMode = (not isReplay and not isSpec and tutorialMode)
	updateCommanders()
end

-- function that gadgets can call
local function eventBroadcast(msg)
	if gameframe < 60 then return end	-- dont alert stuff for first 2 secs so gadgets can still spawn stuff without it triggering notifications

	if string.find(msg, "SoundEvents", nil, true) then
		msg = string.sub(msg, 13)
		local forceplay = (string.sub(msg, string.len(msg)-1) == ' y')
		if not isSpec or (isSpec and playTrackedPlayerNotifs and lockPlayerID ~= nil) or forceplay then
			local event = string.sub(msg, 1, string.find(msg, " ", nil, true)-1)
			local player = string.sub(msg, string.find(msg, " ", nil, true)+1, string.len(msg))
			if forceplay or (tonumber(player) and (tonumber(player) == Spring.GetMyPlayerID())) or (isSpec and tonumber(player) == lockPlayerID) then
				queueNotification(event, forceplay)
			end
		end
	end
end

function widget:Initialize()
	if isReplay or spGetGameFrame() > 0 then
		widget:PlayerChanged()
	end

	widgetHandler:RegisterGlobal('EventBroadcast', eventBroadcast)
	widgetHandler:RegisterGlobal('AddNotification', addSound)

	WG['notifications'] = {}
	for sound, params in pairs(Sound) do
		WG['notifications']['getSound'..sound] = function()
			return soundList[sound] or false
		end
		WG['notifications']['setSound'..sound] = function(value)
			soundList[sound] = value
		end
	end
	WG['notifications'].getSoundList = function()
		local soundInfo = {}
		for i, event in pairs(SoundOrder) do
			soundInfo[i] = { event, soundList[event], Sound[event].messageKey }
		end
		return soundInfo
	end
	WG['notifications'].getTutorial = function()
		return tutorialMode
	end
	WG['notifications'].setTutorial = function(value)
		tutorialMode = value
		if tutorialMode then
			tutorialPlayed = {}
			--for i,v in pairs(LastPlay) do
			--	if string.sub(i, 1, 2) == 't_' then
			--		LastPlay[i] = nil
			--	end
			--end
		end
		widget:PlayerChanged()
	end
	WG['notifications'].getVolume = function()
		return globalVolume
	end
	WG['notifications'].setVolume = function(value)
		globalVolume = value
	end
	WG['notifications'].getSpoken = function()
		return spoken
	end
	WG['notifications'].setSpoken = function(value)
		spoken = value
	end
	WG['notifications'].getMessages = function()
		return displayMessages
	end
	WG['notifications'].setMessages = function(value)
		displayMessages = value
	end
	WG['notifications'].getPlayTrackedPlayerNotifs = function()
		return playTrackedPlayerNotifs
	end
	WG['notifications'].setPlayTrackedPlayerNotifs = function(value)
		playTrackedPlayerNotifs = value
	end
	WG['notifications'].addSound = function(name, file, minDelay, duration, messageKey, unlisted)
		addSound(name, file, minDelay, duration, messageKey, unlisted)
	end
	WG['notifications'].addEvent = function(value, force)
		if Sound[value] then
			queueNotification(value, force)
		end
	end
end

function widget:Shutdown()
	WG['notifications'] = nil
	widgetHandler:DeregisterGlobal('EventBroadcast')
	widgetHandler:DeregisterGlobal('AddNotification')
end

function widget:GameFrame(gf)
	gameframe = gf

	if isSpec then return end

	if not displayMessages and not spoken then return end

	if gameframe < 60 then return end	-- dont alert stuff for first 2 secs so gadgets can still spawn stuff without it triggering notifications

	if gameframe == 70 and doTutorialMode then
		queueTutorialNotification('t_welcome')
	end
	if gameframe % 30 == 15 then
		e_currentLevel, e_storage, e_pull, e_income, e_expense, e_share, e_sent, e_received = spGetTeamResources(myTeamID,'energy')
		m_currentLevel, m_storage, m_pull, m_income, m_expense, m_share, m_sent, m_received = spGetTeamResources(myTeamID,'metal')

		-- tutorial
		if doTutorialMode then
			if gameframe > 300 and not hasBuildMex then
				queueTutorialNotification('t_buildmex')
			end
			if not hasBuildEnergy and hasBuildMex then
				queueTutorialNotification('t_buildenergy')
			end
			if e_income >= 50 and m_income >= 4 then
				queueTutorialNotification('t_nowproduce')
			end
			if not hasMadeT2 and e_income >= 600 and m_income >= 12 then
				queueTutorialNotification('t_readyfortech2')
			end
		end

		-- low power check
		if e_currentLevel and (e_currentLevel / e_storage) < 0.025 and e_currentLevel < 3000 then
			lowpowerDuration = lowpowerDuration + 1
			if lowpowerDuration >= lowpowerThreshold then
				queueNotification('LowPower')
				lowpowerDuration = 0

				-- increase next low power delay
				Sound["LowPower"].delay = Sound["LowPower"].delay + 15
			end
		end

		-- idle builder check
		for unitID, frame in pairs(idleBuilder) do
			if spIsUnitInView(unitID) then
				idleBuilder[unitID] = nil
			elseif frame < gf then
				--QueueNotification('IdleBuilder')
				idleBuilder[unitID] = nil	-- do not repeat
			end
		end
	end
end

function widget:UnitCommand(unitID, unitDefID, unitTeamID, cmdID, cmdParams, cmdOptions, cmdTag)
	idleBuilder[unitID] = nil
end


function widget:UnitIdle(unitID)
	if isBuilder[spGetUnitDefID(unitID)] and not idleBuilder[unitID] and not spIsUnitInView(unitID) then
		idleBuilder[unitID] = spGetGameFrame() + idleBuilderNotificationDelay
	end
end

function widget:UnitFinished(unitID, unitDefID, unitTeam)
	if not displayMessages and not spoken then return end

	if unitTeam == myTeamID then

		if not isCommander[unitDefID] then
			if isMex[unitDefID] then
				hasBuildMex = true
			end
			if isEnergyProducer[unitDefID] then
				hasBuildEnergy = true
			end
		end

		if unitDefID == vulcanDefID then
			queueNotification('VulcanIsReady')
		elseif unitDefID == buzzsawDefID then
			queueNotification('BuzzsawIsReady')
		elseif isT3mobile[unitDefID] then
			queueNotification('Tech3UnitReady')

		elseif doTutorialMode then
			if isFactoryAir[unitDefID] then
				queueTutorialNotification('t_factoryair')
			elseif isFactoryAirSea[unitDefID] then
				queueTutorialNotification('t_factoryairsea')
			elseif isFactoryBot[unitDefID] then
				queueTutorialNotification('t_factorybots')
			elseif isFactoryHover[unitDefID] then
				queueTutorialNotification('t_factoryhovercraft')
			elseif isFactoryVeh[unitDefID] then
				queueTutorialNotification('t_factoryvehicles')
			elseif isFactoryShip[unitDefID] then
				queueTutorialNotification('t_factoryships')
			end
		end
	end
end

function widget:UnitEnteredLos(unitID, unitTeam)
	if not displayMessages and not spoken then return end

	if spIsUnitAllied(unitID) or unitTeam == gaiaTeamID then return end

	local udefID = spGetUnitDefID(unitID)

	-- single detection events below
	if isAircraft[udefID] then
		queueNotification('AircraftSpotted')
	end
	if isT2[udefID] then
		queueNotification('T2Detected')
	end
	if isT3mobile[udefID] then
		queueNotification('T3Detected')
	end
	if isMine[udefID] then
		local x,_,z = Spring.GetUnitPosition(unitID)
		local units = Spring.GetUnitsInCylinder(x,z,1700, myTeamID)
		if #units > 0 then		-- ignore when far away
			queueNotification('MinesDetected')
		end
	end

	-- notify about units of interest
	if udefID and unitsOfInterest[udefID] and not taggedUnitsOfInterest[unitID] then
		taggedUnitsOfInterest[unitID] = true
		queueNotification(unitsOfInterest[udefID])
	end
end

function widget:UnitTaken(unitID, unitDefID, unitTeam, newTeam)
	if unitTeam == myTeamID and isCommander[unitDefID] then
		commanders[unitID] = select(2, spGetUnitHealth(unitID))
	end
end

function widget:UnitGiven(unitID, unitDefID, unitTeam, oldTeam)
	if unitTeam == myTeamID and isCommander[unitDefID] then
		commanders[unitID] = select(2, spGetUnitHealth(unitID))
	end
end

function widget:UnitCreated(unitID, unitDefID, unitTeam)
	if not displayMessages and not spoken then return end

	if unitTeam == myTeamID then
		if not hasMadeT2 and isT2[unitDefID] then
			hasMadeT2 = true
		end

		if isCommander[unitDefID] then
			commanders[unitID] = select(2, spGetUnitHealth(unitID))
		end
		if windNotGood and isWind[unitDefID] then
			queueNotification('WindNotGood')
		end

		if tutorialMode then
			if e_income < 2000 and m_income < 50 then
				if isFactoryAir[unitDefID] then
					numFactoryAir = numFactoryAir + 1
					if numFactoryAir > 1 then
						queueNotification('t_duplicatefactory')
					end
				end
				if isFactoryAirSea[unitDefID] then
					numFactoryAirSea = numFactoryAirSea + 1
					if numFactoryAirSea > 1 then
						queueNotification('t_duplicatefactory')
					end
				end
				if isFactoryVeh[unitDefID] then
					numFactoryVeh = numFactoryVeh + 1
					if numFactoryVeh > 1 then
						queueNotification('t_duplicatefactory')
					end
				end
				if isFactoryBot[unitDefID] then
					numFactoryBot = numFactoryBot + 1
					if numFactoryBot > 1 then
						queueNotification('t_duplicatefactory')
					end
				end
				if isFactoryHover[unitDefID] then
					numFactoryHover = numFactoryHover + 1
					if numFactoryHover > 1 then
						queueNotification('t_duplicatefactory')
					end
				end
				if isFactoryShip[unitDefID] then
					numFactoryShip = numFactoryShip + 1
					if numFactoryShip > 1 then
						queueNotification('t_duplicatefactory')
					end
				end
			end
		end
	end
end

function widget:UnitDamaged(unitID, unitDefID, unitTeam, damage, paralyzer)
	if not displayMessages and not spoken then return end

	if unitTeam == myTeamID then

		if paralyzer then
			queueTutorialNotification('t_paralyzer')
		end

		-- notify when commander gets heavy damage
		if commanders[unitID] and not spIsUnitInView(unitID) then
			if not commandersDamages[unitID] then
				commandersDamages[unitID] = {}
			end
			local gameframe = spGetGameFrame()
			commandersDamages[unitID][gameframe] = damage		-- if widget:UnitDamaged can be called multiple times during 1 gameframe then you need to add those up, i dont know

			-- count total damage of last few secs
			local totalDamage = 0
			local startGameframe = gameframe - (5.5 * 30)
			for gf,damage in pairs(commandersDamages[unitID]) do
				if gf > startGameframe then
					totalDamage = totalDamage + damage
				else
					commandersDamages[unitID][gf] = nil
				end
			end
			if totalDamage >= commanders[unitID] * 0.12 then
				queueNotification('ComHeavyDamage')
			end
		end
	end
end

function widget:UnitDestroyed(unitID, unitDefID, teamID)
	taggedUnitsOfInterest[unitID] = nil
	commandersDamages[unitID] = nil

	if tutorialMode then
		if isFactoryAir[unitDefID] then
			numFactoryAir = numFactoryAir - 1
		end
		if isFactoryAirSea[unitDefID] then
			numFactoryAirSea = numFactoryAirSea - 1
		end
		if isFactoryVeh[unitDefID] then
			numFactoryVeh = numFactoryVeh - 1
		end
		if isFactoryBot[unitDefID] then
			numFactoryBot = numFactoryBot - 1
		end
		if isFactoryHover[unitDefID] then
			numFactoryHover = numFactoryHover - 1
		end
		if isFactoryShip[unitDefID] then
			numFactoryShip = numFactoryShip - 1
		end
	end
end

local function playNextSound()
	if #soundQueue > 0 then
		local event = soundQueue[1]
		local isTutorialNotification = (string.sub(event, 1, 2) == 't_')
		nextSoundQueued = sec + Sound[event].duration + silentTime
		if not muteWhenIdle or not isIdle or isTutorialNotification then
			local m = 1
			if spoken and Sound[event].file and Sound[event].file[1] ~= '' then
				m = math.random(1,#Sound[event].file)
				Spring.PlaySoundFile(Sound[event].file[m], globalVolume, 'ui')
			end
			-- if displayMessages and WG['messages'] and Sound[event].messageKey and Sound[event].messageKey[m] then -- Ready for fix with variation text
			-- 	WG['messages'].addMessage(Spring.I18N(Sound[event].messageKey[m]))
			-- end
			if displayMessages and WG['messages'] and Sound[event].messageKey then
				WG['messages'].addMessage(Spring.I18N(Sound[event].messageKey))
			end
		end
		LastPlay[event] = spGetGameFrame()

		-- for tutorial event: log number of plays
		if isTutorialNotification then
			tutorialPlayed[event] = tutorialPlayed[event] and tutorialPlayed[event] + 1 or 1
			tutorialPlayedThisGame[event] = true
		end

		-- drop current played notification from the table
		local newQueue = {}
		local newQueuecount = 0
		for i,v in pairs(soundQueue) do
			if i ~= 1 then
				newQueuecount = newQueuecount + 1
				newQueue[newQueuecount] = v
			end
		end
		soundQueue = newQueue
	end
end

function widget:Update(dt)
	if not displayMessages and not spoken then return end

	sec = sec + dt

	passedTime = passedTime + dt
	if passedTime > 0.2 then
		passedTime = passedTime - 0.2
		if WG['advplayerlist_api'] and WG['advplayerlist_api'].GetLockPlayerID ~= nil then
			lockPlayerID = WG['advplayerlist_api'].GetLockPlayerID()
		end

		-- process sound queue
		if sec >= nextSoundQueued then
			playNextSound()
		end

		-- check idle status
		local mouseX, mouseY = Spring.GetMouseState()
		if mouseX ~= lastMouseX or mouseY ~= lastMouseY then
			lastUserInputTime = os.clock()
		end
		lastMouseX, lastMouseY = mouseX, mouseY
		-- set user idle when no mouse movement or no commands have been given
		if lastUserInputTime < os.clock() - idleTime then
			isIdle = true
		else
			isIdle = false
		end
		if WG['topbar'] and WG['topbar'].showingRejoining and WG['topbar'].showingRejoining() then
			isIdle = true
		end
	end
end

function widget:MousePress()
	lastUserInputTime = os.clock()
end

function widget:MouseWheel()
	lastUserInputTime = os.clock()
end

function widget:KeyPress()
	lastUserInputTime = os.clock()
end

function widget:GameOver()
	widgetHandler:RemoveWidget()
end

function widget:GetConfigData(data)
	return {
		Sound = Sound,
		soundList = soundList,
		globalVolume = globalVolume,
		spoken = spoken,
		displayMessages = displayMessages,
		playTrackedPlayerNotifs = playTrackedPlayerNotifs,
		LastPlay = LastPlay,
		tutorialMode = tutorialMode,
		tutorialPlayed = tutorialPlayed,
		tutorialPlayedThisGame = tutorialPlayedThisGame,
	}
end

function widget:SetConfigData(data)
	if data.Sound ~= nil and Spring.GetGameFrame() > 0 then
		Sound = data.Sound
	end
	if data.soundList ~= nil then
		for sound, enabled in pairs(data.soundList) do
			if Sound[sound] then
				soundList[sound] = enabled
			end
		end
	end
	if data.globalVolume ~= nil then
		globalVolume = data.globalVolume
	end
	if data.spoken ~= nil then
		spoken = data.spoken
	end
	if data.displayMessages ~= nil then
		displayMessages = data.displayMessages
	end
	if data.playTrackedPlayerNotifs ~= nil then
		playTrackedPlayerNotifs = data.playTrackedPlayerNotifs
	end
	if data.tutorialPlayed ~= nil then
		tutorialPlayed = data.tutorialPlayed
	end
	if data.tutorialMode ~= nil then
		tutorialMode = data.tutorialMode
	end
	if spGetGameFrame() > 0 then
		if data.LastPlay then
			LastPlay = data.LastPlay
		end
		if data.tutorialPlayedThisGame ~= nil then
			tutorialPlayedThisGame = data.tutorialPlayedThisGame
		end
	end
end
