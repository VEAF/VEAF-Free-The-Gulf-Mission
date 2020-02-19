-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF COMBAT ZONE configuration script
-- By zip (2019)
--
-- Features:
-- ---------
-- Contains all the Caucasus mission-specific configuration for the COMBAT ZONE module
-- 
-- Prerequisite:
-- ------------
-- * This script requires DCS 2.5.1 or higher and MIST 4.3.74 or higher.
-- * It also requires veafSecurity.lua
-- 
-- Load the script:
-- ----------------
-- load it in a trigger after loading veafCombatZone
-------------------------------------------------------------------------------------------------------------------------------------------------------------
if veafCombatZone then 
	veafCombatZone.logInfo("Loading configuration")

-- # examples:
-- unit name: #command="_spawn combatgroup, size 10, spacing 1, defense 1, armor 1"
-- unit name: #command="_spawn armorgroup, size 15, hdg 180"
-- unit name: #command="_spawn infantrygroup, size 25, armor 1, defense 2" #spawnChance=50
-- unit name: #command="_spawn transportgroup, size 25, defense 1" #spawnRadius=2500

	veafCombatZone.AddZone(
		VeafCombatZone.new()
			:setMissionEditorZoneName("combatZone_Salhad")
			:setFriendlyName("DP26 Salhad")
			:setBriefing("Free Salhad\n" ..
						 "Red forces has captured the city of Salhad\n" ..
						 "Scouts are reporting armored vehicles and air defense\n")
	)

--	veafCombatZone.AddZone(
--		VeafCombatZone.new()
--			:setMissionEditorZoneName("combatZone_Batumi")
--			:setFriendlyName("Batumi")
--			:setBriefing("This is a second test mission")
--	)
end