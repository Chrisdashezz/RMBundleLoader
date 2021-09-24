return {
	terrainAssetName = 'Levels/MP_Canyon/MP_Canyon_Terrain/MP_Canyon_Terrain/MP_Canyon_Terrain',
	superBundles = {
		'Levels/SP_Tank/SP_Tank',
		'Levels/SP_Bank/SP_Bank',
		'Levels/Coop_006/Coop_006',
		'Levels/Coop_009/Coop_009',
		'SpChunks',
		-- 'Xp5Chunks',
		-- 'Levels/XP5_001/XP5_001',
	},
	bundles = {
		'Levels/SP_Tank/SP_Tank',
		'Levels/SP_Tank/DesertFort',
		'Levels/SP_Bank/SP_Bank',
		'Levels/SP_Bank/Ride_SUB',
		'Levels/Coop_006/Coop_006',
		'Levels/Coop_009/Coop_009',
		-- 'Levels/XP5_001/XP5_001',
		-- 'Levels/XP5_001/Air_Superiority',
	},
	registryDataContainers = {
		['SP_Tank_DesertFort_Registry'] = DC(Guid('44234CB8-700B-461D-AF51-4FD9555128A7'), Guid('4C200C23-43D4-27E3-AC17-EBA1030EE457')),
		-- ['XP5_001_AirSuperiority_Registry'] = DC(Guid('558AD19C-6FB6-4497-98C4-E434E71CEE76'), Guid('4EE4D634-E451-F395-AFCE-756319ABEA33')),
		['Coop_006_Registry'] = DC(Guid('23535E3D-E72F-11DF-99CA-879440EEBD7A'), Guid('51C54150-0ABF-03BD-EADE-1876AAD3EC8D')),
		['Coop_009_Registry'] = DC(Guid('F94C5091-E69C-11DF-9B0E-AF9CA6E0236B'), Guid('F05798B2-31EC-210D-CC1D-0F7535BECA30')),
		['SP_Bank_Ride_SUB_Registry'] = DC(Guid('8148A1BB-8F21-4E40-8A8F-2126000ABCD4'), Guid('9F9CABAF-21C2-EF4A-B35D-4358AEBA7565'))
	}
}