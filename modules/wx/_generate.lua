#!/bin/sh
_=[[
exec lua "$0" "$@"
]]
--[[============================================================
--=
--=  wxLua/wxWidget bindings generator for Glóa
--=
--============================================================]]

local DIR_HERE       = debug.getinfo(1, "S").source:match"^@(.+)":gsub("\\", "/"):gsub("/?[^/]+$", ""):gsub("^$", ".")
local INTERFACE_PATH = DIR_HERE.."/_wx.i"
local INTERFACE_DATA = io.open(INTERFACE_PATH):read"*a"

local function H--[[header]](s)
	local tabs = s:match"^\t+" or s:match"\n(\t+)"
	if not tabs then  return s  end

	local pat = "\t"..("\t?"):rep(#tabs-1)
	s         = s:gsub("^"..pat, ""):gsub("\n"..pat, "\n")
	return s
end

local MODULE_COMMON_HEADER = H[=[
	--[[============================================================
	--=
	--=  wxLua/wxWidget bindings for Glóa
	--=  Interface source: {interfaceFilename}
	--=
	--=  Tested with:
	--=  - wxLua 2.8.7.0 / wxWidgets 2.8.8
	--=
	--=  Note: Most bindings have not been tested yet!
	--=
	--============================================================]]
]=]

local MODULE_SETTINGS = {
	common = {header=H[[
		!preload [=[
			local _print = print

			_G.wx = require"wx" -- Adds globals: wx, wxlua, wxaui, wxstc, bit.

			-- wxLua loves making life miserable, so let's undo some damage it has made...
			_G.print = _print
		]=]

		export time_t       :: int
		export wxEnum       :: int
		export wxEventType  :: int
		export wxFileOffset :: int
		export wxWindowID   :: int

		export wxLuaUserdata :: !foreign struct {
			delete :: (obj:wxLuaUserdata) !foreign method "delete", -- wxLua adds this method to all class userdata.
		}
		export wxNULL: wxLuaUserdata : !foreign lua "wx.NULL"

		export wxEmptyString: wxString: !foreign lua "wx.wxEmptyString"
	]]},
	wxadv_adv = {header=H[[]]},
	wxadv_grid = {header=H[[
		export wxDefaultDateTimeFormat :: "%c"
	]]},
	wxaui_aui = {header=H[[]]},
	wxbase_base = {header=H[[]]},
	wxbase_config = {header=H[[]]},
	wxbase_data = {header=H[[
		export wxDEFAULT_DELIMITERS :: " \t\r\n" -- Is this available in foreign wxLua?
	]]},
	wxbase_datetime = {header=H[[]]},
	wxbase_file = {header=H[[
		export wxMailcapStyle :: wxEnum
		export wxMAILCAP_STANDARD: wxMailcapStyle : 1 -- Are these available in foreign wxLua?
		export wxMAILCAP_NETSCAPE: wxMailcapStyle : 2
		export wxMAILCAP_KDE:      wxMailcapStyle : 4
		export wxMAILCAP_GNOME:    wxMailcapStyle : 8
		export wxMAILCAP_ALL:      wxMailcapStyle : 15
	]]},
	wxcore_appframe = {header=H[[]]},
	wxcore_clipdrag = {header=H[[]]},
	wxcore_controls = {header=H[[]]},
	wxcore_core = {header=H[[]]},
	wxcore_defsutils = {header=H[[]]},
	wxcore_dialogs = {header=H[[
		export wxCHOICE_WIDTH  :: 150
		export wxCHOICE_HEIGHT :: 200
	]]},
	wxcore_event = {header=H[[]]},
	wxcore_gdi = {header=H[[
		export wxBUFFER_VIRTUAL_AREA       :: 0x01 -- Are these available in foreign wxLua?
		export wxBUFFER_CLIENT_AREA        :: 0x02
		export wxBUFFER_USES_SHARED_BUFFER :: 0x04
	]]},
	wxcore_geometry = {header=H[[]]},
	wxcore_help = {header=H[[]]},
	wxcore_image = {header=H[[]]},
	wxcore_mdi = {header=H[[]]},
	wxcore_menutool = {header=H[[]]},
	wxcore_picker = {header=H[[]]},
	wxcore_print = {header=H[[]]},
	wxcore_sizer = {header=H[[
		export wxDefaultSpan: wxGBSpan : !foreign lua "wx.wxDefaultSpan" -- Does this exist in wxLua?
	]]},
	wxcore_windows = {header=H[[
		export wxNOT_FOUND :: -1 -- Is this available in foreign wxLua?
	]]},
	wxgl_gl = {header=H[[]]},
	wxhtml_html = {header=H[[
		export wxPAGE_ODD:  wxEnum : !foreign lua "wx.wxPAGE_ODD" -- Does this exist in wxLua?
		export wxPAGE_EVEN: wxEnum : !foreign lua "wx.wxPAGE_EVEN"
		export wxPAGE_ALL:  wxEnum : !foreign lua "wx.wxPAGE_ALL"

		export wxHTML_CLR_FOREGROUND:             int : 0x01 -- Are these available in foreign wxLua?
		export wxHTML_CLR_BACKGROUND:             int : 0x02
		export wxHTML_CLR_TRANSPARENT_BACKGROUND: int : 0x04
	]]},
	wxlua = {header=H[[]]},
	wxluasocket = {header=H[[]]},
	wxmedia_media = {header=H[[]]},
	wxnet_net = {header=H[[]]},
	wxstc_stc = {header=H[[]]},
	wxxml_xml = {header=H[[]]},
	wxxrc_xrc = {header=H[[]]},
}

local DEFINES = { -- Preprocessor symbols.
	["%gtk"]   = false,
	["%mac"]   = false,
	["%mgl"]   = false,
	["%motif"] = false,
	["%msw"]   = true,
	["%os2"]   = false,
	["%win"]   = true,
	["__X__"]  = false, -- X11

	["%wxchkver_2_4"]   = true,
	["%wxchkver_2_6"]   = true,
	["%wxchkver_2_6_4"] = true,
	["%wxchkver_2_8"]   = true,
	["%wxchkver_2_8_0"] = true,
	["%wxchkver_2_8_1"] = true,
	["%wxchkver_2_8_4"] = true,
	["%wxchkver_2_8_5"] = true,
	["%wxchkver_2_8_6"] = true,
	["%wxchkver_2_8_8"] = true,

	["%wxcompat_2_4"] = false,
	["%wxcompat_2_6"] = false,

	["%wxHAS_NATIVE_RENDERER"] = false, -- Useless flag.

	["wxUSE_STL"] = false, -- Enabling this makes us not compile.
	-- wx*        = true,  -- Anything else starting with 'wx' is hardcoded to be true.
}

local CLASSES_TO_HAVE_NULL = {
	-- @Robustness: Figure these out automatically.
	wxArrayString         = true,
	wxClassInfo           = true,
	wxClipboard           = true,
	wxColourData          = true,
	wxConfigBase          = true,
	wxDC                  = true,
	wxEvtHandler          = true,
	wxFont                = true,
	wxFrame               = true,
	wxGBSizerItem         = true,
	wxGLContext           = true,
	wxGridCellAttr        = true,
	wxHeaderButtonParams  = true,
	wxHelpController      = true,
	wxLuaObject           = true,
	wxMenu                = true,
	wxMenuItem            = true,
	wxObject              = true,
	wxPageSetupDialogData = true,
	wxPalette             = true,
	wxPoint               = true,
	wxPrintData           = true,
	wxPrintDialogData     = true,
	wxProcess             = true,
	wxRect                = true,
	wxSplitterWindow      = true,
	wxString              = true,
	wxTreeItemData        = true,
	wxView                = true,
	wxWindow              = true,
	wxWizard              = true,
	wxWizardPage          = true,
}

local GLOA_KEYWORDS = {
	["and"]       = true,
	["break"]     = true,
	["case"]      = true,
	["cast"]      = true,
	["continue"]  = true,
	["defer"]     = true,
	["do"]        = true,
	["else"]      = true,
	["elseif"]    = true,
	["enum"]      = true,
	["export"]    = true,
	["external"]  = true,
	["for"]       = true,
	["if"]        = true,
	["in"]        = true,
	["inline"]    = true,
	["local"]     = true,
	["namespace"] = true,
	["not"]       = true,
	["or"]        = true,
	["read_only"] = true,
	["return"]    = true,
	["static"]    = true,
	["struct"]    = true,
	["type_info"] = true,
	["type_of"]   = true,
	["using"]     = true,
	["while"]     = true,
	-- Reserved words:
	["goto"]      = true,
	["until"]     = true,
	-- Literals:
	["false"]     = true,
	["nil"]       = true,
	["NULL"]      = true,
	["true"]      = true,
	-- Built-in types:
	["any"]       = true,
	["bool"]      = true,
	["float"]     = true,
	["int"]       = true,
	["string"]    = true,
	["table"]     = true,
	["type"]      = true,
	["void"]      = true,
	["none"]      = true,
}

local EMPTY_TABLE         = {}

local filenames           = {"common"}
local requirements        = {--[[ filename1={requirement1,...}, ... ]]}

local currentFilename     = nil
local currentLuaTableName = nil

local globalTypedefs      = {}
local globalValues        = {}
local globalEnums         = {}
local globalClasses       = {}
local globalFunctions     = {}

local innerTypedefs       = {}
local innerEnums          = {}
local innerClasses        = {}

--==============================================================
--==============================================================
--==============================================================

local function error(message)
	io.stderr:write("\nError @ ", INTERFACE_PATH, ":", debug.getinfo(2, "l").currentline, ": ", message, "\n", debug.traceback("", 2), "\n")
	os.exit(1)
end
local function errorOnLine(ln, message)
	io.stderr:write("\nError @ ", INTERFACE_PATH, ":", ln, ": ", message, "\n", debug.traceback("", 2), "\n")
	os.exit(1)
end
local function errorAt(ln, line, ptr, message)
	local pre = line:sub(1, ptr-1)
	local suf = line:sub(ptr)
	io.stderr:write("\nError @ ", INTERFACE_PATH, ":", ln, ": ", message, ":\n\n> ", pre, "[HERE]>>>", suf, "\n", debug.traceback("", 2), "\n")
	os.exit(1)
end

local function printf(s, ...)
	print(s:format(...))
end

local _getNextLine = INTERFACE_DATA:gmatch"([^\n]*)\n?"
local ln           = 0
local nextLine     = nil

local function defNameToBool(defName, condition, ptr)
	if DEFINES[defName] ~= nil then  return DEFINES[defName]  end
	if defName:find"^wx"       then  return true              end
	errorAt(ln, condition, ptr, "No define for '"..defName.."'")
end

local function isConditionTrue(condition, ptr)
	if condition:find("^%(+", ptr) then
		ptr = ptr+1
		return isConditionTrue(condition, ptr)
	end

	local invert = false
	if condition:find("^!", ptr) then
		invert = true
		ptr    = ptr+1
	end

	local ptrNameStart = ptr

	local i1, i2, defName = condition:find("^(%%?[%w_]+) *", ptr)
	if not i1 then  errorAt(ln, condition, ptr, "Expected a name")  end
	ptr = i2+1

	if defName == "defined" then
		local i1, i2
		i1, i2, defName = condition:find("^(%b()) *", ptr)
		ptr     = i2+1
		defName = defName:sub(2, -2)
	end

	local result = defNameToBool(defName, condition, ptrNameStart)
	if invert then  result = not result  end

	while true do
		if ptr > #condition then
			return result, ptr

		elseif condition:find("^&", ptr) then
			local i1, i2       = condition:find("^&&? *", ptr)
			ptr                = i2+1
			local rhs;rhs, ptr = isConditionTrue(condition, ptr)
			result             = result and rhs

		elseif condition:find("^|", ptr) then
			local i1, i2       = condition:find("^||? *", ptr)
			ptr                = i2+1
			local rhs;rhs, ptr = isConditionTrue(condition, ptr)
			result             = result or rhs

		elseif condition:find("^%)", ptr) then
			local i1, i2 = condition:find("^%) *", ptr)
			ptr          = i2+1
			return result, ptr

		else
			errorAt(ln, condition, ptr, "Expected '&' or '|'")
		end
	end
end

local function getNextLine()
	local line = nextLine
	if line then
		nextLine = nil
		return line
	end

	line = _getNextLine()
	if not line then  return nil  end

	ln   = ln+1
	line = line:gsub("^%s+", ""):gsub("%s+$", "")

	if line == "" then  return getNextLine()  end

	line = line
		:gsub("^%%not_overload +", "")
		:gsub("%%gc +",            "")
		:gsub("%%ungc +",          "")
		:gsub("%%ungc_this +",     "")

	if
		line:find"^!"
		or line:find"^wxUSE_"
		or line:find"^%%wx"
		or line:find"^%%win" or line:find"^%%msw" or line:find"^%%gtk" or line:find"^%%mac"
	then
		local condition = line:match"^%S+"
		-- print("???", condition, (isConditionTrue(condition, 1)))
		if isConditionTrue(condition, 1) then
			line = line:gsub("^%S+ +", "")
		else
			return getNextLine()
		end
	end

	if
		line:find"^// *%%override " and not
		line:find"^// *%%override +%-"
	then
		line = line:gsub("^// *", "")
	end

	-- print(ln, line)
	return line
end

local function removeInlineComments(line)
	line = line:gsub("//.*", ""):gsub("/%*.-%*/", ""):gsub("%s+$", "")
	return line
end

local function handleComment(line)
	-- /* ... */
	if line:find"^/%*" then
		local lnStart = ln
		repeat
			line = getNextLine() or errorOnLine(lnStart, "Missing */")
		until line == "*/"
		return true
	-- // ...
	elseif line:find"^//" then
		return true
	else
		return false
	end
end

-- typeName, pointer, isSpecialLuaType, ptr = parseType( s, ptr )
local function parseType(s, ptr)
	do
		-- Special types found in %override comments. :OverrideHacks

		if s:find("^Lua ", ptr) then
			local i1, i2 = s:find("^Lua int table%f[^%w_] *",                     ptr) ; if i1 then  ptr = i2+1 ; return "[]int",          "", true, ptr  end
			local i1, i2 = s:find("^Lua table of int%f[^%w_] *",                  ptr) ; if i1 then  ptr = i2+1 ; return "[]int",          "", true, ptr  end
			local i1, i2 = s:find("^Lua string table%f[^%w_] *",                  ptr) ; if i1 then  ptr = i2+1 ; return "[]string",       "", true, ptr  end
			local i1, i2 = s:find("^Lua table of strings%f[^%w_] *",              ptr) ; if i1 then  ptr = i2+1 ; return "[]string",       "", true, ptr  end
			local i1, i2 = s:find("^Lua table of output strings%f[^%w_] *",       ptr) ; if i1 then  ptr = i2+1 ; return "[]string",       "", true, ptr  end
			local i1, i2 = s:find("^Lua table of error strings%f[^%w_] *",        ptr) ; if i1 then  ptr = i2+1 ; return "[]string",       "", true, ptr  end
			local i1, i2 = s:find("^Lua table of wxDataFormat objects%f[^%w_] *", ptr) ; if i1 then  ptr = i2+1 ; return "[]wxDataFormat", "", true, ptr  end
			local i1, i2 = s:find("^Lua table of wxTreeItemIds%f[^%w_] *",        ptr) ; if i1 then  ptr = i2+1 ; return "[]wxTreeItemId", "", true, ptr  end

			local i1, i2 = s:find("^Lua table%f[^%w_] *", ptr)
			if i1 then  ptr = i2+1 ; return "[]any", "", true, ptr  end -- Temporary! The actual type will (hopefully) be patched in before writing.

			local i1, i2 = s:find("^Lua string of data%f[^%w_] *", ptr) ; if i1 then  ptr = i2+1 ; return "string",        "", true, ptr  end
			local i1, i2 = s:find("^Lua string%f[^%w_] *",         ptr) ; if i1 then  ptr = i2+1 ; return "string",        "", true, ptr  end -- Must be after 'Lua string table'.

			local i1, i2 = s:find("^Lua function%(long item1, long item2, long data%) returning int *", ptr)
			if i1 then  ptr = i2+1 ; return "(item1,item2:int,data:int)->(side:int)", "", true, ptr  end
			local i1, i2 = s:find("^Lua function%f[^%w_] *", ptr)
			if i1 then  ptr = i2+1 ; return "(event:wxEvent)->void", "", true, ptr  end -- Assume this is in wxEvtHandler::Connect(). @Robustness

			errorAt(ln, s, ptr, "Unhandled type that starts with 'Lua'")
		end

		local i1, i2 = s:find("^new class type%f[^%w_] *", ptr) ; if i1 then  ptr = i2+1 ; return "wxObject--[[new class type]]", "", true, ptr  end
		local i1, i2 = s:find("^new Lua string%f[^%w_] *", ptr) ; if i1 then  ptr = i2+1 ; return "string", "", true, ptr  end
		local i1, i2 = s:find("^any value type%f[^%w_] *", ptr) ; if i1 then  ptr = i2+1 ; return "any",    "", true, ptr  end
		local i1, i2 = s:find("^any object%f[^%w_] *",     ptr) ; if i1 then  ptr = i2+1 ; return "any",    "", true, ptr  end

		local i1, i2 = s:find("^%b{} *", ptr)
		if i1 then  ptr = i2+1 ; return "[][](wxWindowID|string--[[|wxItemKind]])", "", true, ptr  end -- Assume this is that one wxMenu constructor. @Robustness
	end

	local i1, i2 = s:find("^const +", ptr)
	if i1 then  ptr = i2+1  end

	local i1, i2   = s:find("^unsigned +", ptr)
	local unsigned = i1 ~= nil
	if unsigned then  ptr = i2+1  end

	local i1, i2, typeName, pointer = s:find("^(%a[%w_:]*) *([&*]?)%*? *", ptr)
	if not i1 then  errorAt(ln, s, ptr, "Failed parsing type")  end
	ptr = i2+1

	-- Note: wxString and wxArrayString will sometimes be written as
	-- wxString|string and wxArrayString|[]string in the output.

	if typeName == "long" then
		typeName = unsigned and "int--[[unsigned long]]"  or "int--[[long]]"
	elseif typeName == "short" then
		typeName = unsigned and "int--[[unsigned short]]" or "int--[[short]]"
	elseif typeName == "char" then
		typeName = unsigned and "int--[[unsigned char]]"  or "int--[[char]]"
	elseif typeName == "uchar" then
		typeName = "int--[[uchar]]"
	elseif typeName == "voidptr_long" then
		typeName = "int--[[voidptr_long]]"
	elseif typeName == "size_t" then
		typeName = "int--[[size_t]]"
	elseif typeName == "wxUint8" then
		typeName = "int--[[wxUint8]]"
	elseif typeName == "wxUint16" then
		typeName = "int--[[wxUint16]]"
	elseif typeName == "wxUint32" then
		typeName = "int--[[wxUint32]]"
	elseif typeName == "wxCoord" then
		typeName = "int--[[wxCoord]]"

	elseif typeName == "double" then
		typeName = "float--[[double]]"

	elseif typeName == "LuaTable" then
		typeName = "[]any--[[LuaTable]]" -- Temporary! The actual type will (hopefully) be patched in before writing the output.
	elseif typeName == "IntArray_FromLuaTable" then
		typeName = "[]int"

	elseif typeName == "void" and pointer == "*" then
		typeName = "wxLuaUserdata--[[void*]]"

	elseif typeName == "lua_string" then
		typeName = "string"
	elseif typeName == "wxChar" then
		-- Only a couple of virtual methods use this. It seems all other
		-- functions has been changed by wxLua to use wxString instead. These
		-- may simply be copy+paste errors in the interface file.
		typeName = "wxString"

	else
		typeName = typeName:gsub("::", ".")
	end

	return typeName, pointer, false, ptr
end

-- name, ptr = parseName( s, ptr [, allowNamespace=false ] )
local function parseName(s, ptr, allowNamespace)
	local i1, i2, name = s:find("^(%a[%w_:]*) *", ptr)
	if not i1 then  errorAt(ln, s, ptr, "Failed parsing name")  end

	if name == "string" then
		name = "str"
	end

	ptr = i2+1
	return name, ptr
end

-- typeName, pointer, isSpecialLuaType, name, ptr = parseTypeAndName( s, ptr [, allowNamespace=false ] )
local function parseTypeAndName(s, ptr, allowNamespace)
	local typeName, pointer, isSpecialLuaType, name
	typeName, pointer, isSpecialLuaType, ptr = parseType(s, ptr)
	name,                                ptr = parseName(s, ptr, allowNamespace)
	return typeName, pointer, isSpecialLuaType, name, ptr
end

-- funcData = parseFunction( s [, isConstructor=false ] )
local function parseFunction(s, isConstructor)
	local funcData = {name="", argsIn={}, argsOut={}}
	local ptr = 1

	--
	-- Out args and name.
	--

	if isConstructor then
		local className;className, ptr = parseName(s, ptr, true)
		className     = className:gsub("^.+::", "")
		funcData.name = className -- Note: We use !call when outputting.

		funcData.argsOut[1] = {typeName=className, name=""}

	elseif s:find("^%a", ptr) then
		local typeName, pointer, isSpecialLuaType, funcName
		typeName, pointer, isSpecialLuaType, funcName, ptr = parseTypeAndName(s, ptr, true)
		funcData.name = funcName

		if typeName ~= "void" then
			funcData.argsOut[1] = {typeName=typeName, name=""}
		end

	elseif s:find("^%[", ptr) then
		ptr = ptr+1

		for i = 1, math.huge do
			local typeName, pointer, isSpecialLuaType
			typeName, pointer, isSpecialLuaType, ptr = parseType(s, ptr)

			local argName = ""
			if s:find("^%a", ptr) then
				argName, ptr = parseName(s, ptr)
			end

			local argData = {typeName=typeName, name=argName, value=nil}
			table.insert(funcData.argsOut, argData)

			if s:find("^%]", ptr) then
				local i1, i2 = s:find("^%] *", ptr)
				ptr = i2+1
				break
			elseif s:find("^,", ptr) then
				local i1, i2 = s:find("^, *", ptr)
				ptr = i2+1
			else
				errorAt(ln, s, ptr, "Expected ']'")
			end
		end

		local funcName;funcName, ptr = parseName(s, ptr)
		funcData.name = funcName

	else
		errorAt(ln, s, ptr, "Error parsing function")
	end

	funcData.name = funcData.name:gsub("^.+::", "")

	--
	-- In args.
	--

	local i1, i2 = s:find("^%( *", ptr)
	if not i1 then  errorAt(ln, s, ptr, "Expected '('")  end
	ptr = i2+1

	if s:find("^%)", ptr) then
		-- void  No args.

	-- :OverrideHacks

	elseif s:find("^Lua string%)", ptr) then
		local argData = {typeName="string", name="str", value=nil}
		table.insert(funcData.argsIn, argData)

	elseif s:find("^Lua table with this format%)", ptr) then
		-- Assume this is that one wxAcceleratorTable constructor.
		local argData = {typeName="[][]int--[[is int good enough here?]]", name="accelTable", value=nil}
		table.insert(funcData.argsIn, argData)

	elseif s:find("^either a single number or a Lua table with number indexes and values%)", ptr) then
		local argData = {typeName="int|[]int", name="num", value=nil}
		table.insert(funcData.argsIn, argData)

	elseif s:find("^LuaTable stringTable where each index is a row in the image%)", ptr) then
		local argData = {typeName="[]string", name="row", value=nil}
		table.insert(funcData.argsIn, argData)

	-- /OverrideHacks

	else
		for i = 1, math.huge do
			local typeName, pointer, isSpecialLuaType
			typeName, pointer, isSpecialLuaType, ptr = parseType(s, ptr)

			local argName
			if isSpecialLuaType and s:find("^[,)]", ptr) then
				if typeName:find"^%[%][%w_]+$" then
					argName = typeName:sub(3).."Array"
				else
					argName = "arg"..i
				end
			else
				argName, ptr = parseName(s, ptr)
			end

			local argData = {typeName=typeName, name=argName, value=nil}
			table.insert(funcData.argsIn, argData)

			if s:find("^%[%] *= *0", ptr) then
				local i1, i2     = s:find("^%[%] *= *0 *", ptr)
				ptr              = i2+1
				argData.typeName = "[]"..typeName
				argData.value    = "NULL"

			elseif s:find("^= *INT_MAX%f[^%w_]", ptr) then
				local i1, i2  = s:find("^= *INT_MAX *", ptr)
				ptr           = i2+1
				argData.value = "0--[[INT_MAX]]"

			elseif s:find("^= *wxLuaNullSmartwxArrayString%f[^%w_]", ptr) then -- Null value for wxLuaSmartwxArrayString, which I can't even...
				local i1, i2  = s:find("^= *wxLuaNullSmartwxArrayString *", ptr)
				ptr           = i2+1
				argData.value = "NULL"

			elseif s:find("^=", ptr) then
				local i1, i2, argValue = s:find("^= *([^,)]+)", ptr)
				if not i1 then  errorAt(ln, s, ptr, "Failed parsing value")  end
				ptr           = i2+1
				argData.value = argValue:gsub("::", "."):gsub(" +$", "")
			end

			if s:find("^%)", ptr) then
				ptr = ptr+1
				break
			elseif s:find("^,", ptr) then
				local i1, i2 = s:find("^, *", ptr)
				ptr = i2+1
			else
				errorAt(ln, s, ptr, "Expected ')'")
			end
		end
	end

	-- Ignore any trailing 'const'.

	return funcData
end

local function handleAfterOverride()
	while true do
		local line = getNextLine() or errorOnLine(ln, "Missing end of override")
		if handleComment(line) then
			-- void
		elseif line:find"^%%override " then
			nextLine = line
			break
		else
			break -- Ignore line.
		end
	end
end

-- addOneOrMoreRequirements( requirement [, filename=currentFilename ] )
local function addOneOrMoreRequirements(requirement, filename)
	filename                  = filename or currentFilename
	local requirementsForFile = requirements[filename]

	-- print(filename, requirement)

	-- @Robustness: Don't add argument names inside function signatures.

	local ident = requirement:match"^[( ]*(%a[%w_]*)"
	if ident and not requirementsForFile[ident] then
		-- if ident ~= requirement or 1 then  print(filename, "", ident)  end
		requirementsForFile[ident] = true
		table.insert(requirementsForFile, ident)
	end

	for ident in requirement:gmatch"%[%][( ]*(%a[%w_]*)" do
		if not requirementsForFile[ident] then
			-- print(filename, "", ident)
			requirementsForFile[ident] = true
			table.insert(requirementsForFile, ident)
		end
	end

	for ident in requirement:gmatch"|[( ]*(%a[%w_]*)" do
		if not requirementsForFile[ident] then
			-- print(filename, "", ident)
			requirementsForFile[ident] = true
			table.insert(requirementsForFile, ident)
		end
	end

	for ident in requirement:gmatch": *(%a[%w_]*)" do
		if not requirementsForFile[ident] then
			-- print(filename, "", ident)
			requirementsForFile[ident] = true
			table.insert(requirementsForFile, ident)
		end
	end
end

local function addRequirementsForFunction(funcData)
	for _, argData in ipairs(funcData.argsIn) do
		addOneOrMoreRequirements(argData.typeName)
		if argData.value then  addOneOrMoreRequirements(argData.value)  end
	end
	for _, argData in ipairs(funcData.argsOut) do
		addOneOrMoreRequirements(argData.typeName)
	end
end

local function handleLine(line)
	line = removeInlineComments(line)

	-- %__WINDOWS__ %define __WINDOWS__ 1
	if line:find"^%%__" then
		return -- Ignore line.

	-- wxwidgets/wxbase_base.i - Lua table = 'wx'
	-- wxluasocket/wxluasocket.i - Lua table = 'wxlua'
	elseif line:find"^%a+/" then
		currentFilename, currentLuaTableName = line:match"^%a+/([%w_]+)%.i %- Lua table = '(wx%a*)'"
		if not currentFilename then
			errorOnLine(ln, "Failed parsing filename and Lua table name:  "..line)
		end

		if not filenames[currentFilename] then
			filenames [currentFilename] = true
			table.insert(filenames, currentFilename)
			-- print("FILE: "..currentFilename)

			requirements[currentFilename] = {}
		end

		-- print("LUATABLE: "..currentLuaTableName)

	-- %typedef void* WXHANDLE
	-- %typedef unsigned short wxDateTime::wxDateTime_t
	elseif line:find"^%%typedef " then
		local ptr    = 1
		local i1, i2 = line:find("^%%typedef +", ptr)
		ptr          = i2+1

		local typeName, pointer, isSpecialLuaType
		typeName, pointer, isSpecialLuaType, ptr = parseType(line, ptr)

		local i1, i2, typeNameAlias = line:find("^(%a[%w_:]*) *", ptr)
		if not i1 then  errorAt(ln, line, ptr, "Could not parse new type name")  end
		ptr = i2+1

		local scope, _typeNameAlias = typeNameAlias:match"^([%w_]+)::([%w_]+)$"
		if scope then  typeNameAlias = _typeNameAlias  end

		local typedefData = {file=currentFilename, name=typeNameAlias, typeName=typeName}
		-- print("TYPEDEF: "..(scope and scope.."." or "")..typeNameAlias.." :: "..typeName)

		addOneOrMoreRequirements(typeName)

		if scope then
			innerTypedefs[scope] = (innerTypedefs[scope] or {})
			table.insert(innerTypedefs[scope], typedefData)
		else
			table.insert(globalTypedefs, typedefData)
		end

	-- %define wxMAJOR_VERSION
	-- %define wxHAS_REGION_COMBINE 1
	elseif line:find"^%%define " then
		local defName, value = line:match"^%%define +(%a[%w_]*) +(%d+)$"

		if defName then
			-- print("DEFINT: "..defName)
			table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=defName, typeName="int", value=value})
			return
		end

		defName = line:match"^%%define +(%a[%w_]*)$" or errorOnLine(ln, "Failed parsing %define:  "..line)
		-- print("DEFINT: "..defName)

		local typeName = defName:find"^wxID_" and "wxWindowID" or "int"
		table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=defName, typeName=typeName, value=nil})

	-- %define_string wxVERSION_STRING
	-- %define_string wxFILE_SEP_PATH_UNIX wxT("/")
	elseif line:find"^%%define_string " then
		if line == "%define_string wxFILE_SEP_PATH wxLua_FILE_SEP_PATH" then  return  end -- Ignore this hack.

		local defName, value = line:match'^%%define_string +(%a[%w_]*) wxT%(("[^"]*")%)$'
		if not defName then
			defName, value = line:match'^%%define_string +(%a[%w_]*) _T%(("[^"]*")%)$'
		end

		if defName then
			-- print("DEFSTR: "..defName)
			table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=defName, typeName="string", value=value})
			return
		end

		defName = line:match"^%%define_string +(%a[%w_]*)$" or errorOnLine(ln, "Failed parsing %define_string:  "..line)
		-- print("DEFSTR: "..defName)

		table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=defName, typeName="string", value=nil})

	-- %function bool wxCHECK_VERSION(int major, int minor, int release) // actually a define
	elseif line:find"^%%function " then
		local def = line:match"^%%function +(%S.*)$" or errorOnLine(ln, "Failed parsing %function:  "..line)
		-- print("DEFFUNC: "..def)

		local funcData = parseFunction(def)
		funcData.file  = currentFilename
		funcData.table = currentLuaTableName

		table.insert(globalFunctions, funcData)
		addRequirementsForFunction(funcData)

	-- %override wxDateTime wxFileModificationTime(const wxString& filename) (not overridden, just return wxDateTime)
	-- %override [int version, int major, int minor] wxGetOsVersion()
	elseif line:find"^%%override " then
		local def = line:match"^%%override +(%S.*)$" or errorOnLine(ln, "Failed parsing %override:  "..line)
		-- print("DEFFUNC: "..def)

		local funcData = parseFunction(def)
		funcData.file  = currentFilename
		funcData.table = currentLuaTableName

		table.insert(globalFunctions, funcData)
		addRequirementsForFunction(funcData)
		handleAfterOverride()

	-- %rename wxGetTranslationPlural %function wxString wxGetTranslation(const wxString& sz1, const wxString& sz2, size_t n, const wxChar* domain=NULL)
	elseif line:find"^%%rename " then
		local newName, def = line:match"^%%rename +(%a[%w_]*) +%%function +(%S.*)$"
		if not def then  errorOnLine(ln, "Failed parsing %rename:  "..line)  end
		-- print("DEFFUNC: "..def)

		local funcData = parseFunction(def)
		funcData.file  = currentFilename
		funcData.table = currentLuaTableName
		funcData.name  = newName

		table.insert(globalFunctions, funcData)
		addRequirementsForFunction(funcData)
		handleAfterOverride()

	-- %include "wx/filefn.h"
	elseif line:find"^%%include " then
		return -- Ignore line.

	-- %if wxUSE_ON_FATAL_EXCEPTION
	elseif line:find"^%%if " then
		local condition = line:match"^%%if +(%S.*)$" or errorOnLine(ln, "Failed parsing %if:  "..line)
		-- print("IF: "..condition)

		if not isConditionTrue(condition, 1) then
			while true do
				line = getNextLine() or errorOnLine(ln, "Missing %endif")
				if line:find"^%%endif" then
					-- print("ENDIF")
					break
				else
					-- @Robustness: Do we need to handle nested %if statements?
					handleComment(line)
				end
			end
		end

	-- %if // wxLUA_USE_wxDynamicLibrary && wxUSE_DYNLIB_CLASS
	elseif line:find"^%%if" then
		return -- Ignore line. (This seem like an error or something in the interface file.)

	elseif line:find"^%%endif" then
		return -- Ignore line.

	-- %enum
	-- %enum wxPortId
	-- %enum wxConfigBase::EntryType
	elseif line == "%enum" or line:find"^%%enum " then
		local enumName = line:match"^%%enum +(%S+)$" or ""
		-- print("ENUM: "..(enumName ~= "" and enumName or "<unnamed>"))

		local scope, _enumName = enumName:match"^([%w_]+)::([%w_]+)$"
		if scope then
			enumName = (_enumName == "dummy" and "" or _enumName)
		end

		local enumData = {file=currentFilename, table=currentLuaTableName, scope=scope, name=enumName, members={}}
		if scope then
			innerEnums[scope] = (innerEnums[scope] or {})
			table.insert(innerEnums[scope], enumData)
		else
			table.insert(globalEnums, enumData)
		end

		while true do
			line = getNextLine() or errorOnLine(ln, "Missing %endenum")
			if line:find"^%%endenum" then
				-- print("ENDENUM")
				break
			elseif handleComment(line) then
				-- void
			elseif line:find"^%%if " or line:find"^%%endif" then
				handleLine(line)
			else
				line         = removeInlineComments(line)
				local member = line:match"^(%a[%w_]*),?$" or errorOnLine(ln, "Failed parsing enum member:  "..line)
				-- print("MEMBER("..enumName.."): "..member)
				table.insert(enumData.members, member)
			end
		end

	-- %class %delete %noclassinfo %encapsulate wxLog
	-- %class %delete %noclassinfo %encapsulate wxPathList, wxArrayString
	-- %struct %delete %encapsulate wxSplitterRenderParams
	elseif line:find"^%%class " or line:find"^%%struct " then
		local classOrStruct = line:match"^%%(%a+)"

		local classConfigsStr, parentClassName = line:match"^%%%a+ +(%S[%%%w: ]*), +(wx[%w_]*)$"
		if not classConfigsStr then
		end
		if classConfigsStr then
			classConfigsStr = classConfigsStr:gsub("%s+$", "")
		else
			classConfigsStr = line:match"^%%%a+ +(%S[%%%w: ]*)$" or errorOnLine(ln, "Failed parsing %"..classOrStruct..":  "..line)
			parentClassName = "wxLuaUserdata"
		end

		addOneOrMoreRequirements(parentClassName)

		local classConfigs = {}
		for confStr in classConfigsStr:gmatch"%S+" do
			table.insert(classConfigs, confStr)
		end

		local className = table.remove(classConfigs) or errorOnLine(ln, "Missing "..classOrStruct.." name:  "..line)
		if not className:find"^wx[%w:]+$" then  errorOnLine(ln, "Possibly invalid class name '"..className.."'.")  end

		local scope, _className = className:match"^([%w_]+)::([%w_]+)$"
		if scope then  className = _className  end

		local classData = {file=currentFilename, table=currentLuaTableName, name=className, parent=parentClassName, staticFunctions={}, methods={}, enums={}, structs={}, members={}}
		if scope then
			innerClasses[scope] = (innerClasses[scope] or {})
			table.insert(innerClasses[scope], classData)
		else
			table.insert(globalClasses, classData)
		end

		-- @Robustness: Handle/validate classConfigs.

		-- print("CLASS: "..className..(parentClassName ~= "" and " ("..parentClassName..")" or ""))

		local function handleLineInClass(line)
			if line:find"^%%if " or line:find"^%%endif" or line:find"^%%define " then
				handleLine(line)
				return

			-- %operator int operator[](size_t nIndex)
			elseif line:find"^%%operator " then
				return -- Ignore line for now.  @Compiler @Incomplete: Support operator overloading.
			end

			-- %define_event wxEVT_COMMAND_TEXT_COPY // EVT_TEXT_COPY(winid, func)
			if line:find"^%%define_event " then
				local eventName, eventComment = line:match"^%%define_event +(wxEVT_[%a_]+) *// *(.*)$"
				if not eventName then  errorOnLine(ln, "Failed parsing %define_event:  "..line)  end
				-- print("EVENT: "..eventName.." // "..eventComment)
				table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=eventName, typeName="wxEventType", value=nil, comment=(eventComment ~= "" and eventComment or nil)})
				addOneOrMoreRequirements("wxEventType")
				return
			end

			line = removeInlineComments(line)

			-- %define_object wxDefaultDateTime
			if line:find"^%%define_object " then
				local defName = line:match"^%%define_object (wx[%w_]+)" or errorOnLine(ln, "Failed parsing %define_object:  "..line)
				-- print("DEFOBJ: "..defName)
				table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=defName, typeName=className, value=nil})
				return
			end

			-- %rename wxDateTimeFromJDN wxDateTime(double dateTime)
			local newName = nil
			if line:find"^%%rename " then
				local i1, i2
				i1, i2, newName = line:find"^%%rename +(%a[%w_]*) +"
				if not newName then  errorOnLine(ln, "Failed parsing %rename:  "..line)  end
				line = line:sub(i2+1)
			end

			-- %define_pointer wxTheMimeTypesManager
			-- %rename wxSMALL_FONT %define_pointer wxLua_wxSMALL_FONT
			if line:find"^%%define_pointer " then
				local defName = line:match"^%%define_pointer (wx[%w_]+)" or errorOnLine(ln, "Failed parsing %define_pointer:  "..line)
				defName       = newName or defName
				-- print("DEFOBJ: "..defName)
				table.insert(globalValues, {file=currentFilename, table=currentLuaTableName, name=defName, typeName=className, value=nil})
				return

			-- %member int Language; // wxLanguage id
			-- %member const int version;
			-- %member static int ms_test_int
			elseif line:find"^%%member " then
				local ptr    = 1
				local i1, i2 = line:find("^%%member +", ptr)
				ptr          = i2+1

				if line:find("^static +", ptr) then
					return -- Ignore this for now. It only appears once ever! (wxLuaPrintout.ms_test_int)
				end

				local i1, i2  = line:find("^const +", ptr)
				local isConst = i1 ~= nil
				if isConst then  ptr = i2+1  end

				local typeName, pointer, isSpecialLuaType
				typeName, pointer, isSpecialLuaType, ptr = parseType(line, ptr)

				local memberName = line:match("^(%a[%w_]*) *", ptr) or errorAt(ln, line, ptr, "Could not parse member name")
				memberName       = newName or memberName

				local memberData = {name=memberName, typeName=typeName, const=isConst, func=false}
				table.insert(classData.members, memberData)
				addOneOrMoreRequirements(typeName)
				return

			-- %rename X %member_func int x // GetX() and SetX(int x)
			elseif line:find"^%%member_func " then
				local ptr    = 1
				local i1, i2 = line:find("^%%member_func +", ptr)
				ptr          = i2+1

				local typeName, pointer, isSpecialLuaType
				typeName, pointer, isSpecialLuaType, ptr = parseType(line, ptr)

				local memberName = line:match("^(%a[%w_]*) *", ptr) or errorAt(ln, line, ptr, "Could not parse member name")
				memberName       = newName or memberName

				local memberData = {name=memberName, typeName=typeName, const=false, func=true}
				table.insert(classData.members, memberData)
				addOneOrMoreRequirements(typeName)
				return
			end

			-- %override static void wxLog::SetTimestamp(const wxString& ts)
			-- %override [bool, size_t start, size_t len] wxRegEx::GetMatch(size_t index = 0) const
			-- %override [Lua table of wxDataFormat objects] wxDataObject::GetAllFormats(wxDataObject::Direction dir = wxDataObject)
			local i1, i2     = line:find"^%%override +"
			local isOverride = i1 ~= nil
			if isOverride then  line = line:sub(i2+1)  end

			line      = line:gsub("^%%override_name +%a[%w_]* +", "") -- :OverrideHacks, kind of.
			local def = line

			-- Constructor.
			-- wxMemoryConfig()
			-- wxRegEx(const wxString& expr, int flags = wxRE_DEFAULT)
			-- wxFileType::MessageParameters(const wxString& filename, const wxString& mimetype = "")
			if def:find"^%a[%w_]* *%(" or def:find"^%a[%w_]*::%a[%w_]* *%(" then
				local funcData = parseFunction(def, true)
				if funcData.name ~= className then
					errorOnLine(ln, "Unexpected constructor name '"..funcData.name.."': "..line)
				end
				funcData.name = newName or funcData.name

				-- print("DEFFUNC: "..def)
				table.insert(classData.staticFunctions, funcData)
				addRequirementsForFunction(funcData)

				if isOverride then  handleAfterOverride()  end
				return
			end

			-- static wxString GetOption(const wxString& name) const
			local i1, i2   = def:find"^static +"
			local isStatic = i1 ~= nil
			if isStatic then  def = def:sub(i2+1)  end

			-- virtual void SetStatusWidths(IntArray_FromLuaTable intTable)
			def = def:gsub("^virtual +", "")

			if not def:find"^[%a%[]" then
				errorOnLine(ln, "Expected a type or name:  "..def)
			end

			-- unsigned char GetBlue(int x, int y) const
			local funcData = parseFunction(def)
			funcData.name  = newName or funcData.name

			if isStatic then
				funcData.name = funcData.name:gsub("::.+", "")
				-- print("DEFFUNC: "..def)
				table.insert(classData.staticFunctions, funcData)
			else
				-- print("METHOD("..className..(newName and "."..newName or "").."): "..def)
				table.insert(classData.methods, funcData)
			end
			addRequirementsForFunction(funcData)

			if isOverride then  handleAfterOverride()  end
		end

		while true do
			line = getNextLine() or errorOnLine(ln, "Missing %end"..classOrStruct)

			if line:find("^%%end"..classOrStruct) then
				-- print("END"..classOrStruct:upper())
				break
			elseif not handleComment(line) then
				handleLineInClass(line)
			end
		end

	else
		errorOnLine(ln, "Failed parsing line:  "..line)
	end
