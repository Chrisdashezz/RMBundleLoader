return {
	terrainAssetName = 'levels/XP5_001/terrain/terrainexample',
	superBundles = {
		'levels/mp_013/mp_013'
	},
	bundles = {
		'levels/mp_013/mp_013',
		'levels/mp_013/conquestlarge'
	},
	registries = {
		-- 'MP_013_ConquestLarge_Registry'
		DC(Guid('1CEC6C7E-1629-4631-B326-1A134BC6EF27'), Guid('6196137B-50D6-4607-98AE-900BACF47065'))
    },
	blueprintGuidsToBlock = {
		-- Architecture/IND_ServiceBuilding_01/IND_ServiceBuilding_01_Destruction
		["D082A96E-756E-781B-7BD6-6031A52945A6"] = true,
		-- Architecture/StoreRoom_01/StoreRoom_01_Destruction/
		["A29933D7-01C5-4934-0033-D639EEA3180D"] = true,
	}
}
