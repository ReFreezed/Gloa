--[[============================================================
--=
--=  Glóa build script
--=
--=-------------------------------------------------------------
--=
--=  Glóa - a language that compiles into Lua
--=  by Marcus 'ReFreezed' Thunström
--=
--==============================================================

	To build the compiler, run this from the project root folder:

		lua src/build.lua [ <options> ]

	Options:

		--ouput <path>  ; Where to output the compiler. Default is "gloa.lua" in the project root folder.
		--silent        ; Disable printing during build.
		--debug         ; Enable some compiler debugging functionality.
		--debugger      ; Enable the built-in debugger. (Requires --debug)
		--gloadir <dir> ; Where the compiler will be able to find the modules folder etc. Default is the same folder the compiler is in. (Requires --debug)

--============================================================]]

local buildStartTime = os.clock()

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")
collectgarbage("stop") -- Slight speed boost.

local DIR_HERE = debug.getinfo(1, "S").source:match"^@(.+)":gsub("\\", "/"):gsub("/?[^/]+$", ""):gsub("^$", ".")

-- Read build options.
----------------------------------------------------------------
local args               = {...}

local pathGloaOut        = DIR_HERE.."/../gloa.lua"
local silent             = false
local debugMode          = false
local debugger           = false
local dirGloa            = "" -- Empty means automatic value at runtime.

local pathPp             = DIR_HERE.."/../lib/preprocess.lua"
local runtimeErrorPrefix = ""

local i                  = 1

while args[i] do
	local arg = args[i]

	if     arg == "--ouput" then
		pathGloaOut = (args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")):gsub("\\", "/")
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
	elseif arg == "--gloadir" then
		dirGloa     = args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")
		i           = i+2

	-- Secret options:
	elseif arg == "--pp" then
		pathPp             = (args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")):gsub("\\", "/")
		i                  = i+2
	elseif arg == "--runtimeerrorprefix" then
		runtimeErrorPrefix = args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")
		i                  = i+2

	else
		error("[GloaBuildArgs] Unknown option: "..arg)
	end
end

-- Build Glóa.
----------------------------------------------------------------
if not silent then  print("Building Glóa...")  end

local chunk, err = loadfile(pathPp)
if not chunk then  error("Could not load LuaPreprocess from '"..pathPp.."'. ("..err..")")  end

local pp = chunk()

pp.metaEnvironment.DEBUG    = debugMode
pp.metaEnvironment.DEBUGGER = debugMode and debugger
pp.metaEnvironment.GLOA_DIR = debugMode and dirGloa or ""

pp.metaEnvironment.RUNTIME_ERROR_PREFIX = debugMode and runtimeErrorPrefix or ""

pp.metaEnvironment.F = string.format

local luaSegments = {}
function pp.metaEnvironment.preprocessorOutputAtTopOfFile(lua)
	table.insert(luaSegments, lua)
end

function pp.metaEnvironment.trimTemplate(lua)
	return (lua:gsub("%s+", " "):gsub("^ ", ""):gsub(" $", ""))
end
function pp.metaEnvironment.templateToLua(template, values)
	return (template:gsub("$(%a%w*)", values))
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
	if debugMode then  pp.outputLua("assert(",valueCode,")")  end
end

function pp.metaEnvironment.indexOf(t, v)
	for i = 1, #t do
		if t[i] == v then  return i  end
	end
	return nil
end
function pp.metaEnvironment.itemWith1(t, k, v)
	for i = 1, #t do
		if t[i][k] == v then  return t[i], i  end
	end
	return nil, nil
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
----------------------------------------------------------------
if not silent then
	print(("Build completed in %.3f seconds."):format(os.clock()-buildStartTime))
end
