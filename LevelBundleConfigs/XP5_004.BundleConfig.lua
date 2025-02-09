return {
	{
		gamemodes = {
			"AdvanceAndSecureStd",
			"AdvanceAndSecureAlt",
			"ConquestLarge0"
		},
		config = {
			terrainAssetName = 'levels/XP5_004/XP5_004_Terrain/XP5_004_Terrain',
			superBundles = {
				'Xp3Chunks',
				'Levels/XP3_Alborz/XP3_Alborz',
				'Levels/MP_013/MP_013'
			},
			bundles = {
				'Levels/XP3_Alborz/XP3_Alborz',
				'Levels/MP_013/MP_013' -- For vodnik
			},
			dynamicBundles = {
				'Levels/MP_013/ConquestLarge'
			},
			dynamicRegistries = {
				-- 'MP_013_ConquestLarge_Registry'
				DC(Guid('1CEC6C7E-1629-4631-B326-1A134BC6EF27'), Guid('6196137B-50D6-4607-98AE-900BACF47065'))
			},
			blueprintGuidsToBlock = {
				-- Architecture/IND_ServiceBuilding_01/IND_ServiceBuilding_01_Destruction
				["D082A96E-756E-781B-7BD6-6031A52945A6"] = true,
				-- Architecture/StoreRoom_01/StoreRoom_01_Destruction/
				["A29933D7-01C5-4934-0033-D639EEA3180D"] = true,
				-- Architecture/WareHouse_System_01/WareHouse_Wall_Plain_01_Destruction,
				["56E767BD-EBB4-CB65-93F3-FAB29A7D97C5"] = true,
				-- Architecture/WareHouse_System_01/WareHouse_Wall_GaragePort_01_Destruction,
				["0800F12B-8C53-864B-05B9-92C36EA8D760"] = true,
				-- Architecture/WareHouse_System_01/WareHouse_Wall_Windows_01_Destruction,
				["89239BA3-EA21-B844-EDCE-9F1D9BB33526"] = true,
				-- Architecture/WareHouse_System_01/WareHouse_Wall_Corner_Windows_01_Destruction
				["CAF59842-399D-0F1D-C587-B8655FE0B670"] = true
			}
		}
	},
	{
		gamemodes = {
			"SkirmishStd",
		},
		config = {
			terrainAssetName = 'levels/XP5_004/XP5_004_Terrain/XP5_004_Terrain',
			superBundles = {
				'Xp3Chunks',
				'Levels/XP3_Alborz/XP3_Alborz'
			},
			bundles = {
				'Levels/XP3_Alborz/XP3_Alborz'
			}
		}
	}
}
