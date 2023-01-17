return {
	{
		gamemodes = {
			"AAS Standard",
			"AAS Alternative",
			"ConquestLarge0",
			"SKR Standard",
		},
		config = {
			terrainAssetName = 'Levels/XP4_Parliament/Terrain_Parliament/Terrain_Parliament',
			superBundles = {
				'Levels/Coop_010/Coop_010',
				'Levels/FrontEnd/FrontEnd'
			},
			bundles = {
				'Levels/Coop_010/Coop_010',
				'Levels/FrontEnd/FrontEnd' --For mp characters, effects and all weapons
			},
			registries = {
				-- 'FrontEnd_Registry'
				DC(Guid('E07FE68C-01C4-4262-B215-A3FFDE21234C'), Guid('FED93F47-9267-86B1-3B04-D9405BD49C36'))
			}
		}
	},
}
