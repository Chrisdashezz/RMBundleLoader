return {
	terrainAssetName = 'Levels/XP5_003/XP5_003_Terrain/XP5_003_Terrain',
	superBundles = {
		'SpChunks',
		'Levels/SP_Tank/SP_Tank',
		'Levels/SP_Bank/SP_Bank',
	},
	bundles = {
		'Levels/SP_Tank/SP_Tank',
		'Levels/SP_Tank/DesertFort',
		'Levels/SP_Bank/SP_Bank',
		'Levels/SP_Bank/Ride_SUB',
	},
	blueprintGuidsToBlock = {
		-- Architecture/ME_House01/ME_House01_Garage_Destruction
		["4FD89229-7326-6148-92C3-AA6750C1BC2C"] = true
	},
	registries = {
		-- 'SP_Tank_DesertFort_Registry'
		DC(Guid('44234CB8-700B-461D-AF51-4FD9555128A7'), Guid('4C200C23-43D4-27E3-AC17-EBA1030EE457')),
		-- 'SP_Bank_Ride_SUB_Registry'
		DC(Guid('8148A1BB-8F21-4E40-8A8F-2126000ABCD4'), Guid('9F9CABAF-21C2-EF4A-B35D-4358AEBA7565')),
	},
}
