return {
    terrainAssetName = 'Levels/SP_Tank/Terrain/SP_Tank_Terrain_02',
    superBundles = {
        'Levels/Coop_006/Coop_006',
        'Levels/Coop_009/Coop_009',
        'Levels/MP_013/MP_013', -- HMMWV/Vodnik, mapping assets
        -- For SP terrain loading
        'ui',
        'mpchunks',
        'levels/sp_tank/sp_tank', -- This is not a mistake. You have to manually add these bundles unless the game crashes when you want to spawn a blueprint from it.
        'levels/mp_012/mp_012', -- MP logic
    },
    bundles = {
        'Levels/Coop_006/Coop_006',
        'Levels/Coop_009/Coop_009',
        'Levels/MP_013/MP_013',
        'Levels/MP_013/ConquestLarge',
        -- For SP terrain loading
        'ui/flow/bundle/loadingbundlemp',
        'levels/sp_tank/sp_tank',
        'levels/sp_tank/desertfort',
        'levels/sp_tank/backdrop',
        'levels/sp_tank/miclicart',
        'levels/mp_012/mp_012',
        'levels/mp_012/conquest_large',
    }
}