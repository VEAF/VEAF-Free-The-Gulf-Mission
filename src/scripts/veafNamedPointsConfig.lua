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
    -- airbases
    {name="AIRBASE Al Dhafra",point={x=-211113,y=0,z=-173489, atc=true, tower="126.50", tacan="96X MA"
        , runways={ {name="13L", hdg=127}}}},

    {name="AIRBASE Al Minhad",point={x=-126006,y=0,z=-89157, atc=true, tower="121.80", tacan="99X MIN"
        , runways={ 
		    { name="09", hdg=89, ils="110.70"},
		    { name="27", hdg=269, ils="110.75"},
 	     }}},

    {name="AIRBASE Ras Al Khaimah",point={x=-62931,y=0,z=-30481, atc=true, tower="118.25", tacan="99X MIN 041/46"
        , runways={ 
		    { name="17", hdg=165},
 	     }}},
    {name="AIRBASE Khasab",point={x=884,y=0,z=129, atc=true, tower="124.35", tacan="84X KSB"
        , runways={ 
		    { name="19", hdg=193, ils="110.30"},
 	     }}},

    {name="AIRBASE Sir Abu Nuyar",point={x=-103189,y=0,z=-202643, atc=true, tacan="96X MA 344/60"
        , runways={ 
		    { name="10", hdg=99},
 	     }}},

    {name="AIRBASE Sirri Island",point={x=-27656,y=0,z=-169860, atc=true, tower="130.05", tacan="89X KCK 239/39"
        , runways={ 
		    { name="30", hdg=127},
 	     }}},

    {name="AIRBASE Abu Musa Island",point={x=-31593,y=0,z=-122493, atc=true, tower="122.9", tacan="89X KCK 196/23"
        , runways={ 
		    { name="08", hdg=83},
 	     }}},

    {name="AIRBASE Abu Tunb Kochak",point={x=-9049,y=0,z=-109089, tacan="89X KCK"
        , runways={ 
		    { name="08", hdg=81},
 	     }}},

    {name="AIRBASE Abu Tunb Island",point={x=-9707,y=0,z=-92901, tacan="89X KCK 084/9"
        , runways={ 
		    { name="03", hdg=28},
 	     }}},

    {name="AIRBASE Lavan Island",point={x=76294,y=0,z=-287951, tacan="112X KIH 297/40"
        , runways={ 
		    { name="11", hdg=112},
 	     }}},

    {name="AIRBASE Bandar Lengeh",point={x=41396,y=0,z=-142141, atc=true, tower="121.70", tacan="89X KCK 316/24"
        , runways={ 
		    { name="08", hdg=81},
 	     }}},

    {name="AIRBASE Qeshm Island",point={x=66079,y=0,z=-31813, atc=true, tower="118.05", tacan="47X HDR 211/28"
        , runways={ 
		    { name="05", hdg=50},
 	     }}},

    {name="AIRBASE Havadarya",point={x=109479,y=0,z=-5181, atc=true, tower="123.50", tacan="47X HDR"
        , runways={ 
		    { name="08", hdg=79},
 	     }}},

    {name="AIRBASE Lar",point={x=169017,y=0,z=-183823, atc=true, tower="127.35", tacan="112X KIH 017/72"
        , runways={ 
		    { name="09", hdg=79, ils="111.50"},
 	     }}},

}

veafNamedPoints.logInfo("Loading configuration")