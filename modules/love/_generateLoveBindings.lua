--[[============================================================
--=
--=  LÖVE bindings generator for Glóa
--=
--=  Depends on LÖVE-API (github.com/love2d-community/love-api)
--=
--=  Usage:
--=  $ lua _generateLoveBindings.lua <loveApiDirectory>
--=
--=  loveApiDirectory must point to folder with these items:
--=  - extra.lua
--=  - love_api.lua
--=  - modules/
--=
--============================================================]]



local MODULE_HEADER = [=[
--[[============================================================
--=
--=  LÖVE bindings (love2d.org)
--=
--=  Supported versions: 11.3
--=
--============================================================]]
]=]

local ENUMS_AS_STRINGS = {KeyConstant=true, Scancode=true} -- These types will just be 'string' instead of actual enums.

local VALUES_TO_OUTPUT_AS_IS = {
	-- ["luaCodeValue"] = { objectName1, ... }
	sx = { -- sy=sx
		draw              = true,
		drawInstanced     = true,
		drawLayer         = true,
		print             = true,
		printf            = true,
		scale             = true,
		add               = true,
		addLayer          = true,
		set               = true,
		setLayer          = true,
		addf              = true,
		newTransform      = true,
		setTransformation = true,
	},
	rx = { -- ry=rx
		rectangle = true,
	},
	name = { -- attachname=name
		attachAttribute = true,
	},
	xmin = { -- xmax=xmin
		setLinearAcceleration = true,
	},
	ymin = { -- ymax=ymin
		setLinearAcceleration = true,
	},
	min = { -- max=min
		setLinearDamping          = true,
		setParticleLifetime       = true,
		setRadialAcceleration     = true,
		setRotation               = true,
		setSpeed                  = true,
		setSpin                   = true,
		setTangentialAcceleration = true,
	},
}



local GLOA_KEYWORDS = {
	["and"]          = true,
	["break"]        = true,
	["case"]         = true,
	["cast"]         = true,
	["continue"]     = true,
	["defer"]        = true,
	["do"]           = true,
	["else"]         = true,
	["elseif"]       = true,
	["enum"]         = true,
	["export"]       = true,
	["export_value"] = true,
	["external"]     = true,
	["for"]          = true,
	["if"]           = true,
	["in"]           = true,
	["inline"]       = true,
	["local"]        = true,
	["namespace"]    = true,
	["not"]          = true,
	["or"]           = true,
	["return"]       = true,
	["static"]       = true,
	["struct"]       = true,
	["type_info"]    = true,
	["type_of"]      = true,
	["using"]        = true,
	["variant_of"]   = true,
	["while"]        = true,
	-- Reserved words:
	["goto"]         = true,
	["read_only"]    = true,
	["until"]        = true,
	-- Literals:
	["false"]        = true,
	["nil"]          = true,
	["NULL"]         = true,
	["true"]         = true,
	-- Built-in types:
	["any"]          = true,
	["bool"]         = true,
	["float"]        = true,
	["int"]          = true,
	["none"]         = true,
	["string"]       = true,
	["table"]        = true,
	["Type"]         = true,
	["void"]         = true,
}

local DIR_HERE    = debug.getinfo(1, "S").source:match"^@(.+)":gsub("\\", "/"):gsub("/?[^/]+$", ""):gsub("^$", ".")
local EMPTY_TABLE = {}

local loveApiDir = ... or error("Missing <loveApiDirectory> argument.", 0)
package.path     = package.path..";"..loveApiDir.."/?.lua"

local loveApiExtra      = require"extra"(require"love_api") -- Unfortunately 'extra' modifies love_api and everything it requires, so we'll have to painfully undo the damage...
package.loaded.love_api = nil
for moduleName in pairs(package.loaded) do
	if moduleName:find"^modules%." then  package.loaded[moduleName] = nil  end
end
local loveApi = require"love_api"

local countEnums            = 0
local countFunctions        = 0
local countFunctionVariants = 0
local countModules          = 0
local countTypes            = 0

local editsMove             = {}
local editsDelete           = {}
local editsSettype          = {}
local editsRename           = {}
local editsAdd              = {}

local numberTypeByObject    = {}
local numberTypeByScope     = {}
local numberTypeByModule    = {}
local numberTypeByName      = {}

local argumentsToJoin       = {}



--==============================================================
--= Functions ==================================================
--==============================================================

_G.F = string.format

function _G.printf(s, ...)
	print(s:format(...))
end

function _G.errorLine(path, ln, s, ...)
	error(path..":"..ln..": "..s:format(...), 0)
