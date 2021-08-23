#!/bin/sh
_=[[
exec lua "$0" "$@"
]]
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

	To build the compiler, run this from the repository root folder:
		lua src/build.lua [options]

	Options:
		--ouput <path>  ; Where to output the compiler. Default is "gloa.lua" in the repository root folder.
		--silent        ; Disable printing during build.
		--debug         ; Enable some compiler debugging functionality.
		--debugger      ; Enable the built-in debugger. (Requires --debug)
		--gloadir <dir> ; Where the compiler will be able to find the modules folder etc. Default is the same folder the compiler is in.

--============================================================]]

local STATIC_PROFILER            = 1==0
local REPORT_TABLE_CONSTRUCTIONS = 1==0

local STATIC_PROFILER_NAMES_TO_IGNORE = {
	runCompiler     = true,
	eatNextTok      = true,
	peekNextTok     = true,
	inferNode       = true,
	indexOf         = true,
	iprev           = true,
	removeUnordered = true,
	areArraysEqual  = true,
}

local COMPILER_HEADER =
[====[
#!/bin/sh
_=[[
exec lua "$0" "$@"
]] and nil
--[[============================================================
--=
--=  Glóa compiler
--=  by Marcus 'ReFreezed' Thunström
--=
--=  Note: The compiler (this file) has been processed.
--=  The original source can be found at github.com/ReFreezed/Gloa
--=
--=  Language points:
--=  - Strong static type system.
--=  - Compile-time code execution.
--=  - No forward declarations.
--=
--============================================================]]

]====]

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
		dirGloa     = (args[i+1] or error("[GloaBuildArgs] Expected value after "..arg..".")):gsub("\\", "/")
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
pp.metaEnvironment.STATIC_PROFILER      = debugMode and STATIC_PROFILER

pp.metaEnvironment.GLOA_DIR             = dirGloa
pp.metaEnvironment.PLANTUML_PATH        = pathPlantuml
pp.metaEnvironment.GRAPHVIZ_PATH        = pathGraphviz

pp.metaEnvironment.RUNTIME_ERROR_PREFIX = debugMode and runtimeErrorPrefix or ""

local parser                 = require"lib.dumbParser"
pp.metaEnvironment.luaParser = parser

local luaSegments = {}
function pp.metaEnvironment.preprocessorOutputAtTopOfFile(lua)
	table.insert(luaSegments, lua)
end

local postInserts = {}
function pp.metaEnvironment.preprocessorOutputAtDuringPost(label, lua)
	postInserts[label] = lua
end

local compilerLineNumbers = {--[[ { sourcePath=path, sourceLine=lineNumber, outputLine=lineNumber }, ... ]]}
function pp.metaEnvironment.recordLineNumber(path, ln)
	table.insert(compilerLineNumbers, {
		sourcePath  = path,
		sourceLine  = ln,
		outputLine  = pp.getCurrentLineNumberInOutput(),
		-- metaLine = debug.getinfo(2, "l").currentline,
	})
end
function pp.metaEnvironment.getLineNumbers() -- Must only be called once!
	local headerLineCount = select(2, COMPILER_HEADER:gsub("\n", "%0")) + 1
	for _, lnInfo in ipairs(compilerLineNumbers) do
		lnInfo.outputLine = headerLineCount + #luaSegments + lnInfo.outputLine -- Assume one extra line per luaSegment.
	end
	return compilerLineNumbers
end

