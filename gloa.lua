--[[============================================================
--=
--=  Glóa - a language that compiles into Lua
--=  by Marcus 'ReFreezed' Thunström
--=
--=  Language points:
--=  - Strict types (as far as Lua allows).
--=  - In file/declarative scopes, order of things doesn't matter.
--=  - No name shadowing.
--=
--============================================================]]

local compilationStartTime = os.clock()

io.stdout:setvbuf("no") -- Note: This slows down printAst().
io.stderr:setvbuf("no")





_G.DIR_HERE            = debug.getinfo(1, "S").source:match"@?(.+)":gsub("/?[^/]+$", ""):gsub("^$", ".")

_G.TOKEN_TYPE_TITLES   = {"keyword","identifier","directive","number","integer","string","punctuation"}
_G.LITERAL_TYPE_TITLES = {"number","int","string","bool","nil","array"}
_G.OPERATOR_PRECEDENCE = {["%"]=6,["*"]=6,["+"]=5,["-"]=5,["."]=10,[".."]=4,["/"]=6,["//"]=6,["<"]=3,["<="]=3,["=="]=3,[">"]=3,[">="]=3,["^"]=8,["and"]=2,call=9,["or"]=1,unary=7,["~="]=3}



do  --[[============================================================
--=
--=  General functions
--=
--=-------------------------------------------------------------
--=
--=  Glóa - a language that compiles into Lua
--=  by Marcus 'ReFreezed' Thunström
--=
--==============================================================

	errorInternal, errorLine, errorOnLine, errorInFile
	exit, exitFailure
	getFileContents
	isAny
	printf, printTraceback
	reportMessageInFile
	utf8Char

--============================================================]]



function math.clamp(n, nMin, nMax)
	return math.min(math.max(n, nMin), nMax)
end



function _G.printf(s, ...)
	print(s:format(...))
end

function _G.printTraceback(level)
	print("stack traceback:")

	for level = 1+(level or 1), math.huge do
		local info = debug.getinfo(level, "nSl")
		if not info then  break  end

		-- print(level, "source   ", info.source)
		-- print(level, "short_src", info.short_src)
		-- print(level, "name     ", info.name)
		-- print(level, "what     ", info.what)

		local where = info.source:match"^@(.+)" or info.short_src
		local lnStr = info.currentline > 0 and ":"..info.currentline or ""

		local name
			=  info.name --and (info.namewhat ~= "" and "in "..info.namewhat.." "..info.name or info.name)
			or info.linedefined > 0 and where..":"..info.linedefined
			or info.what == "main" and "main chunk"
			or info.what == "tail" and "tail call"
			or "?"

		printf("\t%s%s  (%s)", where, lnStr, name)
	end
end



-- errorInternal( [ level=1, ] formatString, ... )
local function _errorInternal(level, s, ...)
	printf("Error: "..s, ...)
	printTraceback(1+level)
	exitFailure()
end
function _G.errorInternal(levelOrS, ...)
	if type(levelOrS) == "number" then
		_errorInternal(1+levelOrS, ...)
	else
		_errorInternal(2, levelOrS, ...)
	end
end

function _G.errorLine(agent, s, ...)
	if agent then
		printf("[%s] Error: "..s, agent, ...)
	else
		printf("Error: "..s, ...)
	end
	exitFailure()
end

function _G.errorOnLine(path, ln, agent, s, ...)
	s = s:format(...)
	if agent then
		printf("Error @ %s:%d: [%s] %s\n", path, ln, agent, s)
	else
		printf("Error @ %s:%d: %s\n",      path, ln,        s)
	end
	exitFailure()
end

function _G.errorInFile(buffer, path, ptr, agent, s, ...)
	reportMessageInFile(buffer, path, ptr, "Error", agent, s, ...)
	exitFailure()
end




