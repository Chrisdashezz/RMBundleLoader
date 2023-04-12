return {
	{
		gamemodes = {
			"AdvanceAndSecureStd",
			"AdvanceAndSecureAlt",
			"ConquestLarge0",
			"SkirmishStd"
		},
		config = {
			terrainAssetName = 'levels/XP5_004/XP5_004_Terrain/XP5_004_Terrain',
			superBundles = {
				'Xp3Chunks',
				'Levels/XP3_Alborz/XP3_Alborz',
				'Levels/MP_003/MP_003'
			},
			bundles = {
				'Levels/XP3_Alborz/XP3_Alborz',
				'Levels/MP_003/MP_003' -- For vodnik
			},
			dynamicBundles = {
				'Levels/MP_003/ConquestLarge'
			},
			dynamicRegistries = {
				-- 'MP_003_ConquestLarge_Registry'
				DC(Guid('188B00C2-5C8E-4438-A6AC-1C0B842ADFC1'), Guid('3E4FA694-FEF9-81FA-07D7-9EA51B8A97E0'))
			},
			blueprintGuidsToBlock = {
				-- Architecture/IND_ServiceBuilding_01/IND_ServiceBuilding_01_Destruction
				["D082A96E-756E-781B-7BD6-6031A52945A6"] = true,
				-- Architecture/StoreRoom_01/StoreRoom_01_Destruction/
				["A29933D7-01C5-4934-0033-D639EEA3180D"] = true,
				-- Architecture/ME_House01/ME_House01_Garage_Destruction
				["4FD89229-7326-6148-92C3-AA6750C1BC2C"] = true,
				-- Architecture/ME_House01/ME_House01_Medium_Destruction
				["AFE21578-98EC-11E0-AF4E-CC0B1F0C93C6"] = true
			}
		}
	}
}
