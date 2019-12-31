--
-- Glóa build script
--

local buildStartTime = os.clock()

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")
collectgarbage("stop") -- Slight speed boost.

local DIR_HERE = debug.getinfo(1, "S").source:match"@?(.+)":gsub("[/\\]?[^/\\]+$", ""):gsub("^$", ".")

-- Read build arguments.
local args        = {...}
local pathGloaOut = DIR_HERE.."/../gloa.lua"
local pathPp      = DIR_HERE.."/../lib/preprocess.lua" -- @Incomplete: Include LuaPreprocess in this repo.
local silent      = false
local debugMode   = false
local debugger    = false
local i           = 1

while args[i] do
	local arg = args[i]

	if     arg == "--ouput" then
		pathGloaOut = args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")
		i           = i+2

	elseif arg == "--pp" then
		pathPp      = args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")
		i           = i+2

	elseif arg == "--silent" then
		silent      = true
		i           = i+1

	elseif arg == "--debug" then
		debugMode   = true
		i           = i+1

	elseif arg == "--debugger" then
		debugger    = true
		i           = i+1

	else
		error("[GloaBuildArgs] Unknown argument: "..arg)
	end
end

-- Build Glóa.
if not silent then  print("Building Glóa...")  end

local chunk, err = loadfile(pathPp)
if not chunk then  error("Could not load LuaPreprocess from '"..pathPp.."'. ("..err..")")  end

local pp                    = chunk()
pp.metaEnvironment.DEBUG    = debugMode
pp.metaEnvironment.DEBUGGER = debugMode and debugger

pp.metaEnvironment.F = string.format

local luaSegments = {}
function pp.metaEnvironment.preprocessorOutputAtTopOfFile(lua)
	table.insert(luaSegments, lua)
end

function pp.metaEnvironment.trimTemplate(lua)
	return (lua:gsub("%s+", " "):gsub("^ ", ""):gsub(" $", ""))
end
function pp.metaEnvironment.templateToLua(template, values)
	return (template:gsub("$(%w+)", values))
end

function pp.metaEnvironment.outputCommaSeparatedValues(...)
	for i = 1, select("#", ...) do
		if i > 1 then  pp.outputLua(",")  end
		pp.outputValue((select(i, ...)))
	end
end

-- Convert an array of values to a set (where the table keys are the values and the table values are 'true').
function pp.metaEnvironment.Set(values)
	local set = {}
	for _, v in ipairs(values) do
		set[v] = true
	end
	return set
end

-- Output an assert() in DEBUG mode.
function pp.metaEnvironment.ASSERT(valueCode)
	if DEBUG then  pp.outputLua("assert(",valueCode,")")  end
end

pp.processFile{
	pathIn          = DIR_HERE.."/main.lua2p",
	pathOut         = pathGloaOut,
	pathMeta        = pathGloaOut:gsub("%.%w+", ".meta%0"),

	debug           = false,
	backtickStrings = true,

	onInsert = function(path)
		if not silent then  print("Inserting "..path)  end

		return assert(pp.getFileContents(DIR_HERE.."/"..path))
	end,

	onAfterMeta = function(lua)
		table.insert(luaSegments, lua)
		return table.concat(luaSegments, "\n")
	end,

	onError = function(err)
		-- An error message should already have been printed.
		os.exit(1)
	end,
}

-- All done!
if not silent then
	print(("Build completed in %.3f seconds."):format(os.clock()-buildStartTime))
end