end
function _G.errorInternal(s)
	error("Internal error."..(s and " // "..tostring(s) or ""), 2)
end

function _G.indexOf(t, v)
	for i = 1, #t do
		if t[i] == v then  return i  end
	end
	return nil
end
function _G.itemWith1(t, k, v)
	for i, item in ipairs(t) do
		if item[k] == v then  return item, i  end
	end
	return nil
end

function _G.trim(s)
	return (s:gsub("^%s+", ""):gsub("%s+$", ""))
end

function _G.getNameOfMostSpecificType(unsortedLineageTypeNames)
	local parentTypeInfosTable = {}

	for _, typeName in ipairs(unsortedLineageTypeNames) do
		local typeInfoExtra            = itemWith1(loveApiExtra.types, "name", typeName) or errorInternal(typeName)
		parentTypeInfosTable[typeName] = typeInfoExtra.supertypes or {}
	end

	for _, typeName in ipairs(unsortedLineageTypeNames) do
		local parentTypeInfos     = parentTypeInfosTable[typeName]
		local allOthersAreParents = true

		for _, otherTypeName in ipairs(unsortedLineageTypeNames) do
			if otherTypeName ~= typeName and not itemWith1(parentTypeInfos, "name", otherTypeName) then
				allOthersAreParents = false
				break
			end
		end

		if allOthersAreParents then  return typeName  end
	end

	errorInternal()
end

local function eachArgument(t)
	local i = 0
	return function()
		i = i+1
		if t[i] then  return i, t[i]  end
	end
end

local function writeOneOrMoreArgumentNames(state, argIndex, argInfo, arguments, iter)
	local argName1 = state:writeName(argInfo.name, true)

	-- Write (x:float,y:float) as (x,y:float) etc.
	for _, argNames in ipairs(argumentsToJoin) do
		local argIndexLast = argIndex + #argNames - 1

		if arguments[argIndexLast] then
			local matching = true

			for i, argName in ipairs(argNames) do
				local argInfoOther = arguments[argIndex+i-1]

				if not (argInfoOther.name == argName and (argInfoOther.typeOverride or argInfoOther.type) == (argInfo.typeOverride or argInfo.type) and argInfoOther.default == argInfo.default) then
					matching = false
					break
				end
			end

			if matching then
				for argIndex = argIndex+1, argIndexLast do
					state:write(",")
					state:writeName(select(2, iter()).name, false)
				end
				return argName1
			end
		end
	end

	return argName1
end

