-- MP_013: for vodniks

return {
	terrainAssetName = 'Levels/XP5_003/XP5_003_Terrain/XP5_003_Terrain',
	superBundles = {
		'Levels/MP_013/MP_013'
	},
	bundles = {
		'Levels/MP_013/MP_013'
	},
	dynamicBundles = {
		'Levels/MP_013/ConquestLarge'
	},
	dynamicRegistries = {
		-- 'MP_013_ConquestLarge_Registry'
		DC(Guid('1CEC6C7E-1629-4631-B326-1A134BC6EF27'), Guid('6196137B-50D6-4607-98AE-900BACF47065'))
	},
	blueprintGuidsToBlock = {
		-- Architecture/ME_House01/ME_House01_Garage_Destruction
		["4FD89229-7326-6148-92C3-AA6750C1BC2C"] = true,
		-- Architecture/StoreRoom_01/StoreRoom_01_Destruction/
		["A29933D7-01C5-4934-0033-D639EEA3180D"] = true
	}
}
