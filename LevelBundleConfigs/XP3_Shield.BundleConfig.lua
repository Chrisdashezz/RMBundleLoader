return {
	{
		gamemodes = {
			"AssaultAndSecureStd",
			"AssaultAndSecureAlt",
			"ConquestLarge0"
		},
		config = {
			terrainAssetName = 'levels/xp3_legrandval/terrain/legrandval',
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
			}
		}
	},
	{
		gamemodes = {
			"SkirmishStd",
		},
		config = {
			terrainAssetName = 'levels/xp3_legrandval/terrain/legrandval',
			superBundles = {
				'Xp3Chunks',
				'Levels/XP3_Alborz/XP3_Alborz'
			},
			bundles = {
				'Levels/XP3_Alborz/XP3_Alborz'
			},
		}
	}
}
