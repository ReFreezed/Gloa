--[[============================================================
--=
--=  Glóa compiler build script
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
local pathPlantuml       = ""
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
	elseif arg == "--plantuml" then
		pathPlantuml       = (args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")):gsub("\\", "/")
		pathGraphviz       = (args[i+2] or error("[GloaBuildArgs] Expected 2 values after "..arg..".")):gsub("\\", "/")
		i                  = i+3
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

pp.metaEnvironment.DEBUG                = debugMode
pp.metaEnvironment.DEBUGGER             = debugMode and debugger

pp.metaEnvironment.GLOA_DIR             = debugMode and dirGloa or ""
pp.metaEnvironment.PLANTUML_PATH        = pathPlantuml
pp.metaEnvironment.GRAPHVIZ_PATH        = pathGraphviz

pp.metaEnvironment.RUNTIME_ERROR_PREFIX = debugMode and runtimeErrorPrefix or ""

local luaSegments = {}
function pp.metaEnvironment.preprocessorOutputAtTopOfFile(lua)
	table.insert(luaSegments, lua)
end

pp.processFile{
	pathIn          = DIR_HERE.."/main.lua2p",
	pathOut         = pathGloaOut,
	pathMeta        = pathGloaOut:gsub("%.%w+", ".meta%0"),

	debug           = false,
	backtickStrings = true,
	canOutputNil    = false,

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