local function processFunction(state, funcInfo, funcName, alignment)
	for _, variantInfo in ipairs(funcInfo.variants) do
		countFunctionVariants = countFunctionVariants+1

		state:declarationConstantStart(funcName, alignment)

		state:write("(")
		state:writeFirstFunctionArgument(variantInfo)

		if variantInfo.arguments and variantInfo.arguments[1] then
			local iter = eachArgument(variantInfo.arguments)

			for argIndex, argInfo in iter do
				if argIndex > 1 then  state:write(", ")  end

				local argName1 = writeOneOrMoreArgumentNames(state, argIndex, argInfo, variantInfo.arguments, iter)
				state:write(":")

				local typeName = argInfo.typeOverride or state:getFinalType(argInfo.type, funcInfo.name, argName1)
				state:write(typeName)

				if argInfo.default and argInfo.name ~= "..." then
					state:write("=")
					state:writeValue(typeName, argInfo.default, funcInfo.name)
				end
			end
		end

		state:write(")")

		if variantInfo.returns and variantInfo.returns[1] then
			local iter = eachArgument(variantInfo.returns)

			state:write(" -> (")

			for argIndex, argInfo in iter do
				if argIndex > 1 then  state:write(", ")  end

				local argName1 = writeOneOrMoreArgumentNames(state, argIndex, argInfo, variantInfo.returns, iter)
				state:write(":")

				local typeName = argInfo.typeOverride or state:getFinalType(argInfo.type, funcInfo.name, argName1)
				state:write(typeName)
			end

			state:write(")")
		end

		if state.scopeStack[#state.scopeStack] == "struct" then
			state:write(' !foreign method "', funcInfo.name, '"')
		else
			state:write(' !foreign lua "', state.currentModule, '.', funcInfo.name, '"')
		end

		state:statementEnd()
	end
end

function _G.processModule(state, moduleInfo)
	if moduleInfo.constants and moduleInfo.constants[1] then
		local names     = {}
		local alignment = 0

		for i, constInfo in ipairs(moduleInfo.constants) do
			constInfo.nameUpper = constInfo.nameUpper or constInfo.name:upper()
			names[i]            = state:getFinalName(constInfo.nameUpper)
			alignment           = math.max(alignment, #names[i])
		end

		for i, constInfo in ipairs(moduleInfo.constants) do
			state:declarationConstantStart(names[i], alignment)
			state:writef("%q", constInfo.name)
			state:statementEnd()
		end
	end

	if moduleInfo.enums and moduleInfo.enums[1] then
		for _, enumInfo in ipairs(moduleInfo.enums) do
			countEnums = countEnums+1

			if ENUMS_AS_STRINGS[enumInfo.name] then
				state:declarationConstantStart(state:getFinalName(enumInfo.name), 0)
				state:write("string")
				state:statementEnd()
			else
				state:enumStart(enumInfo.name)
				processModule(state, enumInfo)
				state:enumEnd()
			end
		end
	end

	if moduleInfo.types and moduleInfo.types[1] then
		for _, typeInfo in ipairs(moduleInfo.types) do
			countTypes = countTypes+1

			state:structStart(typeInfo.name)

			if typeInfo.supertypes and typeInfo.supertypes[1] then
				local parentTypeName = getNameOfMostSpecificType(typeInfo.supertypes)
				state:write(state.indent, "using ", parentTypeName)
				state:statementEnd()
			end

			processModule(state, typeInfo)
			state:structEnd()
		end
	end

	if moduleInfo.functions and moduleInfo.functions[1] then
		local names     = {}
		local alignment = 0

		for i, funcInfo in ipairs(moduleInfo.functions) do
			countFunctions = countFunctions+1
			names[i]       = state:getFinalName(funcInfo.name)
			alignment      = math.max(alignment, #names[i])
		end

		for i, funcInfo in ipairs(moduleInfo.functions) do
			processFunction(state, funcInfo, names[i], alignment)
		end
	end

	--[[ :CallbackInformation
	if moduleInfo.callbacks and moduleInfo.callbacks[1] then
		for _, callbackInfo in ipairs(moduleInfo.callbacks) do
			processFunction(state, callbackInfo)
		end
	end
	]]

	if moduleInfo.modules and moduleInfo.modules[1] then
		for _, subModuleInfo in ipairs(moduleInfo.modules) do
			countModules = countModules+1
			state:moduleStart(subModuleInfo.name)
			processModule(state, subModuleInfo)
			state:moduleEnd()
		end
	end
end

function _G.splitObjectPath(objectPathString)
	local objectPath = {}
	for segment in objectPathString:gmatch"[^.]+" do
		table.insert(objectPath, segment)
	end
	return objectPath
end

local function findObject(objectName, objectParent, ignores)
	for _, constInfo in ipairs(objectParent.constants or EMPTY_TABLE) do
		constInfo.nameUpper = constInfo.nameUpper or constInfo.name:upper()
		if not ignores[constInfo] and constInfo.nameUpper == objectName then  return constInfo, "constant"  end
	end
	for _, enumInfo in ipairs(objectParent.enums or EMPTY_TABLE) do
		if not ignores[enumInfo] and enumInfo.name == objectName then  return enumInfo, "enum"  end
	end
	for _, funcInfo in ipairs(objectParent.functions or EMPTY_TABLE) do
		if not ignores[funcInfo] and funcInfo.name == objectName then  return funcInfo, "function"  end
	end
	for _, moduleInfo in ipairs(objectParent.modules or EMPTY_TABLE) do
		if not ignores[moduleInfo] and moduleInfo.name == objectName then  return moduleInfo, "module"  end
	end
	for _, typeInfo in ipairs(objectParent.types or EMPTY_TABLE) do
		if not ignores[typeInfo] and typeInfo.name == objectName then  return typeInfo, "type"  end
	end
	for i, variantInfo in ipairs(objectParent.variants or EMPTY_TABLE) do
		for _, argInfo in ipairs(variantInfo.arguments or EMPTY_TABLE) do
			if not ignores[argInfo] and argInfo.name == objectName then  return argInfo, "argument"..i  end
		end
		for _, argInfo in ipairs(variantInfo.returns or EMPTY_TABLE) do
			if not ignores[argInfo] and argInfo.name == objectName then  return argInfo, "return"..i  end
		end
	end
	return nil
end

function _G.getObjectAtPath(objectPath, object, ignores)
	assert(objectPath[1])
	local objectType, objectParent

	for i, objectName in ipairs(objectPath) do
		objectParent       = object
		object, objectType = findObject(objectName, objectParent, ignores)

		if object then
			-- void
		elseif i == 1 then
			return nil, F("Could not find object '%s'.", objectName)
		else
			return nil, F("Could not find object '%s' in '%s'.", objectName, table.concat(objectPath, ".", 1, i-1))
		end
	end

	return object, objectType, objectParent
end

function _G.requireObjectArray(containerObject, objectType)
	if     objectType == "constant" then  containerObject.constants = containerObject.constants or {} ; return containerObject.constants
	elseif objectType == "enum"     then  containerObject.enums     = containerObject.enums     or {} ; return containerObject.enums
	elseif objectType == "function" then  containerObject.functions = containerObject.functions or {} ; return containerObject.functions
	elseif objectType == "module"   then  containerObject.modules   = containerObject.modules   or {} ; return containerObject.modules
	elseif objectType == "type"     then  containerObject.types     = containerObject.types     or {} ; return containerObject.types
	-- elseif objectType:find"^argument%d+$" then  return containerObject.variants[tonumber(objectType:match"%d+")].arguments
	-- elseif objectType:find"^return%d+$"   then  return containerObject.variants[tonumber(objectType:match"%d+")].returns
	else errorInternal(objectType) end
end

local BRACKET_BALANCE = {
	[("("):byte()] = 1,
	[("["):byte()] = 1,
	[("{"):byte()] = 1,
	[(")"):byte()] = -1,
	[("]"):byte()] = -1,
	[("}"):byte()] = -1,
}
function _G.updateBracketBalance(s, balance)
	for i = 1, #s do
		balance = balance + (BRACKET_BALANCE[s:byte(i)] or 0)
		assert((balance >= 0), s)
	end
	return balance
end



--==============================================================
--= Script =====================================================
--==============================================================

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

local EDITS_PATH = DIR_HERE.."/_edits.txt"
local _nextLine  = io.lines(EDITS_PATH)
local ln         = 0

local function nextLine()
	local line = _nextLine()
	ln         = ln+1
	return line
end

for line in nextLine do
	if not (line == "" or line:find"^%-%-") then
		local action, objectPathString, ptr = line:match"^(%S+) +([%w_.]+) *()"
		if not action then
			errorLine(EDITS_PATH, ln, "Bad line format: %s", line)
		end

		if action == "move" then
			local targetPath = line:match("^[%w_.]+$", ptr)
			if not targetPath then
				errorLine(EDITS_PATH, ln, "Bad 'move' action line format: %s", line)
			end
			targetPath       = splitObjectPath(targetPath)
			local objectPath = splitObjectPath(objectPathString)
			local edit       = {path=EDITS_PATH, ln=ln, objectPathString=objectPathString, objectPath=objectPath, targetPath=targetPath}
			table.insert(editsMove, edit)

		elseif action == "delete" then
			if ptr <= #line then
				errorLine(EDITS_PATH, ln, "Bad 'delete' action line format: %s", line)
			end
			local objectPath = splitObjectPath(objectPathString)
			local edit       = {path=EDITS_PATH, ln=ln, objectPathString=objectPathString, objectPath=objectPath}
			table.insert(editsDelete, edit)

		elseif action == "settype" then
			local newType = line:sub(ptr)
			if newType == "" then
				errorLine(EDITS_PATH, ln, "Missing new type: %s", line)
			end
			local objectPath = splitObjectPath(objectPathString)
			local edit       = {path=EDITS_PATH, ln=ln, objectPathString=objectPathString, objectPath=objectPath, newType=newType}
			table.insert(editsSettype, edit)

		elseif action == "rename" then
			local newName = line:match("^[%w_]+$", ptr)
			if not newName then
				errorLine(EDITS_PATH, ln, "Bad 'rename' action line format: %s", line)
			end
			local edit = {path=EDITS_PATH, ln=ln, objectPathString=objectPathString, newName=newName}
			table.insert(editsRename, edit)

		elseif action == "add" then
			local declaration = line:sub(ptr)
			if declaration == "" then
				errorLine(EDITS_PATH, ln, "Bad 'add' action line format: %s", line)
			end

			local balance = updateBracketBalance(line, 0)
			local lnStart = ln

			while balance > 0 do
				line        = nextLine() or errorLine(EDITS_PATH, lnStart, "Unexpected EOF for 'add' action starting here. (Unbalanced brackets.)")
				declaration = declaration.."\n"..line
				balance     = updateBracketBalance(line, balance)
			end

			local edit = {path=EDITS_PATH, ln=lnStart, objectPathString=objectPathString, declaration=declaration}
			table.insert(editsAdd, edit)

		elseif action == "numbertype" then
			local matchKind = objectPathString

			if matchKind == "object" then
				local objectPathString, typeName = line:match("^(%S+) +(%S.*)$", ptr)
				if not typeName then
					errorLine(EDITS_PATH, ln, "Bad 'numbertype object' action line format: %s", line)
				end
				numberTypeByObject[objectPathString] = typeName

			elseif matchKind == "scope" then
				local scopePath, objectName, typeName = line:match("^(%S+) +(%S+) +(%S.*)$", ptr)
				if not typeName then
					errorLine(EDITS_PATH, ln, "Bad 'numbertype scope' action line format: %s", line)
				end
				numberTypeByScope[scopePath]             = numberTypeByScope[scopePath] or {}
				numberTypeByScope[scopePath][objectName] = typeName

			elseif matchKind == "module" then
				local moduleName, objectName, typeName = line:match("^(%S+) +(%S+) +(%S.*)$", ptr)
				if not typeName then
					errorLine(EDITS_PATH, ln, "Bad 'numbertype module' action line format: %s", line)
				end
				numberTypeByModule[moduleName]             = numberTypeByModule[moduleName] or {}
				numberTypeByModule[moduleName][objectName] = typeName

			elseif matchKind == "name" then
				local objectName, typeName = line:match("^(%S+) +(%S.*)$", ptr)
				if not typeName then
					errorLine(EDITS_PATH, ln, "Bad 'numbertype name' action line format: %s", line)
				end
				numberTypeByName[objectName] = typeName

			else
				errorLine(EDITS_PATH, ln, "Bad numbertype match kind '%s'.", matchKind)
			end

		elseif action == "joinargs" then
			local argName1 = objectPathString
			local argNames = {argName1}
			for argName in line:sub(ptr):gmatch"%S+" do
				table.insert(argNames, argName)
			end
			if not argNames[2] then
				errorLine(EDITS_PATH, ln, "At least 2 argument names are required.", line)
			end
			table.insert(argumentsToJoin, argNames)

		else
			errorLine(EDITS_PATH, ln, "Unknown action '%s'.", action)
		end
	end
end

table.sort(argumentsToJoin, function(a, b)
	return #a > #b
end)

-- Move/remove objects before doing anything else. (Note: We don't touch loveApiExtra.)
do
	for _, edit in ipairs(editsMove) do
		local object, objectType, objectParent = getObjectAtPath(edit.objectPath, loveApi, EMPTY_TABLE)
		local targetObject, targetObjectErr    = getObjectAtPath(edit.targetPath, loveApi, EMPTY_TABLE)

		if not object       then  errorLine(edit.path, edit.ln, objectType)       end
		if not targetObject then  errorLine(edit.path, edit.ln, targetObjectErr)  end

		repeat
			local sourceArray = requireObjectArray(objectParent, objectType)
			local targetArray = requireObjectArray(targetObject, objectType)

			local i = indexOf(sourceArray, object) or errorInternal()

			table.remove(sourceArray, i)
			table.insert(targetArray, object)

			table.sort(targetArray, function(a, b)
				return a.name < b.name
			end)

			object, objectType, objectParent = getObjectAtPath(edit.objectPath, loveApi, EMPTY_TABLE)
		until not object
	end

	for _, edit in ipairs(editsDelete) do
		local object, objectType, objectParent = getObjectAtPath(edit.objectPath, loveApi, EMPTY_TABLE)
		if not object then  errorLine(edit.path, edit.ln, objectType)  end

		repeat
			local sourceArray = requireObjectArray(objectParent, objectType)
			local i           = indexOf(sourceArray, object) or errorInternal()

			table.remove(sourceArray, i)

			object, objectType, objectParent = getObjectAtPath(edit.objectPath, loveApi, EMPTY_TABLE)
		until not object
	end

	for _, edit in ipairs(editsSettype) do
		local object, objectType, objectParent = getObjectAtPath(edit.objectPath, loveApi, EMPTY_TABLE)
		if not object then  errorLine(edit.path, edit.ln, objectType)  end

		local ignores = {}

		repeat
			if not (objectType:find"^argument%d+$" or objectType:find"^return%d+$") then
				errorLine(
					edit.path, edit.ln,
					"Can only change type of function arguments/returns. '%s' is '%s'.",
					edit.objectPathString, objectType
				)
			end

			object.typeOverride = edit.newType

			ignores[object]                  = true
			object, objectType, objectParent = getObjectAtPath(edit.objectPath, loveApi, ignores)
		until not object
	end
end

-- Prepare type name substitutions.
local typeLocations = {
	CanvasFormat        = "graphics",
	DisplayOrientation  = "window",
	DroppedFile         = "filesystem",
	GlyphData           = "font",
	HintingMode         = "font",
	IndexDataType       = "graphics",
	MipmapMode          = "graphics",
	PixelFormat         = "graphics",
	Rasterizer          = "font",
	TextureFormat       = "graphics",
	VertexAttributeStep = "graphics",
	VertexWinding       = "graphics",
	VideoStream         = "video",
}

for _, moduleInfo in ipairs(loveApi.modules) do
	for _, enumInfo in ipairs(moduleInfo.enums) do
		typeLocations[enumInfo.name] = moduleInfo.name
	end
	for _, typeInfo in ipairs(moduleInfo.types) do
		typeLocations[typeInfo.name] = moduleInfo.name
	end
end

-- Process everything.
local state = {
	file          = assert(io.open(DIR_HERE.."/love.gloa", "w")),
	indent        = "",
	scopeStack    = {"file"},
	scopeNames    = {""},
	currentModule = "love",

	_declarationPrefix = function(state)
		local scopeType = state.scopeStack[#state.scopeStack]
		return false
			or scopeType == "file"      and "export "
			or scopeType == "namespace" and "export "
			or scopeType == "struct"    and ""
			or scopeType == "enum"      and ""
			or errorInternal(scopeType)
	end,
	_scopeEnd = function(state)
		state.indent = state.indent:sub(2)
		state.file:write(state.indent, "}\n")
		table.remove(state.scopeStack)
		table.remove(state.scopeNames)
	end,

	getFinalName = function(state, name)
		local objectPathString = (state.currentModule.."."..state.scopeNames[#state.scopeNames].."."..name):gsub("^love%.", "")

		for _, edit in ipairs(editsRename) do
			if edit.objectPathString == objectPathString then  return edit.newName  end
		end

		return name
	end,
	getFinalType = function(state, typeName, objectName, pairedName)
		if typeName == "string" or typeName == "any" then
			return typeName

		elseif typeName == "boolean" then
			return "bool"

		elseif typeName == "light userdata" then
			return "LightUserdata"

		elseif typeName == "number" then
			local scopePath        = state:getScopePath()
			local objectPathString = (scopePath ~= "" and scopePath.."."..objectName or objectName)

			return nil
				or numberTypeByObject[objectPathString.."."..pairedName] -- Try sub-object before object directly.
				or numberTypeByObject[objectPathString]
				or numberTypeByScope[scopePath]            and numberTypeByScope[scopePath][pairedName]
				or numberTypeByModule[state.currentModule] and numberTypeByModule[state.currentModule][pairedName]
				or numberTypeByName[pairedName]
				-- or typeName -- DEBUG
				or errorLine(EDITS_PATH, 0, "Missing number type substitution for object: "..objectPathString.."."..pairedName)

		elseif typeName:find"^[A-Z]%w*$" then
			return (typeLocations[typeName] and "love."..typeLocations[typeName] ~= state.currentModule)
				and typeLocations[typeName].."."..typeName
				or  typeName

		else
			-- typeName may be "table" here.
			error("Unhandled type '"..typeName..'".')
		end
	end,

	write = function(state, ...)
		state.file:write(...)
	end,
	writef = function(state, s, ...)
		state.file:write(s:format(...))
	end,
	writeName = function(state, name, allowNameList)
		if name == "..." then
			state.file:write("...")

		elseif name:find"," then
			assert(allowNameList)
			local i = 0

			for name in name:gmatch"[^,]+" do
				name = trim(name)
				assert(name:find"^[%a_][%w_]*$", name)

				i = i+1
				if i > 1 then  state.file:write(",")  end

				state.file:write(name)
			end

			name = trim(name:match"[^,]+")

		else
			name = trim(name)
			assert(name:find"^[%a_][%w_]*$", name)

			if GLOA_KEYWORDS[name] then  state.file:write("\\")  end
			state.file:write(name)
		end

		return name
	end,
	-- writeValue_debug = {},
	writeValue = function(state, typeName, luaCodeValue, objectName)
		-- if not state.writeValue_debug[luaCodeValue] then
		-- 	state.writeValue_debug[luaCodeValue] = true
		-- 	print(typeName, luaCodeValue)
		-- end

		-- Number.
		if luaCodeValue:find"^%-?%d+%.?%d*$" then
			state.file:write(luaCodeValue)

		-- Simple value.
		elseif luaCodeValue == "true" or luaCodeValue == "false" or luaCodeValue == "nil" or luaCodeValue == "{}" then
			state.file:write(luaCodeValue)

		-- String or enum.
		elseif luaCodeValue:find"^[\"'].*[\"']$" then
			local s          = assert(loadstring("return"..luaCodeValue))()
			local sFormatted = F("%q", s)

			if luaCodeValue == "'false'" and objectName == "setRelative" then
				state.file:write("false") -- This was an error on the LÖVE wiki and thus in love_api.
			elseif typeName == "string" then
				state.file:write(sFormatted) -- Assume the Lua string formatting is compatible with Glóa.
			else
				state.file:write("cast(", typeName, ")", sFormatted) -- @Incomplete: Handle enums better. (Remember to handle renames!)
			end

		-- Some call.
		elseif luaCodeValue:find"^%a.*%(.*%)$" then
			if     typeName == "int"    then  state.file:write("0")
			elseif typeName == "float"  then  state.file:write("0")
			elseif typeName == "string" then  state.file:write('""')
			else errorInternal("Unhandled type '"..typeName..'".') end

			state.file:write("--[[", luaCodeValue, "]]")

		-- Specials.
		elseif VALUES_TO_OUTPUT_AS_IS[luaCodeValue] and VALUES_TO_OUTPUT_AS_IS[luaCodeValue][objectName] then
			state.file:write(luaCodeValue)

		else
			errorInternal(objectName.." "..luaCodeValue)
		end
	end,

	moduleStart = function(state, moduleName)
		-- @Incomplete: Write to several files? Maybe not necessary.
		state.file:write(state.indent, state:_declarationPrefix(), moduleName, " :: namespace {\n")
		table.insert(state.scopeStack, "namespace")
		table.insert(state.scopeNames, moduleName)
		state.indent        = state.indent.."\t"
		state.currentModule = "love."..moduleName
	end,
	moduleEnd = function(state)
		state.currentModule = "love"
		state:addEditedDeclarations(state.scopeNames[#state.scopeNames])
		state:_scopeEnd()
	end,

	structStart = function(state, structName)
		state.file:write(state.indent, state:_declarationPrefix(), structName, " :: !foreign struct {\n")
		table.insert(state.scopeStack, "struct")
		table.insert(state.scopeNames, structName)
		state.indent = state.indent.."\t"
	end,
	structEnd = function(state)
		state:addEditedDeclarations(state.scopeNames[#state.scopeNames])
		state:_scopeEnd()
	end,

	enumStart = function(state, enumName)
		state.file:write(state.indent, state:_declarationPrefix(), enumName, " :: enum {\n")
		table.insert(state.scopeStack, "enum")
		table.insert(state.scopeNames, enumName)
		state.indent = state.indent.."\t"
	end,
	enumEnd = function(state)
		state:addEditedDeclarations(state.scopeNames[#state.scopeNames])
		state:_scopeEnd()
	end,

	declarationConstantStart = function(state, declName, alignment)
		state.file:write(state.indent, state:_declarationPrefix(), declName, (" "):rep(alignment-#declName), " :: ")
	end,
	statementEnd = function(state)
		local scopeType = state.scopeStack[#state.scopeStack]
		if scopeType == "struct" or scopeType == "enum" then
			state.file:write(",")
		end
		state.file:write("\n")
	end,

	writeFirstFunctionArgument = function(state, variantInfo)
		if state.scopeStack[#state.scopeStack] ~= "struct" then  return  end

		state.file:write("self:", state.scopeNames[#state.scopeNames])
		if variantInfo.arguments and variantInfo.arguments[1] then
			state.file:write(", ")
		end
	end,

	addEditedDeclarations = function(state, name)
		local objectPathString = (state.currentModule..(name ~= "" and "."..name or "")):gsub("^love%.", "")

		for _, edit in ipairs(editsAdd) do
			if edit.objectPathString == objectPathString then
				local declaration = edit.declaration:gsub("\n", "\n"..state.indent)
				state:write(state.indent, declaration)
				state:statementEnd()
			end
		end
	end,

	getScopePath = function(state)
		local scopeType = state.scopeStack[#state.scopeStack]
		if scopeType == "struct" or scopeType == "enum" then
			return (state.currentModule:gsub("^love%.?", "").."."..state.scopeNames[#state.scopeNames])
		else
			return (state.currentModule:gsub("^love%.?", ""))
		end
	end,
}

state.file:write(MODULE_HEADER, "\n")

state.file:write[[
export Filename      :: string
export Variant       :: string|int|float|bool|table|Object -- Functions and Lua userdata are not supported. Tables have to be "simple".
export Color         :: []float
export Pointer       :: !foreign struct {}
export LightUserdata :: !foreign struct {} -- Actually a value (int) representing a pointer, but for the sake of type safety it's probably better to say it's its own type.
]]

do
	local EXTRA_OBJECT_NAMES = { -- Missing from love_api.
		"DROPPED_FILE", "DroppedFile",
		"GLYPH_DATA",   "GlyphData",
		"RASTERIZER",   "Rasterizer",
	}

	local names     = {}
	local alignment = 0

	for i = 1, #EXTRA_OBJECT_NAMES, 2 do
		alignment = math.max(alignment, #EXTRA_OBJECT_NAMES[i])
	end
	for i, typeInfo in ipairs(loveApiExtra.types) do
		names[i]  = typeInfo.name:gsub("([a-z])([A-Z])", "%1_%2"):upper()
		alignment = math.max(alignment, #names[i])
	end

	state.file:write("\nexport ObjectName :: enum {\n")
	for i = 1, #EXTRA_OBJECT_NAMES, 2 do
		state.file:write('\t', EXTRA_OBJECT_NAMES[i], (" "):rep(alignment-#EXTRA_OBJECT_NAMES[i]), ' :: "', EXTRA_OBJECT_NAMES[i+1], '",\n')
	end
	for i, typeInfo in ipairs(loveApiExtra.types) do
		state.file:write('\t', names[i], (" "):rep(alignment-#names[i]), ' :: "', typeInfo.name, '",\n')
	end
	state.file:write("}\n")
end

-- @Incomplete: Output something useful regarding callbacks. :CallbackInformation

processModule(state, loveApi, "")
state:addEditedDeclarations("")

assert(state.scopeStack[1] == "file")
assert(not state.scopeStack[2])

-- All font stuff is missing from love_api.
state.file:write[[
export font :: namespace {
	export HintingMode :: enum {
		NORMAL :: "normal",
		LIGHT  :: "light",
		MONO   :: "mono",
		NONE   :: "none",
	}

	export GlyphData :: !foreign struct { using Data }

	export Rasterizer :: !foreign struct {
		using Object,

		getAdvance :: (self:Rasterizer) -> (advance:int) !foreign method "getAdvance",
		getAscent  :: (self:Rasterizer) -> (ascent:int)  !foreign method "getAscent",
		getDescent :: (self:Rasterizer) -> (descent:int) !foreign method "getDescent",

		getHeight     :: (self:Rasterizer) -> (height:int)     !foreign method "getHeight",
		getLineHeight :: (self:Rasterizer) -> (lineHeight:int) !foreign method "getLineHeight", -- Is this actually a float?

		getGlyphData :: (self:Rasterizer, glyph:string) -> (glyphData:GlyphData) !foreign method "getGlyphData",
		getGlyphData :: (self:Rasterizer, glyph:int)    -> (glyphData:GlyphData) !foreign method "getGlyphData",

		getGlyphCount :: (self:Rasterizer) -> (count:int) !foreign method "getGlyphCount",

		hasGlyphs :: (self:Rasterizer, glyph,...:string) -> (hasGlyphs:bool) !foreign method "hasGlyphs",
		hasGlyphs :: (self:Rasterizer, glyph,...:int)    -> (hasGlyphs:bool) !foreign method "hasGlyphs",
	}

	-- Do these actually exist?
	-- export TrueTypeRasterizer :: !foreign struct { using Rasterizer }
	-- export BMFontRasterizer   :: !foreign struct { using Rasterizer }

	export newGlyphData :: (rasterizer:Rasterizer, glyph:int) -> (data:GlyphData) !foreign lua "love.font.newGlyphData"

	export newRasterizer         :: (filename:Filename|filesystem.FileData)    -> (rasterizer:Rasterizer) !foreign lua "love.font.newRasterizer"
	export newTrueTypeRasterizer :: (size:int, hintingMode:HintingMode)        -> (rasterizer:Rasterizer) !foreign lua "love.font.newTrueTypeRasterizer"
	export newBMFontRasterizer   :: (imageData:image.ImageData, glyphs:string) -> (rasterizer:Rasterizer) !foreign lua "love.font.newBMFontRasterizer"
}
]]

-- This is just missing from all documentation even though the default love.run() clearly uses it.
state.file:write[[
export arg :: namespace {
	export parseGameArguments :: (rawArguments:[]string) -> (arguments:[]string) !foreign lua "love.arg.parseGameArguments"
}
]]

-- state.file:write("local main :: () {}\n") -- DEBUG
state.file:close()

print()
print("Stats:")
printf("- modules:   %d", countModules)
printf("- enums:     %d", countEnums)
printf("- types:     %d", countTypes)
printf("- functions: %d (variants=%d)", countFunctions, countFunctionVariants)
printf("- deleted:   %d", #editsDelete)
printf("- added:     %d", #editsAdd)
printf("- renamed:   %d", #editsRename)
print()


