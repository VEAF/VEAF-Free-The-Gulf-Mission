-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize all the scripts
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.logInfo("init - veafRadio")
veafRadio.initialize(true)
veaf.logInfo("init - veafSpawn")
veafSpawn.initialize()
veaf.logInfo("init - veafGrass")
veafGrass.initialize()
veaf.logInfo("init - veafCasMission")
veafCasMission.initialize()
--veafTransportMission.initialize()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- change some default parameters
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.DEFAULT_GROUND_SPEED_KPH = 25

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize SHORTCUTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.logInfo("init - veafShortcuts")
veafShortcuts.initialize()

-- you can add all the shortcuts you want here. Shortcuts can be any VEAF command, as entered in a map marker.
-- here are some examples :

-- veafShortcuts.AddAlias(
--     VeafAlias.new()
--         :setName("-sa11")
--         :setDescription("SA-11 Gadfly (9K37 Buk) battery")
--         :setVeafCommand("_spawn group, name sa11")
--         :setBypassSecurity(true)
-- )

-- veafShortcuts.AddAlias(
--     VeafAlias.new()
--         :setName("-login")
--         :setDescription("Unlock the system")
--         :setHidden(true)
--         :setVeafCommand("_auth")
--         :setBypassSecurity(true)
-- )

-- veafShortcuts.AddAlias(
--     VeafAlias.new()
--         :setName("-logout")
--         :setDescription("Lock the system")
--         :setHidden(true)
--         :setVeafCommand("_auth logout")
--         :setBypassSecurity(true)
-- )

-- veafShortcuts.AddAlias(
--     VeafAlias.new()
--         :setName("-mortar")
--         :setDescription("Mortar team")
--         :setVeafCommand("_spawn group, name mortar, country USA")
--         :setBypassSecurity(true)
-- )

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialize the SLMOD connector
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if slmod then
    veaf.logInfo("Setting SLMOD configuration")
    
    -- specific commands
    veaf.monitorWithSlMod("-veaf test", [[trigger.action.outText("VEAF - test command received from SLMOD, flag=66600", 10)]], false, 66600)
    veaf.monitorWithSlMod("-veaf login", [[veafSecurity.authenticate(1)]])
    veaf.monitorWithSlMod("-veaf logout", [[veafSecurity.logout(true)]])
    
else
    veaf.logInfo("SLMOD not found")
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- No MOOSE settings menu. Comment out this line if required.
_SETTINGS:SetPlayerMenuOff()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PSEUDOATC
--pseudoATC=PSEUDOATC:New()
--pseudoATC:Start()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SCORING
-- local Scoring = SCORING:New( "Scoring File" )
-- Scoring:SetScaleDestroyScore( 10 )
-- Scoring:SetScaleDestroyPenalty( 40 )
-- Scoring:SetMessagesToCoalition()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure ASSETS
-------------------------------------------------------------------------------------------------------------------------------------------------------------

veafAssets.logInfo("Loading configuration")
veafAssets.Assets = {
    -- list the assets common to all missions below
	{sort=1, name="CSG-74 Stennis", description="Stennis (CVN74)", information="Tacan 74X\nDatalink 321 Mhz\nICLS 1\nVHF 305 Mhz"},
	{sort=2, name="CSG-70 Vinson", description="Carl Vinson (CVN70)", information="Tacan 70X\nDatalink 321 Mhz\nICLS 1\nVHF 306 Mhz"},
	{sort=3, name="CSG-01 Tarawa", description="Tarawa (LHA-1)", information="Tacan 1X\nICLS 1\nVHF 304 Mhz"},
    {sort=4, name="Arco", description="Arco (KC-135MPRS)", information="Tacan 14Y ARC\nVHF 134 Mhz\nFL200"},
    {sort=5, name="Texaco", description="Texaco (KC-135MPRS)", information="Tacan 15Y TEX\nVHF 135 Mhz\nFL200"},
    {sort=6, name="Shell", description="Shell (KC-135)", information="Tacan 16Y SHL\nVHF 136 Mhz\nFL220"},
    {sort=7, name="Overlord", description="Awacs (E-2D)", information="UHF 251 Mhz\nFL220"},
}

veaf.logInfo("init - veafAssets")
veafAssets.initialize()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure MOVE
-------------------------------------------------------------------------------------------------------------------------------------------------------------

veafMove.logInfo("Setting move tanker radio menus")
table.insert(veafMove.Tankers, "T1-Arco-1")
table.insert(veafMove.Tankers, "T2-Shell-1")
table.insert(veafMove.Tankers, "T3-Texaco-1")
table.insert(veafMove.Tankers, "T4-Shell-2")
--table.insert(veafMove.Tankers, "T5-Petrolsky")