function _G.reportMessageInFile(buffer, path, ptr, label, agent, s, ...)
	s = s:format(...)

	ptr = math.clamp(ptr, 1, #buffer+1)
	local pre = buffer:sub(1, ptr-1)

	local lastLine1 = pre:reverse():match"^[^\n]*":reverse():gsub("\t", "    ")
	local lastLine2 = buffer:match("^[^\n]*", ptr):gsub("\t", "    ")
	local lastLine  = lastLine1..lastLine2

	local _, nlCount = pre:gsub("\n", "%0")
	local ln = nlCount+1

	local len    = 0
	local lenPtr = 1

	while true do
		if lenPtr > #lastLine1 then  break  end

		local _, i2 = lastLine1:find("^[%z\1-\127\194-\244][\128-\191]*", lenPtr)

		len    = len+1 -- The length isn't going to be perfect, depending on what Unicode characters are encountered.
		lenPtr = i2+1
	end

	local col = 1+len

	if agent then
		printf(
			"%s @ %s:%d: [%s] %s\n>\n> %s\n>%s^\n>",
			label, path, ln, agent, s, lastLine, ("-"):rep(col)
		)
	else
		printf(
			"%s @ %s:%d: %s\n>\n> %s\n> %s^\n>",
			label, path, ln,        s, lastLine, ("-"):rep(col-1)
		)
	end
end



function _G.exit(code)
	-- @Incomplete: Close log file and whatnot.
	os.exit(code or 0)
end

function _G.exitFailure()
	exit(1)
end



-- contents, error = getFileContents( path [, isText=false ] )
function _G.getFileContents(path, isText)
	local file, err = io.open(path, (isText and "r" or "rb"))
	if not file then  return nil, err  end

	local s = file:read"*a"
	file:close()
	return s
end



do
	local function _utf8Char(cp)
		if cp < 128 then  return string.char(cp)  end

		local suffix = cp%64
		local c4     = 128+suffix
		cp           = (cp-suffix)/64
		if cp < 32 then  return string.char(192+cp, c4)  end

		suffix   = cp%64
		local c3 = 128+suffix
		cp       = (cp-suffix)/64
		if cp < 16 then  return string.char(224+cp, c3, c4)  end

		suffix = cp%64
		cp     = (cp-suffix)/64
		return string.char(240+cp, 128+suffix, c3, c4)
	end

	local cache = {}

	function _G.utf8Char(cp)
		cache[cp] = cache[cp] or _utf8Char(cp)
		return cache[cp]
	end
end



function _G.isAny(v, ...)
	for i = 1, select("#", ...) do
		if v == select(i, ...) then  return true  end
	end
	return false
end


  end
do  --[[============================================================
--=
--=  Lexer
--=
--=-------------------------------------------------------------
--=
--=  Glóa - a language that compiles into Lua
--=  by Marcus 'ReFreezed' Thunström
--=
--==============================================================

	tokenize
	getToken, isToken, isTokenLiteral, isTokenBuiltinType

--============================================================]]



local KEYWORDS        = {["and"]=true,bool=true,["break"]=true,case=true,cast=true,continue=true,defer=true,["do"]=true,["else"]=true,["elseif"]=true,enum=true,export=true,["false"]=true,["for"]=true,global=true,["goto"]=true,["if"]=true,["in"]=true,int=true,is=true,["local"]=true,["nil"]=true,["not"]=true,number=true,["or"]=true,["repeat"]=true,["return"]=true,string=true,struct=true,table=true,["true"]=true,type=true,typeOf=true,["until"]=true,use=true,useLibrary=true,void=true,["while"]=true}
local DIRECTIVE_WORDS = {bodyText=true,complete=true,["if"]=true,must=true,run=true,through=true,type=true}



local Tokens=function()return{count=0,file={},line1={},line2={},position1={},position2={},type={},value={}}end

function _G.tokenize(s, path)
	local tokens = Tokens()

	local tokTypes      = tokens.type
	local tokValues     = tokens.value
	local tokFiles      = tokens.file
	local tokPositions1 = tokens.position1
	local tokPositions2 = tokens.position2
	local tokLines1     = tokens.line1
	local tokLines2     = tokens.line2

	local ptr = 1
	local ln  = 1

	while true do
		-- Ignore whitespace.  @Incomplete: Count lines.
		local i1, i2 = s:find("^%s+", ptr)
		if i1 then  ptr = i2+1  end

		if ptr > #s then  break  end

		local tokenPos          = ptr
		local tokType, tokValue = nil

		-- Identifier/keyword.
		if s:find("^[%a_\194-\244]", ptr) then
			local i1 = ptr
			local i2, _

			for i = 1, math.huge do
				if s:byte(ptr) <= 127 then
					_, i2 = s:find("^[%w_]+", ptr)
				else
					_, i2 = s:find("^[\194-\244][\128-\191]*", ptr)
				end

				if i2 then
					ptr = i2+1
				else
					break
				end
			end

			local word = s:sub(i1, ptr-1)
			tokType    = KEYWORDS[word] and 1 or 2
			tokValue   = word

		-- Directives.
		elseif s:find("^!%a", ptr) then
			ptr = ptr+1

			local i1, i2, word = s:find("^(%a+)", ptr)
			if not DIRECTIVE_WORDS[word] then
				errorInFile(s, path, ptr, "Tokenizer", "Unknown directive '%s'.", word)
			end
			ptr = i2+1

			tokType  = 3
			tokValue = word

		-- Number (float/any).
		elseif s:find("^%.?%d", ptr) then
			local           lua52Hex, isInt, i1, i2, numStr = true,  false, s:find("^(0[Xx]([%dA-Fa-f]*)%.([%dA-Fa-f]+)[Pp]([-+]?[%dA-Fa-f]+))", ptr)
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = true,  false, s:find("^(0[Xx]([%dA-Fa-f]*)%.([%dA-Fa-f]+))",     ptr)  end
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = true,  false, s:find("^(0[Xx]([%dA-Fa-f]+)[Pp]([-+]?[%dA-Fa-f]+))",      ptr)  end
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = false, true,  s:find("^(0[Xx][%dA-Fa-f]+)",          ptr)  end
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = false, false, s:find("^(%d*%.%d+[Ee][-+]?%d+)", ptr)  end
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = false, false, s:find("^(%d*%.%d+)",     ptr)  end
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = false, false, s:find("^(%d+[Ee][-+]?%d+)",      ptr)  end
			if not i1 then  lua52Hex, isInt, i1, i2, numStr = false, true,  s:find("^(%d+)",          ptr)  end

			if not numStr then
				errorInFile(s, path, ptr, "Tokenizer", "Malformed number.")
			end

			local n = tonumber(numStr)

			-- Support hexadecimal floats in Lua 5.1.
			if not n and lua52Hex then
				local               _, intStr, fracStr, expStr = numStr:match("^(0[Xx]([%dA-Fa-f]*)%.([%dA-Fa-f]+)[Pp]([-+]?[%dA-Fa-f]+))")
				if not intStr then  _, intStr, fracStr         = numStr:match("^(0[Xx]([%dA-Fa-f]*)%.([%dA-Fa-f]+))") ; expStr  = "0"  end
				if not intStr then  _, intStr,          expStr = numStr:match("^(0[Xx]([%dA-Fa-f]+)[Pp]([-+]?[%dA-Fa-f]+))")  ; fracStr = ""   end
				assert(intStr, numStr)

				n = tonumber(intStr, 16) or 0 -- intStr may be "".

				local fracValue = 1
				for i = 1, #fracStr do
					fracValue = fracValue / 16
					n         = n + tonumber(fracStr:sub(i, i), 16) * fracValue
				end

				n = n * 2^expStr:gsub("^+", "")
			end

			if not n then
				errorInFile(s, path, ptr, "Tokenizer", "Invalid number.")
			end

			ptr      = i2+1
			tokType  = isInt and 5 or 4
			tokValue = n

		-- String (short-form).
		elseif s:find("^[\"']", ptr) then
			local reprStart = ptr
			local quoteByte = s:byte(ptr)
			local bytes     = {} -- @Speed: Reuse this table for all strings.

			ptr = ptr+1

			while true do
				local byte = s:byte(ptr)

				if not byte then
					errorInFile(s, path, reprStart, "Tokenizer", "Unfinished string.")

				-- End of string.
				elseif byte == quoteByte then
					ptr = ptr+1
					break

				-- Escape sequence.
				elseif byte == 92 then
					ptr  = ptr+1
					byte = s:byte(ptr)

					

					if not byte then
						errorInFile(s, path, reprStart, "Tokenizer", "Unfinished string after escape character.")

					-- \n or \ followed by a newline inserts a newline.
					-- \r inserts a carriage return,
					-- \t inserts a horizontal tab.
					-- \\ inserts a backslash.
					-- \" inserts a quotation mark.
					-- \' inserts an apostrophe.
					elseif byte == 110 then
						byte = 10
						ptr  = ptr+1
					elseif byte == 114 then
						byte = 13
						ptr  = ptr+1
					elseif byte == 116 then
						byte = 9
						ptr  = ptr+1
					elseif
						byte == 92 or byte == 10 or
						byte == 34     or byte == 39
					then
						-- Keep value of 'byte'.
						ptr  = ptr+1

					-- \ddd specifies a byte denoted by one to three decimal digits.
					elseif s:find("^%d", ptr) then
						local numStr = s:match("^%d%d?%d?", ptr)
						byte         = tonumber(numStr)
						if byte > 255 then
							errorInFile(
								s, path, ptr, "Tokenizer",
								"Invalid escape sequence. (Decimal number '%d' does not fit inside a byte.)",
								byte
							)
						end
						ptr = ptr + #numStr

					-- \xXX specifies a byte denoted by two hexadecimal digits.
					elseif s:find("^x[%dA-Fa-f][%dA-Fa-f]", ptr) then
						local hex = s:sub(ptr+1, ptr+2)
						byte      = tonumber(hex, 16)
						ptr       = ptr+3

					-- \u{XXX} inserts the UTF-8 encoding of a Unicode codepoint denoted by a sequence of hexadecimal digits.
					elseif s:find("^u{[%dA-Fa-f]+}", ptr) then
						local hex = s:match("^[%dA-Fa-f]+", ptr+2)
						local cp  = tonumber(hex, 16)
						byte      = nil
						ptr       = ptr + 3 + #hex

						local cpStr = utf8Char(cp)
						for i = 1, #cpStr do
							table.insert(bytes, cpStr:byte(i))
						end

					-- \z skips the following span of whitespace characters.
					elseif byte == 122 then
						local i1, i2 = s:find("^%s*", ptr+1)
						byte = nil
						ptr  = i2+1

					else
						errorInFile(s, path, ptr-1, "Tokenizer", "Invalid escape sequence.")
					end

					if byte then
						table.insert(bytes, byte)
					end

				-- Illegal characters.
				elseif byte == 10 then
					errorInFile(s, path, ptr, "Tokenizer", "Invalid string. (Line breaks must be escaped inside strings.)")

				-- Any other character.
				else
					table.insert(bytes, byte)
					ptr = ptr+1
				end
			end

			tokType  = 6
			tokValue = string.char(unpack(bytes)) -- @Robustness: Make sure this works for very long strings.

		-- String (long-form).
		elseif s:find("^%[=*%[", ptr) then
			local reprStart      = ptr
			local longEqualSigns = s:match("^%[(=*)%[", ptr)

			ptr = ptr + 2 + #longEqualSigns

			local stringPos1 = ptr
			if s:byte(stringPos1) == 10 then
				stringPos1 = stringPos1+1
			end

			local i1, i2 = s:find("%]"..longEqualSigns.."%]", ptr)
			if not i1 then
				errorInFile(s, path, reprStart, "Tokenizer", "Unfinished long string.")
			end
			ptr = i2+1

			local stringPos2 = i1-1

			tokType  = 6
			tokValue = s:sub(stringPos1, stringPos2)

		-- Comment.
		elseif s:find("^%-%-", ptr) then
			local reprStart = ptr
			ptr = ptr+2

			local longEqualSigns = s:match("^%[(=*)%[", ptr)

			-- Single line.
			if not longEqualSigns then
				local i = s:find("\n", ptr)
				ptr     = (i or #s) + 1

			-- Long-form.
			else
				ptr = ptr + 2 + #longEqualSigns

				local i1, i2 = s:find("%]"..longEqualSigns.."%]", ptr)
				if not i1 then
					errorInFile(s, path, reprStart, "Tokenizer", "Unfinished long comment.")
				end
				ptr = i2+1
			end

			-- Don't set tokType - just ignore the comment!

		-- Punctuation.
		elseif
			s:find("^//=",            ptr) or
			s:find("^%.%.=",          ptr) or
			s:find("^%.%.%.",         ptr)
		then
			tokType  = 7
			tokValue = s:sub(ptr, ptr+2)
			ptr      = ptr+3
		elseif
			s:find("^//",             ptr) or
			s:find("^<<",             ptr) or
			s:find("^>>",             ptr) or
			s:find("^%->",            ptr) or
			s:find("^%.%.",           ptr) or
			s:find("^[-+*/%%^=~<>]=", ptr)
		then
			tokType  = 7
			tokValue = s:sub(ptr, ptr+1)
			ptr      = ptr+2
		elseif
			s:find("^[-+*/%%^#<>=(){}[%];:,.|$!]", ptr)
		then
			tokType  = 7
			tokValue = s:sub(ptr, ptr)
			ptr      = ptr+1

		else
			errorInFile(s, path, ptr, "Tokenizer", "Unknown character. (Byte: %d)", s:byte(ptr))
		end

		if tokType then
			tokens.count = tokens.count+1

			tokTypes[tokens.count]      = tokType
			tokValues[tokens.count]     = tokValue
			tokFiles[tokens.count]      = path
			tokPositions1[tokens.count] = tokenPos
			tokPositions2[tokens.count] = ptr-1
			tokLines1[tokens.count]     = ln
		end

		-- ln = ln+countString(tokRepr, "\n", true) -- @Incomplete: Count lines.

		if tokType then
			tokLines2[tokens.count] = ln
			--[[
			printf("%5d %s%s |%s|",
				#tokTypes,
				TOKEN_TYPE_TITLES[tokType],
				(" "):rep(11-#TOKEN_TYPE_TITLES[tokType]),
				tostring(tokValue))
			--]]
		end
	end

	return tokens
end



-- tokenType, tokenValue = getToken( tokens, index )
function _G.getToken(tokens, i)
	return tokens.type[i], tokens.value[i]
end

-- bool = isToken( targetTokenType, targetTokenValue, tokType [, tokValue1, ... ] )
function _G.isToken(targetTokType, targetTokValue, tokType, ...)
	if targetTokType ~= tokType then  return false  end

	local varargCount = select("#", ...)
	if varargCount == 0 then  return true  end

	for i = 1, varargCount do
		if targetTokValue == select(i, ...) then  return true  end
	end

	return false
end

-- Note: Does not detect [] (array literals).
function _G.isTokenLiteral(tokType, tokValue)
	return
		isAny(tokType, 4,5,6)
		or isToken(tokType,tokValue, 1,"true","false","nil")
end

function _G.isTokenBuiltinType(tokType, tokValue)
	--
	-- 'struct' and 'enum' are kinda built-in types, but it's probably necessary to detect those
	-- explicitly everywhere since they cannot be the types of identifiers directly.
	-- We also don't detect '[]' (array literals).
	--
	return
		isToken(tokType,tokValue, 1,"number","int","string","table","bool","type") or
		isToken(tokType,tokValue, 7,"*")
end


      end
do  --[[============================================================
--=
--=  Parser
--=
--=-------------------------------------------------------------
--=
--=  Glóa - a language that compiles into Lua
--=  by Marcus 'ReFreezed' Thunström
--=
--==============================================================

	errorParsing*
	parse*
	printAst

--============================================================]]





_G.ParseState=function()return{fileBuffers={},nextToken=1,soft=false,tokens={}}end








local AstFileScope=function()return{declarations={},nodeType=1,path="",s=0}end

local AstBlock=function()return{nodeType=2,s=0}end

local AstStatement=function()return{nodeType=3,s=0}end

local AstDeclaration=function()return{isConstant=false,isLocal=true,name="",nodeType=4,s=0,tags={}}end

local AstType=function()return{isPlaceholder=false,nodeType=5,s=0,typeName=""}end

local AstAssignment=function()return{expressions={},nodeType=6,operation="",s=0,variables={}}end

local AstIf=function()return{nodeType=7,s=0}end

local AstWhile=function()return{nodeType=8,s=0}end


local FOR_TYPE_TITLES = {"numeric","short","iterator"}

local AstFor=function()return{forType=1,names={},nodeType=9,s=0}end


local AstExpressionWrapper=function()return{nodeType=10,s=0}end
local AstIdentifier=function()return{name="",nodeType=11,s=0}end
local AstLiteral=function()return{literalType=0,nodeType=12,s=0}end
local AstUnary=function()return{nodeType=13,operation="",s=0}end
local AstBinary=function()return{nodeType=14,operation="",s=0}end
local AstTable=function()return{nodeType=15,s=0}end
local AstCall=function()return{couldBeTypeWithParameters=false,isMethod=false,nodeType=16,s=0}end
local AstExpressionList=function()return{nodeType=17,s=0}end
local AstArgument=function()return{autobake=0,isRequired=false,name="",nodeType=18,s=0}end
local AstArguments=function()return{nodeType=19,s=0}end
local AstLambda=function()return{nodeType=20,s=0}end
local AstTypeOf=function()return{nodeType=21,s=0}end
local AstCast=function()return{nodeType=22,s=0}end

_G.AST_NODE_TYPE_NAMES = {"AstFileScope","AstBlock","AstStatement","AstDeclaration","AstType","AstAssignment","AstIf","AstWhile","AstFor","AstExpressionWrapper","AstIdentifier","AstLiteral","AstUnary","AstBinary","AstTable","AstCall","AstExpressionList","AstArgument","AstArguments","AstLambda","AstTypeOf","AstCast"}



local TableField=function()return{}end



local TOKEN_TYPE_TO_LITERAL_TYPE = {[4]=1,[5]=2,[6]=3}



-- node:AstNodeType = astNewNode( state, AstNodeType [, parentNode ] )
do
	local serialN = 0

	function _G.astNewNode(DEBUG_state, AstNodeType, parentNode)
		if not AstNodeType then  error("AstNodeType is nil.", 2)  end

		serialN = serialN+1

		local node  = AstNodeType()
		node.s      = serialN
		node.parent = parentNode

		--[[
		if
			false
			-- or serialN == 22
			or parentNode and parentNode.s == 21
		then
			-- errorParsingLast(DEBUG_state, "DEBUG")
			error("DEBUG")
		end
		--]]

		return node
	end
end



function _G.parseIdentifier(state, parentNode)
	local tokType, tokValue = consumeNextToken(state)
	if tokType ~= 2 then
		if state.soft then return nil end errorParsingLast(state, "Expected an identifier.")
	end

	local ident = astNewNode(state, AstIdentifier, parentNode)
	ident.name  = tokValue

	return ident
end

function _G.parseType(state, parentNode)
	local tokType, tokValue = consumeNextToken(state)

	if isToken(tokType,tokValue, 1,"typeOf") then
		tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,"(") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected '('.")
		end

		local typeOf                      = astNewNode(state, AstTypeOf, parentNode)
		local __value__ =  parseExpression(state, typeOf) if not __value__ then return nil end typeOf.expression  = __value__

		tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,")") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')'.")
		end

		return typeOf

	elseif isToken(tokType,tokValue, 7,"[") then
		local tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,"]") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ']'.")
		end

		local literal                 = astNewNode(state, AstLiteral, parentNode)
		literal.literalType           = 6
		local __value__ =  parseType(state, literal) if not __value__ then return nil end literal.value  = __value__
		return literal
	end

	local isBuiltinType = isTokenBuiltinType(tokType, tokValue)
	local identType

	if isBuiltinType or tokType == 2 then
		identType               = astNewNode(state, AstType, parentNode)
		identType.isPlaceholder = not isBuiltinType
		identType.typeName      = tokValue
	else
		if state.soft then return nil end errorParsingLast(state, "Expected a type.")
	end

	-- User type parameters.
	tokType2, tokValue2 = peekNextToken(state)

	if isToken(tokType2,tokValue2, 7,"(") then
		consumeNextToken(state)

		if isBuiltinType then
			if state.soft then return nil end errorParsingLast(state, "Built-in types have no parameters.")
		end

		local __value__ =  parseExpressionList(state, identType) if not __value__ then return nil end identType.arguments  = __value__

		tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,")") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')'.")
		end
	end

	return identType
