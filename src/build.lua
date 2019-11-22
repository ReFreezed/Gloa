--
-- Glóa build script
--

local buildStartTime = os.clock()

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

print("Building Glóa...")

local DIR_HERE = debug.getinfo(1, "S").source:match"@?(.+)":gsub("/?[^/]+$", ""):gsub("^$", ".")

local pathPp = DIR_HERE.."/../lib/preprocess.lua" -- @Incomplete: Include LuaPreprocess in this repo.

-- Load config file, if one exists.
local file = io.open(DIR_HERE.."/../gloa.config", "r")

if file then
	local ln = 0

	for line in file:lines() do
		ln   = ln+1
		line = line:gsub("^%s+", ""):gsub("%s+$", "")

		if not (line == "" or line:find"^#") then
			local k, v = line:match"^([%a_][%w_]*)%s*=%s*(.*)$"

			if not k then
				error("gloa.config:"..ln..": Bad line format.")

			elseif k == "luaPreprocessPath" then
				pathPp = v

			else
				error("gloa.config:"..ln..": Unknown key '"..k.."'.")
			end
		end
	end
end

-- Build Glóa.
local pp = assert(dofile(pathPp))

pp.processFile{
	pathIn          = DIR_HERE.."/main.lua2p",
	pathOut         = DIR_HERE.."/../gloa.lua",
	pathMeta        = DIR_HERE.."/../gloa.meta.lua",

	debug           = false,
	addLineNumbers  = false,

	backtickStrings = true,

	onInsert = function(path)
		print("Inserting "..path)
		return assert(pp.getFileContents(DIR_HERE.."/"..path))
	end,

	onError = function(err)
		-- An error message should already have been printed.
		os.exit(1)
	end,
}

-- All done!
print(("Build completed in %.3f seconds."):format(os.clock()-buildStartTime))
