return {
    terrainAssetName = 'Levels/SP_Tank/Terrain/SP_Tank_Terrain_02',
    superBundles = {
        -- RM
        'mpchunks',
        'Levels/MP_013/MP_013', -- HMMWV/Vodnik, mapping assets
        -- For SP terrain loading
        'levels/mp_012/mp_012', -- MP logic
    },
    bundles = {
        -- RM
        'Levels/MP_013/MP_013',
        'Levels/MP_013/ConquestLarge',
        -- For SP terrain loading
        'levels/mp_012/mp_012',
        'levels/mp_012/conquest_large',
        'levels/sp_tank/sp_tank',
        'levels/sp_tank/desertfort',
        'levels/sp_tank/backdrop',
        'levels/sp_tank/miclicart',
    },
    registries = {
		-- 'MP_013_ConquestLarge_Registry'
		DC(Guid('1CEC6C7E-1629-4631-B326-1A134BC6EF27'), Guid('6196137B-50D6-4607-98AE-900BACF47065'))
    },
}