end

function _G.parseTable(state, parentNode)
	-- Note: We assume the '{' has been consumed already.

	local tableStartIndex = state.nextToken
	local tableNode       = astNewNode(state, AstTable, parentNode)
	local listIndex       = 0

	while true do
		local tokType, tokValue = peekNextToken(state)

		if not tokType then
			if state.soft then return nil end errorParsing(state, tableStartIndex, "Unfinished table.")
		elseif isToken(tokType,tokValue, 7,"}") then
			consumeNextToken(state)
			break
		end

		local tokType2, tokValue2 = peekNextToken(state, 2)
		local tableField          = TableField()
		local tableKey

		-- [k]=v
		if isToken(tokType,tokValue, 7,"[") then
			consumeNextToken(state)

			local __value__ =  parseExpression(state, tableNode) if not __value__ then return nil end tableKey  = __value__

			tokType, tokValue = consumeNextToken(state)
			if not isToken(tokType,tokValue, 7,"]") then
				if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ']'.")
			end

			tokType, tokValue = consumeNextToken(state)
			if not isToken(tokType,tokValue, 7,"=") then
				if state.soft then return nil end errorParsingAfterPrevious(state, "Expected '='.")
			end

		-- k=v
		elseif
			tokType == 2
			and isToken(tokType2,tokValue2, 7,"=")
		then
			consumeNextToken(state)
			local literal       = astNewNode(state, AstLiteral, tableNode)
			literal.literalType = 3
			literal.value       = tokValue
			tableKey            = literal
			consumeNextToken(state) -- The equal sign.

		-- v
		elseif
			tokType == 2
			or isToken(tokType,tokValue, 7,"(")
			or isTokenLiteral(tokType, tokValue)
		then
			listIndex           = listIndex+1
			local literal       = astNewNode(state, AstLiteral, tableNode)
			literal.literalType = 2
			literal.value       = listIndex
			tableKey            = literal

		else
			if state.soft then return nil end errorParsingNext(state, "Expected a table field.")
		end

		assert(tableKey)

		tableField.key                   = tableKey
		local __value__ =  parseExpression(state, tableNode) if not __value__ then return nil end tableField.value  = __value__

		table.insert(tableNode, tableField)

		tokType, tokValue = consumeNextToken(state)
		if isToken(tokType,tokValue, 7,"}") then
			break
		elseif isToken(tokType,tokValue, 7,",",";") then
			-- void
			-- Note: A trailing comma or semicolon at the end of the arg list is permitted.
		else
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ','.")
		end
	end

	return tableNode
