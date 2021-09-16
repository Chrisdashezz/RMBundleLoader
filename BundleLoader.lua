class "BundleLoader"

local m_Logger = Logger("BundleLoader", true)

local m_BundleConfig = { }

function BundleLoader:__init()
	m_Logger:Write("BundleLoader init.")
	Hooks:Install('Terrain:Load', 999, self, self.OnTerrainLoad)
	Hooks:Install('VisualTerrain:Load', 999, self, self.OnTerrainLoad)
end

function BundleLoader:OnTerrainLoad(p_Hook, p_TerrainName)
	if not m_BundleConfig then
		return
	end

	if m_BundleConfig.terrainAssetName == nil then
		m_Logger:Write("Warning: No terrain asset name can found for this map. This means every terrain will be loaded.")
		return
	end

	if not string.find(p_TerrainName:lower(), m_BundleConfig.terrainAssetName:lower()) then
		m_Logger:Write("Preventing load of terrain: " .. p_TerrainName)
		p_Hook:Return(nil)
	end
end

function BundleLoader:OnLoadBundles(p_Hook, p_Bundles, p_Compartment)
	if not m_BundleConfig then
		return
	end

	if #p_Bundles == 1 and p_Bundles[1] == SharedUtils:GetLevelName() then

		local s_BundlesToLoad = m_BundleConfig.bundles or { }

		-- we hook the first bundle to load other bundles, but we also have to pass the first bundle to the hook
		table.insert(s_BundlesToLoad, 1, p_Bundles[1])

		m_Logger:Write("Bundles:")
		for _, v in pairs(s_BundlesToLoad) do
			m_Logger:Write(v)
		end

		p_Hook:Pass(s_BundlesToLoad, p_Compartment)
	end
end

function BundleLoader:OnRegisterEntityResources(p_LevelData)
	m_Logger:Write("OnRegisterEntityResources")

	if not m_BundleConfig then
		return
	end

	m_Logger:Write("m_BundleConfig")

	local s_RegistriesToLoad = m_BundleConfig.registryDataContainers or { }

	m_Logger:Write("Registries:")
	for k, _ in pairs(s_RegistriesToLoad) do
		m_Logger:Write(k)
	end

	local s_Registry = RegistryContainer()

	for l_RegistryName, l_RegistryDataContainer in pairs(s_RegistriesToLoad) do
		local s_LoadedRegistry = l_RegistryDataContainer:GetInstance()

		s_Registry.blueprintRegistry:add(s_LoadedRegistry)

		ResourceManager:AddRegistry(s_Registry, ResourceCompartment.ResourceCompartment_Game)
		m_Logger:Write("Registry - " .. l_RegistryName)
	end
end

 -- Returns "mp_001" from "levels/mp_001/mp_001"
 local function GetLevelName()
	local s_LevelName = SharedUtils:GetLevelName()

	if s_LevelName == nil then
		return nil
	end

	return s_LevelName:gsub(".*/", "")
end


function BundleLoader:GetBundleConfig(p_LevelName, p_GameModeName)
	local s_Path = '__shared/BundleLoader/LevelBundleConfigs/' .. p_LevelName .. '_' .. p_GameModeName .. '.BundleConfig'

	local s_Ok, s_BundleConfig = pcall(require, s_Path)
	s_BundleConfig = s_Ok and s_BundleConfig or nil

	m_Logger:Write("bundleconfig found: " .. s_Path:split('/')[4])

	return s_BundleConfig
end

function BundleLoader:OnLoadResources(p_MapName, p_GameModeName, p_DedicatedServer)
	m_BundleConfig = self:GetBundleConfig(GetLevelName(), SharedUtils:GetCurrentGameMode())

	if m_BundleConfig then
		local s_SuperBundlesToLoad = m_BundleConfig.superBundles or { }

		for l_Index, l_SuperBundle in pairs(s_SuperBundlesToLoad) do
			ResourceManager:MountSuperBundle(l_SuperBundle)
			m_Logger:Write("Superbundle - " .. l_Index .. ": " .. l_SuperBundle)
		end
	end
end

-- Singleton.
if g_BundleLoader == nil then
	g_BundleLoader = BundleLoader()
end

return g_BundleLoader
