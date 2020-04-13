# Glóa
**Glóa** is a language that compiles into [Lua](https://www.lua.org/).
The compiler is a single-file program written in pure Lua.
[MIT license](LICENSE.txt).

Glóa introduces static type checking and constants and gets rid of forward declarations, while keeping things like modules, versatile tables and multiple return values.
The language supports compile-time code execution, polymorphism and function overloading.
It draws inspiration from [Jai](https://www.youtube.com/playlist?list=PLmV5I2fxaiCKfxMBrNsU1kgKJXD3PkyxO), C and Lua itself, among other languages.

> **Note**: Glóa is under development and not intended for public use yet.
> The language and the compiler are made as a programming/design exercise.
> This repository is mostly for people interested in programming languages related to Lua or the development of a compiler/transpiler written in/for Lua.

- [Language](#language)
	- [Example Programs](#example-programs)
- [Usage](#usage)
	- [Build the Compiler](#build-the-compiler)
	- [Compile Programs](#compile-programs)
		- [Options](#options)
- [This Repository](#this-repository)
	- [Folders](#folders)



## Language
Types can be explicitly specified or inferred from the assigned value in declarations.
Types of variables can be as dynamic as they can be in Lua.
```lua
local age1  : int        = 32    -- Explicit type.
local age2  :            = 59    -- Inferred type (int in this case). The colon is optional here.
local foo   : string|int = "bar" -- Compound type.
local value : any        = true  -- Literally any type.

-- Substitute the equal sign with a colon to make constants instead of variables.
local PI : float : 3.14 -- Explicit type.
local E  :       : 2.72 -- Inferred type (float in this case).
```

The 12 basic value types in Glóa are:
**bool**, **int**, **float**, **string**, **table**, **type** (types themselves are first-class values),
arrays, functions, enums, structs, **none** (the type of *nil*) and **any**.
(The idea of distinguishing integers from floating-point numbers comes from Lua 5.4.)

A variable can have multiple types (we call those *compound types*) which may sometimes be necessary to use if the program interacts with existing Lua code.
The **any** type means the value can be of literally any type, which is not very safe but sometimes necessary.
It acts like a compound type that contains all the types in the program.
It effectively makes the variable work just like in Lua.

Values of the **table** type work exactly like Lua tables. The stricter and better alternatives to tables are *arrays* (for sequences) and *structs* for anything else.

Arrays and structs are restricted/well-defined tables:
```lua
local names: []string = {"Carl","Jenny","Bo"} -- []string means "array of strings".

local Entity :: struct { -- Entity is defined as constant here.
	entityType: int = 0,
	name = "no name", -- The type can be inferred.
	x: float = 0.0,
	y: float, -- The default value for floats is 0.0
}

local main :: () {
	local ent: Entity -- ent is guaranteed to be a table. It's initialized with the members of the struct.
	ent.x = 5

	!import "basic" -- This is so we can access the standard print() function.
	print(ent.name) -- "no name"
	print(ent.x)    -- 5

	-- ent.foo = 5  -- Error, 'foo' is not a member of Entity!

	local ent2: Entity = {y=7} -- Structs can be initialized with custom values.
	print(ent2.x, ent2.y)      -- 0 7
}
```

The 'function' keyword from Lua is removed in favor of a shorter format for defining functions.
The 'end' keyword is also removed as we define scopes using C-style curly brackets.
```lua
-- Functions are generally declared as constants.
local MY_CONST   :: 5
local myFunction :: (x:int, y:int) -> bool, int { -- Function that takes two ints a returns a bool and an int.
	return true, 7
}

-- With explicit types the above would look like this.
local MY_CONST   : int                         : 5
local myFunction : (x:int, y:int) -> bool, int : (x:int, y:int) -> bool, int {
	return true, 7
}
-- Function declarations can get quite long this way so it's better to have their types be inferred.

-- You can optionally name the return values for better-documented code.
local myFunction :: (x:int, y:int) -> (success:bool, result:int) { }
```

Variables can contain references to functions, and a function can take another function as an argument.
```lua
-- Here, the 'func' argument is a function that takes an int and returns a string.
local callMe :: (func: (n:int)->(s:string), n: int) -> string {
	local str = func(n)
	return str
}

local sizeToString :: (size:int) -> string {
	if size < 100
		return "It's small."
	else
		return "It's big!"
}

local main :: () {
	local str = callMe(sizeToString, 598)
}
```

Names in file scope can be declared and used out-of-order, unlike Lua. No forward declarations needed.
```lua
local main :: () {
	!import "basic"
	print(x) -- 1.23
}
local x = 1.23
```

Here's how to do some more common things in Glóa.
```lua
!import "basic" -- Include a shared module/library. The "basic" module contains common functions like print() and insert().
!load "gui/elements" -- Include a file from the current project folder.

-- The 'main' function is the (default) entry point of a program.
local main :: () {
	-- If statements.
	if x < 0  -- No 'then' keyword, unlike Lua.
		func1()
	elseif x > 0  -- We could also write 'else if' as two words.
		func2()
	else
		func3()

	-- By default, only the one following statement belongs to if/elseif/while statements.
	-- Use {...} to define scopes with multiple statements.
	if x < 6 {
		local n = 2^8
		func(n)
	}

	-- Do statements (create a simple scope).
	do {
		local x = foo()
	}
	local x = 4 -- This x is different from the x above.

	-- Switch statements.
	local count = 2

	if count == {
		case 1:
			print("We got one!")
			local x = 5

		case 2: !through  -- Fall through to case 3.
		case 3:
			print("We got two or three!")
			local x = true -- Cases have their own scope. This x is different from the x above.

		case: -- The default case.
			printf("We got %d...", count)
			print("That's a lot!")
	}

	-- While loops.
	local x = 10
	while x > 0 {
		x -= 1+1  -- Same as  x = x - (1+1)
		if x < 5
			break -- We can break or continue loops.
	}

	-- For loops.
	for 1, 3         print(it)          -- 1 2 3
	for array        print(itIndex, it) -- 'it' is the default name for the item variable.
	for v: array     print(itIndex, v)  -- Rename the 'it' variable.
	for v, i: array  print(i, v)        -- Rename the 'itIndex' variable.
	-- Lua-style and iterators:
	for i = 1, 3               print(i)    -- 1 2 3
	for i, v in ipairs(array)  print(i, v) -- ipairs() returns an iterator and whatever value the 'for' loop require.
	for k, v in next, myTable  print(k, v) -- Explicit iterator function.

	-- Semicolons at the end of statements are optional, just like in Lua.
	local x = 1;
	local y = 2;
}
```

Finally, code can be executed at compile-time. This is quite a powerful feature!
```lua
-- Here we generate the value for a runtime constant at compile-time.
local RANDOM_COLORS :: !run getRandomColors(4)

local getRandomColors :: (count:int) -> []string {
	!import "basic" -- For insert()
	!import "math"  -- For getRandom()

	local COLOR_BANK :: {"red","green","blue","orange","teal"}
	local colors: []string

	for 1, count {
		local i = getRandom(1, #COLOR_BANK) -- # is the length operator.
		insert(colors, COLOR_BANK[i])
	}

	return colors
}
```

There are more features but it's too many to list on this one page!
Proper documentation is yet to be written.

### Example Programs
Full programs that showcase the language can be found in the [Glóa Example Programs repository](https://github.com/ReFreezed/GloaExamples).



## Usage
To use Glóa all you need is to have Lua 5.1 installed on your system (other Lua versions may be supported in the future). Currently you have to build the compiler first before using it.

### Build the Compiler
To build the Glóa compiler (*gloa.lua*) run [buildGloa.cmd](buildGloa.cmd), or run `lua src/build.lua` from the command line from the the top of the repository.

### Compile Programs
To compile a Glóa program, run this from the command line:
```batch
lua gloa.lua [compilerOptions] myProgram.gloa [myOtherProgram.gloa ...] [-- metaprogramArgument1 ...]
```

#### Options
```
--debug    Output debug information into compiled programs.
--help     Display this help.
--nogc     Disable garbage collection during compilation. (May decrease compilation time.)
--nostrip  Disable automatic removal of dead code. (May trigger runtime errors on start-up!)
--silent   Disable output to stdout. (Errors and warnings are still printed to stderr.)
--         Start of arguments for metaprogram.
```



## This Repository

### Folders
- `/docs/` - Relevant documents.
- `/lib/` - Libraries used when building the compiler.
- `/modules/` - Standard/shared Glóa modules/libraries.
- `/src/` - Compiler source components.
- `/tests/` - Test programs that the compiler should be able to compile.

When the compiler is built, the *.lua2p* and *.luapart* files are [preprocessed](https://github.com/ReFreezed/LuaPreprocess) and joined together to form *gloa.lua*.