end

-- Parse comma-separated expressions. Used for function calls and struct parameters.
function _G.parseExpressionList(state, parentNode)
	local exprListStartIndex = state.nextToken
	local exprList           = astNewNode(state, AstExpressionList, parentNode)

	while true do
		local __value__ =  parseExpression(state, exprList) if not __value__ then return nil end local expr  = __value__
		table.insert(exprList, expr)

		local tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,",") then
			consumeNextToken(state)
			-- Continue the loop.
		else
			break
		end
	end

	return exprList
end

function _G.parseArguments(state, parentNode, isInput)
	local argsStartIndex = state.nextToken
	local args           = astNewNode(state, AstArguments, parentNode)

	local tokType, tokValue

	while true do
		-- Argument name(s).
		local argGroup = {}

		while true do
			tokType, tokValue = consumeNextToken(state)

			if tokType ~= 2 then
				if state.soft then return nil end errorParsingLast(state, "Expected an identifier.")
			end

			local arg = astNewNode(state, AstArgument, args)
			arg.name  = tokValue
			table.insert(args,     arg)
			table.insert(argGroup, arg)

			tokType, tokValue = consumeNextToken(state)

			if isToken(tokType,tokValue, 7,":") then
				break
			elseif isToken(tokType,tokValue, 7,",") then
				-- Continue the loop.
			else
				if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ':'.")
			end
		end

		-- Type.
		local tokIndex = state.nextToken
		for _, arg in ipairs(argGroup) do
			state.nextToken                  = tokIndex
			local __value__ =  parseType(state, arg) if not __value__ then return nil end arg.argumentType  = __value__		end

		-- Default value.
		tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,"=") then
			consumeNextToken(state)

			local tokIndex = state.nextToken
			for _, arg in ipairs(argGroup) do
				state.nextToken                  = tokIndex
				local __value__ =  parseExpression(state, arg) if not __value__ then return nil end arg.argumentType  = __value__			end
		end

		-- @Incomplete: Set arg.isRequired.
		-- if isInput then
		-- 	arg.isRequired = (arg.defaultValue == nil)
		-- else
		-- 	-- @Incomplete: Set arg.isRequired if there's a !must somewhere closeby.
		-- end

		tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,",") then
			consumeNextToken(state)
			-- Continue the loop.
		else
			break
		end
	end

	return args
end

function _G.parseDeclaration(state, parentNode)
	--[[
	local a = 0        -- Variable, inferred type.
	local b:number = 0 -- Variable, explicit type.
	local c:number     -- Variable, getting a default value.
	local A :: 0       -- Constant, inferred type.
	local B:number : 0 -- Constant, explicit type.
	]]

	local tokType, keyword = consumeNextToken(state)
	assert(tokType == 1, tokType)
	assert(isAny(keyword, "local","global"), keyword)

	local tokType, identName = consumeNextToken(state)
	if tokType ~= 2 then
		if state.soft then return nil end errorParsingLast(state, "Expected identifier.")
	end

	local decl   = astNewNode(state, AstDeclaration, parentNode)
	decl.name    = identName
	decl.isLocal = keyword == "local"

	local tokType, tokValue = peekNextToken(state)

	-- Type is specified and/or we have a constant.
	if isToken(tokType,tokValue, 7,":") then
		consumeNextToken(state)
		local tokType, tokValue = peekNextToken(state)

		-- Inferred type.
		if isToken(tokType,tokValue, 7,":") then
			-- void

			-- @Robustness: Mark the declaration to have it's type inferred instead of just
			-- leaving decl.valueType as nil? Or should we have an AstTypeInferred node?

		-- Specified type.
		else
			local __value__ =  parseType(state, decl) if not __value__ then return nil end decl.valueType  = __value__
		end

	-- We must have = or : after the identifier, for specified or inferred type.
	elseif not isToken(tokType,tokValue, 7,"=") then
		if state.soft then return nil end errorParsingAfterLast(state, "Expected ':' or '='.")
	end

	local tokType, tokValue = peekNextToken(state)

	-- The value.
	if isToken(tokType,tokValue, 7,"=",":") then
		consumeNextToken(state)

		decl.isConstant            = tokValue == ":"
		local __value__ =  parseExpression(state, decl) if not __value__ then return nil end decl.value  = __value__
	end

	return decl
end

function _G.parseAssignment(state, parentNode)
	local assignment = astNewNode(state, AstAssignment, parentNode)

	while true do
		local __value__ =  parseIdentifier(state, parentNode) if not __value__ then return nil end local ident  = __value__
		table.insert(assignment.variables, ident)

		local tokType, tokValue = consumeNextToken(state, steps)

		if isToken(tokType,tokValue, 7,",") then
			-- Continue the loop.
		elseif isToken(tokType,tokValue, 7,"=","+=","-=","*=","/=","//=","^=","%=","..=") then
			assignment.operation = tokValue
			break
		else
			if state.soft then return nil end errorParsingLast(state, "Expected '='.")
		end
	end

	while true do
		local __value__ =  parseExpression(state, assignment) if not __value__ then return nil end local expr  = __value__
		table.insert(assignment.expressions, expr)

		tokType, tokValue = peekNextToken(state, steps)

		if isToken(tokType,tokValue, 7,",") then
			consumeNextToken(state)
			-- Continue the loop.
		else
			break
		end
	end

	return assignment
end

local function isAtAssignment(state)
	local steps = 1

	-- @Incomplete: Detect (expression1).key1, (expression2).key2 = ...

	while true do
		local tokType, tokValue = peekNextToken(state, steps)
		if tokType ~= 2 then  return false  end

		steps             = steps+1
		tokType, tokValue = peekNextToken(state, steps)

		if isToken(tokType,tokValue, 7,",") then
			steps = steps+1
			-- Continue the loop.
			-- @Cleanup: Do we need to keep checking the following tokens? Can any other statement start with 'IDENT' ','
		else
			return isToken(tokType,tokValue, 7,"=","+=","-=","*=","/=","//=","^=","%=","..=")
		end
	end
end

-- Add the names to the 'names' array.
-- success = parseNameList( state, parentNode, names )
function _G.parseNameList(state, parentNode, names)
	while true do
		local ident = parseIdentifier(state, parentNode)
		if not ident then  return false  end

		table.insert(names, ident)
		local tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,",") then
			consumeNextToken(state)
			-- Continue the loop.
		else
			break
		end
	end

	return true
end

