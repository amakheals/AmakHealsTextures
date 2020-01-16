local AddonName, AmakHealsTextures = ...
if AmakHealsTextures.BuildFail(80300) then return end

--WoW API / Variables
local IsAddOnLoaded = IsAddOnLoaded
local LoadAddOn = LoadAddOn

-- check for optional dependency WeakAuras
if not select(1, IsAddOnLoaded("WeakAuras")) then
	loaded, reason = LoadAddOn("WeakAuras")
	if not loaded then
		AmakHealsTextures.log("Can't Load Optional Dependencies: " .. "WeakAuras")
	end
end
local WeakAuras = WeakAuras
if select(1, IsAddOnLoaded("WeakAuras")) then
	if not WeakAuras then
		AmakHealsTextures.log("Can't Find Optional Dependencys")
	else
		AmakHealsTextures.log("Found Optional Dependency: " .. "WeakAuras")
		WeakAuras.RegisterAddon(AddonName, AmakHealsTextures.PlainAddonTitle, "Data sourced from " .. AmakHealsTextures.PlainAddonTitle, "Interface\\Addons\\" .. AmakHealsTextures.Name .. "\\MiscTexturePack\\Logo.blp")
		AmakHealsTextures.log("Enabled Optional Dependency: " .. "WeakAuras")
	end
-- local spellsTextureMap = {}
else
	AmakHealsTextures.log("Optional Dependency Not Loaded: " .. "WeakAuras")
end

-- DEBUG Code

-- set throttle keys
AmakHealsTextures.throttleKeys = (AmakHealsTextures.throttleKeys or {})
AmakHealsTextures.throttleKeys["default"] = 0

--set throttle states --
AmakHealsTextures.throttleStates = (AmakHealsTextures.throttleStates or {})

-- initialize a key for throttling
function AmakHealsTextures.initThrottleTick(key)
	if (not AmakHealsTextures.throttleKeys[key]) then
		AmakHealsTextures.throttleKeys[key] = 0
		AmakHealsTextures.throttleStates[key] = false
	end
end

function AmakHealsTextures.resetThrottleTick(resetkey, throttleRate)
	-- need to call AmakHealsTextures.initThrottleTick(key) first
	if not AmakHealsTextures.throttleKeys[resetkey] then return end
	local theTime = floor(GetTime())
	if (not AmakHealsTextures.lastTick) or (AmakHealsTextures.lastTick < (theTime - throttleRate)) then
		AmakHealsTextures.lastTick = theTime
	end
	if (not AmakHealsTextures.throttleStates[resetkey]) or (AmakHealsTextures.throttleKeys[resetkey] < (AmakHealsTextures.lastTick - throttleRate)) then
		AmakHealsTextures.throttleKeys[resetkey] = AmakHealsTextures.lastTick
		-- deactivate throttle
		AmakHealsTextures.throttleStates[resetkey] = false
	end
	return
end


function AmakHealsTextures.shouldThrottle(throttlekey, throttleRate)
	-- need to call AmakHealsTextures.initThrottleTick(throttlekey) first
	if (not AmakHealsTextures.throttleKeys) then return false end
	-- if throttling active
	if AmakHealsTextures.throttleKeys[throttlekey] then
		if (AmakHealsTextures.throttleStates[throttlekey] or false) then
			-- check and reset throttle if needed
			AmakHealsTextures.resetThrottleTick(throttlekey, throttleRate)
			-- throttle if needed
			return AmakHealsTextures.throttleStates[throttlekey]
		else
			-- snooze next time
			AmakHealsTextures.throttleStates[throttlekey] = true
			-- and don't throttle yet
			return false
		end
	end
	-- no throttling
	return false
end
