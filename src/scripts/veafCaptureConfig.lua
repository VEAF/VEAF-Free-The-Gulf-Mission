-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF CAPTURE configuration script
-- By mitch (2020)
--
-- Features:
-- ---------
-- Contains all the airport configuration for the CAPTURE module
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


veafCapture = {}

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Global settings. Stores the script constants
-------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Identifier. All output in DCS.log will start with this.
veafCapture.Id = "CAPTURE - "

--- Version.
veafCapture.Version = "0.0.0"

-- trace level, specific to this module
veafCapture.Trace = false

veafCapture.RadioMenuName = "CAPTURE"

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Utility methods
-------------------------------------------------------------------------------------------------------------------------------------------------------------

function veafCapture.logInfo(message)
    veaf.logInfo(veafCapture.Id .. message)
end

function veafCapture.logDebug(message)
    veaf.logDebug(veafCapture.Id .. message)
end

function veafCapture.logTrace(message)
    if message and veafCapture.Trace then
        veaf.logTrace(veafCapture.Id .. message)
    end
end

veafCapture.logInfo(string.format("Loading version %s", veafCapture.Version))

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Radio menu and help
-------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Build the initial radio menu
function veafCapture.buildRadioMenu()
    veafCapture.logDebug("buildRadioMenu()")
    veafCapture.rootPath = veafRadio.addMenu(veafCapture.RadioMenuName)
    veafRadio.addCommandToSubmenu("SA", veafCapture.rootPath, veafCapture.displayReport, nil, veafRadio.USAGE_ForAll)
    
    veafRadio.refreshRadioMenu()
end


--- Converts side string to coalition integer.
-- 0 = "neutral", 1 = "red", 2 = "blue"
-- @param string side side string.
-- @return number coalition number.
function veafCapture.coalition(side)
	if side == "neutral" then return coalition.side.NEUTRAL
	elseif side == "red" then return coalition.side.RED
	elseif side == "blue" then return coalition.side.BLUE
	end
end

-- get airfields of given side which are marked with
function veafCapture.getAirfields(side)
    return coalition.getAirbases(veafCapture.coalition(side))
end

-- manage airport capture (internal)
-- @param bool displayAlert
function veafCapture.updateAirports(displayAlert)

	local airfields=veafCapture.getAirfields("red")

    for i = 1, #airfields do
      -- get name of airfield
      local airfieldName = airfields[i]:getName()
	
	  if veafCapture.Airports[airfieldName] then
		if veafCapture.Airports[airfieldName].coalition == "blue" then
			if displayAlert then
				trigger.action.outText(string.format("Airport %s has been captured by Red", airfieldName), 20, true)
			end
			veafCapture.Airports[airfieldName].coalition = "red"
		end
	  end
    end

	airfields=veafCapture.getAirfields("blue")

    for i = 1, #airfields do
      -- get name of airfield
      local airfieldName = airfields[i]:getName()
	
	  if veafCapture.Airports[airfieldName] then
		if veafCapture.Airports[airfieldName].coalition == "red" then
			if displayAlert then
				trigger.action.outText(string.format("Airport %s has been captured by Blue", airfieldName), 20, true)
			end
			veafCapture.Airports[airfieldName].coalition = "blue"
		end
	  end
    end

end

-- display airports status
function veafCapture.displayReport()
	local message="";
	message = message .. "Airports Global Situation\n"
	message = message .. "-------------------------\n\n"
	
	for airportName,airport in pairs(veafCapture.Airports) do
		message = message .. string.format("%s - %s\n", airport.coalition, airportName)
    end

	trigger.action.outText(message, 20, true)
end

-- manage airport capture (should by triggered on airport capture in mission editor
function veafCapture.onAirportCapture()
	veafCapture.logInfo("an Airport has been captured")

	veafCapture.updateAirports(true);
	veafCapture.displayReport()
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- initialisation
-------------------------------------------------------------------------------------------------------------------------------------------------------------
function veafCapture.initialize()
    veafCapture.logInfo("Initializing module")
    veafCapture.buildRadioMenu()
	veafCapture.updateAirports(false)
	veafCapture.displayReport()
	
	local airfields=veafCapture.getAirfields("red")

    for i = 1, #airfields do
		local capturable="n/a";
		-- get name of airfield
		local airfieldName = airfields[i]:getName()
		if veafCapture.Airports[airfieldName] then
			capturable="capturable";
		end
		veafCapture.logInfo(string.format("red airport '%s' %s", airfieldName, capturable))
	end

	local airfields=veafCapture.getAirfields("blue")

    for i = 1, #airfields do
		local capturable="n/a";
		-- get name of airfield
		local airfieldName = airfields[i]:getName()
		if veafCapture.Airports[airfieldName] then
			capturable="capturable";
		end
		veafCapture.logInfo(string.format("blue airport '%s' %s", airfieldName, capturable))
	end

end

---- config

veafCapture.Airports = {

    -- airports
	["Abu Musa Island Airport"] = {
	  coalition = "red",
	},
	["Bandar Lengeh"] = {
	  coalition = "red",
	},
	["Tunb Island AFB"] = {
	  coalition = "red",
	},
	["Havadarya"] = {
	  coalition = "red",
	},
	["Khasab"] = {
	  coalition = "red",
	},
	["Lar Airbase"] = {
	  coalition = "red",
	},
	["Qeshm Island"] = {
	  coalition = "red",
	},
	["Sirri Island"] = {
	  coalition = "red",
	},
	["Tunb Kochak"] = {
	  coalition = "red",
	},
	["Lavan Island Airport"] = {
	  coalition = "red",
	},
}


veafCapture.logInfo("Loading configuration")

-- red airports
-- 'Abu Musa Island Airport'
-- 'Bandar Lengeh'
-- 'Tunb Island AFB'
-- 'Havadarya'
-- 'Khasab'
-- 'Lar Airbase'
-- 'Qeshm Island'
-- 'Sirri Island'
-- 'Tunb Kochak'
-- 'Lavan Island Airport'

-- blue airports
-- 'Al Dhafra AB'
-- 'Al Minhad AB'
-- 'Sir Abu Nuayr'
-- 'Ras Al Khaimah'
-- 'FARP London'
-- 'FARP DP15 Salhad Zone'
-- 'FARP DP06 Ras Al Khaimah'
-- 'FARP DP17 Khasab Zone'