veaf.logInfo("init - veafMove")
veafMove.initialize()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure COMBAT MISSION
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCombatMission then 
	veafCombatMission.logInfo("Loading configuration")
    
    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-Krasnodar-1")
		:setFriendlyName("CAP on Krasnodar / 2-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over Krasnodar.
It is composed of 2 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("CAP-Krasnodar-1")
			:setGroups({"OnDemand-CAP-Krasnodar-1"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
    )
    

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-Maykop-1")
		:setFriendlyName("CAP on Maykop / 2-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over Maykop.
It is composed of 2 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Maykop-1")
			:setGroups({"OnDemand-CAP-Maykop-1"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
    )
    

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-GL-1")
		:setFriendlyName("CAP on grid GL / 2-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over grid GL.
It is composed of 2 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-GL-1")
			:setGroups({"OnDemand-CAP-GL-1"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
    )
    

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-Mozdok-1")
		:setFriendlyName("CAP on Mozdok / 2-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over Mozdok.
It is composed of 2 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Mozdok-1")
			:setGroups({"OnDemand-CAP-Mozdok-1"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
    )
    

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setName("CAP-Crimea-1")
		:setFriendlyName("CAP on Crimea / 2-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted west of the Crimea peninsula.
It is composed of 2 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Crimea-1")
			:setGroups({"OnDemand-CAP-Crimea-1"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
	)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-Minvody-2")
		:setFriendlyName("CAP on Mineralnye Vody / 2-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over Mineralnye Vody.
It is composed of 2 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("CAP-Minvody-1")
			:setGroups({"OnDemand-CAP-Minvody-1"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
	)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-Minvody-4")
		:setFriendlyName("CAP on Mineralnye Vody / 4-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over Mineralnye Vody.
It is composed of 4 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-1")
			:setGroups({"OnDemand-CAP-Minvody-1"})
            :setSkill("Excellent")
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-2")
			:setGroups({"OnDemand-CAP-Minvody-2"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
	)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setRadioMenuEnabled(false)
		:setName("CAP-Minvody-8")
		:setFriendlyName("CAP on Mineralnye Vody / 8-ship")
		:setBriefing([[
A Russian CAP patrol has been spotted over Mineralnye Vody.
It is composed of 8 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-1")
			:setGroups({"OnDemand-CAP-Minvody-1"})
            :setSkill("Excellent")
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-2")
			:setGroups({"OnDemand-CAP-Minvody-2"})
            :setSkill("Excellent")
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-3")
			:setGroups({"OnDemand-CAP-Minvody-3"})
            :setSkill("Excellent")
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-4")
			:setGroups({"OnDemand-CAP-Minvody-4"})
            :setSkill("Excellent")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
	)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setName("CAP-Minvody")
		:setFriendlyName("CAP on Mineralnye Vody / random")
		:setBriefing([[
A Russian CAP patrol has been spotted over Mineralnye Vody.
It is composed of 2 to 8 fighters.
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-1")
			:setGroups({"OnDemand-CAP-Minvody-1"})
            :setSkill("Excellent")
            :setSpawnChance(100)
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-2")
			:setGroups({"OnDemand-CAP-Minvody-2"})
            :setSkill("Excellent")
            :setSpawnChance(40)
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-3")
			:setGroups({"OnDemand-CAP-Minvody-3"})
            :setSkill("Excellent")
            :setSpawnChance(40)
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("OnDemand-CAP-Minvody-4")
			:setGroups({"OnDemand-CAP-Minvody-4"})
            :setSkill("Excellent")
            :setSpawnChance(40)
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the fighters")
			:setDescription("you must kill all of the fighters")
			:setMessage("%d fighters destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
	)

    veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setSecured(true)
		:setName("Red-attack-Gudauta")
		:setFriendlyName("Red attack On Gudauta")
		:setBriefing([[
Alert ! This is not a drill !
Tactical and strategic bombers have been detected at the russian border, to the north of Gudauta.
Their course will lead them to the Gudauta airbase, which is probably their mission.
Destroy all the bombers before they hit the base !
]]
)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("SEAD")
			:setGroups({
				"Red Attack On Gudauta - Wave 1-1", 
				"Red Attack On Gudauta - Wave 1-2", 
				"Red Attack On Gudauta - Wave 1-3", 
				"Red Attack On Gudauta - Wave 1-4" })
			:setSkill("Random")
		)
		:addElement(
			VeafCombatMissionElement.new()
			:setName("Bombers")
			:setGroups({
				"Red Attack On Gudauta - Wave 2-1",
                "Red Attack On Gudauta - Wave 2-2", 
                "Red Attack On Gudauta - Wave 2-3" })
			:setSkill("Random")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("HVT Gudauta")
			:setDescription("the mission will be failed if any of the HVT on Gudauta are destroyed")
			:setMessage("HVT target(s) destroyed : %s !")
			:configureAsPreventDestructionOfSceneryObjectsInZone(
				{
					"Gudauta - Tower", 
					"Gudauta - Kerosen", 
					"Gudauta - Mess"},
				{
					[156696667] = "Gudauta Tower", 
					[156735615] = "Gudauta Kerosen tankers", 
					[156729386] = "Gudauta mess"
				}
			)
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the bombers")
			:setDescription("you must kill all of the bombers")
			:setMessage("%d bombers destroyed !")
			:configureAsKillEnemiesObjective()
		)
		:initialize()
	)

	veafCombatMission.AddMission(
		VeafCombatMission.new()
		:setName("Training-Bomber-1-slow")
		:setFriendlyName("Training - Bomber Scenario 1 - slow Tu-160")
		:setBriefing([[
You're head-on at 25nm with 11 Tu-160, FL200, Mach 0.8.
Destroy them all in less than 10 minutes !]])
		:addElement(
			VeafCombatMissionElement.new()
			:setName("Bombers")
			:setGroups({
				"Red Tu-160 Bomber Wave1-1",
				"Red Tu-160 Bomber Wave1-2",
				"Red Tu-160 Bomber Wave1-3",
				"Red Tu-160 Bomber Wave1-4",
				"Red Tu-160 Bomber Wave1-5",
				"Red Tu-160 Bomber Wave1-6",
				"Red Tu-160 Bomber Wave1-7",
				"Red Tu-160 Bomber Wave1-8",
                "Red Tu-160 Bomber Wave1-9",
                "Red Tu-160 Bomber Wave1-10",
                "Red Tu-160 Bomber Wave1-11",
            })
			:setSkill("Good")
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("< 15 minutes")
			:setDescription("the mission will be over after 15 minutes")
			:setMessage("the 15 minutes have passed !")
			:configureAsTimedObjective(900)
		)
		:addObjective(
			VeafCombatMissionObjective.new()
			:setName("Kill all the bombers")
			:setDescription("you must kill or route all bombers")
			:setMessage("%d bombers destroyed or routed !")
			:configureAsKillEnemiesObjective(-1, 50)
		)
		:initialize()
	)

	veaf.logInfo("init - veafCombatMission")
    veafCombatMission.initialize()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure COMBAT ZONE
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCombatZone then 
	veafCombatZone.logInfo("Loading configuration")

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_Salhad")
			:setFriendlyName("DP26 Salhad")
			:setBriefing("Free Salhad\n" ..
						 "Red forces has captured the city of Salhad\n" ..
						 "Scouts are reporting armored vehicles and air defense\n")
	)

    veaf.logInfo("init - veafCombatZone")
    veafCombatZone.initialize()

end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure NAMEDPOINTS
-------------------------------------------------------------------------------------------------------------------------------------------------------------

veafNamedPoints.Points = {
    -- airbases
    {name="AIRBASE Al Dhafra",point={x=-211113,y=0,z=-173489, atc=true, tower="126.50", tacan="96X MA", runways={ {name="13L", hdg=127}}}},
    {name="AIRBASE Al Minhad",point={x=-126006,y=0,z=-89157, atc=true, tower="121.80", tacan="99X MIN", runways={ { name="09", hdg=89, ils="110.70"}, { name="27", hdg=269, ils="110.75"}, }}},
    {name="AIRBASE Ras Al Khaimah",point={x=-62931,y=0,z=-30481, atc=true, tower="118.25", tacan="99X MIN 041/46", runways={ { name="17", hdg=165}, }}},
    {name="AIRBASE Khasab",point={x=884,y=0,z=129, atc=true, tower="124.35", tacan="84X KSB", runways={ { name="19", hdg=193, ils="110.30"}, }}},
    {name="AIRBASE Sir Abu Nuyar",point={x=-103189,y=0,z=-202643, atc=true, tacan="96X MA 344/60", runways={ { name="10", hdg=99}, }}},
    {name="AIRBASE Sirri Island",point={x=-27656,y=0,z=-169860, atc=true, tower="130.05", tacan="89X KCK 239/39", runways={ { name="30", hdg=127}, }}},
    {name="AIRBASE Abu Musa Island",point={x=-31593,y=0,z=-122493, atc=true, tower="122.9", tacan="89X KCK 196/23", runways={ { name="08", hdg=83}, }}},
    {name="AIRBASE Abu Tunb Kochak",point={x=-9049,y=0,z=-109089, tacan="89X KCK", runways={ { name="08", hdg=81}, }}},
    {name="AIRBASE Abu Tunb Island",point={x=-9707,y=0,z=-92901, tacan="89X KCK 084/9", runways={ { name="03", hdg=28}, }}},
    {name="AIRBASE Lavan Island",point={x=76294,y=0,z=-287951, tacan="112X KIH 297/40", runways={ { name="11", hdg=112},}}},
    {name="AIRBASE Bandar Lengeh",point={x=41396,y=0,z=-142141, atc=true, tower="121.70", tacan="89X KCK 316/24", runways={ { name="08", hdg=81}, }}},
    {name="AIRBASE Qeshm Island",point={x=66079,y=0,z=-31813, atc=true, tower="118.05", tacan="47X HDR 211/28", runways={ { name="05", hdg=50}, }}}, -- bug tacan ?
    {name="AIRBASE Havadarya",point={x=109479,y=0,z=-5181, atc=true, tower="123.50", tacan="47X HDR", runways={ { name="08", hdg=79}, }}}, -- bug tacan ?
    {name="AIRBASE Lar",point={x=169017,y=0,z=-183823, atc=true, tower="127.35", tacan="112X KIH 017/72", runways={ { name="09", hdg=79, ils="111.50"}, }}},
}

veafNamedPoints.logInfo("Loading configuration")

veaf.logInfo("init - veafNamedPoints")
veafNamedPoints.initialize()
veafNamedPoints.addAllPersianGulfCities()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure SECURITY
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veafSecurity.password_L9["6ade6629f9219d87a011e7b8fbf8ef9584f2786d"] = true
veafSecurity.logInfo("Loading configuration")
veaf.logInfo("init - veafSecurity")
veafSecurity.initialize()

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure CARRIER OPERATIONS 
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veaf.logInfo("init - veafCarrierOperations")
veafCarrierOperations.initialize(true)

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- configure CTLD 
-------------------------------------------------------------------------------------------------------------------------------------------------------------

ctld.staticBugWorkaround = false --  DCS had a bug where destroying statics would cause a crash. If this happens again, set this to TRUE

ctld.disableAllSmoke = false -- if true, all smoke is diabled at pickup and drop off zones regardless of settings below. Leave false to respect settings below

ctld.hoverPickup = true --  if set to false you can load crates with the F10 menu instead of hovering... Only if not using real crates!

ctld.enableCrates = true -- if false, Helis will not be able to spawn or unpack crates so will be normal CTTS
ctld.slingLoad = false -- if false, crates can be used WITHOUT slingloading, by hovering above the crate, simulating slingloading but not the weight...
-- There are some bug with Sling-loading that can cause crashes, if these occur set slingLoad to false
-- to use the other method.
-- Set staticBugFix  to FALSE if use set ctld.slingLoad to TRUE

ctld.enableSmokeDrop = true -- if false, helis and c-130 will not be able to drop smoke

ctld.maxExtractDistance = 125 -- max distance from vehicle to troops to allow a group extraction
ctld.maximumDistanceLogistic = 500 -- max distance from vehicle to logistics to allow a loading or spawning operation
ctld.maximumSearchDistance = 8000 -- max distance for troops to search for enemy
ctld.maximumMoveDistance = 2000 -- max distance for troops to move from drop point if no enemy is nearby

ctld.minimumDeployDistance = 1000 -- minimum distance from a friendly pickup zone where you can deploy a crate

ctld.numberOfTroops = 10 -- default number of troops to load on a transport heli or C-130 
							-- also works as maximum size of group that'll fit into a helicopter unless overridden
ctld.enableFastRopeInsertion = true -- allows you to drop troops by fast rope
ctld.fastRopeMaximumHeight = 18.28 -- in meters which is 60 ft max fast rope (not rappell) safe height

ctld.vehiclesForTransportRED = { "BRDM-2", "BTR_D" } -- vehicles to load onto Il-76 - Alternatives {"Strela-1 9P31","BMP-1"}
ctld.vehiclesForTransportBLUE = { "M1045 HMMWV TOW", "M1043 HMMWV Armament" } -- vehicles to load onto c130 - Alternatives {"M1128 Stryker MGS","M1097 Avenger"}

ctld.aaLaunchers = 3 -- controls how many launchers to add to the kub/buk when its spawned.
ctld.hawkLaunchers = 5 -- controls how many launchers to add to the hawk when its spawned.

ctld.spawnRPGWithCoalition = true --spawns a friendly RPG unit with Coalition forces
ctld.spawnStinger = false -- spawns a stinger / igla soldier with a group of 6 or more soldiers!

ctld.enabledFOBBuilding = true -- if true, you can load a crate INTO a C-130 than when unpacked creates a Forward Operating Base (FOB) which is a new place to spawn (crates) and carry crates from
-- In future i'd like it to be a FARP but so far that seems impossible...
-- You can also enable troop Pickup at FOBS

ctld.cratesRequiredForFOB = 3 -- The amount of crates required to build a FOB. Once built, helis can spawn crates at this outpost to be carried and deployed in another area.
-- The large crates can only be loaded and dropped by large aircraft, like the C-130 and listed in ctld.vehicleTransportEnabled
-- Small FOB crates can be moved by helicopter. The FOB will require ctld.cratesRequiredForFOB larges crates and small crates are 1/3 of a large fob crate
-- To build the FOB entirely out of small crates you will need ctld.cratesRequiredForFOB * 3

ctld.troopPickupAtFOB = true -- if true, troops can also be picked up at a created FOB

ctld.buildTimeFOB = 120 --time in seconds for the FOB to be built

ctld.crateWaitTime = 120 -- time in seconds to wait before you can spawn another crate

ctld.forceCrateToBeMoved = true -- a crate must be picked up at least once and moved before it can be unpacked. Helps to reduce crate spam

ctld.radioSound = "beacon.ogg" -- the name of the sound file to use for the FOB radio beacons. If this isnt added to the mission BEACONS WONT WORK!
ctld.radioSoundFC3 = "beaconsilent.ogg" -- name of the second silent radio file, used so FC3 aircraft dont hear ALL the beacon noises... :)

ctld.deployedBeaconBattery = 30 -- the battery on deployed beacons will last for this number minutes before needing to be re-deployed

ctld.enabledRadioBeaconDrop = true -- if its set to false then beacons cannot be dropped by units

ctld.allowRandomAiTeamPickups = false -- Allows the AI to randomize the loading of infantry teams (specified below) at pickup zones

-- Simulated Sling load configuration

ctld.minimumHoverHeight = 7.5 -- Lowest allowable height for crate hover
ctld.maximumHoverHeight = 12.0 -- Highest allowable height for crate hover
ctld.maxDistanceFromCrate = 5.5 -- Maximum distance from from crate for hover
ctld.hoverTime = 10 -- Time to hold hover above a crate for loading in seconds

-- end of Simulated Sling load configuration

-- AA SYSTEM CONFIG --
-- Sets a limit on the number of active AA systems that can be built for RED.
-- A system is counted as Active if its fully functional and has all parts
-- If a system is partially destroyed, it no longer counts towards the total
-- When this limit is hit, a player will still be able to get crates for an AA system, just unable
-- to unpack them

ctld.AASystemLimitRED = 20 -- Red side limit

ctld.AASystemLimitBLUE = 20 -- Blue side limit

--END AA SYSTEM CONFIG --

-- ***************** JTAC CONFIGURATION *****************

ctld.JTAC_LIMIT_RED = 10 -- max number of JTAC Crates for the RED Side
ctld.JTAC_LIMIT_BLUE = 10 -- max number of JTAC Crates for the BLUE Side

ctld.JTAC_dropEnabled = true -- allow JTAC Crate spawn from F10 menu

ctld.JTAC_maxDistance = 10000 -- How far a JTAC can "see" in meters (with Line of Sight)

ctld.JTAC_smokeOn_RED = true -- enables marking of target with smoke for RED forces
ctld.JTAC_smokeOn_BLUE = true -- enables marking of target with smoke for BLUE forces

ctld.JTAC_smokeColour_RED = 4 -- RED side smoke colour -- Green = 0 , Red = 1, White = 2, Orange = 3, Blue = 4
ctld.JTAC_smokeColour_BLUE = 1 -- BLUE side smoke colour -- Green = 0 , Red = 1, White = 2, Orange = 3, Blue = 4

ctld.JTAC_jtacStatusF10 = true -- enables F10 JTAC Status menu

ctld.JTAC_location = true -- shows location of target in JTAC message

ctld.JTAC_lock = "all" -- "vehicle" OR "troop" OR "all" forces JTAC to only lock vehicles or troops or all ground units

-- ***************** Pickup, dropoff and waypoint zones *****************

-- Available colors (anything else like "none" disables smoke): "green", "red", "white", "orange", "blue", "none",

-- Use any of the predefined names or set your own ones

-- You can add number as a third option to limit the number of soldier or vehicle groups that can be loaded from a zone.
-- Dropping back a group at a limited zone will add one more to the limit

-- If a zone isn't ACTIVE then you can't pickup from that zone until the zone is activated by ctld.activatePickupZone
-- using the Mission editor

-- You can pickup from a SHIP by adding the SHIP UNIT NAME instead of a zone name

-- Side - Controls which side can load/unload troops at the zone

-- Flag Number - Optional last field. If set the current number of groups remaining can be obtained from the flag value

--pickupZones = { "Zone name or Ship Unit Name", "smoke color", "limit (-1 unlimited)", "ACTIVE (yes/no)", "side (0 = Both sides / 1 = Red / 2 = Blue )", flag number (optional) }
ctld.pickupZones = {
    { "pickzone1", "none", -1, "yes", 0 },
    { "pickzone2", "none", -1, "yes", 0 },
    { "pickzone3", "none", -1, "yes", 0 },
    { "pickzone4", "none", -1, "yes", 0 },
    { "pickzone5", "none", -1, "yes", 0 },
    { "pickzone6", "none", -1, "yes", 0 },
    { "pickzone7", "none", -1, "yes", 0 },
    { "pickzone8", "none", -1, "yes", 0 },
    { "pickzone9", "none", -1, "yes", 0 }, 
    { "pickzone10", "none", -1, "yes", 0 },
    { "pickzone11", "none", -1, "yes", 0 }, 
    { "pickzone12", "none", -1, "yes", 0 }, 
    { "pickzone13", "none", -1, "yes", 0 }, 
    { "pickzone14", "none", -1, "yes", 0 },
    { "pickzone15", "none", -1, "yes", 0 },
    { "pickzone16", "none", -1, "yes", 0 },
    { "pickzone17", "none", -1, "yes", 0 },
    { "pickzone18", "none", -1, "yes", 0 },
    { "pickzone19", "none", 5, "yes", 0 },
    { "pickzone20", "none", 10, "yes", 0, 1000 }, -- optional extra flag number to store the current number of groups available in

    { "CVN-74 Stennis", "none", 10, "yes", 0, 1001 }, -- instead of a Zone Name you can also use the UNIT NAME of a ship
    { "LHA-1 Tarawa", "none", 10, "yes", 0, 1002 }, -- instead of a Zone Name you can also use the UNIT NAME of a ship
}

-- dropOffZones = {"name","smoke colour",0,side 1 = Red or 2 = Blue or 0 = Both sides}
ctld.dropOffZones = {
    { "dropzone1", "green", 2 },
    { "dropzone2", "blue", 2 },
    { "dropzone3", "orange", 2 },
    { "dropzone4", "none", 2 },
    { "dropzone5", "none", 1 },
    { "dropzone6", "none", 1 },
    { "dropzone7", "none", 1 },
    { "dropzone8", "none", 1 },
    { "dropzone9", "none", 1 },
    { "dropzone10", "none", 1 },
}


--wpZones = { "Zone name", "smoke color",  "ACTIVE (yes/no)", "side (0 = Both sides / 1 = Red / 2 = Blue )", }
ctld.wpZones = {
    { "wpzone1", "green","yes", 2 },
    { "wpzone2", "blue","yes", 2 },
    { "wpzone3", "orange","yes", 2 },
    { "wpzone4", "none","yes", 2 },
    { "wpzone5", "none","yes", 2 },
    { "wpzone6", "none","yes", 1 },
    { "wpzone7", "none","yes", 1 },
    { "wpzone8", "none","yes", 1 },
    { "wpzone9", "none","yes", 1 },
    { "wpzone10", "none","no", 0 }, -- Both sides as its set to 0
}


-- ******************** Transports names **********************

-- Use any of the predefined names or set your own ones
ctld.transportPilotNames = {

    "helicargo1",
    "helicargo1",
    "helicargo2",
    "helicargo3",
    "helicargo4",
    "helicargo5",
    "helicargo6",
    "helicargo7",
    "helicargo8",
    "helicargo9",
    "helicargo10",
    "helicargo11",
    "helicargo12",
    "helicargo13",
    "helicargo14",
    "helicargo15",
    "helicargo16",
    "helicargo17",
    "helicargo18",
    "helicargo19",
    "helicargo20",
    "helicargo21",
    "helicargo22",
    "helicargo23",
    "helicargo24",
    "helicargo25",
    "helicargo26",
    "helicargo27",
    "helicargo28",
    "helicargo29",
    "helicargo30",
    "helicargo31",
    "helicargo32",
    "helicargo33",
    "helicargo34",
    "helicargo35",
    "helicargo36",
    "helicargo37",
    "helicargo38",
    "helicargo39",
    "helicargo40",
    "helicargo41",
    "helicargo42",
    "helicargo43",
    "helicargo44",
    "helicargo45",
    "helicargo46",
    "helicargo47",
    "helicargo48",
    "helicargo49",
    "helicargo51",
    "helicargo52",
    "helicargo53",
    "helicargo54",
    "helicargo61",
    "helicargo62",
    "helicargo63",
    "helicargo64",

    "yak1",
    "yak2",
    "yak3",
    "yak4",
    "yak5",
    "yak6",
    "yak7",
    "yak8",
    "yak9",
    "yak10",
    "yak11",
    "yak12",
    "yak13",
    "yak14",
    "yak15",
    "yak16",
    "yak17",
    "yak18",
    "yak19",
    "yak20",
    "yak21",
    "yak22",
    "yak23",
    "yak24",
    "yak25",

}

-- *************** Optional Extractable GROUPS *****************

-- Use any of the predefined names or set your own ones

ctld.extractableGroups = {
    "extract1",
    "extract2",
    "extract3",
    "extract4",
    "extract5",
    "extract6",
    "extract7",
    "extract8",
    "extract9",
    "extract10",

    "extract11",
    "extract12",
    "extract13",
    "extract14",
    "extract15",
    "extract16",
    "extract17",
    "extract18",
    "extract19",
    "extract20",

    "extract21",
    "extract22",
    "extract23",
    "extract24",
    "extract25",
}

-- ************** Logistics UNITS FOR CRATE SPAWNING ******************

-- Use any of the predefined names or set your own ones
-- When a logistic unit is destroyed, you will no longer be able to spawn crates

ctld.logisticUnits = {
    "logistic1",
    "logistic2",
    "logistic3",
    "logistic4",
    "logistic5",
    "logistic6",
    "logistic7",
    "logistic8",
    "logistic9",
    "logistic10",
    "logistic11",
    "logistic12",
    "logistic13",
    "logistic14",
    "logistic15",
    "logistic16",
    "logistic17",
    "logistic18",
    "logistic19",
    "logistic20",
}

-- ************** UNITS ABLE TO TRANSPORT VEHICLES ******************
-- Add the model name of the unit that you want to be able to transport and deploy vehicles
-- units db has all the names or you can extract a mission.miz file by making it a zip and looking
-- in the contained mission file
ctld.vehicleTransportEnabled = {
    "76MD", -- the il-76 mod doesnt use a normal - sign so il-76md wont match... !!!! GRR
    "C-130",
}


-- ************** Maximum Units SETUP for UNITS ******************

-- Put the name of the Unit you want to limit group sizes too
-- i.e
-- ["UH-1H"] = 10,
--
-- Will limit UH1 to only transport groups with a size 10 or less
-- Make sure the unit name is exactly right or it wont work

ctld.unitLoadLimits = {
    ["Mi-8MT"] = 24

    -- Remove the -- below to turn on options
    -- ["SA342Mistral"] = 4,
    -- ["SA342L"] = 4,
    -- ["SA342M"] = 4,

}


-- ************** Allowable actions for UNIT TYPES ******************

-- Put the name of the Unit you want to limit actions for
-- NOTE - the unit must've been listed in the transportPilotNames list above
-- This can be used in conjunction with the options above for group sizes
-- By default you can load both crates and troops unless overriden below
-- i.e
-- ["UH-1H"] = {crates=true, troops=false},
--
-- Will limit UH1 to only transport CRATES but NOT TROOPS
--
-- ["SA342Mistral"] = {crates=fales, troops=true},
-- Will allow Mistral Gazelle to only transport crates, not troops

ctld.unitActions = {
    ["Yak-52"] = {crates=false, troops=true}

    -- Remove the -- below to turn on options
    -- ["SA342Mistral"] = {crates=true, troops=true},
    -- ["SA342L"] = {crates=false, troops=true},
    -- ["SA342M"] = {crates=false, troops=true},

}

-- ************** INFANTRY GROUPS FOR PICKUP ******************
-- Unit Types
-- inf is normal infantry
-- mg is M249
-- at is RPG-16
-- aa is Stinger or Igla
-- mortar is a 2B11 mortar unit
-- You must add a name to the group for it to work
-- You can also add an optional coalition side to limit the group to one side
-- for the side - 2 is BLUE and 1 is RED
ctld.loadableGroups = {
    {name = "Standard Group", inf = 6, mg = 2, at = 2 }, -- will make a loadable group with 5 infantry, 2 MGs and 2 anti-tank for both coalitions
    {name = "Anti Air", inf = 2, aa = 3  },
    {name = "Anti Tank", inf = 2, at = 6  },
    {name = "Mortar Squad", mortar = 6 },
    {name = "Mortar Squad x 4", mortar = 24},
    -- {name = "Mortar Squad Red", inf = 2, mortar = 5, side =1 }, --would make a group loadable by RED only
}

-- ************** SPAWNABLE CRATES ******************
-- Weights must be unique as we use the weight to change the cargo to the correct unit
-- when we unpack
--
ctld.spawnableCrates = {
    -- name of the sub menu on F10 for spawning crates
    ["Ground Forces"] = {
        --crates you can spawn
        -- weight in KG
        -- Desc is the description on the F10 MENU
        -- unit is the model name of the unit to spawn
        -- cratesRequired - if set requires that many crates of the same type within 100m of each other in order build the unit
        -- side is optional but 2 is BLUE and 1 is RED
        -- dont use that option with the HAWK Crates
        { weight = 500, desc = "HMMWV - TOW", unit = "M1045 HMMWV TOW", side = 2 },
        { weight = 505, desc = "HMMWV - MG", unit = "M1043 HMMWV Armament", side = 2 },

        { weight = 510, desc = "BTR-D", unit = "BTR_D", side = 1 },
        { weight = 515, desc = "BRDM-2", unit = "BRDM-2", side = 1 },

        { weight = 520, desc = "HMMWV - JTAC", unit = "Hummer", side = 2, }, -- used as jtac and unarmed, not on the crate list if JTAC is disabled
        { weight = 525, desc = "SKP-11 - JTAC", unit = "SKP-11", side = 1, }, -- used as jtac and unarmed, not on the crate list if JTAC is disabled

        { weight = 100, desc = "2B11 Mortar", unit = "2B11 mortar" },

        { weight = 250, desc = "SPH 2S19 Msta", unit = "SAU Msta", side = 1, cratesRequired = 3 },
        { weight = 255, desc = "M-109", unit = "M-109", side = 2, cratesRequired = 3 },

        { weight = 252, desc = "Ural-375 Ammo Truck", unit = "Ural-375", side = 1, cratesRequired = 2 },
        { weight = 253, desc = "M-818 Ammo Truck", unit = "M 818", side = 2, cratesRequired = 2 },

        { weight = 800, desc = "FOB Crate - Small", unit = "FOB-SMALL" }, -- Builds a FOB! - requires 3 * ctld.cratesRequiredForFOB
    },
    ["AA Crates"] = {
        { weight = 50, desc = "Stinger", unit = "Stinger manpad", side = 2 },
        { weight = 55, desc = "Igla", unit = "SA-18 Igla manpad", side = 1 },

        -- HAWK System
        { weight = 540, desc = "HAWK Launcher", unit = "Hawk ln", side = 2},
        { weight = 545, desc = "HAWK Search Radar", unit = "Hawk sr", side = 2 },
        { weight = 550, desc = "HAWK Track Radar", unit = "Hawk tr", side = 2 },
        { weight = 551, desc = "HAWK PCP", unit = "Hawk pcp" , side = 2 }, -- Remove this if on 1.2
        { weight = 552, desc = "HAWK Repair", unit = "HAWK Repair" , side = 2 },
        -- End of HAWK

        -- KUB SYSTEM
        { weight = 560, desc = "KUB Launcher", unit = "Kub 2P25 ln", side = 1},
        { weight = 565, desc = "KUB Radar", unit = "Kub 1S91 str", side = 1 },
        { weight = 570, desc = "KUB Repair", unit = "KUB Repair", side = 1},
        -- End of KUB

        -- BUK System
        --        { weight = 575, desc = "BUK Launcher", unit = "SA-11 Buk LN 9A310M1"},
        --        { weight = 580, desc = "BUK Search Radar", unit = "SA-11 Buk SR 9S18M1"},
        --        { weight = 585, desc = "BUK CC Radar", unit = "SA-11 Buk CC 9S470M1"},
        --        { weight = 590, desc = "BUK Repair", unit = "BUK Repair"},
        -- END of BUK

        { weight = 595, desc = "Early Warning Radar", unit = "1L13 EWR", side = 1 }, -- cant be used by BLUE coalition

        { weight = 405, desc = "Strela-1 9P31", unit = "Strela-1 9P31", side = 1, cratesRequired = 3 },
        { weight = 400, desc = "M1097 Avenger", unit = "M1097 Avenger", side = 2, cratesRequired = 3 },

    },
}

-- if the unit is on this list, it will be made into a JTAC when deployed
ctld.jtacUnitTypes = {
    "SKP", "Hummer" -- there are some wierd encoding issues so if you write SKP-11 it wont match as the - sign is encoded differently...
}

veaf.logInfo("init - ctld")
ctld.initialize()

veaf.logInfo("init - veafInterpreter")
veafInterpreter.initialize()
