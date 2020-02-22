-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VEAF ASSETS configuration script
-- By zip (2019)
--
-- Features:
-- ---------
-- Contains all the Caucasus mission-specific configuration for the ASSETS module
-- 
-- Prerequisite:
-- ------------
-- * This script requires DCS 2.5.1 or higher and MIST 4.3.74 or higher.
-- * It also requires veafAssets.lua
-- 
-- Load the script:
-- ----------------
-- load it in a trigger after loading veafAssets
-------------------------------------------------------------------------------------------------------------------------------------------------------------
veafAssets.logInfo("Loading configuration")

veafAssets.Assets = {
	{sort=1, name="CSG-74 Stennis", description="Stennis (CVN74)", information="Tacan 74X\nDatalink 321 Mhz\nICLS 1\nVHF 305 Mhz"},  
	{sort=2, name="CSG-70 Vinson", description="Carl Vinson (CVN70)", information="Tacan 70X\nDatalink 321 Mhz\nICLS 1\nVHF 306 Mhz"},  
	{sort=3, name="CSG-01 Tarawa", description="Tarawa (LHA-1)", information="Tacan 1X\nICLS 1\nVHF 304 Mhz"},  
    {sort=4, name="Arco", description="Arco (KC-135MPRS)", information="Tacan 14Y ARC\nVHF 134 Mhz\nFL200"}, 
    {sort=5, name="Texaco", description="Texaco (KC-135MPRS)", information="Tacan 15Y TEX\nVHF 135 Mhz\nFL200"}, 
    {sort=6, name="Shell", description="Shell (KC-135)", information="Tacan 16Y SHL\nVHF 136 Mhz\nFL220"}, 
    {sort=7, name="Overlord", description="Awacs (E-2D)", information="UHF 251 Mhz\nFL220"}, 
    
}

veafAssets.logInfo("Setting move tanker radio menus")
table.insert(veafMove.Tankers, "Arco")
table.insert(veafMove.Tankers, "Texaco")
table.insert(veafMove.Tankers, "Shell")