function _G.parseStatementInImperativeScope(state, block)
	local statementStartIndex = state.nextToken
	local statement           = astNewNode(state, AstStatement, block)

	local tokType,  tokValue  = peekNextToken(state, 1)
	local tokType2, tokValue2 = peekNextToken(state, 2)
	local tokType3, tokValue3 = peekNextToken(state, 3)
	local tokType4, tokValue4 = peekNextToken(state, 4)

	if isToken(tokType,tokValue, 1,"local","global") then
		local __value__ =  parseDeclaration(state, statement) if not __value__ then return nil end statement.what  = __value__

	elseif isAtAssignment(state) then
		local __value__ =  parseAssignment(state, statement) if not __value__ then return nil end statement.what  = __value__

	elseif tokType == 2 and (
			isToken(tokType2,tokValue2, 7,"(")
			-- or isToken(tokType2,tokValue2, !(TOKEN_TYPE_PUNCTUATION),"{")
			-- or tokType2 == !(TOKEN_TYPE_STRING)
		)
	then
		local __value__ =  parseCall(state, statement, false) if not __value__ then return nil end statement.what  = __value__

	elseif isToken(tokType,tokValue, 1,"if") and (
		isToken(tokType2,tokValue2, 3,"complete")
		or (
			isToken(tokType2,tokValue2, 2)
			and isToken(tokType3,tokValue3, 7,"==")
			and isToken(tokType4,tokValue4, 7,"{")
		)
	) then
		if state.soft then return nil end errorParsingNext(state, "@Incomplete: if x == {case...}")

	elseif isToken(tokType,tokValue, 1,"if") then
		consumeNextToken(state)

		local ifBranch                      = astNewNode(state, AstIf, statement)
		local __value__ =  parseExpression(state, ifBranch) if not __value__ then return nil end ifBranch.condition   = __value__
		local __value__ =  parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement(state, ifBranch) if not __value__ then return nil end ifBranch.branchTrue  = __value__
		statement.what                      = ifBranch

		while true do
			tokType, tokValue = peekNextToken(state)

			if isToken(tokType,tokValue, 1,"elseif") then
				consumeNextToken(state)
				-- Continue.
			else
				break
			end

			local ifBranchElse                      = astNewNode(state, AstIf, ifBranch)
			local __value__ =  parseExpression(state, ifBranchElse) if not __value__ then return nil end ifBranchElse.condition   = __value__
			local __value__ =  parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement(state, ifBranchElse) if not __value__ then return nil end ifBranchElse.branchTrue  = __value__

			ifBranch.branchFalse = ifBranchElse
			ifBranch             = ifBranchElse
		end

		if isToken(tokType,tokValue, 1,"else") then
			consumeNextToken(state)
			local __value__ =  parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement(state, ifBranch) if not __value__ then return nil end ifBranch.branchFalse  = __value__
		end

	elseif isToken(tokType,tokValue, 1,"while") then
		consumeNextToken(state)

		local whileLoop                     = astNewNode(state, AstWhile, statement)
		local __value__ =  parseExpression(state, whileLoop) if not __value__ then return nil end whileLoop.condition  = __value__
		local __value__ =  parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement(state, whileLoop) if not __value__ then return nil end whileLoop.body       = __value__
		statement.what                      = whileLoop

	elseif isToken(tokType,tokValue, 1,"for") then
		consumeNextToken(state)

		local forStartIndex = state.nextToken
		local forLoop       = astNewNode(state, AstFor, statement)

		local __value__ =  parseExpressionList(state, forLoop) if not __value__ then return nil end local exprListWeMayOrMayNotUse  = __value__

		tokType, tokValue = peekNextToken(state)
		local twoParter

		-- FOR_TYPE_ITERATOR  for v1, ... in iter [, state [, init ] ]
		if isToken(tokType,tokValue, 1,"in") then
			forLoop.forType = 3
		-- FOR_TYPE_SHORT  for v1, ... : obj
		elseif isToken(tokType,tokValue, 7,":") then
			forLoop.forType = 2
			twoParter       = true
		-- FOR_TYPE_NUMERIC  for start, end [, step ]
		elseif #exprListWeMayOrMayNotUse >= 2 then -- If more than 3 arguments are specified then we'll get an error later.
			forLoop.forType = 1
			twoParter       = false
		-- FOR_TYPE_NUMERIC  for i = start, end [, step ]
		elseif #exprListWeMayOrMayNotUse == 1 and isToken(tokType,tokValue, 7,"=") then
			forLoop.forType = 1
			twoParter       = true
		-- FOR_TYPE_SHORT  for obj
		elseif #exprListWeMayOrMayNotUse == 1 then
			forLoop.forType = 2
			twoParter       = false
		else
			state.nextToken = forStartIndex
			if state.soft then return nil end errorParsingNext(state, "Could not determine what kind of 'for' statement this is.")
		end

		if forLoop.forType == 1 then
			local paramStartIndex

			-- for i = start, end [, step ]
			if twoParter then
				state.nextToken = forStartIndex
				if not (parseNameList(state, forLoop, forLoop.names)) then return nil end

				assert(#forLoop.names == 1)

				tokType, tokValue = consumeNextToken(state) -- Should eat the '='.
				assert(isToken(tokType,tokValue, 7,"="))

				paramStartIndex                     = state.nextToken
				local __value__ =  parseExpressionList(state, forLoop) if not __value__ then return nil end forLoop.expressions  = __value__

			-- for start, end [, step ]
			else
				paramStartIndex     = state.nextToken
				forLoop.expressions = exprListWeMayOrMayNotUse

				-- Is this name generation really necessay? For the other 'for' loop paths we don't generate names (yet).
				local ident = astNewNode(state, AstIdentifier, forLoop)
				ident.name  = "it"
				table.insert(forLoop.names, ident)
			end

			if #forLoop.expressions < 2 then
				if state.soft then return nil end errorParsingAfterLast(state, "Expected 2 or 3 parameters for the numeric 'for' loop.")

			elseif #forLoop.expressions > 3 then
				-- Navigate back to the actual error position.
				state.nextToken = paramStartIndex
				tokType, tokValue = parseExpression(state)
				consumeNextToken(state) -- ','
				tokType, tokValue = parseExpression(state)
				consumeNextToken(state) -- ','
				tokType, tokValue = parseExpression(state)

				if state.soft then return nil end errorParsingNext(state, "Expected 2 or 3 parameters for the numeric 'for' loop.")
			end

		elseif forLoop.forType == 2 then
			-- for v1, ... : obj
			if twoParter then
				state.nextToken = forStartIndex
				if not (parseNameList(state, forLoop, forLoop.names)) then return nil end

				tokType, tokValue = consumeNextToken(state) -- Should eat the ':'.

				local i = state.nextToken
				assert(isToken(tokType,tokValue, 7,":"))

				local __value__ =  parseExpressionList(state, forLoop) if not __value__ then return nil end local exprList  = __value__

				if #exprList > 1 then
					-- Navigate back to the actual error position.
					state.nextToken = i
					parseExpression(state)
					if state.soft then return nil end errorParsingNext(state, "Expected a single parameter for the short-form 'for' loop.")
				end

				forLoop.expressions = exprList

				-- @Incomplete: Generate 'itIndex' name for arrays (and more?) if necessary (when types are figured out).

			-- for obj
			else
				forLoop.expressions = exprListWeMayOrMayNotUse
				assert(#forLoop.expressions == 1)

				-- @Incomplete: Generate 'it' and 'itIndex' names for arrays (and more?) if necessary (when types are figured out).
			end

		-- for v1, ... in iter [, state [, init ] ]
		else
			state.nextToken = forStartIndex
			if not (parseNameList(state, forLoop, forLoop.names)) then return nil end

			tokType, tokValue = consumeNextToken(state) -- Should eat the 'in'.
			assert(isToken(tokType,tokValue, 1,"in"))

			local __value__ =  parseExpressionList(state, forLoop) if not __value__ then return nil end forLoop.expressions  = __value__
		end

		local __value__ =  parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement(state, forLoop, true) if not __value__ then return nil end forLoop.body  = __value__
		statement.what               = forLoop

	-- Table lookup ending in a function call.
	-- Note: We must detect assignments before this!
	elseif
		(
			tokType == 2
			and isToken(tokType2,tokValue2, 7,".")
		)
		or isToken(tokType,tokValue, 7,"(")
	then
		local __value__ =  parseExpression(state, statement) if not __value__ then return nil end local expr  = __value__

		if not (expr.nodeType == 16) then
			if state.soft then return nil end errorParsing(state, statementStartIndex, "Expected the statement to end in a function call.")
		end

		statement.what = expr

	else
		if state.soft then return nil end errorParsingNext(state, "Unexpected token at the start of a new statement.")
	end

	tokType, tokValue = peekNextToken(state)
	if isToken(tokType,tokValue, 7,";") then
		consumeNextToken(state)
	end

	return statement
end

function _G.parseBlock(state, parentNode)
	-- Note: We assume the '{' has been consumed already.

	local blockStartIndex = state.nextToken
	local block           = astNewNode(state, AstBlock, parentNode)

	while true do
		local tokType, tokValue = peekNextToken(state)

		if not tokType then
			if state.soft then return nil end errorParsing(state, blockStartIndex, "Unfinished block.")

		elseif isToken(tokType,tokValue, 7,"}") then
			consumeNextToken(state)
			break

		elseif isToken(tokType,tokValue, 7,";") then
			if state.soft then return nil end errorParsingNext(state, "Statement is empty.")

		else
			local __value__ =  parseStatementInImperativeScope(state, block) if not __value__ then return nil end local statement  = __value__
			table.insert(block, statement)
		end
	end

	return block
end

-- node = parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement( state, parentNode [, requireBlock=false ] )
function _G.parseBlockOrScopedStatementOrUnwrappedNonPolutingStatement(state, parentNode, requireBlock)
	tokType, tokValue = peekNextToken(state)

	if isToken(tokType,tokValue, 7,"{") then
		consumeNextToken(state)
		return parseBlock(state, parentNode) -- May return nil.
	end

	local __value__ =  parseStatementInImperativeScope(state, parentNode) if not __value__ then return nil end local statement  = __value__

	-- We only need to wrap declarations and 'for' bodies in a block (I think).
	if requireBlock or statement.what.nodeType == 4 then
		local block = astNewNode(state, AstBlock, parentNode)
		table.insert(block, statement)

		statement.parent = block
		return block
	end

	-- Is it ok to strip the statement like this? @Robustness?
	statement.what.parent = parentNode
	return statement.what
end

function _G.parseFileScope(state, path, parentNode)
	local fileScope = astNewNode(state, AstFileScope, parentNode)
	fileScope.path  = path

	while true do
		local tokType, tokValue = peekNextToken(state)

		if not tokType then
			break

		elseif isToken(tokType,tokValue, 1,"local","global") then
			local __value__ =  parseDeclaration(state, fileScope) if not __value__ then return nil end local decl  = __value__
			table.insert(fileScope.declarations, decl)

		elseif isToken(tokType,tokValue, 1,"export","use","useLibrary") then
			if state.soft then return nil end errorParsingNext(state, "@Incomplete: Handle '%s'.", tokValue)

		else
			if state.soft then return nil end errorParsingNext(state, "Expected file level declaration.")
		end
	end

	return fileScope
end

-- call = parseCall( state, parentNode, couldBeType [, callee=theFollowingIdentifier, isMethod=false ] )
function _G.parseCall(state, parentNode, couldBeType, callee, isMethod)
	assert(type(state)       == "table")
	assert(type(parentNode)  == "table")
	assert(type(couldBeType) == "boolean")

	if not callee then
		local __value__ =  parseIdentifier(state) if not __value__ then return nil end callee  = __value__	end

	isMethod = isMethod or false
	local call

	while true do
		local tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,"(") then
			if state.soft then return nil end errorParsingLast(state, "Expected '('.")
		end

		call              = astNewNode(state, AstCall, parentNode)
		tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,")") then
			consumeNextToken(state)

			-- Should struct arguments be able to have default values, allowing foo()
			-- to possibly be a type?
			couldBeType = false

			-- We're likely to insert default values and iterate over this etc. so
			-- it's best to not leave it nil.
			call.arguments = astNewNode(state, AstExpressionList, call)

		else
			local __value__ =  parseExpressionList(state, call) if not __value__ then return nil end call.arguments  = __value__

			tokType, tokValue = consumeNextToken(state)
			if not isToken(tokType,tokValue, 7,")") then
				if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')' or ','.")
			end
		end

		call.couldBeTypeWithParameters = couldBeType

		callee.parent = call
		call.callee   = callee
		call.isMethod = isMethod

		tokType, tokValue = peekNextToken(state)
		if not isToken(tokType,tokValue, 7,"(") then  break  end

		call.couldBeTypeWithParameters = false
		callee   = call
		isMethod = false
	end

	return call
