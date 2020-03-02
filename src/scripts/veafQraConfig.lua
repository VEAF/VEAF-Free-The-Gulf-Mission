-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF QRA configuration script
-- By mitch (2020)
--
-- Features:
-- ---------
-- Work in progress to manage QRA
-- 
-- Prerequisite:
-- ------------
-- * This script requires DCS 2.5.1 or higher and MIST 4.3.74 or higher.
-- * It also requires veafCapture.lua
-- 
-- Load the script:
-- ----------------
-- load it in a trigger (mission start)
-------------------------------------------------------------------------------------------------------------------------------------------------------------


veafQra = {}

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Global settings. Stores the script constants
-------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Identifier. All output in DCS.log will start with this.
veafQra.Id = "QRA - "

--- Version.
veafQra.Version = "0.0.0"

-- trace level, specific to this module
veafQra.Trace = false

veafQra.RadioMenuName = "QRA"

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Utility methods
-------------------------------------------------------------------------------------------------------------------------------------------------------------

function veafQra.logInfo(message)
    veaf.logInfo(veafQra.Id .. message)
end

function veafQra.logDebug(message)
    veaf.logDebug(veafQra.Id .. message)
end

function veafQra.logTrace(message)
    if message and veafQra.Trace then
        veaf.logTrace(veafQra.Id .. message)
    end
end

veafQra.logInfo(string.format("Loading version %s", veafQra.Version))

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialisation
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function veafQra.initialize()
    veafQra.logInfo("Initializing module")
    -- veafQra.buildRadioMenu()
	
	
	--veafCapture.updateAirports(false)
	--veafCapture.displayReport()
	
    for i, group in pairs(veafQra.groups) do
		veafQra.groups[i].status="ready"
		veafQra.groups[i].inZone=false

		local unitGroup=Group.getByName(veafQra.groups[i].group)
		if unitGroup then
	      trigger.action.deactivateGroup(unitGroup)		
		end
	end

    for i, group in pairs(veafQra.groups) do

		local airbase = Airbase.getByName(veafQra.groups[i].airbase)
		veafQra.logInfo(string.format("QRA %s is %s near %s", veafQra.groups[i].group, veafQra.groups[i].status, airbase.getName(airbase)))

	end
	
	-- mist.addEventHandler(veafQra.eventHandler)
end


-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Event Handler (manage QRA logic)
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function veafQra.eventHandler()

    for i, group in pairs(veafQra.groups) do
	
		local airbase = Airbase.getByName(veafQra.groups[i].airbase)

		-- todo manage Blue In Zone ...
		-- todo manage Blue Out Zone ...

		-- manage QRA reload
		-- if QRA is dead and no blue in zone
		if veafQra.groups[i].status == "dead" and not veafQra.groups[i].inZone then
			veafQra.logInfo(string.format("RELOAD %s", veafQra.groups[i].group))
			veafQra.groups[i].status = "ready"
			trigger.action.outTextForCoalition(2, string.format("Overlord: a new QRA group is preparing near %s", veafQra.groups[i].airbase),20)
		end

		-- manage delay in spawn process
		if veafQra.groups[i].status == "spawn" then
			veafQra.groups[i].spawnTime = veafQra.groups[i].spawnTime+1
		end
		-- manage QRA dead
		-- if QRA is Ready, attached airbase is RED, and BLUE is in zone: POPUP group	
		if veafQra.groups[i].status == "spawn" and veafQra.groups[i].spawnTime > 30 and not Group.getByName(veafQra.groups[i].group) then
			veafQra.logInfo(string.format("DEAD %s", veafQra.groups[i].group))
			veafQra.groups[i].status = "dead"
			trigger.action.outTextForCoalition(2, string.format("Overlord: group %s faded", veafQra.groups[i].airbase),20)
		end
		
		-- manage QRA spawn		
		-- if QRA is Ready, attached airbase is RED, and BLUE is in zone: POPUP group
		if veafQra.groups[i].status == "ready" and airbase.getCoalition(airbase) == 1 and veafQra.groups[i].inZone then
			veafQra.logInfo(string.format("SPAWN %s", veafQra.groups[i].group))
			veafQra.groups[i].status = "spawn"
			veafQra.groups[i].spawnTime = 0
            mist.respawnGroup(veafQra.groups[i].group,true)
			trigger.action.outTextForCoalition(2, string.format("Overlord: popup group near %s", veafQra.groups[i].airbase),20)
			trigger.action.outSoundForCoalition(2, "Radar Contact Closing Fast.ogg")
		end

	end
	
end


-- config

veafQra.logInfo("Loading configuration")

veafQra.groups={
  ["Lavan"] =
    {   
      zone="Lavan",
	  group = "RED QRA Lavan",
	  airbase = "Lavan Island Airport",
	  status = "ready",
	  inZone = false,
    },
  ["Bandar Lengeh"] =
    {   
      zone="Bandar Lengeh",
	  group = "RED QRA Bandar Lengeh",
	  airbase = "Bandar Lengeh",
	  status = "ready",
	  inZone = false,
    },
  ["Lar Airbase"] =
    {   
      zone="Lar Airbase",
	  group = "RED QRA Lar",
	  airbase = "Lar Airbase",
	  status = "ready",
	  inZone = false,
    },
  ["Havadarya"] =
    {   
      zone="Havadarya",
	  group = "RED QRA Havadarya",
	  airbase = "Havadarya",
	  status = "ready",
	  inZone = false,
    },
  ["Khasab"] =
    {   
      zone="Khasab",
	  group = "RED QRA Khasab",
	  airbase = "Khasab",
	  status = "ready",
	  inZone = false,
    },
}
