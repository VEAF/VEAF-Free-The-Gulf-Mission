-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF NAMEDPOINTS configuration script
-- By zip (2019)
--
-- Features:
-- ---------
-- Contains all the Caucasus mission-specific configuration for the NAMEDPOINTS module
-- 
-- Prerequisite:
-- ------------
-- * This script requires DCS 2.5.1 or higher and MIST 4.3.74 or higher.
-- * It also requires veafNamedPoints.lua
-- 
-- Load the script:
-- ----------------
-- load it in a trigger after loading veafNamedPoints
-------------------------------------------------------------------------------------------------------------------------------------------------------------

veafNamedPoints.Points = {
    -- airbases in Georgia
--    {name="AIRBASE Kobuleti",point={x=-318000,y=0,z=636620, atc=true, tower="133.00", tacan="67X KBL"
--        , runways={ {name="07", hdg=69, ils="111.50"}}}},
}

veafNamedPoints.logInfo("Loading configuration")