end

local function toIdent(name)
	return GLOA_KEYWORDS[name] and "\\"..name or name
end
local function toMaybeCompound(typeName)
	return
		typeName == "wxString"      and "wxString|string"        or
		typeName == "wxArrayString" and "wxArrayString|[]string" or
		typeName
end
local function toWxLuaCommonType(typeName)
	return
		typeName == "wxString" and "string" or
		-- typeName == "wxArrayString" and "[]string" or
		typeName
end

local function align(name, colWidth)
	return (" "):rep(colWidth-#name)
end

local function isCommonType(typeName)
	return
		typeName    == "bool"
		or typeName == "any"    or nil ~= typeName:find"^any%-%-"
		or typeName == "float"  or nil ~= typeName:find"^float%-%-"
		or typeName == "int"    or nil ~= typeName:find"^int%-%-"
		or typeName == "string" or nil ~= typeName:find"^string%-%-"
		or typeName == "table"  or nil ~= typeName:find"^table%-%-"

		or typeName == "time_t"
		or typeName == "wxEnum"
		or typeName == "wxEventType"
		or typeName == "wxFileOffset"
		or typeName == "wxWindowID"

		or typeName == "wxLuaUserdata"

		or typeName == "wxClassInfo"
		or typeName == "wxObject"
		or typeName == "wxObjectRefData"
		or typeName == "wxString"
end

local function itemWith1(t, k, v)
	for _, item in ipairs(t) do
		if item[k] == v then  return item  end
	end
	return nil
end

local function flipArray(t)
	local flipped = {}
	for i, v in ipairs(t) do
		flipped[v] = i
	end
	return flipped
end

--==============================================================
--==============================================================
--==============================================================

io.stdout:setvbuf("no")
io.stderr:setvbuf("no")

print("Parsing WX interface file...")

for line in getNextLine do
	if not handleComment(line) then
		handleLine(line)
	end
end

print("Parsing WX interface file... done!")

-- Move some things to common.

local moved = {}

for _, className in ipairs{"wxString","wxObject","wxObjectRefData","wxClassInfo"} do
	local classData  = itemWith1(globalClasses, "name", className) or error(className)
	classData.file   = "common"
	moved[className] = "common"
end
for _, funcName in ipairs{"wxCreateDynamicObject"} do
	local funcData  = itemWith1(globalFunctions, "name", funcName) or error(funcName)
	funcData.file   = "common"
	moved[funcName] = "common"
end

for _, typedefData in ipairs(globalTypedefs) do
	typedefData.file        = "common"
	moved[typedefData.name] = "common"
end
--[[ Moving these seem to increase compilation time by 50% or more. No good!
for _, valueData in ipairs(globalValues) do
	if isCommonType(valueData.typeName) then
		valueData.file        = "common"
		moved[valueData.name] = "common"
	end
end
--]]

-- Apply patches.

for _, funcData in ipairs(globalFunctions) do
	local funcName = funcData.name

	if funcName == "GetTrackedWindowInfo" then
		funcData.argsOut[1].typeName = "([]wxTopLevelWindow)|([]string)"
		addOneOrMoreRequirements("wxTopLevelWindow", funcData.file)

	elseif funcName == "GetGCUserdataInfo" or funcName == "GetTrackedObjectInfo" then
		funcData.argsOut[1].typeName = "([]wxLuaUserdata)|([]string)"
		addOneOrMoreRequirements("wxLuaUserdata", funcData.file)

	elseif funcName == "GetTrackedEventCallbackInfo" then
		funcData.argsOut[1].typeName = "([](event:wxEvent)->void)|([]string)"
		addOneOrMoreRequirements("wxEvent", funcData.file)

	elseif funcName == "GetTrackedWinDestroyCallbackInfo" then
		funcData.argsOut[1].typeName = "([]wxLuaUserdata)|([]string)" -- Not sure about the wxLuaUserdata type.
		addOneOrMoreRequirements("wxLuaUserdata", funcData.file)

	elseif funcName == "GetBindings" then
		funcData.argsOut[1].typeName = "[]table--[[wxLuaBinding]]"
		-- funcData.argsOut[1].typeName = "[]wxLuaBinding" -- wxLuaBinding is not a class! The returned value is a handcoded table. See the interface file.
		-- addOneOrMoreRequirements("wxLuaBinding", funcData.file)
	end
end

for _, classData in ipairs(globalClasses) do
	local className = classData.name

	for _, funcData in ipairs(classData.staticFunctions) do
		if className == "wxBitmap" and funcData.name == className and funcData.argsOut[1] and funcData.argsOut[1].name == "charTable" then
			funcData.argsOut[1].typeName = "[]string"
		end
	end

	for _, funcData in ipairs(classData.methods) do
		if className == "wxArrayInt" and funcData.name == "ToLuaTable" then
			funcData.argsOut[1].typeName = "[]int"
		elseif className == "wxArrayString" and funcData.name == "ToLuaTable" then
			funcData.argsOut[1].typeName = "[]string"
		end
	end
end

-- Register declarations.

local declarations = {--[[ globalName1=filename1, ... ]]}

for _, filename in ipairs(filenames) do
	for name in MODULE_SETTINGS[filename].header:gmatch"%f[%w_]export +(%a[%w_]*)" do
		declarations[name] = filename
	end
end

for _, datas in ipairs{globalTypedefs,globalValues,globalEnums,globalClasses} do
	for _, data in ipairs(datas) do
		if data.name ~= "" then  declarations[data.name] = data.file  end
	end
end

for _, enumData in ipairs(globalEnums) do
	for _, member in ipairs(enumData.members) do
		declarations[member] = enumData.file
	end
end

-- Tidy things up a bit.

local globalValueIndices = flipArray(globalValues)

table.sort(globalValues, function(a, b)
	if a.typeName ~= b.typeName then  return a.typeName < b.typeName  end
	return globalValueIndices[a] < globalValueIndices[b]
end)

-- Write files!

local gloaFile
local function write(...)
	gloaFile:write(...)
end

-- writeFunctionSignature( funcData, methodSelfType=nil, isConstructor )
local function writeFunctionSignature(funcData, methodSelfType, isConstructor)
	write("(")

	if methodSelfType then
		write("self:", methodSelfType)
		if funcData.argsIn[1] then  write(", ")  end
	end

	local i = 1

	while funcData.argsIn[i] do
		if i > 1 then  write(", ")  end

		local argData      = funcData.argsIn[i]
		local argDataNext1 = funcData.argsIn[i+1]
		local argDataNext2 = funcData.argsIn[i+2]
		local argDataNext3 = funcData.argsIn[i+3]
		local argsToWrite  = nil

		-- @Polish: Do this for named argsOut too.
		if argDataNext1 and argData.typeName == argDataNext1.typeName and argData.value == argDataNext1.value then
			if argDataNext2 and argData.typeName == argDataNext2.typeName and argData.value == argDataNext2.value then
				if argDataNext3 and argData.typeName == argDataNext3.typeName and argData.value == argDataNext3.value then
					if (
						argData.name == "r"  and argDataNext1.name == "g"  and argDataNext2.name == "b"  and argDataNext3.name == "a" or
						argData.name == "x1" and argDataNext1.name == "y1" and argDataNext2.name == "x2" and argDataNext3.name == "y2"
					) then
						argsToWrite = 4
					end
				end

				if not argsToWrite and (
					argData.name == "h"      and argDataNext1.name == "s"      and argDataNext2.name == "v"  or
					argData.name == "r"      and argDataNext1.name == "g"      and argDataNext2.name == "b"  or
					argData.name == "r1"     and argDataNext1.name == "g1"     and argDataNext2.name == "b1" or
					argData.name == "r2"     and argDataNext1.name == "g2"     and argDataNext2.name == "b2" or
					argData.name == "startR" and argDataNext1.name == "startG" and argDataNext2.name == "startB"
				) then
					argsToWrite = 3
				end
			end

			if not argsToWrite and (
				argData.name == "x"     and argDataNext1.name == "y"  or
				argData.name == "w"     and argDataNext1.name == "h"  or
				argData.name == "cx"    and argDataNext1.name == "cy" or
				argData.name == "dx"    and argDataNext1.name == "dy" or
				argData.name == "xc"    and argDataNext1.name == "yc" or
				argData.name == "width" and argDataNext1.name == "height"
			) then
				argsToWrite = 2
			end
		end

		argsToWrite = argsToWrite or 1

		for argToWrite = 1, argsToWrite do
			if argToWrite > 1 then  write(",")  end
			write(toIdent(funcData.argsIn[i].name))
			i = i+1
		end

		-- if not argData.value or argData.value == "NULL" then
			write(":", toMaybeCompound(argData.typeName))
		-- end

		if not argData.value then
			-- void

		elseif argData.value:find"[|&]" then
			assert((argData.typeName == "int" or argData.typeName:find"^int%-%-"), argData.typeName)
			write("=0--[[bitwise(", argData.value:gsub(" +", ""), ")]]")

		elseif argData.value == "NULL" then
			if argData.typeName == "[]int" then
				write("=NULL")
			else
				assert(argData.typeName:find"^wx[%w_]+$", argData.typeName)
				write("=", argData.typeName, ".null")
				-- write("=cast(", argData.typeName, ")wxNULL")
			end

		else
			write("=", argData.value)
		end
	end

	write(")")

	if not funcData.argsOut[1] then
		-- void
	elseif funcData.argsOut[1].name == "" then
		write(" -> ")
		for i, argData in ipairs(funcData.argsOut) do
			if i > 1 then  write(", ")  end
			write(isConstructor and argData.typeName or toWxLuaCommonType(argData.typeName))
		end
	else
		write(" -> (")
		for i, argData in ipairs(funcData.argsOut) do
			if i > 1 then  write(", ")  end
			if argData.name ~= "" then
				write(toIdent(argData.name))
			else
				write("_"..i)
			end
			write(":")
			write(isConstructor and argData.typeName or toWxLuaCommonType(argData.typeName))
		end
		write(")")
	end
end

local function writeValue(valueData, colWidth)
	if valueData.value ~= nil then
		write('export ', toIdent(valueData.name), align(valueData.name, colWidth), ' :: ', valueData.value)
	else
		write('export ', toIdent(valueData.name), ': ', align(valueData.name, colWidth), valueData.typeName, ' : !foreign lua "', valueData.table, '.', valueData.name, '"')
	end

	if valueData.comment then  write(" -- ", valueData.comment)  end
	write("\n")
end

local function writeTypedef(typedefData, colWidth, isInner)
	write(isInner and "\t" or "export ", toIdent(typedefData.name), align(typedefData.name, colWidth), " :: ", toWxLuaCommonType(typedefData.typeName))
	if isInner             then  write(",")                          end
	if typedefData.comment then  write(" -- ", typedefData.comment)  end
	write("\n")
end

local function writeEnum(enumData, isInner)
	local enumName = enumData.name ~= "" and enumData.name or "wxEnum"
	local indent   = isInner and "\t" or ""

	if enumData.name ~= "" then
		write(indent)
		if not isInner then  write("export ")  end
		write(enumName, " :: wxEnum")
		if isInner then  write(",")  end
		if enumData.comment then  write(" -- ", enumData.comment)  end
		write("\n")
	elseif enumData.comment then
		write("-- ", enumData.comment, "\n")
	end

	local colWidth = 0
	for _, member in ipairs(enumData.members) do
		colWidth = math.max(colWidth, #member)
	end

	for _, member in ipairs(enumData.members) do
		write(indent)
		if not isInner then  write("export ")  end
		write(member, ': ', align(member, colWidth), enumName, ' : !foreign lua "', enumData.table)
		if isInner then  write(".", enumData.scope)  end
		write('.', member, '"')
		if isInner then  write(",")  end
		write("\n")
	end
end

local function writeFunction(funcData, colWidth)
	local funcName = funcData.name

	write("export ", toIdent(funcName), align(funcName, colWidth), " :: ")
	writeFunctionSignature(funcData, nil, false)
	write(' !foreign lua "', funcData.table, '.', funcName, '"')

	if funcData.comment then  write(" -- ", funcData.comment)  end
	write("\n")
end

local function writeClass(classData, isInner)
	local className = classData.name
	local indent    = isInner and "\t" or ""

	write(indent)
	if not isInner then  write("export ")  end
	write(className, " :: !foreign struct {")
	if classData.comment then  write(" -- ", classData.comment)  end
	write("\n")

	write(indent, "\tusing ", classData.parent, ",\n")

	if CLASSES_TO_HAVE_NULL[className] then
		write("\n")
		write(indent, '\tnull: ', className, ' : !foreign lua "wx.NULL",\n')
	end

	if classData.members[1] then
		local anyFuncs = false

		local colWidth = 0
		for _, memberData in ipairs(classData.members) do
			colWidth = math.max(colWidth, #memberData.name)
		end

		write("\n")

		for _, memberData in ipairs(classData.members) do
			write(indent, "\t", toIdent(memberData.name), ": ", align(memberData.name, colWidth), toWxLuaCommonType(memberData.typeName), ",")
			if memberData.const then  write(" -- Read-only.")  end
			write("\n")
			anyFuncs = anyFuncs or memberData.func
		end

		if anyFuncs then
			write("\n")

			for _, memberData in ipairs(classData.members) do
				if memberData.func then
					local memberName = memberData.name
					write(
						indent, '\tGet', memberName, align(memberData.name, colWidth),
						' :: (self:', className, ') -> ', toWxLuaCommonType(memberData.typeName),
						' !foreign method "Get', memberName, '",\n'
					)
					if not memberData.const then
						write(
							indent, '\tSet', memberName, align(memberData.name, colWidth),
							' :: (self:', className, ', value:', toMaybeCompound(memberData.typeName), ')',
							' !foreign method "Set', memberName, '",\n'
						)
					end
				end
			end
		end
	end

	if innerTypedefs[className] then
		local colWidth = 0
		for _, typedefDataInner in ipairs(innerTypedefs[className]) do
			colWidth = math.max(colWidth, #typedefDataInner.name)
		end
		write("\n")
		for _, typedefDataInner in ipairs(innerTypedefs[className]) do
			writeTypedef(typedefDataInner, colWidth, true)
		end
	end

	for _, enumDataInner in ipairs(innerEnums[className] or EMPTY_TABLE) do
		write("\n")
		writeEnum(enumDataInner, true)
	end

	for _, classDataInner in ipairs(innerClasses[className] or EMPTY_TABLE) do
		write("\n")
		writeClass(classDataInner, true)
	end

	if classData.staticFunctions[1] then
		local colWidth = 0
		for _, funcData in ipairs(classData.staticFunctions) do
			colWidth = math.max(
				colWidth,
				-- (funcData.name == className and 5 or #funcData.name)
				(funcData.name ~= className and #funcData.name) or (isInner and 3) or 5
			)
		end
		write("\n")
		for _, funcData in ipairs(classData.staticFunctions) do
			if funcData.name == className then
				if isInner then
					write(indent, "\tnew", align("new", colWidth), " :: ") -- @Compiler @Incomplete: Support overloading of names is different scopes. (Or maybe that's a bad idea?)
				else
					write(indent, "\t!call",  align("!call",  colWidth), " :: ")
				end
				writeFunctionSignature(funcData, nil, true)
				write(' !foreign lua "', classData.table, '.', className, '",\n')
			else
				write(indent, "\t", funcData.name, align(funcData.name, colWidth), " :: ")
				writeFunctionSignature(funcData, nil, false)
				write(' !foreign lua "', classData.table, '.', className, '.', funcData.name, '",\n')
			end
		end
	end

	if classData.methods[1] then
		local colWidth = 0
		for _, funcData in ipairs(classData.methods) do
			colWidth = math.max(colWidth, #funcData.name)
		end
		write("\n")
		for _, funcData in ipairs(classData.methods) do
			write(indent, "\t", funcData.name, align(funcData.name, colWidth), " :: ")
			writeFunctionSignature(funcData, className, false)
			write(' !foreign method "', funcData.name, '",\n')
		end
	end

	write(indent, "}")
	if isInner then  write(",")  end
	write("\n")
end

print("Generating WX modules...")

for _, filename in ipairs(filenames) do
	local path                = DIR_HERE.."/"..filename..".gloa"
	local moduleSettings      = MODULE_SETTINGS[filename]
	local requirementsForFile = requirements[filename] or EMPTY_TABLE
	local imported            = {}

	-- print("Writing "..filename..".gloa...")
	gloaFile = assert(io.open(path, "wb"))

	write(MODULE_COMMON_HEADER:gsub("{interfaceFilename}", (filename == "common" and "(generator)" or filename..".i")), "\n")

	for _, requirement in ipairs(requirementsForFile) do
		local otherFilename = moved[requirement] or declarations[requirement]
		if otherFilename and otherFilename ~= filename and not imported[otherFilename] then
			imported[otherFilename] = true
			write('!import "wx/', otherFilename, '"\n')
			-- print(filename, otherFilename)
		end
	end
	write("\n")

	if moduleSettings.header ~= "" then
		write(moduleSettings.header, "\n")
	end

	local colWidth = 0
	for _, typedefData in ipairs(globalTypedefs) do
		if typedefData.file == filename then
			colWidth = math.max(colWidth, #typedefData.name)
		end
	end
	for _, typedefData in ipairs(globalTypedefs) do
		if typedefData.file == filename then
			writeTypedef(typedefData, colWidth, false)
		end
	end

	local colWidth1, colWidth2 = 0, 0
	for _, valueData in ipairs(globalValues) do
		if valueData.file == filename then
			if valueData.value ~= nil then
				colWidth1 = math.max(colWidth1, #valueData.name)
			else
				colWidth2 = math.max(colWidth2, #valueData.name)
			end
		end
	end
	for _, valueData in ipairs(globalValues) do
		if valueData.file == filename and valueData.value ~= nil then
			writeValue(valueData, colWidth1)
		end
	end
	for _, valueData in ipairs(globalValues) do
		if valueData.file == filename and valueData.value == nil then
			writeValue(valueData, colWidth2)
		end
	end

	for _, enumData in ipairs(globalEnums) do
		if enumData.file == filename then
			write("\n")
			writeEnum(enumData, false)
		end
	end

	for _, classData in ipairs(globalClasses) do
		if classData.file == filename then
			write("\n")
			writeClass(classData, false)
		end
	end

	local colWidth = 0
	for _, funcData in ipairs(globalFunctions) do
		if funcData.file == filename then
			colWidth = math.max(colWidth, #funcData.name)
		end
	end
	local first = true
	for _, funcData in ipairs(globalFunctions) do
		if funcData.file == filename then
			if first then  write("\n")  end
			first = false
			writeFunction(funcData, colWidth)
		end
	end

	gloaFile:close()
end

print("Generating WX modules... done!")

--==============================================================
--==============================================================
--==============================================================