end



-- expression = parseExpression( state, parentNode [, minOperatorPrecedence ] )
function _G.parseExpression(state, parentNode, minOpPrecedence)
	-- @Robustness: Check that parents are set correctly everywhere in here.

	minOpPrecedence = minOpPrecedence or 0

	local tokType,  tokValue, exprStartIndex = consumeNextToken(state)
	local tokType2, tokValue2                = peekNextToken(state, 1)
	local tokType3, tokValue3                = peekNextToken(state, 2)
	local expr

	-- Function call or type with parameters.
	--
	-- Note: We also detect function calls later by the binary operations.
	-- The difference is that here we may have a type.
	--
	if
		tokType == 2
		and isToken(tokType2,tokValue2, 7,"(")
	then
		putBackLastToken(state)
		local __value__ =  parseCall(state, parentNode, true) if not __value__ then return nil end expr  = __value__

	-- Built-in type.
	elseif isTokenBuiltinType(tokType, tokValue) then
		local identType    = astNewNode(state, AstType, parentNode)
		identType.typeName = tokValue
		expr               = identType

		-- @Incomplete: Check if there's a '(' after this and give error early.

	-- Identifier or literal.
	elseif tokType == 2 or isTokenLiteral(tokType, tokValue) then
		if tokType == 2 then
			local ident = astNewNode(state, AstIdentifier, parentNode)
			ident.name  = tokValue
			expr        = ident

		elseif tokType == 1 then
			local literal = astNewNode(state, AstLiteral, parentNode)

			if tokValue == "nil" then
				literal.literalType = 5
				literal.value       = nil
			else
				literal.literalType = 4
				literal.value       = tokValue == "true"
			end

			expr = literal

		else
			local literal       = astNewNode(state, AstLiteral, parentNode)
			literal.literalType = TOKEN_TYPE_TO_LITERAL_TYPE[tokType]
			literal.value       = tokValue
			expr                = literal
		end

	-- Table constructor.
	elseif isToken(tokType,tokValue, 7,"{") then
		local __value__ =  parseTable(state, parentNode) if not __value__ then return nil end expr  = __value__

	-- Unary operation.
	elseif
		isToken(tokType,tokValue, 7,"+","-","#") or
		isToken(tokType,tokValue, 1,"not")
	then
		local unaryOp                      = astNewNode(state, AstUnary, parentNode)
		unaryOp.operation                  = tokValue
		local __value__ =  parseExpression(state, unaryOp, OPERATOR_PRECEDENCE.unary) if not __value__ then return nil end unaryOp.expression  = __value__
		expr                               = unaryOp

	-- Function signature (type) or lambda.
	--
	--     inArgs [-> outArgs] [body]
	--
	--     inArgs  = ( [ inName1:inType1, ... ] )
	--     outArgs = void
	--     outArgs = outType1 [, ... ]
	--     outArgs = ( outName1:outType1 [, ... ] )
	--     body    = { ... }
	--
	elseif
		isToken(tokType,tokValue, 7,"(")
		and (
			isToken(tokType2,tokValue2, 7,")")
			or (
				isToken(tokType2,tokValue2, 2)
				and isToken(tokType3,tokValue3, 7,":",",")
			)
		)
	then
		local lambda = astNewNode(state, AstLambda, parentNode)

		-- In args.
		tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,")") then
			consumeNextToken(state)

		else
			local __value__ =  parseArguments(state, lambda, true) if not __value__ then return nil end lambda.argumentsIn  = __value__

			tokType, tokValue = consumeNextToken(state)
			if not isToken(tokType,tokValue, 7,")") then
				if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')'.")
			end
		end

		-- Out args.
		tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,"->") then
			consumeNextToken(state)

			tokType, tokValue = peekNextToken(state)

			-- () -> void
			if isToken(tokType,tokValue, 1,"void") then
				consumeNextToken(state)

				tokType, tokValue = peekNextToken(state)
				if isToken(tokType,tokValue, 7,",") then
					if state.soft then return nil end errorParsingNext(state, "Argument list with 'void' cannot have other arguments.")
				end

			-- () -> (name:type, ...)
			elseif isToken(tokType,tokValue, 7,"(") then
				consumeNextToken(state)

				local __value__ =  parseArguments(state, lambda, false) if not __value__ then return nil end lambda.argumentsOut  = __value__

				tokType, tokValue = consumeNextToken(state)
				if not isToken(tokType,tokValue, 7,")") then
					if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')'.")
				end

			-- () -> type, ...
			else
				local args          = astNewNode(state, AstArguments, lambda)
				lambda.argumentsOut = args

				while true do
					local arg                        = astNewNode(state, AstArgument, args)
					local __value__ =  parseType(state, arg) if not __value__ then return nil end arg.argumentType  = __value__

					tokType, tokValue = peekNextToken(state)
					if isToken(tokType,tokValue, 7,",") then
						consumeNextToken(state)
					else
						break
					end
				end
			end
		end

		-- Body.
		tokType, tokValue = peekNextToken(state)

		if isToken(tokType,tokValue, 7,"{") then
			consumeNextToken(state)

			local __value__ =  parseBlock(state, lambda) if not __value__ then return nil end lambda.body  = __value__
			expr                        = lambda

		else
			local identType             = astNewNode(state, AstType, parentNode)
			identType.isPlaceholder     = true
			identType.functionSignature = lambda
			expr                        = identType
		end

	-- Parenthesis.
	elseif isToken(tokType,tokValue, 7,"(") then
		local __value__ =  parseExpression(state, parentNode) if not __value__ then return nil end expr  = __value__

		tokType, tokValue = consumeNextToken(state)

		if not isToken(tokType,tokValue, 7,")") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')'.")
		end

	-- Type.
	elseif isToken(tokType,tokValue, 3,"type") then
		-- Note: parseType() does not recognize !type which is why you can't put
		-- the directive anywhere a type is expected. Should we change this?
		local __value__ =  parseType(state, parentNode) if not __value__ then return nil end expr  = __value__

	elseif
		isToken(tokType,tokValue, 1,"typeOf") or
		isToken(tokType,tokValue, 7,"[")
	then
		putBackLastToken(state)
		local __value__ =  parseType(state, parentNode) if not __value__ then return nil end expr  = __value__

	-- Cast.
	elseif isToken(tokType,tokValue, 1,"cast") then
		tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,"(") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected '('.")
		end

		local cast                      = astNewNode(state, AstCast, parentNode)
		local __value__ =  parseType(state, cast) if not __value__ then return nil end cast.targetType  = __value__

		tokType, tokValue = consumeNextToken(state)
		if not isToken(tokType,tokValue, 7,")") then
			if state.soft then return nil end errorParsingAfterPrevious(state, "Expected ')'.")
		end

		local __value__ =  parseExpression(state, cast, math.huge) if not __value__ then return nil end cast.expression  = __value__		expr                            = cast

	else
		print(LITERAL_TYPE_TITLES[tokType], tokValue)
		if state.soft then return nil end errorParsingLast(state, "Expected a value.")
	end

	-- Binary operations.
	local nextCanBeMethodCall = false

	while true do
		tokType,  tokValue  = peekNextToken(state, 1)
		tokType2, tokValue2 = peekNextToken(state, 2)

		local thisCanBeMethodCall = nextCanBeMethodCall
		nextCanBeMethodCall       = false

		if not tokType then
			break

		-- Arithmetic opration, comparison or string concatination.
		-- @Incomplete: Combine string concatinations into an AstExpressionList.
		elseif (
			isToken(tokType,tokValue, 1,"and","or")
			or isToken(tokType,tokValue, 7,
				"+","-","*","/","//","^","%","<",">","<=",">=","==","~=",".."
			)
		) and OPERATOR_PRECEDENCE[tokValue] >= minOpPrecedence then
			consumeNextToken(state)

			local binOp                 = astNewNode(state, AstBinary, parentNode)
			binOp.operation             = tokValue
			binOp.left                  = expr
			local __value__ =  parseExpression(state, binOp, OPERATOR_PRECEDENCE[tokValue]) if not __value__ then return nil end binOp.right  = __value__
			expr.parent                 = binOp
			expr                        = binOp

		-- Table lookup or similar using '.'.
		elseif
			isToken(tokType,tokValue, 7,".")
			and OPERATOR_PRECEDENCE[tokValue] > minOpPrecedence -- Note: Not using >= here.
		then
			consumeNextToken(state)

			local binOp     = astNewNode(state, AstBinary, parentNode)
			binOp.operation = tokValue

			tokType, tokValue = consumeNextToken(state)
			if tokType ~= 2 then
				if state.soft then return nil end errorParsingLast(state, "Expected an identifier.")
			end

			local literal       = astNewNode(state, AstLiteral, binOp)
			literal.literalType = 3
			literal.value       = tokValue

			binOp.left          = expr
			binOp.right         = literal

			expr.parent         = binOp
			expr                = binOp

			nextCanBeMethodCall = true

		-- Table lookup or similar using '['.
		elseif
			isToken(tokType,tokValue, 7,"[")
			and OPERATOR_PRECEDENCE["."] > minOpPrecedence -- Note: Not using >= here.
		then
			consumeNextToken(state)

			local binOp                 = astNewNode(state, AstBinary, parentNode)
			binOp.operation             = tokValue
			binOp.left                  = expr
			local __value__ =  parseExpression(state, binOp, OPERATOR_PRECEDENCE[tokValue]) if not __value__ then return nil end binOp.right  = __value__

			tokType, tokValue = consumeNextToken(state)
			if not isToken(tokType,tokValue, 7, "]") then
				if state.soft then return nil end errorParsingLast(state, "Expected ']'.")
			end

			expr.parent = binOp
			expr        = binOp

		-- Function call.
		elseif
			isToken(tokType,tokValue, 7,"(")
			and OPERATOR_PRECEDENCE.call >= minOpPrecedence
		then
			local __value__ =  parseCall(state, parentNode, false, expr, false) if not __value__ then return nil end expr  = __value__

		-- Method call.
		elseif
			(
				isToken(tokType,tokValue, 7,"!")
				and isToken(tokType2,tokValue2, 7,"(")
			)
			and OPERATOR_PRECEDENCE.call >= minOpPrecedence
		then
			tokType, tokValue = peekLastToken(state)

			if not isToken(tokType,tokValue, 2) then
				if state.soft then return nil end errorParsingNext(state, "Expected a method name before this.")
			elseif not thisCanBeMethodCall then
				putBackLastToken(state)
				if state.soft then return nil end errorParsingNext(state, "Expected an object to call a method on.")
			end

			consumeNextToken(state)
			local __value__ =  parseCall(state, parentNode, false, expr, true) if not __value__ then return nil end expr  = __value__

		else
			break
		end
	end

	return expr
