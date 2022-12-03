return {
	terrainAssetName = 'Levels/MP_Canyon/MP_Canyon_Terrain/MP_Canyon_Terrain/MP_Canyon_Terrain',
	superBundles = {
		'levels/mp_013/mp_013'
	},
	bundles = {
		'Levels/Coop_009/ab00_art_parent',
		'Levels/Coop_009/ab00_art_interior_parent',
		'levels/mp_013/mp_013',
		'levels/mp_013/conquestlarge',
	},
	blueprintGuidsToBlock = {
		-- Architecture/IND_ServiceBuilding_01/IND_ServiceBuilding_01_Destruction
		["D082A96E-756E-781B-7BD6-6031A52945A6"] = true,
		-- Architecture/StoreRoom_01/StoreRoom_01_Destruction/
		["A29933D7-01C5-4934-0033-D639EEA3180D"] = true,
	}
}