local function profilerMaybeModifyFunction(func, name)
	if not func.body.statements[1]              then  return  end
	if func.body.statements[1].type == "return" then  return  end
	if STATIC_PROFILER_NAMES_TO_IGNORE[name]    then  return  end
	if name:find"^_"                            then  return  end
	if name:find"[Pp]rofiler"                   then  return  end
	if name:find"[Tt]imer"                      then  return  end
	if name:find"[Pp]rint"                      then  return  end
	if name:find"[Ee]rror"                      then  return  end
	if name:find"[Aa]ssert"                     then  return  end

	do
		local blockToInsert                      = parser.newNodeFast("block")
		blockToInsert.statements[1]              = parser.newNodeFast("call")
		blockToInsert.statements[1].callee       = parser.newNodeFast("identifier", "staticProfilerPush")
		blockToInsert.statements[1].arguments[1] = parser.newNodeFast("literal", name)
		table.insert(func.body.statements, 1, blockToInsert)
	end

	if func.body.statements[#func.body.statements].type ~= "return" then
		table.insert(func.body.statements, parser.newNodeFast("return"))
	end

	parser.traverseTree(func.body, function(node, parent, container, k)
		if node.type == "function" then  return "ignorechildren"  end
		if node.type ~= "return"   then  return nil               end

		local returnNode = node

		local replacementBlock                      = parser.newNodeFast("block")
		replacementBlock.statements[1]              = parser.newNodeFast("call")
		replacementBlock.statements[1].callee       = parser.newNodeFast("identifier", "staticProfilerPop")
		replacementBlock.statements[1].arguments[1] = parser.newNodeFast("literal", name)
		replacementBlock.statements[2]              = returnNode

		container[k] = replacementBlock
		return "ignorechildren"
	end)
end

local function maybeAddProfilerStuff(lua)
	if STATIC_PROFILER then
		local time = os.clock()
		local ast  = assert(parser.parse(lua, "@lua"))
		print("Profiler: parse", os.clock()-time)

		local time = os.clock()
		parser.traverseTree(ast, function(block, parent, container, k)
			if block.type ~= "block" then  return  end

			for _, statement in ipairs(block.statements) do
				if (statement.type == "declaration" or statement.type == "assignment") and #statement.values == 1 and statement.values[1].type == "function" then
					local func = statement.values[1]
					local name

					if statement.type == "declaration" then
						name = statement.names[1].name
					else
						local target = statement.targets[1]
						name
							=  target.type == "identifier" and target.name
							or target.type == "lookup"     and target.member.type == "literal"    and type(target.member.value) == "string"  and target.member.value
							-- or target.type == "lookup"     and target.object.type == "identifier" and target.member.type        == "literal" and target.object.name..tostring(target.member.value)
							or tostring(func):gsub("^table: (%x+)", "func%1")
							or nil
					end

					if name then  profilerMaybeModifyFunction(func, name)  end
				end
			end
		end)
		print("Profiler: modif", os.clock()-time)

		local time = os.clock()
		lua        = assert(parser.toLua(ast, true))
		print("Profiler: toLua", os.clock()-time)

	elseif REPORT_TABLE_CONSTRUCTIONS then
		--
		-- Report table constructions.
		--
		local file = assert(io.open("temp/gloa.raw.lua", "wb"))
		file:write(lua)
		file:close()

		local time = os.clock()
		local ast  = assert(parser.parse(lua, "@lua"))
		print("Profiler: parse", os.clock()-time)

		local time = os.clock()

		parser.traverseTree(ast, function(tableNode, parent, container, k)
			if tableNode.type ~= "table" then  return  end

			local call        = parser.newNodeFast("call")
			call.callee       = parser.newNodeFast("identifier", "TABLE")
			call.arguments[1] = parser.newNodeFast("literal", tableNode.line)
			call.arguments[2] = tableNode
			container[k]      = call
		end)

		for i, statement in ipairs(assert(parser.parse[[
			local tableConstructions = {}
			local function TABLE(ln, t)
				tableConstructions[ln] = (tableConstructions[ln] or 0) + 1
				return t
			end
		]]).statements) do
			table.insert(ast.statements, i, statement)
		end

		parser.traverseTreeReverse(ast, function(node, parent, container, k)
			-- Find function _G.exit()
			if
				node.type                        == "assignment"
				and node.targets[1].type         == "lookup"
				and node.targets[1].object.type  == "identifier"
				and node.targets[1].object.name  == "_G"
				and node.targets[1].member.type  == "literal"
				and node.targets[1].member.value == "exit"
				and node.values[1].type          == "function"
			then
				local funcBodyStatements = node.values[1].body.statements

				for i, statement in ipairs(assert(parser.parse[[
					local lines = {}
					for line in io.lines"temp/gloa.raw.lua" do
						table.insert(lines, line)
					end
					local total = 0
					for _, ln in ipairs(sort(getKeys(tableConstructions), function(a, b)
						if tableConstructions[a] ~= tableConstructions[b] then
							return tableConstructions[a] > tableConstructions[b]
						end
						return a < b
					end)) do
						total = total + tableConstructions[ln]
						if tableConstructions[ln] >= 100 then
							printf("temp/gloa.raw.lua:%d: %d: %s", ln, tableConstructions[ln], lines[ln]:match"^%s*(.-)%s*$")
						end
					end
					printf("Total: %d", total)
				]]).statements) do
					table.insert(funcBodyStatements, i, statement)
				end

				return "stop"
			end
		end)

		print("Profiler: modif", os.clock()-time)

		local time = os.clock()
		lua        = assert(parser.toLua(ast, true))
		print("Profiler: toLua", os.clock()-time)
	end

	return lua
end

local pathMeta = pathGloaOut:gsub("%.%w+$", ".meta%0")

local lua = assert(pp.processFile{
	pathIn          = DIR_HERE.."/main.lua2p",
	pathOut         = pathGloaOut,
	pathMeta        = pathMeta,

	debug           = debugMode and 1==0,
	addLineNumbers  = debugMode and 1==1,
	backtickStrings = true,
	canOutputNil    = false,

	onInsert = function(path)
		if not silent then  print("Inserting "..path)  end

		return assert(pp.getFileContents(DIR_HERE.."/../"..path))
	end,

	onAfterMeta = function(lua)
		table.insert(luaSegments, lua)
		lua = table.concat(luaSegments, "\n")

		lua = lua:gsub("%-%-%[%[INSERT:(%w+)%]%]", function(label)
			return postInserts[label] or error(label)
		end)

		if debugMode then
			lua = maybeAddProfilerStuff(lua)
		else
			lua = lua:gsub("[ \t]+\n", "\n"):gsub("\n\n\n+", "\n\n")
		end

		return COMPILER_HEADER .. lua
	end,

	onError = function(err)
		-- An error message should already have been printed.
		os.exit(1)
	end,
})

-- All done!
----------------------------------------------------------------
if not silent then
	print(("Build completed in %.3f seconds."):format(os.clock()-buildStartTime))
end