end



-- tokenType, tokenValue, tokenIndex = consumeNextToken( parseState )
function _G.consumeNextToken(state)
	local i         = state.nextToken
	state.nextToken = i+1
	local tokType, tokValue = getToken(state.tokens, i)
	return tokType, tokValue, i
end

-- tokenType, tokenValue = peekNextToken( state [, steps=1 ] )
function _G.peekNextToken(state, steps)
	steps   = steps or 1
	local i = state.nextToken+steps-1
	return getToken(state.tokens, i)
end

function _G.peekLastToken(state)
	return getToken(state.tokens, state.nextToken-1)
end

function _G.putBackLastToken(state)
	state.nextToken = state.nextToken-1
	assert(state.nextToken >= 1)
end



do
	-- errorParsing( parseState, tokenIndex, formatString, ... )
	function _G.errorParsing(state, i, s, ...)
		local tokens = state.tokens

		local path
			=  tokens.file[i]
			or tokens.file[1] -- Not great, but better than crashing.
			or errorInternal(2, "No tokens.")

		local buffer = state.fileBuffers[path] or errorInternal("No file buffer for '%s'.", path)

		local ptr
			=  tokens.position1[i]
			or i <= 1 and 1
			or tokens.count > 0 and tokens.position2[tokens.count]+1
			or #buffer

		errorInFile(buffer, path, ptr, "Parser", s, ...)
	end

	-- errorParsingAfter( parseState, tokenIndex, formatString, ... )
	function _G.errorParsingAfter(state, i, s, ...)
		local tokens = state.tokens

		local path
			=  tokens.file[i]
			or tokens.file[1] -- Not great, but better than crashing.
			or errorInternal(2, "No tokens.")

		local buffer = state.fileBuffers[path] or errorInternal("No file buffer for '%s'.", path)

		local ptr
			=  tokens.position2[i] and tokens.position2[i]+1
			or i <= 1 and 1
			or tokens.count > 0 and tokens.position2[tokens.count]+1
			or #buffer

		errorInFile(buffer, path, ptr, "Parser", s, ...)
	end

	function _G.errorParsingLast(state, ...)
		errorParsing(state, state.nextToken-1, ...)
	end
	function _G.errorParsingNext(state, ...)
		errorParsing(state, state.nextToken, ...)
	end

	function _G.errorParsingAfterPrevious(state, ...)
		errorParsingAfter(state, state.nextToken-2, ...)
	end
	function _G.errorParsingAfterLast(state, ...)
		errorParsingAfter(state, state.nextToken-1, ...)
	end
end



