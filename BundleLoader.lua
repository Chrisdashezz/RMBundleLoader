---@class BundleLoader
BundleLoader = class "BundleLoader"

---@type Logger
local m_Logger = Logger("BundleLoader", false)

---@class BundleConfigTable
---@field terrainAssetName string
---@field superBundles string[]
---@field bundles string[]
---@field blueprintGuidsToBlock boolean[] | nil

---@type BundleConfigTable
local m_BundleConfig = { }

function BundleLoader:__init()
	m_Logger:Write("BundleLoader init.")
	Hooks:Install('Terrain:Load', 999, self, self.OnTerrainLoad)
	Hooks:Install('VisualTerrain:Load', 999, self, self.OnTerrainLoad)
end

---VEXT Shared EntityFactory:CreateFromBlueprint Hook
---@param p_HookCtx HookContext
---@param p_Blueprint DataContainer
---@param p_Transform LinearTransform
---@param p_Variation integer
---@param p_ParentRepresentative DataContainer | nil
function BundleLoader:OnEntityCreateFromBlueprint(p_HookCtx, p_Blueprint, p_Transform, p_Variation, p_ParentRepresentative)
	if m_BundleConfig.blueprintGuidsToBlock and m_BundleConfig.blueprintGuidsToBlock[tostring(p_Blueprint.instanceGuid)] then
		m_Logger:Warning("Blocking blueprint: " .. tostring(p_Blueprint.instanceGuid))
		p_HookCtx:Return()
	end
end

---VEXT Shared VisualTerrain:Load Hook
---VEXT Shared Terrain:Load Hook
---@param p_HookCtx HookContext
---@param p_TerrainName string
function BundleLoader:OnTerrainLoad(p_HookCtx, p_TerrainName)
	if not m_BundleConfig then
		return
	end

	if m_BundleConfig.terrainAssetName == nil then
		m_Logger:Write("Warning: No terrain asset name can found for this map. This means every terrain will be loaded.")
		return
	end

	if not string.find(p_TerrainName:lower(), m_BundleConfig.terrainAssetName:lower()) then
		m_Logger:Write("Preventing load of terrain: " .. p_TerrainName)
		p_HookCtx:Return(nil)
	end
end

---VEXT Shared ResourceManager:LoadBundles Hook
---@param p_HookCtx HookContext
---@param p_Bundles string[]
---@param p_Compartment ResourceCompartment|integer
function BundleLoader:OnLoadBundles(p_HookCtx, p_Bundles, p_Compartment)
	if not m_BundleConfig then
		return
	end

	if #p_Bundles == 1 and p_Bundles[1] == SharedUtils:GetLevelName() then
		---@type string[]
		local s_BundlesToLoad = {}

		m_Logger:Write("Bundles:")
		for _, l_Bundle in pairs(m_BundleConfig.bundles) do
			m_Logger:Write(l_Bundle)
			table.insert(s_BundlesToLoad, l_Bundle)
		end

		-- we hook the first bundle to load other bundles, but we also have to pass the first bundle to the hook
		-- unless a singleplayer or coop level is being loaded, in which case the main level bundle is listed in the bundle config so that the order is correct
		if string.find(SharedUtils:GetLevelName(), 'SP_') == nil and string.find(SharedUtils:GetLevelName(), 'COOP_') == nil then
			m_Logger:Write(p_Bundles[1])
			table.insert(s_BundlesToLoad, p_Bundles[1])
		end

		p_HookCtx:Pass(s_BundlesToLoad, p_Compartment)
	end
end

---VEXT Shared Level:RegisterEntityResources Event
---@param p_LevelData DataContainer
function BundleLoader:OnRegisterEntityResources(p_LevelData)
	---@type DC[]
	local s_RegistriesToLoad = {
		-- 'SP_Tank_DesertFort_Registry'
		DC(Guid('44234CB8-700B-461D-AF51-4FD9555128A7'), Guid('4C200C23-43D4-27E3-AC17-EBA1030EE457')),
		-- 'Coop_006_Registry'
		DC(Guid('23535E3D-E72F-11DF-99CA-879440EEBD7A'), Guid('51C54150-0ABF-03BD-EADE-1876AAD3EC8D')),
		-- 'Coop_009_Registry'
		DC(Guid('F94C5091-E69C-11DF-9B0E-AF9CA6E0236B'), Guid('F05798B2-31EC-210D-CC1D-0F7535BECA30')),
		-- 'SP_Bank_Ride_SUB_Registry'
		DC(Guid('8148A1BB-8F21-4E40-8A8F-2126000ABCD4'), Guid('9F9CABAF-21C2-EF4A-B35D-4358AEBA7565')),
		-- 'MP_017_R_Registry'
		DC(Guid('D9E8DC6C-250E-4AF9-9878-07809B5AE5D9'), Guid('33FF3424-F0C5-9A3A-5C0F-A49573416A13')),
		-- 'MP_013_ConquestLarge_Registry'
		DC(Guid('1CEC6C7E-1629-4631-B326-1A134BC6EF27'), Guid('6196137B-50D6-4607-98AE-900BACF47065'))
	}

	for l_Index, l_RegistryDataContainer in pairs(s_RegistriesToLoad) do
		m_Logger:Write(l_Index)
		local s_LoadedRegistry = l_RegistryDataContainer:GetInstance()

		if s_LoadedRegistry == nil then
			m_Logger:Warning("Couldn\'t find RegistryContainer Guid('" .. tostring(l_RegistryDataContainer.m_InstanceGuid) .. "')")
		else
			ResourceManager:AddRegistry(s_LoadedRegistry, ResourceCompartment.ResourceCompartment_Game)
		end
	end
end

 -- Returns "mp_001" from "levels/mp_001/mp_001"
 ---@return string
 local function GetLevelName()
	local s_LevelName = SharedUtils:GetLevelName()

	if s_LevelName == nil then
		return nil
	end

	return s_LevelName:gsub(".*/", "")
end

---@param p_LevelName string
---@param p_GameModeName string
---@return BundleConfigTable
function BundleLoader:GetBundleConfig(p_LevelName, p_GameModeName)
	---@type string
	local s_Path = '__shared/BundleLoader/LevelBundleConfigs/' .. p_LevelName .. '_' .. p_GameModeName .. '.BundleConfig'

	local s_Ok, s_BundleConfig = pcall(require, s_Path)
	s_BundleConfig = s_Ok and s_BundleConfig or nil

	m_Logger:Write("BundleConfig found: " .. s_Path:split('/')[4])

	return s_BundleConfig
end

---VEXT Shared Level:LoadResources Event
---@param p_LevelName string
---@param p_GameModeName string
---@param p_IsDedicatedServer boolean
function BundleLoader:OnLoadResources(p_LevelName, p_GameModeName, p_IsDedicatedServer)
	m_BundleConfig = self:GetBundleConfig(GetLevelName(), SharedUtils:GetCurrentGameMode())

	if m_BundleConfig then
		---@type string[]
		local s_SuperBundlesToLoad = m_BundleConfig.superBundles or { }

		for l_Index, l_SuperBundle in pairs(s_SuperBundlesToLoad) do
			ResourceManager:MountSuperBundle(l_SuperBundle)
			m_Logger:Write("Superbundle - " .. l_Index .. ": " .. l_SuperBundle)
		end
	end
end

return BundleLoader()