-- printAst( node [, fileToPrintTo=io.stdout ] )
do
	local file

	local function write(...)
		file:write(...)
	end

	local function printNode(node, indent, printed, keyName)
		
		

		local indentStr = ("\t"):rep(indent)

		write(indentStr)
		if keyName then  write(keyName, " ")  end
		write(AST_NODE_TYPE_NAMES[node.nodeType] or "?")
		write(" @", node.s)
		if node.parent then  write(" ^", node.parent.s)  end

		if printed[node] then
			write("  !!! ERROR: RECURSION DETECTED !!!\n")
		else
			printed[node] = true

			if node.nodeType == 11 then
				local ident = node
				write(" (", ident.name, ")\n")

			elseif node.nodeType == 14 then
				local binOp = node
				write(" (", binOp.operation, ")")
				
				write("\n")
				if binOp.left  then  printNode(binOp.left,  indent+1, printed)  end
				write(indentStr, "\top ", binOp.operation, "\n")
				if binOp.right then  printNode(binOp.right, indent+1, printed)  end
				

			elseif node.nodeType == 13 then
				local unaryOp = node
				write(" (", unaryOp.operation, ")")
				
				write("\n")
				if unaryOp.expression then  printNode(unaryOp.expression, indent+1, printed)  end
				

			elseif node.nodeType == 4 then
				local decl = node
				write(" (")
				if decl.isConstant then  write("CONST ")  end
				write(decl.name ~= "" and decl.name or "-")
				write(")")
				
				write("\n")
				if decl.valueType then  printNode(decl.valueType, indent+1, printed, "TYPE")  end
				if decl.value     then  printNode(decl.value,     indent+1, printed, "VAL")  end
				

			elseif node.nodeType == 15 then
				local tableNode = node
				
				write("\n")
				for i, tableField in ipairs(tableNode) do
					if tableField.key   then  printNode(tableField.key,   indent+1, printed, i.."K")  end
					if tableField.value then  printNode(tableField.value, indent+1, printed, i.."V")  end
				end
				

			elseif node.nodeType == 16 then
				local call = node
				assert(not (call.couldBeTypeWithParameters and call.isMethod))
				if call.couldBeTypeWithParameters then  write(" (couldBeType)")  end
				if call.isMethod                  then  write(" (method)")       end
				
				write("\n")
				if call.callee    then  printNode(call.callee,    indent+1, printed)  end
				if call.arguments then  printNode(call.arguments, indent+1, printed)  end
				

			elseif node.nodeType == 20 then
				local lambda = node
				
				write("\n")
				if lambda.argumentsIn then
					for i, arg in ipairs(lambda.argumentsIn) do
						printNode(arg, indent+1, printed, "IN"..i)
					end
				end
				if lambda.argumentsOut then
					for i, arg in ipairs(lambda.argumentsOut) do
						printNode(arg, indent+1, printed, "OUT"..i)
					end
				end
				if lambda.body then
					printNode(lambda.body, indent+1, printed)
				end
				

			elseif node.nodeType == 18 then
				local arg = node
				if arg.name ~= "" then  write(" (", arg.name, ")")  end
				
				write("\n")
				if arg.argumentType  then  printNode(arg.argumentType,  indent+1, printed)              end
				if arg.defaultValue  then  printNode(arg.defaultValue,  indent+1, printed, "DEFAULT")   end
				

			elseif node.nodeType == 17 then
				local exprList = node
				
				write("\n")
				for i, expr in ipairs(exprList) do
					printNode(expr, indent+1, printed, i)
				end
				

			elseif node.nodeType == 2 then
				local block = node
				
				write("\n")
				for i, statement in ipairs(block) do
					printNode(statement, indent+1, printed)
				end
				

			elseif node.nodeType == 3 then
				local statement = node
				
				write("\n")
				if statement.what then  printNode(statement.what, indent+1, printed)  end
				

			elseif node.nodeType == 5 then
				local identType = node
				if identType.typeName ~= "" then  write(" (", identType.typeName, ")")  end
				
				write("\n")
				if identType.functionSignature then
					printNode(identType.functionSignature, indent+1, printed)
				elseif identType.arguments then
					printNode(identType.arguments, indent+1, printed)
				end
				

			elseif node.nodeType == 21 then
				local typeOf = node
				
				write("\n")
				if typeOf.expression then  printNode(typeOf.expression, indent+1, printed)  end
				

			elseif node.nodeType == 6 then
				local assignment = node
				
				write("\n")
				for i, identifier in ipairs(assignment.variables) do
					printNode(identifier, indent+1, printed, "VAR"..i)
				end
				write(indentStr, "\top ", assignment.operation, "\n")
				for i, expr in ipairs(assignment.expressions) do
					printNode(expr, indent+1, printed, "VAL"..i)
				end
				

			elseif node.nodeType == 22 then
				local cast = node
				
				write("\n")
				if cast.targetType then  printNode(cast.targetType, indent+1, printed)  end
				if cast.expression then  printNode(cast.expression, indent+1, printed)  end
				

			elseif node.nodeType == 7 then
				local ifBranch = node
				
				write("\n")
				if ifBranch.condition   then  printNode(ifBranch.condition,   indent+1, printed)           end
				if ifBranch.branchTrue  then  printNode(ifBranch.branchTrue,  indent+1, printed, "TRUE")   end
				if ifBranch.branchFalse then  printNode(ifBranch.branchFalse, indent+1, printed, "FALSE")  end
				

			elseif node.nodeType == 8 then
				local whileLoop = node
				
				write("\n")
				if whileLoop.condition then  printNode(whileLoop.condition, indent+1, printed)  end
				if whileLoop.body      then  printNode(whileLoop.body,      indent+1, printed)  end
				

			elseif node.nodeType == 9 then
				local forLoop = node
				write(" (", FOR_TYPE_TITLES[forLoop.forType], ")")
				
				write("\n")
				for i, ident in ipairs(forLoop.names) do
					printNode(ident, indent+1, printed, "NAME"..i)
				end
				if forLoop.expressions then  printNode(forLoop.expressions, indent+1, printed)  end
				if forLoop.body        then  printNode(forLoop.body,        indent+1, printed)  end
				

			elseif node.nodeType == 10 then
				local wrapper = node
				
				write("\n")
				printNode(wrapper, indent+1, printed)
				

			elseif node.nodeType == 12 then
				local literal = node

				if literal.literalType == 6 then
					write(" (array)")
					
					write("\n")
					printNode(literal.value, indent+1, printed)
					

				else
					write(" (")

					if isAny(literal.literalType, 4,5) then
						write(tostring(literal.value))

					else
						
						local vStr = tostring(literal.value):sub(1, 100)

						vStr = vStr:gsub(".", function(c)
							local byte = c:byte()
							return
								byte == 10   and "{NL}"  or
								byte == 13   and "{CR}"  or
								byte == 9   and "{TAB}" or
								byte >= 32 and byte <= 126 and c       or -- Printable ASCII characters.
								"?"
						end)

						write(LITERAL_TYPE_TITLES[literal.literalType])

						if literal.literalType == 3 then
							write("(", #literal.value, ")")
						end

						if vStr ~= "" then  write(": ", vStr:sub(1, 100))  end
					end

					write(")\n")
				end

			elseif node.declarations then
				if node.nodeType == 1 then
					local fileScope = node
					write(" (", fileScope.path, ")")
				end

				
				write("\n")
				for i, decl in ipairs(node.declarations) do
					printNode(decl, indent+1, printed)
				end
				

			else
				write("\n")
			end
		end
	end

	function _G.printAst(node, _file)
		file = _file or io.stdout
		printNode(node, 0, {})
	end
end


     end



print()
print("-------- Glóa --------")
print(os.date"%Y-%m-%d %H:%M:%S")



-- Parse arguments.
local args = {...}
print("Args: "..table.concat(args, " "))

args[1] = args[1] or "--help"

local parseOptions   = true
local pathsToCompile = {}
local disableGc      = false
local i              = 1

while args[i] do
	local arg = args[i]

	if not (parseOptions and arg:find"^%-") then
		table.insert(pathsToCompile, arg)
		i = i+1

	elseif arg == "--" then
		parseOptions = false
		i            = i+1

	elseif arg == "--help" or arg == "-help" or arg == "-?" or arg == "/help" or arg == "/?" then
		print("@Incomplete: Help text.")
		return

	elseif arg == "--nogc" then
		disableGc = true
		i = i+1

	else
		errorLine(nil, "Unknown option '%s'.", arg)
	end
end

print("Files: "..table.concat(pathsToCompile, ", "))
if disableGc then
	print("Garbage collection disabled")
	collectgarbage("stop")
end
print()

local duplicates = {}
for _, path in ipairs(pathsToCompile) do
	if duplicates[path] then
		errorLine(nil, "Duplicate path in arguments: %s", path)
	end
	duplicates[path] = true
end

if not pathsToCompile[1] then
	errorLine(nil, "No files to compile.")
end



-- Tokenize file.
-- @Incomplete: Handle multiple files to compile.
if pathsToCompile[2] then
	errorLine(nil, "Can only compile one file at a time right now. (%d files were given.)", #pathsToCompile)
end

local path = pathsToCompile[1]
local s    = assert(getFileContents(path, true))

print("Compiling "..path:gsub("^.*/", ""))

s = s:gsub("\r\n?", "\n") -- Normalize line endings.  @Robustness: Handle the uncommon occurrence of \n\r.

local tokens = tokenize(s, path)



-- Quickly check for stray/unmatched brackets.
-- Note: Sometimes an error message here isn't very helpful, so we sometimes continue with parsing despite getting an error here.

local BRACKETS            = {["("]=")", ["{"]="}", ["["]="]"}
local bracketTokenIndices = {}

for i = 1, tokens.count do
	if isToken(tokens.type[i],tokens.value[i], 7,"(","{","[") then
		table.insert(bracketTokenIndices, i)

	elseif isToken(tokens.type[i],tokens.value[i], 7,")","}","]") then
		local iStart   = table.remove(bracketTokenIndices)
		local expected = BRACKETS[tokens.value[iStart]]

		if not iStart then
			reportMessageInFile(s, path, tokens.position1[i], "Error", "BracketChecker", "Stray bracket.")
			bracketTokenIndices[1] = nil
			break

		elseif tokens.value[i] ~= expected then
			reportMessageInFile(s, path, tokens.position1[i],      "Error", "BracketChecker", "Expected '%s'.", expected)
			reportMessageInFile(s, path, tokens.position1[iStart], "Info",  "BracketChecker", "... here is the unmatched bracket.")
			exitFailure()
			-- bracketTokenIndices[1] = nil
			-- break
		end
	end
end

if bracketTokenIndices[1] then
	local i = bracketTokenIndices[1]
	errorInFile(s, path, tokens.position1[i], "BracketChecker", "Missing end bracket.", BRACKETS[tokens.value[i]])
	-- reportMessageInFile(s, path, tokens.position1[i], "Error", "BracketChecker", "Missing end bracket.", BRACKETS[tokens.value[i]])
end



-- Parse!
local state             = ParseState()
state.fileBuffers[path] = s
state.tokens            = tokens

local topNode = parseFileScope(state, path)

if peekNextToken(state) then
	errorParsingNext(state, "Expected the end of the file.")
end



-- All done!
printf("Compilation completed in %.3f seconds", os.clock()-compilationStartTime)
if disableGc then
	printf("Memory usage: %d bytes", collectgarbage("count")*1024)
end

print()
printAst(topNode)

exit()


