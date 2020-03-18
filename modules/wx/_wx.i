// Search for 'GloaEdit' for Glóa-specific edits.

wxwidgets/wxbase_base.i - Lua table = 'wx'
// ===========================================================================
// Purpose: Various wxBase classes
// Author: Ray Gilbert, John Labenski
// Created: July 2004
// Copyright: (c) Ray Gilbert
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxWidgets version defines

%define wxMAJOR_VERSION
%define wxMINOR_VERSION
%define wxRELEASE_NUMBER
%define wxSUBRELEASE_NUMBER
%define_string wxVERSION_STRING

%function bool wxCHECK_VERSION(int major, int minor, int release) // actually a define
%function bool wxCHECK_VERSION_FULL(int major, int minor, int release, int subrel) // actually a define

%define wxABI_VERSION

// ---------------------------------------------------------------------------
// wxWidgets platform defines

%__WINDOWS__ %define __WINDOWS__ 1
%__WIN16__ %define __WIN16__ 1
%__WIN32__ %define __WIN32__ 1
%__WIN95__ %define __WIN95__ 1
%__WXBASE__ %define __WXBASE__ 1
%__WXCOCOA__ %define __WXCOCOA__ 1
%__WXWINCE__ %define __WXWINCE__ 1
%__WXGTK__ %define __WXGTK__ 1
%__WXGTK12__ %define __WXGTK12__ 1
%__WXGTK20__ %define __WXGTK20__ 1
%__WXMOTIF__ %define __WXMOTIF__ 1
%__WXMOTIF20__ %define __WXMOTIF20__ 1
%__WXMAC__ %define __WXMAC__ 1
%__WXMAC_CLASSIC__ %define __WXMAC_CLASSIC__ 1
%__WXMAC_CARBON__ %define __WXMAC_CARBON__ 1
%__WXMAC_OSX__ %define __WXMAC_OSX__ 1
%__WXMGL__ %define __WXMGL__ 1
%__WXMSW__ %define __WXMSW__ 1
%__WXOS2__ %define __WXOS2__ 1
%__WXOSX__ %define __WXOSX__ 1
%__WXPALMOS__ %define __WXPALMOS__ 1
%__WXPM__ %define __WXPM__ 1
%__WXSTUBS__ %define __WXSTUBS__ 1
%__WXXT__ %define __WXXT__ 1
%__WXX11__ %define __WXX11__ 1
%__WXWINE__ %define __WXWINE__ 1
%__WXUNIVERSAL__ %define __WXUNIVERSAL__ 1
%__X__ %define __X__ 1

// ---------------------------------------------------------------------------

%if wxUSE_ON_FATAL_EXCEPTION
%function bool wxHandleFatalExceptions(bool doIt = true)
%endif // wxUSE_ON_FATAL_EXCEPTION

// ---------------------------------------------------------------------------
// Network, user, and OS functions

%if !%wxchkver_2_8
%enum

    wxUNKNOWN_PLATFORM
    wxCURSES
    wxXVIEW_X
    wxMOTIF_X
    wxCOSE_X
    wxNEXTSTEP
    wxMAC
    wxMAC_DARWIN
    wxBEOS
    wxGTK
    wxGTK_WIN32
    wxGTK_OS2
    wxGTK_BEOS
    wxGEOS
    wxOS2_PM
    wxWINDOWS
    wxMICROWINDOWS
    wxPENWINDOWS
    wxWINDOWS_NT
    wxWIN32S
    wxWIN95
    wxWIN386
    wxWINDOWS_CE
    wxWINDOWS_POCKETPC
    wxWINDOWS_SMARTPHONE
    wxMGL_UNIX
    wxMGL_X
    wxMGL_WIN32
    wxMGL_OS2
    wxMGL_DOS
    wxWINDOWS_OS2
    wxUNIX
    wxX11
    wxPALMOS
    wxDOS

%endenum
%endif // !%wxchkver_2_8

%function wxString wxGetEmailAddress()
%function wxLongLong wxGetFreeMemory()
%function wxString wxGetFullHostName()
%function wxString wxGetHomeDir()
%function wxString wxGetHostName()
%function wxString wxGetOsDescription()
// %override [int version, int major, int minor] wxGetOsVersion()
// int wxGetOsVersion(int *major = NULL, int *minor = NULL)
%function int wxGetOsVersion()

%function wxString wxGetUserHome(const wxString& user = "")
%function wxString wxGetUserId()
%function wxString wxGetUserName()

// ---------------------------------------------------------------------------
// Environmental access functions

%function bool wxGetEnv(const wxString& var, wxString *value)
%function bool wxSetEnv(const wxString& var, const wxString& value)
%function bool wxUnsetEnv(const wxString& var)


// ---------------------------------------------------------------------------
// wxSystemOptions

%if wxLUA_USE_wxSystemOptions

%include "wx/sysopt.h"

%class %noclassinfo wxSystemOptions, wxObject

    //wxSystemOptions() // No constructor, all member functions static

    static wxString GetOption(const wxString& name) const
    static int GetOptionInt(const wxString& name) const
    static bool HasOption(const wxString& name) const
    static bool IsFalse(const wxString& name) const

    %if wxUSE_SYSTEM_OPTIONS
    static void SetOption(const wxString& name, const wxString& value)
    static void SetOption(const wxString& name, int value)
    %endif //wxUSE_SYSTEM_OPTIONS

%endclass

%endif //wxLUA_USE_wxSystemOptions


// ---------------------------------------------------------------------------
// wxPlatformInfo

%enum wxOperatingSystemId

    wxOS_UNKNOWN // returned on error

    wxOS_MAC_OS // Apple Mac OS 8/9/X with Mac paths
    wxOS_MAC_OSX_DARWIN // Apple Mac OS X with Unix paths
    wxOS_MAC // wxOS_MAC_OS|wxOS_MAC_OSX_DARWIN,

    wxOS_WINDOWS_9X // Windows 9x family (95/98/ME)
    wxOS_WINDOWS_NT // Windows NT family (NT/2000/XP)
    wxOS_WINDOWS_MICRO // MicroWindows
    wxOS_WINDOWS_CE // Windows CE (Window Mobile)
    wxOS_WINDOWS // wxOS_WINDOWS_9X|wxOS_WINDOWS_NT|wxOS_WINDOWS_MICRO|wxOS_WINDOWS_CE,

    wxOS_UNIX_LINUX // Linux
    wxOS_UNIX_FREEBSD // FreeBSD
    wxOS_UNIX_OPENBSD // OpenBSD
    wxOS_UNIX_NETBSD // NetBSD
    wxOS_UNIX_SOLARIS // SunOS
    wxOS_UNIX_AIX // AIX
    wxOS_UNIX_HPUX // HP/UX
    wxOS_UNIX // wxOS_UNIX_LINUX|wxOS_UNIX_FREEBSD|wxOS_UNIX_OPENBSD|wxOS_UNIX_NETBSD|wxOS_UNIX_SOLARIS|wxOS_UNIX_AIX|wxOS_UNIX_HPUX,

    wxOS_DOS // Microsoft DOS
    wxOS_OS2 // OS/2

%endenum

%enum wxPortId

    wxPORT_UNKNOWN // returned on error

    wxPORT_BASE // wxBase, no native toolkit used

    wxPORT_MSW // wxMSW, native toolkit is Windows API
    wxPORT_MOTIF // wxMotif, using [Open]Motif or Lesstif
    wxPORT_GTK // wxGTK, using GTK+ 1.x, 2.x, GPE or Maemo
    wxPORT_MGL // wxMGL, using wxUniversal
    wxPORT_X11 // wxX11, using wxUniversal
    wxPORT_PM // wxOS2, using OS/2 Presentation Manager
    wxPORT_OS2 // wxOS2, using OS/2 Presentation Manager
    wxPORT_MAC // wxMac, using Carbon or Classic Mac API
    wxPORT_COCOA // wxCocoa, using Cocoa NextStep/Mac API
    wxPORT_WINCE // wxWinCE, toolkit is WinCE SDK API
    wxPORT_PALMOS // wxPalmOS, toolkit is PalmOS API
    wxPORT_DFB // wxDFB, using wxUniversal

%endenum

%enum wxArchitecture

    wxARCH_INVALID // returned on error

    wxARCH_32 // 32 bit
    wxARCH_64

    wxARCH_MAX

%endenum

%enum wxEndianness

    wxENDIAN_INVALID // returned on error

    wxENDIAN_BIG // 4321
    wxENDIAN_LITTLE // 1234
    wxENDIAN_PDP // 3412

    wxENDIAN_MAX

%endenum

%class %noclassinfo wxPlatformInfo

    // No constructor, use static Get() function
    //wxPlatformInfo();
    //wxPlatformInfo(wxPortId pid, int tkMajor = -1, int tkMinor = -1, wxOperatingSystemId id = wxOS_UNKNOWN, int osMajor = -1, int osMinor = -1, wxArchitecture arch = wxARCH_INVALID, wxEndianness endian = wxENDIAN_INVALID, bool usingUniversal = false)

    // Gets a wxPlatformInfo already initialized with the values for
    // the currently running platform.
    //static const wxPlatformInfo& Get();
    static const wxPlatformInfo& Get()

    static wxOperatingSystemId GetOperatingSystemId(const wxString &name);
    static wxPortId GetPortId(const wxString &portname);

    static wxArchitecture GetArch(const wxString &arch);
    static wxEndianness GetEndianness(const wxString &end);

    static wxString GetOperatingSystemFamilyName(wxOperatingSystemId os);
    static wxString GetOperatingSystemIdName(wxOperatingSystemId os);
    static wxString GetPortIdName(wxPortId port, bool usingUniversal);
    static wxString GetPortIdShortName(wxPortId port, bool usingUniversal);

    static wxString GetArchName(wxArchitecture arch);
    static wxString GetEndiannessName(wxEndianness end);

    int GetOSMajorVersion() const
    int GetOSMinorVersion() const

    bool CheckOSVersion(int major, int minor) const

    int GetToolkitMajorVersion() const
    int GetToolkitMinorVersion() const

    bool CheckToolkitVersion(int major, int minor) const
    bool IsUsingUniversalWidgets() const

    wxOperatingSystemId GetOperatingSystemId() const
    wxPortId GetPortId() const
    wxArchitecture GetArchitecture() const
    wxEndianness GetEndianness() const

    wxString GetOperatingSystemFamilyName() const
    wxString GetOperatingSystemIdName() const
    wxString GetPortIdName() const
    wxString GetPortIdShortName() const
    wxString GetArchName() const
    wxString GetEndiannessName() const

    void SetOSVersion(int major, int minor)
    void SetToolkitVersion(int major, int minor)
    void SetOperatingSystemId(wxOperatingSystemId n)
    void SetPortId(wxPortId n)
    void SetArchitecture(wxArchitecture n)
    void SetEndianness(wxEndianness n)

    bool IsOk() const

    //bool operator==(const wxPlatformInfo &t) const; // we only use the wxWidget's wxPlatformInfo
    //bool operator!=(const wxPlatformInfo &t) const

%endclass


// ---------------------------------------------------------------------------
// wxSingleInstanceChecker

%if wxUSE_SNGLINST_CHECKER

%include "wx/snglinst.h"

%class %delete %noclassinfo %encapsulate wxSingleInstanceChecker

    wxSingleInstanceChecker() // default ctor, use Create() after it
    // like Create() but no error checking (dangerous!)
    //wxSingleInstanceChecker(const wxString& name, const wxString& path = "")

    // name must be given and be as unique as possible, it is used as the mutex
    // name under Win32 and the lock file name under Unix -
    // wxTheApp->GetAppName() may be a good value for this parameter
    //
    // path is optional and is ignored under Win32 and used as the directory to
    // create the lock file in under Unix (default is wxGetHomeDir())
    //
    // returns false if initialization failed, it doesn't mean that another
    // instance is running - use IsAnotherRunning() to check it
    bool Create(const wxString& name, const wxString& path = "")

    bool IsAnotherRunning() const // is another copy of this program already running?

%endclass

%endif // wxUSE_SNGLINST_CHECKER


// ---------------------------------------------------------------------------
// wxLog - See GUI log bindings in wxcore_core.i

%if wxLUA_USE_wxLog && wxUSE_LOG

%include "wx/log.h"

// These functions are in log.h
%function unsigned long wxSysErrorCode()
%function wxString wxSysErrorMsg(unsigned long nErrCode = 0)

%function void wxSafeShowMessage(const wxString& title, const wxString& text)

// All of the wxLogXXX functions take only a single string,
// use string.format(...) to format the string in Lua.

// C++ Func: void wxLogError(const char *formatString, ...)
%function void wxLogError(const wxString& message)
// C++ Func: void wxLogFatalError(const char *formatString, ...)
%function void wxLogFatalError(const wxString& message)
// C++ Func: void wxLogWarning(const char *formatString, ...)
%function void wxLogWarning(const wxString& message)
// C++ Func: void wxLogMessage(const char *formatString, ...)
%function void wxLogMessage(const wxString& message)
// C++ Func: void wxLogVerbose(const char *formatString, ...)
%function void wxLogVerbose(const wxString& message)
// C++ Func: void wxLogStatus(wxFrame *frame, const char *formatString, ...)
// void wxLogStatus(const char *formatString, ...) // this just uses the toplevel frame, use wx.NULL for the frame
// IN wxCore %function void wxLogStatus(wxFrame *frame, const wxString& message)

// C++ Func: void wxLogSysError(const char *formatString, ...)
%function void wxLogSysError(const wxString& message)
// C++ Func: void wxLogDebug(const char *formatString, ...)
%function void wxLogDebug(const wxString& message)
// C++ Func: void wxLogTrace(const char *mask, const char *formatString, ...)
%function void wxLogTrace(const wxString& mask, const wxString& message)
// void wxLogTrace(const char *formatString, ...)
// void wxLogTrace(wxTraceMask mask, const char *formatString, ...) - deprecated

%typedef unsigned long wxTraceMask
%typedef unsigned long wxLogLevel

%enum // wxLogLevel - uses these enums

    wxLOG_FatalError, // program can't continue, abort immediately
    wxLOG_Error, // a serious error, user must be informed about it
    wxLOG_Warning, // user is normally informed about it but may be ignored
    wxLOG_Message, // normal message (i.e. normal output of a non GUI app)
    wxLOG_Status, // informational: might go to the status line of GUI app
    wxLOG_Info, // informational message (a.k.a. 'Verbose')
    wxLOG_Debug, // never shown to the user, disabled in release mode
    wxLOG_Trace, // trace messages are also only enabled in debug mode
    wxLOG_Progress, // used for progress indicator (not yet)

    wxLOG_User, // user defined levels start here
    wxLOG_Max

%endenum

// symbolic trace masks - wxLogTrace("foo", "some trace message...") will be
// discarded unless the string "foo" has been added to the list of allowed
// ones with AddTraceMask()
%define_string wxTRACE_MemAlloc //wxT("memalloc") // trace memory allocation (new/delete)
%define_string wxTRACE_Messages //wxT("messages") // trace window messages/X callbacks
%define_string wxTRACE_ResAlloc //wxT("resalloc") // trace GDI resource allocation
%define_string wxTRACE_RefCount //wxT("refcount") // trace various ref counting operations
%msw %define_string wxTRACE_OleCalls //wxT("ole") // OLE interface calls

%class %delete %noclassinfo %encapsulate wxLog

    //wxLog() - No constructor, a base class, use one of the derived classes.

    static bool IsEnabled()
    static bool EnableLogging(bool doIt = true)
    virtual void Flush()
    static void FlushActive()
    // Don't delete the active target until you set a new one or set it to wx.NULL
    // Note, a new wxLog is created unless DontCreateOnDemand() is called.
    static wxLog *GetActiveTarget()
    // When you create a new wxLog and call "oldLog = SetActiveTarget(MyLog)"
    // the returned oldLog will be garbage collected or you can delete() the
    // oldLog unless you want to reuse it by calling "myLog = SetActiveTarget(oldLog)"
    // which releases myLog to be garbage collected or delete()ed by you.
    // Basicly, wxWidgets 'owns' the log you pass to SetActiveTarget() and
    // wxLua 'owns' the returned log.
    static %gc wxLog *SetActiveTarget(%ungc wxLog *pLogger)
    static void Suspend()
    static void Resume()
    static void SetVerbose(bool bVerbose = true)
    static void SetLogLevel(wxLogLevel logLevel)
    static void DontCreateOnDemand()
    %wxchkver_2_8 static void SetRepetitionCounting(bool bRepetCounting = true)
    %wxchkver_2_8 static bool GetRepetitionCounting()
    static void SetTraceMask(wxTraceMask ulMask)
    static void AddTraceMask(const wxString& str)
    static void RemoveTraceMask(const wxString& str)
    static void ClearTraceMasks()
    static const wxArrayString GetTraceMasks()

    // %override static void wxLog::SetTimestamp(const wxString& ts)
    // Allows an input of "nil" or no value to disable time stamping.
    // C++ Func: static void wxLog::SetTimestamp(const wxChar* ts)
    static void SetTimestamp(const wxString& ts)

    static bool GetVerbose()
    static wxTraceMask GetTraceMask()
    static bool IsAllowedTraceMask(const wxString& mask)
    static wxLogLevel GetLogLevel()
    static wxString GetTimestamp()

%endclass

// ---------------------------------------------------------------------------
// wxLogBuffer

%class %delete %noclassinfo %encapsulate wxLogBuffer, wxLog

    wxLogBuffer()

    const wxString& GetBuffer() const // get the string contents with all messages logged

%endclass

// ---------------------------------------------------------------------------
// wxLogChain

%class %delete %noclassinfo %encapsulate wxLogChain, wxLog

    wxLogChain(wxLog *logger)

    void SetLog(wxLog *logger) // change the new log target
    // this can be used to temporarily disable (and then reenable) passing
    // messages to the old logger (by default we do pass them)
    void PassMessages(bool bDoPass)
    // are we passing the messages to the previous log target?
    bool IsPassingMessages() const
    // return the previous log target (may be NULL)
    wxLog *GetOldLog() const

%endclass

// ---------------------------------------------------------------------------
// wxLogNull

%class %delete %noclassinfo %encapsulate wxLogNull, wxLog

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxLogNull()

%endclass

// ---------------------------------------------------------------------------
// wxLogPassThrough - a chain log target which uses itself as the new logger

%class %delete %noclassinfo %encapsulate wxLogPassThrough, wxLogChain

    wxLogPassThrough()

%endclass

// ---------------------------------------------------------------------------
// wxLogStderr - FIXME need to implement FILE*

/*
%class %delete %noclassinfo %encapsulate wxLogStderr, wxLog

    wxLogStderr(FILE *fp = (FILE *) NULL) // redirect log output to a FILE

%endclass
*/

// ---------------------------------------------------------------------------
// wxLogStream - FIXME need to implement wxSTD ostream* (just use wxLogBuffer)

/*
%if wxUSE_STD_IOSTREAM

%class %delete %noclassinfo %encapsulate wxLogStream, wxLog

    wxLogStream(wxSTD ostream *ostr = NULL); // redirect log output to an ostream

%endclass

%endif // wxUSE_STD_IOSTREAM
*/

%endif // wxLUA_USE_wxLog && wxUSE_LOG

// ---------------------------------------------------------------------------
// wxDynamicLibrary - No a lot you can do with this, but it might make
// testing or debugging a C++ program easier to test thing
// out in wxLua first.

%if // wxLUA_USE_wxDynamicLibrary && wxUSE_DYNLIB_CLASS

%include "wx/dynlib.h"

%enum wxDLFlags

    wxDL_LAZY // resolve undefined symbols at first use
    // (only works on some Unix versions)
    wxDL_NOW // resolve undefined symbols on load
    // (default, always the case under Win32)
    wxDL_GLOBAL // export extern symbols to subsequently
    // loaded libs.
    wxDL_VERBATIM // attempt to load the supplied library
    // name without appending the usual dll
    // filename extension.
    wxDL_NOSHARE // load new DLL, don't reuse already loaded
    // (only for wxPluginManager)

    wxDL_DEFAULT // = wxDL_NOW // default flags correspond to Win32

%endenum

%enum wxDynamicLibraryCategory

    wxDL_LIBRARY, // standard library
    wxDL_MODULE // loadable module/plugin

%endenum

%enum wxPluginCategory

    wxDL_PLUGIN_GUI, // plugin that uses GUI classes
    wxDL_PLUGIN_BASE // wxBase-only plugin

%endenum


%class %delete %noclassinfo %encapsulate wxDynamicLibraryDetails

    // ctor, normally never used as these objects are only created by wxDynamicLibrary
    // wxDynamicLibrary::ListLoaded()
    //wxDynamicLibraryDetails() { m_address = NULL; m_length = 0; }

    wxString GetName() const // get the (base) name
    wxString GetPath() const // get the full path of this object

    // get the load address and the extent, return true if this information is available
    //bool GetAddress(void **addr, size_t *len) const

    wxString GetVersion() const // return the version of the DLL (may be empty if no version info)

%endclass

%class %delete %noclassinfo %encapsulate wxDynamicLibraryDetailsArray

    //wxDynamicLibraryDetailsArray() // Get this from wxDynamicLibrary::ListLoaded

    int GetCount() const
    wxDynamicLibraryDetails Item( int n )

%endclass


%class %delete %noclassinfo %encapsulate wxDynamicLibrary

    wxDynamicLibrary()
    wxDynamicLibrary(const wxString& libname, int flags = wxDL_DEFAULT)

    // return a valid handle for the main program itself or NULL if back
    // linking is not supported by the current platform (e.g. Win32)
    //static wxDllType GetProgramHandle();

    // return the platform standard DLL extension (with leading dot)
    //static const wxChar *GetDllExt()
    static wxString GetDllExt()

    // return true if the library was loaded successfully
    bool IsLoaded() const

    // load the library with the given name (full or not), return true if ok
    bool Load(const wxString& libname, int flags = wxDL_DEFAULT);

    // raw function for loading dynamic libs: always behaves as if
    // wxDL_VERBATIM were specified and doesn't log error message if the
    // library couldn't be loaded but simply returns NULL
    //static wxDllType RawLoad(const wxString& libname, int flags = wxDL_DEFAULT);

    // detach the library object from its handle, i.e. prevent the object from
    // unloading the library in its dtor -- the caller is now responsible for doing this
    //wxDllType Detach()

    // unload the given library handle (presumably returned by Detach() before)
    //static void Unload(wxDllType handle);

    // unload the library, also done automatically in dtor
    void Unload()

    // Return the raw handle from dlopen and friends.
    //wxDllType GetLibHandle() const { return m_handle; }

    // check if the given symbol is present in the library, useful to verify if
    // a loadable module is our plugin, for example, without provoking error
    // messages from GetSymbol()
    bool HasSymbol(const wxString& name) const

    // resolve a symbol in a loaded DLL, such as a variable or function name.
    // 'name' is the (possibly mangled) name of the symbol. (use extern "C" to
    // export unmangled names)
    // Since it is perfectly valid for the returned symbol to actually be NULL,
    // that is not always indication of an error. Pass and test the parameter
    // 'success' for a true indication of success or failure to load the symbol.
    // Returns a pointer to the symbol on success, or NULL if an error occurred
    // or the symbol wasn't found.
    //void *GetSymbol(const wxString& name, bool *success = NULL) const;

    // low-level version of GetSymbol()
    //static void *RawGetSymbol(wxDllType handle, const wxString& name);
    //void *RawGetSymbol(const wxString& name) const

    //#ifdef __WXMSW__
    // this function is useful for loading functions from the standard Windows
    // DLLs: such functions have an 'A' (in ANSI build) or 'W' (in Unicode, or
    // wide character build) suffix if they take string parameters
    //static void *RawGetSymbolAorW(wxDllType handle, const wxString& name)
    //void *GetSymbolAorW(const wxString& name) const
    //#endif // __WXMSW__

    // return all modules/shared libraries in the address space of this process
    // returns an empty array if not implemented or an error occurred
    static wxDynamicLibraryDetailsArray ListLoaded();

    // return platform-specific name of dynamic library with proper extension
    // and prefix (e.g. "foo.dll" on Windows or "libfoo.so" on Linux)
    static wxString CanonicalizeName(const wxString& name, wxDynamicLibraryCategory cat = wxDL_LIBRARY);

    // return name of wxWidgets plugin (adds compiler and version info
    // to the filename):
    static wxString CanonicalizePluginName(const wxString& name, wxPluginCategory cat = wxDL_PLUGIN_GUI);

    // return plugin directory on platforms where it makes sense and empty string on others:
    static wxString GetPluginsDirectory()

%endclass

// ---------------------------------------------------------------------------
// wxPluginLibrary - You cannot use this within wxLua

// ---------------------------------------------------------------------------
// wxPluginManager - You cannot use this within wxLua

%endif // wxLUA_USE_wxDynamicLibrary && wxUSE_DYNLIB_CLASS


// ---------------------------------------------------------------------------
// wxCriticalSection

%if wxLUA_USE_wxCriticalSection && wxUSE_THREADS

%include "wx/thread.h"

%class %delete %encapsulate %noclassinfo wxCriticalSection

    wxCriticalSection()
    void Enter()
    void Leave()

%endclass

%endif // wxLUA_USE_wxCriticalSection


// ---------------------------------------------------------------------------
// wxCriticalSectionLocker

%if wxLUA_USE_wxCriticalSectionLocker

%include "wx/thread.h"

%class %delete %encapsulate %noclassinfo wxCriticalSectionLocker

    wxCriticalSectionLocker(wxCriticalSection& cs);

%endclass

%endif // wxLUA_USE_wxCriticalSectionLocker && wxUSE_THREADS


// ---------------------------------------------------------------------------
// wxRegEx - Regular expression support

%if wxLUA_USE_wxRegEx && wxUSE_REGEX

%include "wx/regex.h"

%enum

    wxRE_EXTENDED
    wxRE_BASIC
    wxRE_ICASE
    wxRE_NOSUB
    wxRE_NEWLINE
    wxRE_DEFAULT

%endenum

%enum

    wxRE_NOTBOL
    wxRE_NOTEOL

%endenum

%class %delete %noclassinfo %encapsulate wxRegEx

    wxRegEx()
    wxRegEx(const wxString& expr, int flags = wxRE_DEFAULT)

    bool Compile(const wxString& pattern, int flags = wxRE_DEFAULT)
    bool IsValid() const
    wxString GetMatch(const wxString& text, size_t index = 0) const

    // %override [bool, size_t start, size_t len] wxRegEx::GetMatch(size_t index = 0) const
    // C++ Func: bool GetMatch(size_t* start, size_t* len, size_t index = 0) const
    %override_name wxLua_wxRegEx_GetMatchIndexes bool GetMatch(size_t index = 0) const

    size_t GetMatchCount() const
    // Note: only need this form of Matches
    bool Matches(const wxString &text, int flags = 0) const

    // %override [int, string text] wxRegEx::Replace(const wxString& text, const wxString& replacement, size_t maxMatches = 0) const
    // C++ Func: int Replace(wxString* text, const wxString& replacement, size_t maxMatches = 0) const
    int Replace(const wxString& text, const wxString& replacement, size_t maxMatches = 0) const

    // %override [int, string text] wxRegEx::ReplaceAll(const wxString& text, const wxString& replacement) const
    // C++ Func: int ReplaceAll(wxString* text, const wxString& replacement) const
    int ReplaceAll(const wxString& text, const wxString& replacement) const

    // %override [int, string text] wxRegEx::ReplaceFirst(const wxString& text, const wxString& replacement) const
    // C++ Func: int ReplaceFirst(wxString* text, const wxString& replacement) const
    int ReplaceFirst(const wxString& text, const wxString& replacement) const

%endclass

%endif //wxLUA_USE_wxRegEx && wxUSE_REGEX


wxwidgets/wxbase_config.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxConfig and wxConfigBase classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// TODO - add wxConfigFile and Reg

// ---------------------------------------------------------------------------
// wxConfigBase

%if wxLUA_USE_wxConfig && wxUSE_CONFIG

%include "wx/confbase.h"
%include "wx/config.h"
%include "wx/fileconf.h"

%enum

    wxCONFIG_USE_LOCAL_FILE
    wxCONFIG_USE_GLOBAL_FILE
    wxCONFIG_USE_RELATIVE_PATH
    wxCONFIG_USE_NO_ESCAPE_CHARACTERS
    %wxchkver_2_8_1 wxCONFIG_USE_SUBDIR

%endenum

%enum wxConfigBase::EntryType

    Type_Unknown
    Type_String
    Type_Boolean
    Type_Integer
    Type_Float

%endenum

%class %delete %noclassinfo %encapsulate wxConfigBase

    // No constructor since this is a base class

    // // %override wxConfigBase::delete() - this is a wxLua provided function to
    // // delete the config (or derived class). Created wxConfigs are NOT tracked
    // // in memory since you MUST call wxConfigBase::Set(NULL) before
    // // deleting them. This is because the wxConfig you install using
    // // wxConfigBase::Set may need to exist outside of the scope it was created
    // // in and we don't want Lua to garbage collect it.
    // void delete()

    // Note: the return wxConfig cannot be deleted.
    // You must call "config = Set(wx.NULL); config:delete()"
    static wxConfigBase* Create()
    static void DontCreateOnDemand()

    bool DeleteAll()
    bool DeleteEntry(const wxString& key, bool bDeleteGroupIfEmpty = true)
    bool DeleteGroup(const wxString& key)
    bool Exists(wxString& strName) const
    bool Flush(bool bCurrentOnly = false)
    static wxConfigBase* Get(bool CreateOnDemand = true)
    wxString GetAppName() const
    wxConfigBase::EntryType GetEntryType(const wxString& name) const

    // %override [bool, string, long index] wxConfigBase::GetFirstGroup()
    // C++ Func: bool GetFirstGroup(wxString& str, long& index) const
    bool GetFirstGroup() const

    // %override [bool, string, long index] wxConfigBase::GetFirstEntry()
    // C++ Func: bool GetFirstEntry(wxString& str, long& index) const
    bool GetFirstEntry() const

    // %override [bool, string, long index] wxConfigBase::GetNextGroup(long index)
    // C++ Func: bool GetNextGroup(wxString& str, long& index) const
    bool GetNextGroup() const

    // %override [bool, string, long index] wxConfigBase::GetNextEntry(long index)
    // C++ Func: bool GetNextEntry(wxString& str, long& index) const
    bool GetNextEntry(long index) const

    unsigned int GetNumberOfEntries(bool bRecursive = false) const
    unsigned int GetNumberOfGroups(bool bRecursive = false) const
    const wxString& GetPath() const
    wxString GetVendorName() const
    bool HasEntry(wxString& strName) const
    bool HasGroup(const wxString& strName) const
    bool IsExpandingEnvVars() const
    bool IsRecordingDefaults() const

    // %override [bool, string] wxConfigBase::Read(const wxString& key, const wxString& defaultVal = "")
    // C++ Func: bool Read(const wxString& key, wxString* str, const wxString& defaultVal) const
    bool Read(const wxString& key, const wxString& defaultVal = "") const

    // Since Lua uses double as it's number type, we only read/write doubles

    // %override [bool, double] wxConfigBase::Read(const wxString& key, double defaultVal)
    // C++ Func: bool Read(const wxString& key, double* d, double defaultVal = 0) const
    %override_name wxLua_wxConfigBase_ReadFloat bool Read(const wxString& key, double defaultVal) const

    // // %override [bool, int] wxConfigBase::ReadInt(const wxString& key, long defaultVal = 0)
    // // C++ Func: bool Read(const wxString& key, long* l, long defaultVal = 0) const
    // %rename ReadInt bool Read(const wxString& key, long defaultVal = 0) const
    // // %override [bool, double] wxConfigBase::ReadFloat(const wxString& key, double defaultVal = 0)
    // // C++ Func: bool Read(const wxString& key, double* d, double defaultVal = 0) const
    // %rename ReadFloat bool Read(const wxString& key, double defaultVal = 0) const

    bool RenameEntry(const wxString& oldName, const wxString& newName)
    bool RenameGroup(const wxString& oldName, const wxString& newName)
    static %gc wxConfigBase* Set(%ungc wxConfigBase *pConfig = NULL)
    void SetExpandEnvVars(bool bDoIt = true)
    void SetPath(const wxString& strPath)
    void SetRecordDefaults(bool bDoIt = true)


    bool Write(const wxString& key, wxString &value)
    // Since Lua uses double as it's number type, we only read/write doubles
    bool Write(const wxString &key, double value)

    // %rename WriteInt bool Write(const wxString &key, long value)
    // %rename WriteFloat bool Write(const wxString &key, double value)

%endclass

// ---------------------------------------------------------------------------
// wxConfig

%class %delete %noclassinfo %encapsulate wxConfig, wxConfigBase

    wxConfig(const wxString& appName = "", const wxString& vendorName = "", const wxString& localFilename = "", const wxString& globalFilename = "", long style = 0)

%endclass

// ---------------------------------------------------------------------------
// wxFileConfig

%class %delete %noclassinfo %encapsulate wxFileConfig, wxConfigBase

    wxFileConfig(const wxString& appName = "", const wxString& vendorName = "", const wxString& localFilename = "", const wxString& globalFilename = "", long style = wxCONFIG_USE_LOCAL_FILE | wxCONFIG_USE_GLOBAL_FILE) //, wxMBConv& conv = wxConvUTF8)

    void SetUmask(int mode)

%endclass

// ---------------------------------------------------------------------------
// wxMemoryConfig

%include "wx/memconf.h"

%class %delete %noclassinfo %encapsulate wxMemoryConfig, wxFileConfig

    wxMemoryConfig()

%endclass

// ---------------------------------------------------------------------------
// wxConfigPathChanger

// a handy little class which changes current path to the path of given entry
// and restores it in dtor: so if you declare a local variable of this type,
// you work in the entry directory and the path is automatically restored
// when the function returns

%class %delete %noclassinfo %encapsulate wxConfigPathChanger

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxConfigPathChanger(const wxConfigBase *pContainer, const wxString& strEntry)

    wxString Name() const
    %wxchkver_2_8 void UpdateIfDeleted()

%endclass

%endif //wxLUA_USE_wxConfig && wxUSE_CONFIG

wxwidgets/wxbase_data.i - Lua table = 'wx'
// ===========================================================================
// Purpose: data classes, wxObject, arrays, lists, hash
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxString - A stub class for people who absolutely need wxStrings
//
// wxLua uses Lua strings for almost everything and any function that takes
// a wxString can take a Lua string. All functions that return a wxString
// actually return Lua string unless otherwise noted.

%class %delete %noclassinfo %encapsulate wxString

    wxString(const wxString& str = "")

    wxString GetData() const

%endclass

// ---------------------------------------------------------------------------
// wxStringTokenizer

%include "wx/tokenzr.h"

%enum wxStringTokenizerMode

    wxTOKEN_INVALID // set by def ctor until SetString() is called
    wxTOKEN_DEFAULT // strtok() for whitespace delims, RET_EMPTY else
    wxTOKEN_RET_EMPTY // return empty token in the middle of the string
    wxTOKEN_RET_EMPTY_ALL // return trailing empty tokens too
    wxTOKEN_RET_DELIMS // return the delim with token (implies RET_EMPTY)
    wxTOKEN_STRTOK // behave exactly like strtok(3)

%endenum

%class %delete %noclassinfo wxStringTokenizer, wxObject

    wxStringTokenizer()
    wxStringTokenizer(const wxString& str, const wxString& delims = wxDEFAULT_DELIMITERS, wxStringTokenizerMode mode = wxTOKEN_DEFAULT);

    void SetString(const wxString& str, const wxString& delims = wxDEFAULT_DELIMITERS, wxStringTokenizerMode mode = wxTOKEN_DEFAULT);

    void Reinit(const wxString& str);
    size_t CountTokens() const;
    bool HasMoreTokens() const;
    wxString GetNextToken();
    //wxChar GetLastDelimiter() const

    wxString GetString() const
    size_t GetPosition() const

    wxStringTokenizerMode GetMode() const
    bool AllowEmpty() const

%endclass

// ---------------------------------------------------------------------------
// wxClientData
//
// No %delete since the container will delete it and you should only create one
// of these if you plan on attaching it to a container to avoid a memory leak.

//%enum wxClientDataType - used internally so we don't need it
// wxClientData_None
// wxClientData_Object
// wxClientData_Void
//%endenum

%class %noclassinfo wxClientData

    // declare this as a datatype, but there is nothing we can do with this as
    // it must be derived, see wxStringClientData

%endclass

// ---------------------------------------------------------------------------
// wxStringClientData
//
// No %delete since the container will delete it and you should only create one
// of these if you plan on attaching it to a container to avoid a memory leak.

%class %noclassinfo wxStringClientData, wxClientData

    wxStringClientData(const wxString& data = "")

    wxString GetData() const
    void SetData(const wxString& data)

%endclass

// ---------------------------------------------------------------------------
// wxClientDataContainer

%class %noclassinfo wxClientDataContainer

    wxClientDataContainer()

    void SetClientObject( wxClientData *data )
    wxClientData *GetClientObject() const

    void SetClientData( voidptr_long data ) // C++ is (void *clientData) You can put a number here
    // C++ Func: void *GetClientData() const
    voidptr_long GetClientData() const // C++ returns (void *) You get a number here

%endclass

// ---------------------------------------------------------------------------
// wxObject

%if wxLUA_USE_wxObject

%include "wx/object.h"

%function wxObject* wxCreateDynamicObject(const wxString& className)

%class %delete wxObject

    wxObject()

    //void Dump(ostream& stream)

    // %override [new class type] wxObject::DynamicCast(const wxString &classname) converts the wxObject  GloaEdit: The classname argument was missing. Was that intentional?
    // to an object of type classname
    void *DynamicCast(const wxString &classname)

    wxClassInfo* GetClassInfo()
    wxObjectRefData* GetRefData() const
    bool IsKindOf(wxClassInfo *info)
    bool IsSameAs(const wxObject& o) const
    void Ref(const wxObject& clone)
    void SetRefData(wxObjectRefData* data)
    void UnRef()

    //%operator wxObject& operator=(const wxObject& other)

%endclass

%class %noclassinfo wxObjectRefData // no %delete since this should be from a wxObject

    int GetRefCount() const

%endclass

%endif //wxLUA_USE_wxObject

// ---------------------------------------------------------------------------
// wxClassInfo

%if wxLUA_USE_wxClassInfo

%include "wx/object.h"

%class %noclassinfo wxClassInfo // no %delete since we're always getting a static instance

    // %override wxClassInfo() constructor creates an instance using wxClassInfo::FindClass
    wxClassInfo(const wxString &name)

    wxObject* CreateObject()
    static wxClassInfo* FindClass(const wxString &name)
    wxString GetBaseClassName1() const
    wxString GetBaseClassName2() const
    const wxClassInfo *GetBaseClass1() const
    const wxClassInfo *GetBaseClass2() const
    wxString GetClassName() const
    int GetSize() const
    bool IsDynamic()
    bool IsKindOf(wxClassInfo* info)

    static const wxClassInfo *GetFirst()
    const wxClassInfo *GetNext() const

%endclass

%endif //wxLUA_USE_wxClassInfo


// ---------------------------------------------------------------------------
// wxList

%if wxLUA_USE_wxList && !wxUSE_STL

%include "wx/list.h"

%enum wxKeyType

    wxKEY_NONE
    wxKEY_INTEGER
    wxKEY_STRING

%endenum

%class %delete wxList, wxObject

    wxList()

    wxNode *Append(wxObject *object)
    wxNode *Append(long key, wxObject *object)
    wxNode *Append(const wxString& key, wxObject *object)
    void Clear()
    void DeleteContents(bool destroy)
    bool DeleteNode(wxNode *pNode)
    bool DeleteObject(wxObject *pObject)
    wxNode* Find(wxObject* pObject)
    wxNode *Find(long key)
    wxNode *Find(const wxString &key)
    int GetCount() const
    wxNode *GetFirst()
    wxNode *GetLast()
    int IndexOf(wxObject* pObject)
    wxNode *Insert(wxObject *pObject)
    wxNode *Insert(size_t position, wxObject *pObject)
    wxNode *Insert(wxNode *pNode, wxObject *pObject)
    bool IsEmpty() const
    wxNode *Item(int iIndex) const
    wxNode *Member(wxObject *pObject)

%endclass

// ---------------------------------------------------------------------------
// wxNode - wxList

%class %noclassinfo wxNode // no %delete since we get this from a wxList

    // no constructor, just use this from a wxList

    wxObject *GetData()
    wxNode *GetNext()
    wxNode *GetPrevious()
    void SetData(wxObject *data)
    //int IndexOf() - unfortunately a protected member of wxNodeBase

    // To convert wxObject* GetData() to another type use wxObject::DynamicCast
    // See wxPenList, wxBrushList, wxMenuItemList, wxWindowList

    // Example: How to use a wxWindowList
    // frame = wx.wxFrame(wx.NULL, wx.wxID_ANY, "Test");
    // win = wx.wxWindow(frame, wx.wxID_ANY)
    // frame:Show(true)
    // wlist = frame:GetChildren()
    // wlist:Item(0):GetData():DynamicCast("wxWindow"):SetBackgroundColour(wx.wxRED)

    // Example: How to use a wxMenuItemList
    // local fileMenu = wx.wxMenu()
    // fileMenu:Append(wx.wxID_EXIT, "E&xit", "Quit the program")
    // mList = fileMenu:GetMenuItems()
    // print(mList:GetCount(), mList:GetFirst():GetData():DynamicCast("wxMenuItem"):GetLabel())

%endclass

%endif //wxLUA_USE_wxList && !wxUSE_STL

// ---------------------------------------------------------------------------
// wxArray - Can't implement this since it's not really a class.
// Here's the list of generic functions.

//%class %noclassinfo wxArray
// // no constructor since this class doesn't exist
// void Add(T &item, size_t copies = 1)
// void Alloc(size_t count)
// void Clear()
// void Empty()
// int GetCount() const
// void Insert(T &item, size_t n, size_t copies = 1)
// bool IsEmpty() const
// void RemoveAt(size_t index, size_t count = 1)
// void Shrink()
//%endclass

// ---------------------------------------------------------------------------
// wxArrayInt
//
// NOTE: Any function that takes a "const wxArrayInt& arr" or "wxArrayInt arr"
// can take a Lua table of integers with numeric indexes

%if wxLUA_USE_wxArrayInt

%include "wx/dynarray.h"

%class %delete %noclassinfo %encapsulate wxArrayInt

    wxArrayInt()
    wxArrayInt(const wxArrayInt& array)

    // %override [Lua table] wxArrayInt::ToLuaTable() const
    // returns a table array of the integers
    int ToLuaTable() const

    void Add( int num )
    void Alloc(size_t count)
    void Clear()
    void Empty()
    int GetCount() const
    bool IsEmpty() const
    int Index(int n, bool searchFromEnd = false)
    void Insert( int num, int n, int copies = 1 )
    int Item( int n )
    void Remove(int n)
    void RemoveAt(size_t index)
    void Shrink()

    %operator int operator[](size_t nIndex)

%endclass

%endif //wxLUA_USE_wxArrayInt

// ---------------------------------------------------------------------------
// wxArrayString
//
// NOTE: Any function that takes a "const wxArrayString& arr" or "wxArrayString arr"
// can take a Lua table of strings with numeric indexes

%if wxLUA_USE_wxArrayString

%include "wx/arrstr.h"

%class %delete %noclassinfo %encapsulate wxArrayString

    wxArrayString()
    wxArrayString(const wxArrayString& array)

    // %override [Lua table] wxArrayString::ToLuaTable() const
    // returns a table array of the strings
    int ToLuaTable() const

    size_t Add(const wxString& str, size_t copies = 1)
    void Alloc(size_t nCount)
    void Clear()
    void Empty()
    int GetCount() const
    int Index(const wxString &sz, bool bCase = true, bool bFromEnd = false)
    void Insert(const wxString& str, int nIndex, size_t copies = 1)
    bool IsEmpty()
    wxString Item(size_t nIndex) const
    wxString Last()
    void Remove(const wxString &sz)
    void RemoveAt(size_t nIndex, size_t count = 1)
    void Shrink()
    void Sort(bool reverseOrder = false)

    %operator wxString& operator[](size_t nIndex)

%endclass

// ---------------------------------------------------------------------------
// wxSortedArrayString
//
// NOTE: Any function that takes a "const wxSortedArrayString& arr" or "wxSortedArrayString arr"
// can take a Lua table of strings with numeric indexes
//
// Note: We cheat by saying that it's derived from a wxArrayString to not
// have to duplicate it's methods. The binder doesn't know any better.

%class %delete %noclassinfo %encapsulate wxSortedArrayString, wxArrayString

    wxSortedArrayString()
    wxSortedArrayString(const wxArrayString& src) // have to have this constructor since they're not actually derived
    wxSortedArrayString(const wxSortedArrayString& src)

%endclass

%endif //wxLUA_USE_wxArrayString

// ---------------------------------------------------------------------------
// wxStringList - is deprecated in wxWidgets since 2.2

//%if wxLUA_USE_wxStringList
//%include "wx/list.h"
//%class %noclassinfo wxStringList, wxList
// wxStringList()
// wxNode *Add(const wxString& s)
// void Clear()
// void Delete(const wxString& s)
// bool Member(const wxString& s)
// void Sort()
//%endclass
//%endif wxLUA_USE_wxStringList

// ---------------------------------------------------------------------------
// wxHashTable - Lua tables are hashtables

//%if wxLUA_USE_wxHashTable

//%include "wx/hash.h"

//%if %wxchkver_2_6
//%class %noclassinfo wxHashTable::Node
//%endclass
//%endif

//%class %noclassinfo wxHashTable, wxObject
// !%wxchkver_2_6 wxHashTable(unsigned int key_type, int size = 1000)
// %wxchkver_2_6 wxHashTable(wxKeyType key_type, int size = 1000)
// void BeginFind()
// void Clear()
// wxObject * Delete(long key)
// void DeleteContents(bool flag)
// wxObject * Get(long key)
// wxObject * Get(const wxString &key)
// long MakeKey(const wxString& string)
// !%wxchkver_2_6 wxNode * Next()
// %wxchkver_2_6 wxHashTable::Node * Next()
// void Put(long key, wxObject *object)
// void Put(const wxString& key, wxObject *object)
// int GetCount() const
//%endclass

//%endif wxLUA_USE_wxHashTable

// ---------------------------------------------------------------------------
// wxLongLong

%if wxUSE_LONGLONG

%include "wx/longlong.h"

%class %delete %encapsulate %noclassinfo wxLongLong

    wxLongLong(long hi = 0, unsigned long lo = 0)

    wxLongLong Abs() const
    wxLongLong& Assign(double d)
    long GetHi() const
    unsigned long GetLo() const
    double ToDouble() const
    long ToLong() const
    wxString ToString() const

    //%operator wxLongLong operator+(const wxLongLong& ll) const
    //%operator wxLongLong& operator+(const wxLongLong& ll)
    //%operator wxLongLong& operator++()
    //%operator wxLongLong operator-() const
    //%operator wxLongLong operator-(const wxLongLong& ll) const

%endclass

// ---------------------------------------------------------------------------
// wxULongLong

%class %delete %encapsulate %noclassinfo wxULongLong

    wxULongLong(unsigned long hi = 0, unsigned long lo = 0)

    unsigned long GetHi() const
    unsigned long GetLo() const
    long ToULong() const
    wxString ToString() const

%endclass

%endif wxUSE_LONGLONG

wxwidgets/wxbase_datetime.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxDateTime and other time related classes and functions
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%include "wx/utils.h"
%include "wx/timer.h"

%function wxString wxNow()
%function long wxGetLocalTime()
%function long wxGetUTCTime()
%function wxLongLong wxGetLocalTimeMillis()
%wxcompat_2_6 %function void wxStartTimer() // deprecated in 2.8 use wxStopWatch
%wxcompat_2_6 %function long wxGetElapsedTime(bool resetTimer = true) // deprecated in 2.8 use wxStopWatch
%function void wxSleep(int secs)
%wxchkver_2_6 %function void wxMilliSleep(unsigned long milliseconds)
%wxchkver_2_6 %function void wxMicroSleep(unsigned long microseconds)
!%wxchkver_2_6 %function void wxUsleep(unsigned long milliseconds)

// ---------------------------------------------------------------------------
// wxDateTime

%if wxLUA_USE_wxDateTime && wxUSE_DATETIME

%include "wx/datetime.h"

%enum wxDateTime::TZ

    Local
    GMT_12
    GMT_11
    GMT_10
    GMT_9
    GMT_8
    GMT_7
    GMT_6
    GMT_5
    GMT_4
    GMT_3
    GMT_2
    GMT_1
    GMT0
    GMT1
    GMT2
    GMT3
    GMT4
    GMT5
    GMT6
    GMT7
    GMT8
    GMT9
    GMT10
    GMT11
    GMT12
    %wxchkver_2_8 GMT13
    WET
    WEST
    CET
    CEST
    EET
    EEST
    MSK
    MSD
    AST
    ADT
    EST
    EDT
    CST
    CDT
    MST
    MDT
    PST
    PDT
    HST
    AKST
    AKDT
    A_WST
    A_CST
    A_EST
    A_ESST
    %wxchkver_2_8 NZST
    %wxchkver_2_8 NZDT
    UTC

%endenum

%enum wxDateTime::Calendar

    Gregorian
    Julian

%endenum

%enum wxDateTime::Country

    Country_Unknown
    Country_Default
    Country_WesternEurope_Start
    Country_EEC
    France
    Germany
    UK
    Country_WesternEurope_End
    Russia
    USA

%endenum

%enum wxDateTime::Month

    Jan
    Feb
    Mar
    Apr
    May
    Jun
    Jul
    Aug
    Sep
    Oct
    Nov
    Dec
    Inv_Month

%endenum

%enum wxDateTime::WeekDay

    Sun
    Mon
    Tue
    Wed
    Thu
    Fri
    Sat
    Inv_WeekDay

%endenum

// GloaEdit: This was missing...
%enum wxDateTime::Year
	Inv_Year
%endenum

%typedef unsigned short wxDateTime::wxDateTime_t

%class %delete %noclassinfo %encapsulate wxDateTime

    %define_object wxDefaultDateTime

    wxDateTime()
    wxDateTime(time_t dateTime) // use with Lua's os.time() on MSW, Linux, others?
    %rename wxDateTimeFromJDN wxDateTime(double dateTime)
    %rename wxDateTimeFromHMS wxDateTime(int hour, int minute, int second, int millisec)
    %rename wxDateTimeFromDMY wxDateTime(int day, wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year, int hour = 0, int minute = 0, int second = 0, int millisec = 0)

    wxDateTime& SetToCurrent()
    wxDateTime& Set(time_t time) // use with Lua's os.time() on MSW, Linux, others?
    %rename SetToJDN wxDateTime& Set(double dateTime)
    %rename SetToHMS wxDateTime& Set(int hour, int minute, int second, int millisec)
    %rename SetToDMY wxDateTime& Set(int day, wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year, int hour = 0, int minute = 0, int second = 0, int millisec = 0)
    wxDateTime& ResetTime()
    wxDateTime& SetDay(int day)
    wxDateTime& SetMonth(wxDateTime::Month month)
    wxDateTime& SetYear(int year)
    wxDateTime& SetHour(int hour)
    wxDateTime& SetMinute(int minute)
    wxDateTime& SetSecond(int second)
    wxDateTime& SetMillisecond(int millisecond)
    bool IsWorkDay(wxDateTime::Country country = wxDateTime::Country_Default) const
    bool IsEqualTo(const wxDateTime& datetime) const
    bool IsEarlierThan(const wxDateTime& datetime) const
    bool IsLaterThan(const wxDateTime& datetime) const
    bool IsStrictlyBetween(const wxDateTime& t1, const wxDateTime& t2) const
    bool IsBetween(const wxDateTime& t1, const wxDateTime& t2) const
    bool IsSameDate(const wxDateTime& dt) const
    bool IsSameTime(const wxDateTime& dt) const
    bool IsEqualUpTo(const wxDateTime& dt, const wxTimeSpan& ts) const
    bool IsValid()
    long GetTicks()
    wxDateTime& SetToWeekDayInSameWeek(wxDateTime::WeekDay weekday)
    wxDateTime GetWeekDayInSameWeek(wxDateTime::WeekDay weekday) const
    wxDateTime& SetToNextWeekDay(wxDateTime::WeekDay weekday)
    wxDateTime GetNextWeekDay(wxDateTime::WeekDay weekday) const
    wxDateTime& SetToPrevWeekDay(wxDateTime::WeekDay weekday)
    wxDateTime GetPrevWeekDay(wxDateTime::WeekDay weekday) const
    bool SetToWeekDay(wxDateTime::WeekDay weekday, int n = 1, wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year)
    wxDateTime GetWeekDay(wxDateTime::WeekDay weekday, int n = 1, wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year) const
    bool SetToLastWeekDay(wxDateTime::WeekDay weekday, wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year)
    wxDateTime GetLastWeekDay(wxDateTime::WeekDay weekday, wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year)
    !%wxchkver_2_6 bool SetToTheWeek(wxDateTime::wxDateTime_t numWeek, wxDateTime::WeekDay weekday = wxDateTime::Mon)
    !%wxchkver_2_6 wxDateTime GetWeek(wxDateTime::wxDateTime_t numWeek, wxDateTime::WeekDay weekday = wxDateTime::Mon) const
    %wxchkver_2_6 static wxDateTime SetToWeekOfYear(int year, wxDateTime::wxDateTime_t numWeek, wxDateTime::WeekDay weekday = wxDateTime::Mon)
    wxDateTime& SetToLastMonthDay(wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year)
    wxDateTime GetLastMonthDay(wxDateTime::Month month = wxDateTime::Inv_Month, int year = wxDateTime::Inv_Year) const
    wxDateTime& SetToYearDay(wxDateTime::wxDateTime_t yday)
    wxDateTime GetYearDay(wxDateTime::wxDateTime_t yday) const
    double GetJulianDayNumber() const
    double GetJDN() const
    double GetModifiedJulianDayNumber() const
    double GetMJD() const
    double GetRataDie() const
    wxDateTime ToGMT(bool noDST = false) const
    wxDateTime& MakeGMT(bool noDST = false)
    int IsDST(wxDateTime::Country country = wxDateTime::Country_Default) const
    wxDateTime& Add(const wxTimeSpan& diff)
    wxDateTime& Add(const wxDateSpan& diff)
    wxDateTime& Subtract(const wxTimeSpan& diff)
    wxDateTime& Subtract(const wxDateSpan& diff)
    wxString ParseRfc822Date(wxString date)
    wxString ParseFormat(wxString date, wxString format = "%c", const wxDateTime& dateDef = wxDefaultDateTime)
    wxString ParseDateTime(wxString datetime)
    wxString ParseDate(wxString date)
    wxString ParseTime(wxString time)
    wxString FormatDate() const
    wxString FormatTime() const
    wxString FormatISODate() const
    wxString FormatISOTime() const
    wxString Format(wxString format = "%c", wxDateTime::TZ tz = wxDateTime::Local) const

%endclass

// ---------------------------------------------------------------------------
// wxDateTimeArray

%class %delete %noclassinfo %encapsulate wxDateTimeArray

    wxDateTimeArray()
    wxDateTimeArray(const wxDateTimeArray& array)

    void Add(const wxDateTime& dateTime, size_t copies = 1)
    void Alloc(size_t nCount)
    void Clear()
    void Empty()
    int GetCount() const
    void Insert(const wxDateTime& dt, int nIndex, size_t copies = 1)
    bool IsEmpty()
    wxDateTime Item(size_t nIndex) const
    wxDateTime Last()
    void RemoveAt(size_t nIndex, size_t count = 1)
    void Shrink()

%endclass

%endif //wxLUA_USE_wxDateTime && wxUSE_DATETIME

// ---------------------------------------------------------------------------
// wxTimeSpan

%if wxLUA_USE_wxTimeSpan && wxUSE_DATETIME

%include "wx/datetime.h"

%class %delete %noclassinfo %encapsulate wxTimeSpan

    wxTimeSpan()
    wxTimeSpan(long hours, long minutes = 0, long seconds = 0, long milliseconds = 0)

    wxTimeSpan Abs()
    wxTimeSpan Add(const wxTimeSpan& diff) const
    static wxTimeSpan Days(long days)
    static wxTimeSpan Day()
    wxString Format(wxString format = "%H:%M:%S") const
    int GetDays() const
    int GetHours() const
    wxLongLong GetMilliseconds() const
    int GetMinutes() const
    wxLongLong GetSeconds() const
    wxLongLong GetValue() const
    int GetWeeks() const
    static wxTimeSpan Hours(long hours)
    static wxTimeSpan Hour()
    bool IsEqualTo(const wxTimeSpan& ts) const
    bool IsLongerThan(const wxTimeSpan& ts) const
    bool IsNegative() const
    bool IsNull() const
    bool IsPositive() const
    bool IsShorterThan(const wxTimeSpan& ts) const
    static wxTimeSpan Minutes(long min)
    static wxTimeSpan Minute()
    wxTimeSpan Multiply(int n) const
    wxTimeSpan Negate() const
    wxTimeSpan& Neg()
    static wxTimeSpan Seconds(long sec)
    static wxTimeSpan Second()
    wxTimeSpan Subtract(const wxTimeSpan& diff) const
    static wxTimeSpan Weeks(long weeks)
    static wxTimeSpan Week()

%endclass

%endif //wxLUA_USE_wxTimeSpan && wxUSE_DATETIME

// ---------------------------------------------------------------------------
// wxDateSpan

%if wxLUA_USE_wxDateSpan && wxUSE_DATETIME

%include "wx/datetime.h"

%class %delete %noclassinfo %encapsulate wxDateSpan

    wxDateSpan(int years = 0, int months = 0, int weeks = 0, int days = 0)

    wxDateSpan Add(const wxDateSpan& other) const
    static wxDateSpan Day()
    static wxDateSpan Days(int days)
    int GetDays() const
    int GetMonths() const
    int GetTotalDays() const
    int GetWeeks() const
    int GetYears() const
    static wxDateSpan Month()
    static wxDateSpan Months(int mon)
    wxDateSpan Multiply(int factor) const
    wxDateSpan Negate() const
    wxDateSpan& Neg()
    wxDateSpan& SetDays(int n)
    wxDateSpan& SetMonths(int n)
    wxDateSpan& SetWeeks(int n)
    wxDateSpan& SetYears(int n)
    wxDateSpan Subtract(const wxDateSpan& other) const
    static wxDateSpan Week()
    static wxDateSpan Weeks(int weeks)
    static wxDateSpan Year()
    static wxDateSpan Years(int years)

    %operator bool operator==(wxDateSpan& other) const

%endclass

%endif //wxLUA_USE_wxDateSpan && wxUSE_DATETIME

// ---------------------------------------------------------------------------
// wxDateTimeHolidayAuthority

%if wxLUA_USE_wxDateTimeHolidayAuthority && wxUSE_DATETIME

%class %noclassinfo %encapsulate wxDateTimeHolidayAuthority

    // no constructor since this class has pure virtual functions

    static bool IsHoliday(const wxDateTime& dt)
    static size_t GetHolidaysInRange(const wxDateTime& dtStart, const wxDateTime& dtEnd, wxDateTimeArray& holidays)
    static void ClearAllAuthorities()
    static void AddAuthority(wxDateTimeHolidayAuthority *auth)

%endclass

// ---------------------------------------------------------------------------
// wxDateTimeWorkDays

%class %delete %noclassinfo %encapsulate wxDateTimeWorkDays, wxDateTimeHolidayAuthority

    wxDateTimeWorkDays()

%endclass

%endif //wxLUA_USE_wxDateTimeHolidayAuthority && wxUSE_DATETIME


// ---------------------------------------------------------------------------
// wxStopWatch

%if wxLUA_USE_wxStopWatch && wxUSE_STOPWATCH

%include "wx/stopwatch.h"

%class %delete %noclassinfo %encapsulate wxStopWatch

    wxStopWatch() // ctor starts the stop watch

    void Start(long t0 = 0) // start the stop watch at the moment t0
    void Pause()
    void Resume()
    long Time() const

%endclass

%endif // wxLUA_USE_wxStopWatch && wxUSE_STOPWATCH


// ---------------------------------------------------------------------------
// wxLocale

%include "wx/intl.h"

%if wxUSE_INTL

%enum wxLanguage

    // user's default/preffered language as got from OS:
    wxLANGUAGE_DEFAULT,
    // unknown language, if wxLocale::GetSystemLanguage fails:
    wxLANGUAGE_UNKNOWN,

    wxLANGUAGE_ABKHAZIAN,
    wxLANGUAGE_AFAR,
    wxLANGUAGE_AFRIKAANS,
    wxLANGUAGE_ALBANIAN,
    wxLANGUAGE_AMHARIC,
    wxLANGUAGE_ARABIC,
    wxLANGUAGE_ARABIC_ALGERIA,
    wxLANGUAGE_ARABIC_BAHRAIN,
    wxLANGUAGE_ARABIC_EGYPT,
    wxLANGUAGE_ARABIC_IRAQ,
    wxLANGUAGE_ARABIC_JORDAN,
    wxLANGUAGE_ARABIC_KUWAIT,
    wxLANGUAGE_ARABIC_LEBANON,
    wxLANGUAGE_ARABIC_LIBYA,
    wxLANGUAGE_ARABIC_MOROCCO,
    wxLANGUAGE_ARABIC_OMAN,
    wxLANGUAGE_ARABIC_QATAR,
    wxLANGUAGE_ARABIC_SAUDI_ARABIA,
    wxLANGUAGE_ARABIC_SUDAN,
    wxLANGUAGE_ARABIC_SYRIA,
    wxLANGUAGE_ARABIC_TUNISIA,
    wxLANGUAGE_ARABIC_UAE,
    wxLANGUAGE_ARABIC_YEMEN,
    wxLANGUAGE_ARMENIAN,
    wxLANGUAGE_ASSAMESE,
    wxLANGUAGE_AYMARA,
    wxLANGUAGE_AZERI,
    wxLANGUAGE_AZERI_CYRILLIC,
    wxLANGUAGE_AZERI_LATIN,
    wxLANGUAGE_BASHKIR,
    wxLANGUAGE_BASQUE,
    wxLANGUAGE_BELARUSIAN,
    wxLANGUAGE_BENGALI,
    wxLANGUAGE_BHUTANI,
    wxLANGUAGE_BIHARI,
    wxLANGUAGE_BISLAMA,
    wxLANGUAGE_BRETON,
    wxLANGUAGE_BULGARIAN,
    wxLANGUAGE_BURMESE,
    wxLANGUAGE_CAMBODIAN,
    wxLANGUAGE_CATALAN,
    wxLANGUAGE_CHINESE,
    wxLANGUAGE_CHINESE_SIMPLIFIED,
    wxLANGUAGE_CHINESE_TRADITIONAL,
    wxLANGUAGE_CHINESE_HONGKONG,
    wxLANGUAGE_CHINESE_MACAU,
    wxLANGUAGE_CHINESE_SINGAPORE,
    wxLANGUAGE_CHINESE_TAIWAN,
    wxLANGUAGE_CORSICAN,
    wxLANGUAGE_CROATIAN,
    wxLANGUAGE_CZECH,
    wxLANGUAGE_DANISH,
    wxLANGUAGE_DUTCH,
    wxLANGUAGE_DUTCH_BELGIAN,
    wxLANGUAGE_ENGLISH,
    wxLANGUAGE_ENGLISH_UK,
    wxLANGUAGE_ENGLISH_US,
    wxLANGUAGE_ENGLISH_AUSTRALIA,
    wxLANGUAGE_ENGLISH_BELIZE,
    wxLANGUAGE_ENGLISH_BOTSWANA,
    wxLANGUAGE_ENGLISH_CANADA,
    wxLANGUAGE_ENGLISH_CARIBBEAN,
    wxLANGUAGE_ENGLISH_DENMARK,
    wxLANGUAGE_ENGLISH_EIRE,
    wxLANGUAGE_ENGLISH_JAMAICA,
    wxLANGUAGE_ENGLISH_NEW_ZEALAND,
    wxLANGUAGE_ENGLISH_PHILIPPINES,
    wxLANGUAGE_ENGLISH_SOUTH_AFRICA,
    wxLANGUAGE_ENGLISH_TRINIDAD,
    wxLANGUAGE_ENGLISH_ZIMBABWE,
    wxLANGUAGE_ESPERANTO,
    wxLANGUAGE_ESTONIAN,
    wxLANGUAGE_FAEROESE,
    wxLANGUAGE_FARSI,
    wxLANGUAGE_FIJI,
    wxLANGUAGE_FINNISH,
    wxLANGUAGE_FRENCH,
    wxLANGUAGE_FRENCH_BELGIAN,
    wxLANGUAGE_FRENCH_CANADIAN,
    wxLANGUAGE_FRENCH_LUXEMBOURG,
    wxLANGUAGE_FRENCH_MONACO,
    wxLANGUAGE_FRENCH_SWISS,
    wxLANGUAGE_FRISIAN,
    wxLANGUAGE_GALICIAN,
    wxLANGUAGE_GEORGIAN,
    wxLANGUAGE_GERMAN,
    wxLANGUAGE_GERMAN_AUSTRIAN,
    wxLANGUAGE_GERMAN_BELGIUM,
    wxLANGUAGE_GERMAN_LIECHTENSTEIN,
    wxLANGUAGE_GERMAN_LUXEMBOURG,
    wxLANGUAGE_GERMAN_SWISS,
    wxLANGUAGE_GREEK,
    wxLANGUAGE_GREENLANDIC,
    wxLANGUAGE_GUARANI,
    wxLANGUAGE_GUJARATI,
    wxLANGUAGE_HAUSA,
    wxLANGUAGE_HEBREW,
    wxLANGUAGE_HINDI,
    wxLANGUAGE_HUNGARIAN,
    wxLANGUAGE_ICELANDIC,
    wxLANGUAGE_INDONESIAN,
    wxLANGUAGE_INTERLINGUA,
    wxLANGUAGE_INTERLINGUE,
    wxLANGUAGE_INUKTITUT,
    wxLANGUAGE_INUPIAK,
    wxLANGUAGE_IRISH,
    wxLANGUAGE_ITALIAN,
    wxLANGUAGE_ITALIAN_SWISS,
    wxLANGUAGE_JAPANESE,
    wxLANGUAGE_JAVANESE,
    wxLANGUAGE_KANNADA,
    wxLANGUAGE_KASHMIRI,
    wxLANGUAGE_KASHMIRI_INDIA,
    wxLANGUAGE_KAZAKH,
    wxLANGUAGE_KERNEWEK,
    wxLANGUAGE_KINYARWANDA,
    wxLANGUAGE_KIRGHIZ,
    wxLANGUAGE_KIRUNDI,
    wxLANGUAGE_KONKANI,
    wxLANGUAGE_KOREAN,
    wxLANGUAGE_KURDISH,
    wxLANGUAGE_LAOTHIAN,
    wxLANGUAGE_LATIN,
    wxLANGUAGE_LATVIAN,
    wxLANGUAGE_LINGALA,
    wxLANGUAGE_LITHUANIAN,
    wxLANGUAGE_MACEDONIAN,
    wxLANGUAGE_MALAGASY,
    wxLANGUAGE_MALAY,
    wxLANGUAGE_MALAYALAM,
    wxLANGUAGE_MALAY_BRUNEI_DARUSSALAM,
    wxLANGUAGE_MALAY_MALAYSIA,
    wxLANGUAGE_MALTESE,
    wxLANGUAGE_MANIPURI,
    wxLANGUAGE_MAORI,
    wxLANGUAGE_MARATHI,
    wxLANGUAGE_MOLDAVIAN,
    wxLANGUAGE_MONGOLIAN,
    wxLANGUAGE_NAURU,
    wxLANGUAGE_NEPALI,
    wxLANGUAGE_NEPALI_INDIA,
    wxLANGUAGE_NORWEGIAN_BOKMAL,
    wxLANGUAGE_NORWEGIAN_NYNORSK,
    wxLANGUAGE_OCCITAN,
    wxLANGUAGE_ORIYA,
    wxLANGUAGE_OROMO,
    wxLANGUAGE_PASHTO,
    wxLANGUAGE_POLISH,
    wxLANGUAGE_PORTUGUESE,
    wxLANGUAGE_PORTUGUESE_BRAZILIAN,
    wxLANGUAGE_PUNJABI,
    wxLANGUAGE_QUECHUA,
    wxLANGUAGE_RHAETO_ROMANCE,
    wxLANGUAGE_ROMANIAN,
    wxLANGUAGE_RUSSIAN,
    wxLANGUAGE_RUSSIAN_UKRAINE,
    wxLANGUAGE_SAMOAN,
    wxLANGUAGE_SANGHO,
    wxLANGUAGE_SANSKRIT,
    wxLANGUAGE_SCOTS_GAELIC,
    wxLANGUAGE_SERBIAN,
    wxLANGUAGE_SERBIAN_CYRILLIC,
    wxLANGUAGE_SERBIAN_LATIN,
    wxLANGUAGE_SERBO_CROATIAN,
    wxLANGUAGE_SESOTHO,
    wxLANGUAGE_SETSWANA,
    wxLANGUAGE_SHONA,
    wxLANGUAGE_SINDHI,
    wxLANGUAGE_SINHALESE,
    wxLANGUAGE_SISWATI,
    wxLANGUAGE_SLOVAK,
    wxLANGUAGE_SLOVENIAN,
    wxLANGUAGE_SOMALI,
    wxLANGUAGE_SPANISH,
    wxLANGUAGE_SPANISH_ARGENTINA,
    wxLANGUAGE_SPANISH_BOLIVIA,
    wxLANGUAGE_SPANISH_CHILE,
    wxLANGUAGE_SPANISH_COLOMBIA,
    wxLANGUAGE_SPANISH_COSTA_RICA,
    wxLANGUAGE_SPANISH_DOMINICAN_REPUBLIC,
    wxLANGUAGE_SPANISH_ECUADOR,
    wxLANGUAGE_SPANISH_EL_SALVADOR,
    wxLANGUAGE_SPANISH_GUATEMALA,
    wxLANGUAGE_SPANISH_HONDURAS,
    wxLANGUAGE_SPANISH_MEXICAN,
    wxLANGUAGE_SPANISH_MODERN,
    wxLANGUAGE_SPANISH_NICARAGUA,
    wxLANGUAGE_SPANISH_PANAMA,
    wxLANGUAGE_SPANISH_PARAGUAY,
    wxLANGUAGE_SPANISH_PERU,
    wxLANGUAGE_SPANISH_PUERTO_RICO,
    wxLANGUAGE_SPANISH_URUGUAY,
    wxLANGUAGE_SPANISH_US,
    wxLANGUAGE_SPANISH_VENEZUELA,
    wxLANGUAGE_SUNDANESE,
    wxLANGUAGE_SWAHILI,
    wxLANGUAGE_SWEDISH,
    wxLANGUAGE_SWEDISH_FINLAND,
    wxLANGUAGE_TAGALOG,
    wxLANGUAGE_TAJIK,
    wxLANGUAGE_TAMIL,
    wxLANGUAGE_TATAR,
    wxLANGUAGE_TELUGU,
    wxLANGUAGE_THAI,
    wxLANGUAGE_TIBETAN,
    wxLANGUAGE_TIGRINYA,
    wxLANGUAGE_TONGA,
    wxLANGUAGE_TSONGA,
    wxLANGUAGE_TURKISH,
    wxLANGUAGE_TURKMEN,
    wxLANGUAGE_TWI,
    wxLANGUAGE_UIGHUR,
    wxLANGUAGE_UKRAINIAN,
    wxLANGUAGE_URDU,
    wxLANGUAGE_URDU_INDIA,
    wxLANGUAGE_URDU_PAKISTAN,
    wxLANGUAGE_UZBEK,
    wxLANGUAGE_UZBEK_CYRILLIC,
    wxLANGUAGE_UZBEK_LATIN,
    wxLANGUAGE_VIETNAMESE,
    wxLANGUAGE_VOLAPUK,
    wxLANGUAGE_WELSH,
    wxLANGUAGE_WOLOF,
    wxLANGUAGE_XHOSA,
    wxLANGUAGE_YIDDISH,
    wxLANGUAGE_YORUBA,
    wxLANGUAGE_ZHUANG,
    wxLANGUAGE_ZULU,

    // for custom, user-defined languages:
    wxLANGUAGE_USER_DEFINED

%endenum

%enum wxFontEncoding

    wxFONTENCODING_SYSTEM // system default
    wxFONTENCODING_DEFAULT // current default encoding

    // ISO8859 standard defines a number of single-byte charsets
    wxFONTENCODING_ISO8859_1 // West European (Latin1)
    wxFONTENCODING_ISO8859_2 // Central and East European (Latin2)
    wxFONTENCODING_ISO8859_3 // Esperanto (Latin3)
    wxFONTENCODING_ISO8859_4 // Baltic (old) (Latin4)
    wxFONTENCODING_ISO8859_5 // Cyrillic
    wxFONTENCODING_ISO8859_6 // Arabic
    wxFONTENCODING_ISO8859_7 // Greek
    wxFONTENCODING_ISO8859_8 // Hebrew
    wxFONTENCODING_ISO8859_9 // Turkish (Latin5)
    wxFONTENCODING_ISO8859_10 // Variation of Latin4 (Latin6)
    wxFONTENCODING_ISO8859_11 // Thai
    wxFONTENCODING_ISO8859_12 // doesn't exist currently, but put it
    // here anyhow to make all ISO8859
    // consecutive numbers
    wxFONTENCODING_ISO8859_13 // Baltic (Latin7)
    wxFONTENCODING_ISO8859_14 // Latin8
    wxFONTENCODING_ISO8859_15 // Latin9 (a.k.a. Latin0, includes euro)
    wxFONTENCODING_ISO8859_MAX

    // Cyrillic charset soup (see http://czyborra.com/charsets/cyrillic.html)
    wxFONTENCODING_KOI8 // KOI8 Russian
    wxFONTENCODING_KOI8_U // KOI8 Ukrainian
    wxFONTENCODING_ALTERNATIVE // same as MS-DOS CP866
    wxFONTENCODING_BULGARIAN // used under Linux in Bulgaria

    // what would we do without Microsoft? They have their own encodings
    // for DOS
    wxFONTENCODING_CP437 // original MS-DOS codepage
    wxFONTENCODING_CP850 // CP437 merged with Latin1
    wxFONTENCODING_CP852 // CP437 merged with Latin2
    wxFONTENCODING_CP855 // another cyrillic encoding
    wxFONTENCODING_CP866 // and another one
    // and for Windows
    wxFONTENCODING_CP874 // WinThai
    wxFONTENCODING_CP932 // Japanese (shift-JIS)
    wxFONTENCODING_CP936 // Chinese simplified (GB)
    wxFONTENCODING_CP949 // Korean (Hangul charset)
    wxFONTENCODING_CP950 // Chinese (traditional - Big5)
    wxFONTENCODING_CP1250 // WinLatin2
    wxFONTENCODING_CP1251 // WinCyrillic
    wxFONTENCODING_CP1252 // WinLatin1
    wxFONTENCODING_CP1253 // WinGreek (8859-7)
    wxFONTENCODING_CP1254 // WinTurkish
    wxFONTENCODING_CP1255 // WinHebrew
    wxFONTENCODING_CP1256 // WinArabic
    wxFONTENCODING_CP1257 // WinBaltic (same as Latin 7)
    wxFONTENCODING_CP12_MAX

    wxFONTENCODING_UTF7 // UTF-7 Unicode encoding
    wxFONTENCODING_UTF8 // UTF-8 Unicode encoding
    wxFONTENCODING_EUC_JP // Extended Unix Codepage for Japanese
    wxFONTENCODING_UTF16BE // UTF-16 Big Endian Unicode encoding
    wxFONTENCODING_UTF16LE // UTF-16 Little Endian Unicode encoding
    wxFONTENCODING_UTF32BE // UTF-32 Big Endian Unicode encoding
    wxFONTENCODING_UTF32LE // UTF-32 Little Endian Unicode encoding

    wxFONTENCODING_MACROMAN // the standard mac encodings
    wxFONTENCODING_MACJAPANESE
    wxFONTENCODING_MACCHINESETRAD
    wxFONTENCODING_MACKOREAN
    wxFONTENCODING_MACARABIC
    wxFONTENCODING_MACHEBREW
    wxFONTENCODING_MACGREEK
    wxFONTENCODING_MACCYRILLIC
    wxFONTENCODING_MACDEVANAGARI
    wxFONTENCODING_MACGURMUKHI
    wxFONTENCODING_MACGUJARATI
    wxFONTENCODING_MACORIYA
    wxFONTENCODING_MACBENGALI
    wxFONTENCODING_MACTAMIL
    wxFONTENCODING_MACTELUGU
    wxFONTENCODING_MACKANNADA
    wxFONTENCODING_MACMALAJALAM
    wxFONTENCODING_MACSINHALESE
    wxFONTENCODING_MACBURMESE
    wxFONTENCODING_MACKHMER
    wxFONTENCODING_MACTHAI
    wxFONTENCODING_MACLAOTIAN
    wxFONTENCODING_MACGEORGIAN
    wxFONTENCODING_MACARMENIAN
    wxFONTENCODING_MACCHINESESIMP
    wxFONTENCODING_MACTIBETAN
    wxFONTENCODING_MACMONGOLIAN
    wxFONTENCODING_MACETHIOPIC
    wxFONTENCODING_MACCENTRALEUR
    wxFONTENCODING_MACVIATNAMESE
    wxFONTENCODING_MACARABICEXT
    wxFONTENCODING_MACSYMBOL
    wxFONTENCODING_MACDINGBATS
    wxFONTENCODING_MACTURKISH
    wxFONTENCODING_MACCROATIAN
    wxFONTENCODING_MACICELANDIC
    wxFONTENCODING_MACROMANIAN
    wxFONTENCODING_MACCELTIC
    wxFONTENCODING_MACGAELIC
    wxFONTENCODING_MACKEYBOARD

    wxFONTENCODING_MAX // highest enumerated encoding value

    wxFONTENCODING_MACMIN //= wxFONTENCODING_MACROMAN ,
    wxFONTENCODING_MACMAX //= wxFONTENCODING_MACKEYBOARD ,

    // aliases for endian-dependent UTF encodings
    wxFONTENCODING_UTF16 // native UTF-16
    wxFONTENCODING_UTF32 // native UTF-32

    // alias for the native Unicode encoding on this platform
    // (this is used by wxEncodingConverter and wxUTFFile only for now)
    wxFONTENCODING_UNICODE

    // alternative names for Far Eastern encodings
    // Chinese
    wxFONTENCODING_GB2312 // Simplified Chinese
    wxFONTENCODING_BIG5 // Traditional Chinese

    // Japanese (see http://zsigri.tripod.com/fontboard/cjk/jis.html)
    wxFONTENCODING_SHIFT_JIS // Shift JIS

%endenum

%enum wxLocaleCategory

    wxLOCALE_CAT_NUMBER, // (any) numbers
    wxLOCALE_CAT_DATE, // date/time
    wxLOCALE_CAT_MONEY, // monetary value
    wxLOCALE_CAT_MAX

%endenum

%enum wxLocaleInfo

    wxLOCALE_THOUSANDS_SEP, // the thounsands separator
    wxLOCALE_DECIMAL_POINT // the character used as decimal point

%endenum

%enum wxLocaleInitFlags

    wxLOCALE_LOAD_DEFAULT // load wxwin.mo?
    wxLOCALE_CONV_ENCODING // convert encoding on the fly?

%endenum

%if %wxchkver_2_8
%enum wxLayoutDirection

    wxLayout_Default
    wxLayout_LeftToRight
    wxLayout_RightToLeft

%endenum
%endif %wxchkver_2_8

%struct %delete %encapsulate wxLanguageInfo

    wxLanguageInfo() // you must set all the values by hand

    %member int Language; // wxLanguage id
    %member wxString CanonicalName; // Canonical name, e.g. fr_FR
    %member wxString Description; // human-readable name of the language
    %wxchkver_2_8 %member wxLayoutDirection LayoutDirection;

%endstruct


%class %delete %noclassinfo %encapsulate wxLocale


    // call Init() if you use this ctor
    wxLocale()

    // the ctor has a side effect of changing current locale
    // name (for messages), dir prefix (for msg files), locale (for setlocale), preload wxstd.mo?, convert Win<->Unix if necessary?
    wxLocale(const wxString& szName, const wxString& szShort = "", const wxString& szLocale = "", bool bLoadDefault = true, bool bConvertEncoding = false)

    // wxLanguage id or custom language
    wxLocale(int language, int flags = wxLOCALE_LOAD_DEFAULT | wxLOCALE_CONV_ENCODING)

    // the same as a function (returns true on success)
    //bool Init(const wxChar *szName, const wxChar *szShort = (const wxChar *) NULL, const wxChar *szLocale = (const wxChar *) NULL, bool bLoadDefault = true, bool bConvertEncoding = false)
    bool Init(const wxString &szName, const wxString &szShort = "", const wxString &szLocale = "", bool bLoadDefault = true, bool bConvertEncoding = false)

    // same as second ctor (returns true on success)
    bool Init(int language = wxLANGUAGE_DEFAULT, int flags = wxLOCALE_LOAD_DEFAULT | wxLOCALE_CONV_ENCODING);

    // Try to get user's (or OS's) preferred language setting.
    // Return wxLANGUAGE_UNKNOWN if language-guessing algorithm failed
    static int GetSystemLanguage()

    // get the encoding used by default for text on this system, returns
    // wxFONTENCODING_SYSTEM if it couldn't be determined
    static wxFontEncoding GetSystemEncoding();

    // get the string describing the system encoding, return empty string if
    // couldn't be determined
    static wxString GetSystemEncodingName();

    // get the values of the given locale-dependent datum: the current locale
    // is used, the US default value is returned if everything else fails
    static wxString GetInfo(wxLocaleInfo index, wxLocaleCategory cat);

    // return true if the locale was set successfully
    bool IsOk() const

    // returns locale name
    wxString GetLocale() const

    // return current locale wxLanguage value
    int GetLanguage() const

    // return locale name to be passed to setlocale()
    wxString GetSysName() const;

    // return 'canonical' name, i.e. in the form of xx[_YY], where xx is
    // language code according to ISO 639 and YY is country name
    // as specified by ISO 3166.
    wxString GetCanonicalName() const

    // add a prefix to the catalog lookup path: the message catalog files will be
    // looked up under prefix/<lang>/LC_MESSAGES, prefix/LC_MESSAGES and prefix
    // (in this order).
    //
    // This only applies to subsequent invocations of AddCatalog()!
    static void AddCatalogLookupPathPrefix(const wxString& prefix);

    // add a catalog: it's searched for in standard places (current directory
    // first, system one after), but the you may prepend additional directories to
    // the search path with AddCatalogLookupPathPrefix().
    //
    // The loaded catalog will be used for message lookup by GetString().
    //
    // Returns 'true' if it was successfully loaded
    bool AddCatalog(const wxString& szDomain);
    bool AddCatalog(const wxString& szDomain, wxLanguage msgIdLanguage, const wxString& msgIdCharset);

    // check if the given locale is provided by OS and C run time
    %wxchkver_2_8 static bool IsAvailable(int lang);

    // check if the given catalog is loaded
    bool IsLoaded(const wxString& szDomain) const;

    // Retrieve the language info struct for the given language
    //
    // Returns NULL if no info found, pointer must *not* be deleted by caller
    static const wxLanguageInfo *GetLanguageInfo(int lang);

    // Returns language name in English or empty string if the language
    // is not in database
    static wxString GetLanguageName(int lang);

    // Find the language for the given locale string which may be either a
    // canonical ISO 2 letter language code ("xx"), a language code followed by
    // the country code ("xx_XX") or a Windows full language name ("Xxxxx...")
    //
    // Returns NULL if no info found, pointer must *not* be deleted by caller
    static const wxLanguageInfo *FindLanguageInfo(const wxString& locale);

    // Add custom language to the list of known languages.
    // Notes: 1) wxLanguageInfo contains platform-specific data
    // 2) must be called before Init to have effect
    static void AddLanguage(const wxLanguageInfo& info);

    // retrieve the translation for a string in all loaded domains unless
    // the szDomain parameter is specified (and then only this domain is
    // searched)
    // n - additional parameter for PluralFormsParser
    //
    // return original string if translation is not available
    // (in this case an error message is generated the first time
    // a string is not found; use wxLogNull to suppress it)
    //
    // domains are searched in the last to first order, i.e. catalogs
    // added later override those added before.
    virtual wxString GetString(const wxString& szOrigString, const wxChar* szDomain = NULL) const;
    // plural form version of the same:
    virtual wxString GetString(const wxString& szOrigString, const wxString& szOrigString2, size_t n, const wxChar* szDomain = NULL) const;

    // Returns the current short name for the locale
    const wxString& GetName() const

    // return the contents of .po file header
    wxString GetHeaderValue( const wxString& szHeader, const wxString& szDomain = "" ) const;

%endclass

%function wxLocale* wxGetLocale()

%wxchkver_2_8 %function wxString wxGetTranslation(const wxString& sz, const wxChar* domain=NULL)
!%wxchkver_2_8 %function wxString wxGetTranslation(const wxString& sz)

%wxchkver_2_8 %rename wxGetTranslationPlural %function wxString wxGetTranslation(const wxString& sz1, const wxString& sz2, size_t n, const wxChar* domain=NULL)
!%wxchkver_2_8 %rename wxGetTranslationPlural %function wxString wxGetTranslation(const wxString& sz1, const wxString& sz2, size_t n)

%endif //wxUSE_INTL

wxwidgets/wxbase_file.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxFile, wxDir, wxFileName and file functions
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%include "wx/filefn.h"
%include "sys/stat.h"

// global functions from the wxWindow's functions docs

%function bool wxDirExists(const wxString& dirname)
%function bool wxFileExists(const wxString& filename)

// %override [new Lua string] wxDos2UnixFilename(Lua string)
// C++ Func: void wxDos2UnixFilename(wxChar *s)
%function wxString wxDos2UnixFilename(const wxString& s)
// %override wxDateTime wxFileModificationTime(const wxString& filename) (not overridden, just return wxDateTime)
// C++ Func: time_t wxFileModificationTime(const wxString& filename)
%function wxDateTime wxFileModificationTime(const wxString& filename)
//%function wxString wxFileNameFromPath(const wxString& path) // obsolete use wxFileName::SplitPath
%function wxString wxFindFirstFile(const wxString& spec, int flags = 0)
%function wxString wxFindNextFile()
// bool wxGetDiskSpace(const wxString& path, wxLongLong *total = NULL, wxLongLong *free = NULL)
//wxFileKind wxGetFileKind(FILE* fd)
%function wxString wxGetOSDirectory()
%function bool wxIsAbsolutePath(const wxString& filename)
%function wxString wxPathOnly(const wxString& path)
// %override [new Lua string] wxUnix2DosFilename(Lua string)
// C++ Func: void wxUnix2DosFilename(wxChar *s)
%function wxString wxUnix2DosFilename(const wxString& s)
%function bool wxConcatFiles(const wxString& file1, const wxString& file2,const wxString& file3)
%function bool wxCopyFile(const wxString& file1, const wxString& file2, bool overwrite = true)
%function wxString wxGetCwd()
//%function char* wxGetTempFileName(const wxString& prefix) // obsolete use wxFileName::CreateTempFileName
%function bool wxIsWild(const wxString& pattern)
%function bool wxMatchWild(const wxString& pattern, const wxString& text, bool dot_special)
%function bool wxMkdir(const wxString& dir, int perm = 0777)
//int wxParseCommonDialogsFilter(const wxString& wildCard, wxArrayString& descriptions, wxArrayString& filters)
%wxchkver_2_8 %function wxString wxRealPath(const wxString& path)
%function bool wxRemoveFile(const wxString& file)
!%wxchkver_2_8 %function bool wxRenameFile(const wxString& file1, const wxString& file2)
%wxchkver_2_8 %function bool wxRenameFile(const wxString& file1, const wxString& file2, bool overwrite = true)
%function bool wxRmdir(const wxString& dir, int flags=0)
%function bool wxSetWorkingDirectory(const wxString& dir)

%wxchkver_2_8 %function bool wxIsWritable(const wxString &path)
%wxchkver_2_8 %function bool wxIsReadable(const wxString &path)
%wxchkver_2_8 %function bool wxIsExecutable(const wxString &path)

// These two methods are for wxLua
// %override long wxFileSize(const wxString& fileName) - gets the filesize
%function long wxFileSize(const wxString& fileName)

// wxLua only has storage for wxChar* in bindings, wxFILE_SEP_XXX are #defined
// as wxChar wxT('.'), so we just redefine them to be wxT(".") or wxChar*
%define_string wxFILE_SEP_EXT wxT(".")
%define_string wxFILE_SEP_DSK wxT(":")
%define_string wxFILE_SEP_PATH_DOS wxT("\\")
%define_string wxFILE_SEP_PATH_UNIX wxT("/")
%define_string wxFILE_SEP_PATH_MAC wxT(":")
%define_string wxFILE_SEP_PATH_VMS wxT(".") // VMS also uses '[' and ']'

%define_string wxFILE_SEP_PATH wxLua_FILE_SEP_PATH // hack to convert from wxChar wxT('') to wxChar* wxT("")

%define_string wxPATH_SEP_DOS // wxT(";")
%define_string wxPATH_SEP_UNIX // wxT(":")
%define_string wxPATH_SEP_MAC // wxT(";")
%define_string wxPATH_SEP // wxPATH_SEP_XXX

%define wxARE_FILENAMES_CASE_SENSITIVE // bool 1/0

//%function bool wxIsPathSeparator(wxChar c) FIXME
%function bool wxEndsWithPathSeparator(const wxString& pszFileName)


// ---------------------------------------------------------------------------
// wxStandardPaths

%if %wxchkver_2_8 && wxLUA_USE_wxStandardPaths

%include "wx/stdpaths.h"

%enum wxStandardPaths::ResourceCat

    ResourceCat_None // no special category
    ResourceCat_Messages // message catalog resources
    ResourceCat_Max // end of enum marker

%endenum


%class %noclassinfo wxStandardPaths // we ignore wxStandardPathsBase

    // No constructor - use static Get() function

    // return the global standard paths object
    // %override static wxStandardPaths& Get();
    // C++ Func: static wxStandardPathsBase& Get();
    // We pretend that there is no wxStandardPathsBase and just use the wxStandardPaths name
    static wxStandardPaths& Get();

    // These are only for the generic version, probably not ever needed
    //void SetInstallPrefix(const wxString& prefix)
    //wxString GetInstallPrefix() const

    virtual wxString GetExecutablePath() const
    virtual wxString GetConfigDir() const
    virtual wxString GetUserConfigDir() const
    virtual wxString GetDataDir() const
    virtual wxString GetLocalDataDir() const
    virtual wxString GetUserDataDir() const
    virtual wxString GetUserLocalDataDir() const
    virtual wxString GetPluginsDir() const
    virtual wxString GetResourcesDir() const
    virtual wxString GetLocalizedResourcesDir(const wxString& lang, wxStandardPaths::ResourceCat category = wxStandardPaths::ResourceCat_None) const
    virtual wxString GetDocumentsDir() const
    virtual wxString GetTempDir() const;

%endclass

%endif // %wxchkver_2_8 && wxLUA_USE_wxStandardPaths


// ---------------------------------------------------------------------------
// wxPathList

%include "wx/filefn.h"

%class %delete %encapsulate %noclassinfo wxPathList, wxArrayString

    wxPathList()
    //wxPathList(const wxArrayString &arr)

    // Adds all paths in environment variable
    void AddEnvList(const wxString& envVariable)
    // Adds given path to this list
    !%wxchkver_2_8 void Add(const wxString& path)
    %wxchkver_2_8 bool Add(const wxString& path)
    %wxchkver_2_8 void Add(const wxArrayString& paths)
    // Find the first full path for which the file exists
    wxString FindValidPath(const wxString& filename) const
    // Find the first full path for which the file exists; ensure it's an
    // absolute path that gets returned.
    wxString FindAbsoluteValidPath(const wxString& filename) const
    // Given full path and filename, add path to list
    %not_overload !%wxchkver_2_8 void EnsureFileAccessible(const wxString& path)
    %not_overload %wxchkver_2_8 bool EnsureFileAccessible(const wxString& path)

%endclass

// ---------------------------------------------------------------------------
// wxFileName

%if wxLUA_USE_wxFileName

%include "wx/filename.h"

%define wxPATH_GET_VOLUME
%define wxPATH_GET_SEPARATOR
%define wxPATH_MKDIR_FULL

%define wxFILE
%define wxDIR

%enum wxPathFormat

    wxPATH_NATIVE
    wxPATH_UNIX
    wxPATH_MAC
    wxPATH_DOS
    wxPATH_VMS
    wxPATH_BEOS
    wxPATH_WIN
    wxPATH_OS2
    wxPATH_MAX

%endenum

%enum wxPathNormalize

    wxPATH_NORM_ENV_VARS
    wxPATH_NORM_DOTS
    wxPATH_NORM_TILDE
    wxPATH_NORM_CASE
    wxPATH_NORM_ABSOLUTE
    wxPATH_NORM_LONG
    wxPATH_NORM_SHORTCUT
    wxPATH_NORM_ALL

%endenum

%class %delete %noclassinfo %encapsulate wxFileName

    wxFileName()
    wxFileName(const wxFileName& filename)
    wxFileName(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)
    wxFileName(const wxString& path, const wxString& name, wxPathFormat format = wxPATH_NATIVE)
    wxFileName(const wxString& volume, const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE)

    void AppendDir(const wxString& dir)
    void Assign(const wxFileName& filepath)
    void Assign(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)
    void Assign(const wxString& volume, const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE)
    void Assign(const wxString& path, const wxString& name, wxPathFormat format = wxPATH_NATIVE)
    void Assign(const wxString& path, const wxString& name, const wxString& ext, wxPathFormat format = wxPATH_NATIVE)
    void AssignCwd(const wxString& volume = "")
    void AssignDir(const wxString& dir, wxPathFormat format = wxPATH_NATIVE)
    void AssignHomeDir()
    !%wxchkver_2_8 void AssignTempFileName(const wxString& prefix, wxFile *fileTemp = NULL)
    %wxchkver_2_8&&(wxUSE_FILE||wxUSE_FFILE) void AssignTempFileName(const wxString& prefix)
    %wxchkver_2_8&&wxUSE_FILE void AssignTempFileName(const wxString& prefix, wxFile *fileTemp)
    //%wxchkver_2_8&&wxUSE_FFILE void AssignTempFileName(const wxString& prefix, wxFFile *fileTemp)
    void Clear()
    void ClearExt()

    // Use AssignTempFileName(...) equivalents
    //!%wxchkver_2_8 static wxString CreateTempFileName(const wxString& prefix, wxFile *fileTemp = NULL)
    //%wxchkver_2_8&&(wxUSE_FILE||wxUSE_FFILE) static wxString CreateTempFileName(const wxString& prefix)
    //%wxchkver_2_8&&wxUSE_FILE static wxString CreateTempFileName(const wxString& prefix, wxFile *fileTemp)
    //%wxchkver_2_8&&wxUSE_FFILE static wxString CreateTempFileName(const wxString& prefix, wxFFile *fileTemp);

    bool DirExists()
    static bool DirExists(const wxString& dir)
    static wxFileName DirName(const wxString& dir)
    bool FileExists()
    static bool FileExists(const wxString& file)
    static wxFileName FileName(const wxString& file)
    static wxString GetCwd(const wxString& volume = "")
    int GetDirCount() const

    // %override [Lua string table] wxFileName::GetDirs()
    // C++ Func: const wxArrayString& GetDirs() const
    const wxArrayString& GetDirs() const

    wxString GetExt() const
    static wxString GetForbiddenChars(wxPathFormat format = wxPATH_NATIVE)
    static wxPathFormat GetFormat(wxPathFormat format = wxPATH_NATIVE)
    wxString GetFullName() const
    wxString GetFullPath(wxPathFormat format = wxPATH_NATIVE) const
    static wxString GetHomeDir()
    %wxchkver_2_8 wxString GetHumanReadableSize(const wxString &nullsize = "Not available", int precision = 1) const
    //%wxchkver_2_8 wxString GetHumanReadableSize(const wxString &nullsize = wxGetTranslation(_T("Not available")), int precision = 1) const
    //%wxchkver_2_8 static wxString GetHumanReadableSize(const wxULongLong &sz, const wxString &nullsize = wxGetTranslation(_T("Not available")), int precision = 1)
    wxString GetLongPath() const
    wxDateTime GetModificationTime() const
    wxString GetName() const
    wxString GetPath(int flags = 0, wxPathFormat format = wxPATH_NATIVE) const
    static int GetPathSeparator(wxPathFormat format = wxPATH_NATIVE)
    static wxString GetPathSeparators(wxPathFormat format = wxPATH_NATIVE)
    static wxString GetPathTerminators(wxPathFormat format = wxPATH_NATIVE)
    wxString GetPathWithSep(wxPathFormat format = wxPATH_NATIVE ) const
    wxString GetShortPath() const

    %if %wxchkver_2_8
    wxULongLong GetSize() const
    static wxULongLong GetSize(const wxString &file)
    %endif // %wxchkver_2_8

    // %override [bool, wxDateTime dtAccess, wxDateTime dtMod, wxDateTime dtCreate] wxFileName::GetTimes()
    // C++ Func: bool GetTimes(wxDateTime* dtAccess, wxDateTime* dtMod, wxDateTime* dtCreate) const
    bool GetTimes() const

    wxString GetVolume() const
    static wxString GetVolumeSeparator(wxPathFormat format = wxPATH_NATIVE)
    bool HasExt() const
    bool HasName() const
    bool HasVolume() const
    void InsertDir(int before, const wxString& dir)
    bool IsAbsolute(wxPathFormat format = wxPATH_NATIVE)
    static bool IsCaseSensitive(wxPathFormat format = wxPATH_NATIVE)
    bool IsOk() const
    static bool IsPathSeparator(int ch, wxPathFormat format = wxPATH_NATIVE)
    bool IsRelative(wxPathFormat format = wxPATH_NATIVE)
    bool IsDir() const

    %if %wxchkver_2_8
    bool IsDirWritable() const
    static bool IsDirWritable(const wxString &path)
    bool IsDirReadable() const
    static bool IsDirReadable(const wxString &path)
    bool IsFileWritable() const
    static bool IsFileWritable(const wxString &path)
    bool IsFileReadable() const
    static bool IsFileReadable(const wxString &path)
    bool IsFileExecutable() const
    static bool IsFileExecutable(const wxString &path)
    %endif // %wxchkver_2_8

    //static bool MacFindDefaultTypeAndCreator(const wxString& ext, wxUint32* type, wxUint32* creator)
    //bool MacSetDefaultTypeAndCreator()
    bool MakeAbsolute(const wxString& cwd = "", wxPathFormat format = wxPATH_NATIVE)
    bool MakeRelativeTo(const wxString& pathBase = "", wxPathFormat format = wxPATH_NATIVE)
    bool Mkdir(int perm = 4095, int flags = 0)
    static bool Mkdir(const wxString& dir, int perm = 4095, int flags = 0)
    bool Normalize(int flags = wxPATH_NORM_ALL, const wxString& cwd = wxEmptyString, wxPathFormat format = wxPATH_NATIVE)
    void PrependDir(const wxString& dir)
    void RemoveDir(int pos)
    void RemoveLastDir()
    bool Rmdir()
    static bool Rmdir(const wxString& dir)
    bool SameAs(const wxFileName& filepath, wxPathFormat format = wxPATH_NATIVE) const
    bool SetCwd()
    static bool SetCwd(const wxString& cwd)
    void SetExt(const wxString& ext)
    void SetEmptyExt()
    void SetFullName(const wxString& fullname)
    void SetName(const wxString& name)
    bool SetTimes(const wxDateTime* dtAccess, const wxDateTime* dtMod, const wxDateTime* dtCreate)
    void SetVolume(const wxString& volume)

    // %override [wxString path, wxString name, wxString ext] wxFileName::SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)
    // C++ Func: static void SplitPath(const wxString& fullpath, wxString* path, wxString* name, wxString* ext, wxPathFormat format = wxPATH_NATIVE)
    static void SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)

    // %override [wxString volume, wxString path, wxString name, wxString ext] wxFileName::SplitPathVolume(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)
    // C++ Func: static void SplitPath(const wxString& fullpath, wxString* volume, wxString* path, wxString* name, wxString* ext, wxPathFormat format = wxPATH_NATIVE)
    %rename SplitPathVolume static void SplitPath(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)

    // %override [wxString volume, wxString path] wxFileName::SplitVolume(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)
    // C++ Func: static void SplitVolume(const wxString& fullpath, wxString* volume, wxString* path, wxPathFormat format = wxPATH_NATIVE)
    static void SplitVolume(const wxString& fullpath, wxPathFormat format = wxPATH_NATIVE)

    bool Touch()

    %operator wxFileName& operator=(const wxFileName& filename)
    %operator bool operator==(const wxFileName& filename) const

%endclass

%endif //wxLUA_USE_wxFileName

// ---------------------------------------------------------------------------
// wxFile

%if wxLUA_USE_wxFile && wxUSE_FILE

%include "wx/file.h"

%enum wxFile::OpenMode

    read
    write
    read_write
    write_append
    write_excl

%endenum

%enum wxFile::dummy

    fd_invalid // = -1
    fd_stdin
    fd_stdout
    fd_stderr

%endenum

%enum wxSeekMode

    wxFromStart
    wxFromCurrent
    wxFromEnd
    wxInvalidOffset

%endenum

%enum wxFileKind

    wxFILE_KIND_UNKNOWN
    wxFILE_KIND_DISK
    wxFILE_KIND_TERMINAL
    wxFILE_KIND_PIPE

%endenum

%define wxS_IRUSR
%define wxS_IWUSR
%define wxS_IXUSR
%define wxS_IRGRP
%define wxS_IWGRP
%define wxS_IXGRP
%define wxS_IROTH
%define wxS_IWOTH
%define wxS_IXOTH
%define wxS_DEFAULT

%class %delete %noclassinfo %encapsulate wxFile

    wxFile()
    wxFile(const wxString& filename, wxFile::OpenMode mode = wxFile::read)

    static bool Access(const wxString& name, wxFile::OpenMode mode)
    void Attach(int fd)
    void Close()
    bool Create(const wxString& filename, bool overwrite = false, int access = wxS_DEFAULT)
    void Detach()
    int fd() const
    bool Eof() const
    static bool Exists(const wxString& name)
    bool Flush()
    wxFileKind GetKind() const
    bool IsOpened() const
    wxFileOffset Length() const
    bool Open(const wxString& filename, wxFile::OpenMode mode = wxFile::read)

    // %override [size_t count, Lua string] wxFile::Read(unsigned int count)
    // C++ Func: size_t Read(void* buffer, unsigned int count)
    size_t Read(unsigned int count)

    wxFileOffset Seek(wxFileOffset offset, wxSeekMode mode = wxFromStart)
    wxFileOffset SeekEnd(wxFileOffset offset = 0)
    wxFileOffset Tell() const

    // %override size_t wxFile::Write(Lua string, unsigned int count)
    // C++ Func: size_t Write(const void* buffer, unsigned int count)
    size_t Write(const wxString& buffer, unsigned int count)

    size_t Write(const wxString &str) //, const wxMBConv& conv = wxConvUTF8)

%endclass

// ---------------------------------------------------------------------------
// wxTempFile

%include "wx/file.h"

%class %delete %noclassinfo %encapsulate wxTempFile

    wxTempFile()
    // associates the temp file with the file to be replaced and opens it
    wxTempFile(const wxString& strName)

    // open the temp file (strName is the name of file to be replaced)
    bool Open(const wxString& strName)

    // is the file opened?
    bool IsOpened() const
    // get current file length
    wxFileOffset Length() const
    // move ptr ofs bytes related to start/current offset/end of file
    wxFileOffset Seek(wxFileOffset ofs, wxSeekMode mode = wxFromStart)
    // get current offset
    wxFileOffset Tell() const

    // I/O (both functions return true on success, false on failure)
    //bool Write(const void *p, size_t n)
    bool Write(const wxString& str) //, const wxMBConv& conv = wxConvUTF8)

    // validate changes and delete the old file of name m_strName
    bool Commit()
    // discard changes
    void Discard();

%endclass

%endif //wxLUA_USE_wxFile && wxUSE_FILE

// ---------------------------------------------------------------------------
// wxDir

%if wxLUA_USE_wxDir

%include "wx/dir.h"

%define wxDIR_FILES
%define wxDIR_DIRS
%define wxDIR_HIDDEN
%define wxDIR_DOTDOT
%define wxDIR_DEFAULT

%class %delete %noclassinfo %encapsulate wxDir

    wxDir()
    wxDir(const wxString& dir)

    static bool Exists(const wxString& dir)

    // %override [unsigned int, Lua string table] wxDir::GetAllFiles(const wxString& dirname, const wxString& filespec = "", int flags = wxDIR_DEFAULT)
    // C++ Func: static unsigned int GetAllFiles(const wxString& dirname, wxArrayString *files, const wxString& filespec = "", int flags = wxDIR_DEFAULT)
    static unsigned int GetAllFiles(const wxString& dirname, const wxString& filespec = "", int flags = wxDIR_DEFAULT)

    // %override [bool, string filename] wxDir::GetFirst(const wxString& filespec = "", int flags = wxDIR_DEFAULT)
    // C++ Func: bool GetFirst(wxString * filename, const wxString& filespec = "", int flags = wxDIR_DEFAULT) const
    bool GetFirst(const wxString& filespec = "", int flags = wxDIR_DEFAULT) const

    wxString GetName() const

    // %override [bool, string filename] wxDir::GetNext()
    // C++ Func: bool GetNext(wxString * filename) const
    bool GetNext() const

    bool HasFiles(const wxString& filespec = "")
    bool HasSubDirs(const wxString& dirspec = "")
    bool IsOpened() const
    bool Open(const wxString& dir)

    %if %wxchkver_2_8
    static wxString FindFirst(const wxString& dirname, const wxString& filespec, int flags = wxDIR_DEFAULT)
    static wxULongLong GetTotalSize(const wxString &dir) //, wxArrayString *filesSkipped = NULL) FIXME override
    %endif // %wxchkver_2_8

    // We don't need wxDirTraverser, just use wxDir methods GetFirst, GetNext.
    //size_t Traverse(wxDirTraverser& sink, const wxString& filespec = wxEmptyString, int flags = wxDIR_DEFAULT)

%endclass

%endif //wxLUA_USE_wxDir

// ---------------------------------------------------------------------------
// wxFileTypeInfo

%include "wx/mimetype.h"

%class %delete %noclassinfo %encapsulate wxFileTypeInfo

    // the ... parameters form a NULL terminated list of extensions
    //wxFileTypeInfo(const wxChar *mimeType, const wxChar *openCmd, const wxChar *printCmd, const wxChar *desc, ...)
    // the array elements correspond to the parameters of the ctor above in the same order
    wxFileTypeInfo(const wxArrayString& sArray)

    // invalid item - use this to terminate the array passed to wxMimeTypesManager::AddFallbacks
    wxFileTypeInfo()

    bool IsValid() const

    void SetIcon(const wxString& iconFile, int iconIndex = 0)
    void SetShortDesc(const wxString& shortDesc)

    wxString GetMimeType() const
    wxString GetOpenCommand() const
    wxString GetPrintCommand() const
    wxString GetShortDesc() const
    wxString GetDescription() const
    wxArrayString GetExtensions() const
    size_t GetExtensionsCount() const
    wxString GetIconFile() const
    int GetIconIndex() const

%endclass

// ---------------------------------------------------------------------------
// wxIconLocation

%include "wx/iconloc.h"

%class %delete %noclassinfo %encapsulate wxIconLocation

    // ctor takes the name of the file where the icon is
    !%msw wxIconLocation(const wxString& filename = "")
    %msw wxIconLocation(const wxString& file = "", int num = 0)

    // returns true if this object is valid/initialized
    bool IsOk() const

    // set/get the icon file name
    void SetFileName(const wxString& filename)
    const wxString& GetFileName() const

    // set/get the icon index
    %msw void SetIndex(int num)
    %msw int GetIndex() const

%endclass

// ---------------------------------------------------------------------------
// wxFileType::MessageParameters

%class %delete %noclassinfo %encapsulate wxFileType::MessageParameters

    //wxFileType::MessageParameters()
    wxFileType::MessageParameters(const wxString& filename, const wxString& mimetype = "")

    // accessors (called by GetOpenCommand)
    wxString GetFileName() const
    wxString GetMimeType() const

    // override this function in derived class
    virtual wxString GetParamValue(const wxString& name) const

%endclass

// ---------------------------------------------------------------------------
// wxFileType

%class %delete %noclassinfo %encapsulate wxFileType

    wxFileType(const wxFileTypeInfo& ftInfo)

    // accessors: all of them return true if the corresponding information
    // could be retrieved/found, false otherwise (and in this case all [out] parameters are unchanged)

    // return the MIME type for this file type
    //bool GetMimeType(wxString *mimeType) const;
    bool GetMimeTypes(wxArrayString& mimeTypes) const;

    bool GetExtensions(wxArrayString& extensions);

    // get the icon corresponding to this file type and of the given size
    bool GetIcon(wxIconLocation *iconloc) const;
    //bool GetIcon(wxIconLocation *iconloc, const wxFileType::MessageParameters& params) const;

    // get a brief file type description ("*.txt" => "text document")
    // %override [bool, Lua string] wxFileType::GetDescription() const;
    // C++ Func: bool GetDescription(wxString *desc) const
    bool GetDescription() const

    // get the command to be used to open/print the given file.
    //bool GetOpenCommand(wxString *openCmd, const wxFileType::MessageParameters& params) const;
    // a simpler to use version of GetOpenCommand() -- it only takes the
    // filename and returns an empty string on failure
    wxString GetOpenCommand(const wxString& filename) const;

    // get the command to print the file of given type
    // %override [bool, Lua string] wxFileType::GetPrintCommand(const wxFileType::MessageParameters& params) const;
    // C++ Func: bool GetPrintCommand(wxString *printCmd, const wxFileType::MessageParameters& params) const;
    bool GetPrintCommand(const wxFileType::MessageParameters& params) const;

    // return the number of commands defined for this file type, 0 if none
    size_t GetAllCommands(wxArrayString *verbs, wxArrayString *commands, const wxFileType::MessageParameters& params) const;

    // set an arbitrary command, ask confirmation if it already exists and overwriteprompt is true
    bool SetCommand(const wxString& cmd, const wxString& verb, bool overwriteprompt = true)

    bool SetDefaultIcon(const wxString& cmd = "", int index = 0)

    // remove the association for this filetype from the system MIME database:
    // notice that it will only work if the association is defined in the user
    // file/registry part, we will never modify the system-wide settings
    bool Unassociate();

    // expand a string in the format of GetOpenCommand (which may contain
    // '%s' and '%t' format specificators for the file name and mime type
    // and %{param} constructions).
    static wxString ExpandCommand(const wxString& command, const wxFileType::MessageParameters& params);

%endclass

// ---------------------------------------------------------------------------
// wxMimeTypesManager

%class %noclassinfo %encapsulate wxMimeTypesManager

    %define_pointer wxTheMimeTypesManager

    // wxMimeTypesManager(); - Use pointer wxTheMimeTypesManager

    // check if the given MIME type is the same as the other one: the
    // second argument may contain wildcards ('*'), but not the first. If
    // the types are equal or if the mimeType matches wildcard the function
    // returns true, otherwise it returns false
    static bool IsOfType(const wxString& mimeType, const wxString& wildcard);

    // NB: the following 2 functions are for Unix only and don't do anything elsewhere

    // loads data from standard files according to the mailcap styles
    // specified: this is a bitwise OR of wxMailcapStyle values
    //
    // use the extraDir parameter if you want to look for files in another
    // directory
    void Initialize(int mailcapStyle = wxMAILCAP_ALL, const wxString& extraDir = "");
    // and this function clears all the data from the manager
    void ClearData();

    // Database lookup: all functions return a pointer to wxFileType object
    // whose methods may be used to query it for the information you're
    // interested in. If the return value is !NULL, caller is responsible for
    // deleting it.
    // get file type from file extension
    wxFileType *GetFileTypeFromExtension(const wxString& ext);
    // get file type from MIME type (in format <category>/<format>)
    wxFileType *GetFileTypeFromMimeType(const wxString& mimeType);

    bool ReadMailcap(const wxString& filename, bool fallback = false);
    // read in additional file in mime.types format
    bool ReadMimeTypes(const wxString& filename);

    // enumerate all known MIME types returns the number of retrieved file types
    size_t EnumAllFileTypes(wxArrayString& mimetypes);

    // The filetypes array should be terminated by either NULL entry or an
    // invalid wxFileTypeInfo (i.e. the one created with default ctor)
    //void AddFallbacks(const wxFileTypeInfo *filetypes);
    void AddFallback(const wxFileTypeInfo& ft)

    // create a new association using the fields of wxFileTypeInfo (at least
    // the MIME type and the extension should be set)
    // if the other fields are empty, the existing values should be left alone
    wxFileType *Associate(const wxFileTypeInfo& ftInfo)

    // undo Associate()
    bool Unassociate(wxFileType *ft)

%endclass

// ---------------------------------------------------------------------------
// wxStreamBase

%if wxUSE_STREAMS

%include "wx/stream.h"
%include "wx/txtstrm.h"

%enum wxEOL

    wxEOL_NATIVE
    wxEOL_UNIX
    wxEOL_MAC
    wxEOL_DOS

%endenum

%enum wxStreamError

    wxSTREAM_NO_ERROR
    wxSTREAM_EOF
    wxSTREAM_WRITE_ERROR
    wxSTREAM_READ_ERROR

%endenum

// ---------------------------------------------------------------------------
// wxStreamBase

%class %noclassinfo wxStreamBase

    // wxStreamBase() this is only a base class

    %wxchkver_2_6 wxFileOffset GetLength() const
    wxStreamError GetLastError() const
    size_t GetSize() const
    bool IsOk() const
    bool IsSeekable() const
    void Reset()

%endclass

// ---------------------------------------------------------------------------
// wxInputStream

%class %noclassinfo %encapsulate wxInputStream, wxStreamBase

    // wxInputStream() this is only a base class

    bool CanRead() const
    char GetC()
    bool Eof()
    size_t LastRead() const
    char Peek()

    // %override [Lua string] wxInputStream::Read(size_t size)
    // C++ Func: wxInputStream& Read(void *buffer, size_t size)
    wxString Read(size_t size)

    wxInputStream& Read(wxOutputStream& stream_in)
    wxFileOffset SeekI(wxFileOffset pos, wxSeekMode mode = wxFromStart)
    wxFileOffset TellI() const

    // %override size_t wxInputStream::Ungetch(Lua string, size_t size)
    // C++ Func: size_t Ungetch(const char* buffer, size_t size)
    %override_name wxLua_wxInputStream_UngetchString size_t Ungetch(const wxString& str, size_t size)

    bool Ungetch(char c)

%endclass

// ---------------------------------------------------------------------------
// wxOutputStream

%class %noclassinfo %encapsulate wxOutputStream, wxStreamBase

    // wxOutputStream() this is only a base class

    bool Close()
    size_t LastWrite() const
    void PutC(char c)
    wxFileOffset SeekO(wxFileOffset pos, wxSeekMode mode = wxFromStart)
    wxFileOffset TellO() const

    // %override wxOutputStream& wxOutputStream::Write(Lua string, size_t size)
    // C++ Func: wxOutputStream& Write(const void *buffer, size_t size)
    wxOutputStream& Write(const wxString& buffer, size_t size)

    wxOutputStream& Write(wxInputStream& stream_in)

%endclass

// ---------------------------------------------------------------------------
// wxFileInputStream

%include "wx/wfstream.h"

%class %delete %noclassinfo %encapsulate wxFileInputStream, wxInputStream

    wxFileInputStream(const wxString& fileName)
    wxFileInputStream(wxFile& file)
    //wxFileInputStream(int fd)

    bool Ok() const

%endclass

// ---------------------------------------------------------------------------
// wxFileOutputStream

%class %delete %noclassinfo %encapsulate wxFileOutputStream, wxOutputStream

    wxFileOutputStream(const wxString& fileName)
    wxFileOutputStream(wxFile& file)
    //wxFileOutputStream(int fd)

    bool Ok() const

%endclass

// ---------------------------------------------------------------------------
// wxMemoryInputStream

%include "wx/mstream.h"

%class %delete %noclassinfo %encapsulate wxMemoryInputStream, wxInputStream

    wxMemoryInputStream(const char *data, size_t length)
    //wxMemoryInputStream(const wxMemoryOutputStream& stream)

%endclass

// ---------------------------------------------------------------------------
// wxMemoryOutputStream

//%include "wx/mstream.h"

//%class %delete %noclassinfo %encapsulate wxMemoryInputStream, wxInputStream
// wxMemoryOutputStream(void *data, size_t length)
// wxMemoryInputStream(const wxMemoryOutputStream& stream)
//%endclass

// ---------------------------------------------------------------------------
// wxDataInputStream

%include "wx/datstrm.h"

%class %delete %noclassinfo %encapsulate wxDataInputStream

    // wxDataInputStream(wxInputStream& s, const wxMBConv& conv = wxConvAuto());
    wxDataInputStream(wxInputStream& s)

    bool IsOk()

    //#if wxHAS_INT64
    // wxUint64 Read64()
    //#endif
    //#if wxUSE_LONGLONG
    // wxLongLong ReadLL()
    //#endif
    wxUint32 Read32()
    wxUint16 Read16()
    wxUint8 Read8()
    double ReadDouble()
    wxString ReadString()

    //#if wxHAS_INT64
    // void Read64(wxUint64 *buffer, size_t size)
    // void Read64(wxInt64 *buffer, size_t size)
    //#endif
    //#if defined(wxLongLong_t) && wxUSE_LONGLONG
    // void Read64(wxULongLong *buffer, size_t size)
    // void Read64(wxLongLong *buffer, size_t size)
    //#endif
    //#if wxUSE_LONGLONG
    // void ReadLL(wxULongLong *buffer, size_t size)
    // void ReadLL(wxLongLong *buffer, size_t size)
    //#endif
    //void Read32(wxUint32 *buffer, size_t size)
    //void Read16(wxUint16 *buffer, size_t size)
    //void Read8(wxUint8 *buffer, size_t size)
    //void ReadDouble(double *buffer, size_t size)

    void BigEndianOrdered(bool be_order)

%endclass

// ---------------------------------------------------------------------------
// wxDataOutputStream

%include "wx/datstrm.h"

%class %delete %noclassinfo %encapsulate wxDataOutputStream

    // wxDataOutputStream(wxOutputStream& s, const wxMBConv& conv = wxConvAuto());
    wxDataOutputStream(wxOutputStream& s);

    bool IsOk()

    //#if wxHAS_INT64
    // void Write64(wxUint64 i);
    // void Write64(wxInt64 i);
    //#endif
    //#if wxUSE_LONGLONG
    // void WriteLL(const wxLongLong &ll);
    // void WriteLL(const wxULongLong &ll);
    //#endif
    void Write32(wxUint32 i)
    void Write16(wxUint16 i)
    void Write8(wxUint8 i)
    void WriteDouble(double d)
    void WriteString(const wxString& string)

    //#if wxHAS_INT64
    // void Write64(const wxUint64 *buffer, size_t size);
    // void Write64(const wxInt64 *buffer, size_t size);
    //#endif
    //#if defined(wxLongLong_t) && wxUSE_LONGLONG
    // void Write64(const wxULongLong *buffer, size_t size);
    // void Write64(const wxLongLong *buffer, size_t size);
    //#endif
    //#if wxUSE_LONGLONG
    // void WriteLL(const wxULongLong *buffer, size_t size);
    // void WriteLL(const wxLongLong *buffer, size_t size);
    //#endif
    //void Write32(const wxUint32 *buffer, size_t size);
    //void Write16(const wxUint16 *buffer, size_t size);
    //void Write8(const wxUint8 *buffer, size_t size);
    //void WriteDouble(const double *buffer, size_t size);

    void BigEndianOrdered(bool be_order)

%endclass



// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
// wxFSFile

%if wxUSE_FILESYSTEM // already has wxUSE_STREAMS

%include "wx/filesys.h"


%class %delete wxFSFile, wxObject

    wxFSFile(%ungc wxInputStream *stream, const wxString& loc, const wxString& mimetype, const wxString& anchor, wxDateTime modif)

    // returns stream. This doesn't give away ownership of the stream object.
    wxInputStream *GetStream() const
    // gives away the ownership of the current stream.
    %gc wxInputStream *DetachStream()
    // deletes the current stream and takes ownership of another.
    void SetStream(%ungc wxInputStream *stream)

    // returns file's mime type
    wxString GetMimeType() const
    // returns the original location (aka filename) of the file
    wxString GetLocation() const
    wxString GetAnchor() const
    wxDateTime GetModificationTime() const

%endclass


// ---------------------------------------------------------------------------
// wxFileSystemHandler

%class %delete wxFileSystemHandler, wxObject

    // wxFileSystemHandler() // no constructor since it has abstract functions

    // returns true if this handler is able to open given location
    virtual bool CanOpen(const wxString& location) //= 0;

    // opens given file and returns pointer to input stream.
    // Returns NULL if opening failed.
    // The location is always absolute path.
    virtual wxFSFile* OpenFile(wxFileSystem& fs, const wxString& location) //= 0;

    // Finds first/next file that matches spec wildcard. flags can be wxDIR for restricting
    // the query to directories or wxFILE for files only or 0 for either.
    // Returns filename or empty string if no more matching file exists
    virtual wxString FindFirst(const wxString& spec, int flags = 0);
    virtual wxString FindNext();

%endclass


// ---------------------------------------------------------------------------
// wxLocalFSHandler


%class %delete wxLocalFSHandler, wxFileSystemHandler

    wxLocalFSHandler()

    // wxLocalFSHandler will prefix all filenames with 'root' before accessing
    // files on disk. This effectively makes 'root' the top-level directory
    // and prevents access to files outside this directory.
    // (This is similar to Unix command 'chroot'.)
    static void Chroot(const wxString& root)

%endclass


// ---------------------------------------------------------------------------
// wxFileSystem

%enum

    wxFS_READ // Open for reading
    wxFS_SEEKABLE // Returned stream will be seekable

%endenum

%class %delete wxFileSystem, wxObject

    wxFileSystem()

    // sets the current location. Every call to OpenFile is
    // relative to this location.
    // NOTE !!
    // unless is_dir = true 'location' is *not* the directory but
    // file contained in this directory
    // (so ChangePathTo("dir/subdir/xh.htm") sets m_Path to "dir/subdir/")
    void ChangePathTo(const wxString& location, bool is_dir = false);

    wxString GetPath() const

    // opens given file and returns pointer to input stream.
    // Returns NULL if opening failed.
    // It first tries to open the file in relative scope
    // (based on ChangePathTo()'s value) and then as an absolute
    // path.
    wxFSFile* OpenFile(const wxString& location, int flags = wxFS_READ);

    // Finds first/next file that matches spec wildcard. flags can be wxDIR for restricting
    // the query to directories or wxFILE for files only or 0 for either.
    // Returns filename or empty string if no more matching file exists
    wxString FindFirst(const wxString& spec, int flags = 0);
    wxString FindNext();

    // find a file in a list of directories, returns false if not found
    // %override [bool, Lua string full_path] FindFileInPath(const wxString& path, const wxString& file);
    // C++ Func: bool FindFileInPath(wxString *pStr, const wxChar *path, const wxChar *file);
    bool FindFileInPath(const wxString& path, const wxString& file);

    // Adds FS handler.
    // In fact, this class is only front-end to the FS handlers :-)
    static void AddHandler(wxFileSystemHandler *handler);

    // Removes FS handler
    static wxFileSystemHandler* RemoveHandler(wxFileSystemHandler *handler);

    // Returns true if there is a handler which can open the given location.
    static bool HasHandlerForPath(const wxString& location);

    // remove all items from the m_Handlers list
    static void CleanUpHandlers();

    // Returns the native path for a file URL
    static wxFileName URLToFileName(const wxString& url);

    // Returns the file URL for a native path
    static wxString FileNameToURL(const wxFileName& filename);

%endclass


// ---------------------------------------------------------------------------
// wxArchiveFSHandler

%include "wx/fs_arc.h"

%class %delete wxArchiveFSHandler, wxFileSystemHandler

    wxArchiveFSHandler()

%endclass

// ---------------------------------------------------------------------------
// wxZipFSHandler - is just a typedef to wxArchiveFSHandler

//%include "wx/fs_zip.h"

//%if wxUSE_FS_ZIP
// typedef wxArchiveFSHandler wxZipFSHandler;
//%endif

// ---------------------------------------------------------------------------
// wxFilterFSHandler

%include "wx/fs_filter.h"

%class %delete wxFilterFSHandler, wxFileSystemHandler

    wxFilterFSHandler()

%endclass

// ---------------------------------------------------------------------------
// wxInternetFSHandler

%if wxUSE_FS_INET && wxUSE_SOCKETS // already has wxUSE_STREAMS && wxUSE_FILESYSTEM
%include "wx/fs_inet.h"

%class %delete wxInternetFSHandler, wxFileSystemHandler

    wxInternetFSHandler()

%endclass
%endif //wxUSE_FS_INET && wxUSE_SOCKETS

// ---------------------------------------------------------------------------
// wxMemoryFSHandler - See wxcore_core.i for this since it requires wxImage & wxBitmap.


%endif // wxUSE_FILESYSTEM


%endif // wxUSE_STREAMS

wxwidgets/wxcore_appframe.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxApp and wxFrame
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================


// ---------------------------------------------------------------------------
// wxApp

%if wxLUA_USE_wxApp

%include "wx/app.h"

// %override wxApp* wxGetApp()
// C++ func: wxApp* wxGetApp() - use wxTheApp* since this requires IMPLEMENT_APP()
%function wxApp* wxGetApp()

%class wxApp, wxEvtHandler

    // wxApp() NO CONSTRUCTOR! the wxApp is created in C++, use wxGetApp()

    // These two are pushed into Lua by C++ at startup as table arg = { argv }
    // int wxApp::argc
    // wxChar** wxApp::argv

    //!%wxchkver_2_6|%wxcompat_2_4 virtual wxLog* CreateLogTarget()
    void Dispatch()
    void ExitMainLoop()
    // virtual int FilterEvent(wxEvent& event) too dangerous, use ConnectEvent
    wxString GetAppName() const
    //!%wxchkver_2_6&%win bool GetAuto3D() const
    wxString GetClassName() const
    bool GetExitOnFrameDelete() const
    // static wxAppConsole *GetInstance() FIXME
    wxWindow* GetTopWindow() const
    bool GetUseBestVisual() const
    wxString GetVendorName() const
    bool IsActive() const
    static bool IsMainLoopRunning()
    // bool Initialized() obsolete in wxWidgets

    // %override int wxApp::MainLoop()
    // C++ Func: int MainLoop()
    // Only calls it if (!IsMainLoopRuinning() && !wxLuaState::sm_wxAppMainLoop_will_run), returns 0 if not called.
    int MainLoop()

    // virtual int OnExit() nothing we can do here
    // virtual bool OnInit() nothing we can do here
    // virtual int OnRun() nothing we can do here
    bool Pending()
    // !%wxchkver_2_6 bool SendIdleEvents()
    %wxchkver_2_6 bool SendIdleEvents(wxWindow* win, wxIdleEvent& event)
    void SetAppName(const wxString& name)
    //!%wxchkver_2_4&(%win|%mac) void SetAuto3D(const bool auto3D)
    void SetClassName(const wxString& name)
    void SetExitOnFrameDelete(bool flag)
    // static void SetInstance(wxAppConsole* app) nothing we can do here
    void SetTopWindow(wxWindow* window)
    void SetVendorName(const wxString& name)
    //virtual wxIcon GetStdIcon(int which) const
    void SetUseBestVisual(bool flag)

%endclass

%endif //wxLUA_USE_wxApp

// ---------------------------------------------------------------------------
// wxTopLevelWindow

%if wxLUA_USE_wxFrame|wxLUA_USE_wxDialog

%include "wx/toplevel.h"

%enum

    wxUSER_ATTENTION_INFO
    wxUSER_ATTENTION_ERROR

%endenum

%enum

    wxFULLSCREEN_NOMENUBAR
    wxFULLSCREEN_NOTOOLBAR
    wxFULLSCREEN_NOSTATUSBAR
    wxFULLSCREEN_NOBORDER
    wxFULLSCREEN_NOCAPTION
    wxFULLSCREEN_ALL

%endenum

%class wxTopLevelWindow, wxWindow

    // No constructors, virtual base class, use wxFrame or wxDialog

    %wxchkver_2_8 wxWindow* GetDefaultItem() const
    wxIcon GetIcon() const
    //const wxIconBundle& GetIcons() const
    wxString GetTitle() const
    %wxchkver_2_8 wxWindow* GetTmpDefaultItem() const
    void Iconize(bool iconize)
    bool IsActive() const
    bool IsFullScreen() const
    bool IsIconized() const
    bool IsMaximized() const
    void Maximize(bool maximize)
    void RequestUserAttention(int flags = wxUSER_ATTENTION_INFO)
    %wxchkver_2_8 wxWindow* SetDefaultItem(wxWindow *win)
    void SetIcon(const wxIcon& icon)
    void SetIcons(const wxIconBundle& icons)
    //void SetLeftMenu(int id = wxID_ANY, const wxString& label = wxEmptyString, wxMenu * subMenu = NULL)
    //void SetRightMenu(int id = wxID_ANY, const wxString& label = wxEmptyString, wxMenu * subMenu = NULL)
    bool SetShape(const wxRegion& region)
    virtual void SetTitle(const wxString& title)
    %wxchkver_2_8 wxWindow* SetTmpDefaultItem(wxWindow *win)
    %win bool ShowFullScreen(bool show, long style = wxFULLSCREEN_ALL)

%endclass

%endif //wxLUA_USE_wxFrame|wxLUA_USE_wxDialog

// ---------------------------------------------------------------------------
// wxFrame

%if wxLUA_USE_wxFrame

%include "wx/frame.h"

%define wxDEFAULT_FRAME_STYLE
%define wxICONIZE
%define wxCAPTION
%define wxMINIMIZE
%define wxMINIMIZE_BOX
%define wxMAXIMIZE
%define wxMAXIMIZE_BOX
%wxchkver_2_6 %define wxCLOSE_BOX
%define wxSTAY_ON_TOP
%define wxSYSTEM_MENU
//%define wxSIMPLE_BORDER see wxWindow defines
%define wxRESIZE_BORDER

%define wxFRAME_TOOL_WINDOW
%define wxFRAME_NO_TASKBAR
%define wxFRAME_FLOAT_ON_PARENT
%define wxFRAME_EX_CONTEXTHELP
%wxchkver_2_6 %define wxFRAME_SHAPED
%wxchkver_2_6 %define wxFRAME_EX_METAL
%define wxTHICK_FRAME

%class wxFrame, wxTopLevelWindow

    wxFrame()
    wxFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxFrame")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxFrame")

    // void Centre(int direction = wxBOTH) - see wxWindow
    virtual wxStatusBar* CreateStatusBar(int number = 1, long style = 0, wxWindowID id = wxID_ANY, const wxString& name = "wxStatusBar")
    virtual wxToolBar* CreateToolBar(long style = wxNO_BORDER|wxTB_HORIZONTAL, wxWindowID id = wxID_ANY, const wxString& name = "wxToolBar")
    wxPoint GetClientAreaOrigin() const
    wxMenuBar* GetMenuBar() const
    wxStatusBar* GetStatusBar() const
    int GetStatusBarPane()
    wxToolBar* GetToolBar() const

    %wxchkver_2_4 void ProcessCommand(int id)
    //!%wxchkver_2_4 void Command(int id)

    void SendSizeEvent()
    void SetMenuBar(wxMenuBar* menuBar)
    void SetStatusBar(wxStatusBar* statusBar)
    void SetStatusBarPane(int n)
    virtual void SetStatusText(const wxString& text, int number = 0)

    // void wxFrame::SetStatusWidths(Lua table with number indexes and values)
    // C++ Func: virtual void SetStatusWidths(int n, int *widths)
    virtual void SetStatusWidths(IntArray_FromLuaTable intTable)

    void SetToolBar(wxToolBar* toolBar)

%endclass

// ---------------------------------------------------------------------------
// wxMiniFrame

%if wxLUA_USE_wxMiniFrame

%include "wx/minifram.h"

%define wxTINY_CAPTION_HORIZ
%define wxTINY_CAPTION_VERT

%class wxMiniFrame, wxFrame

    wxMiniFrame()
    wxMiniFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMiniFrame")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMiniFrame")

%endclass

%endif //wxLUA_USE_wxMiniFrame
%endif //wxLUA_USE_wxFrame

// ---------------------------------------------------------------------------
// wxStatusBar

%if wxLUA_USE_wxStatusBar && wxUSE_STATUSBAR

%include "wx/statusbr.h"

%define wxST_SIZEGRIP
%define wxSB_NORMAL
%define wxSB_FLAT
%define wxSB_RAISED

%class wxStatusBar, wxWindow

    wxStatusBar()
    wxStatusBar(wxWindow* parent, wxWindowID id, long style = wxST_SIZEGRIP, const wxString& name = "wxStatusBar")
    bool Create(wxWindow *parent, wxWindowID id, long style = wxST_SIZEGRIP, const wxString& name = "wxStatusBar")

    virtual bool GetFieldRect(int i, wxRect& rect) const
    int GetFieldsCount() const
    virtual wxString GetStatusText(int ir = 0) const
    void PopStatusText(int field = 0)
    void PushStatusText(const wxString& string, int field = 0)

    // %override void wxStatusBar::SetFieldsCount(either a single number or a Lua table with number indexes and values)
    // C++ Func: virtual void SetFieldsCount(int number = 1, int* widths = NULL)
    virtual void SetFieldsCount(LuaTable intTable)

    void SetMinHeight(int height)
    virtual void SetStatusText(const wxString& text, int i = 0)

    // void wxStatusBar::SetStatusWidths(Lua table with number indexes and values)
    // C++ Func: virtual void SetStatusWidths(int n, int *widths)
    virtual void SetStatusWidths(IntArray_FromLuaTable intTable)

    // void wxStatusBar::SetStatusStyles(Lua table with number indexes and values)
    // C++ Func: virtual void SetStatusStyles(int n, int *styles)
    virtual void SetStatusStyles(IntArray_FromLuaTable intTable)

%endclass

%endif //wxLUA_USE_wxStatusBar && wxUSE_STATUSBAR

wxwidgets/wxcore_clipdrag.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxClipboard and drag & drop and their wxDataFormat
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxClipboard

%if wxLUA_USE_wxClipboard && wxUSE_CLIPBOARD

%include "wx/clipbrd.h"

%class wxClipboard, wxObject

    !%wxchkver_2_6 %define_pointer wxTheClipboard
    %wxchkver_2_6 static wxClipboard *Get()

    // No constructor, use global clipboard from static Get() function only

    bool AddData( %ungc wxDataObject *data )
    void Clear()
    void Close()
    bool Flush()
    bool GetData( wxDataObject& data )
    bool IsOpened() const
    bool IsSupported( const wxDataFormat& format )
    bool Open()
    bool SetData( %ungc wxDataObject *data )
    void UsePrimarySelection( bool primary = true )

%endclass

// ---------------------------------------------------------------------------
// wxClipboardLocker

%class %delete %noclassinfo %encapsulate wxClipboardLocker

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxClipboardLocker(wxClipboard *clipboard = NULL)

    %operator bool operator!() const

%endclass

// ---------------------------------------------------------------------------
// wxClipboardTextEvent

%if %wxchkver_2_8

%include "wx/event.h"

%class %delete wxClipboardTextEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_TEXT_COPY // EVT_TEXT_COPY(winid, func)
    %define_event wxEVT_COMMAND_TEXT_CUT // EVT_TEXT_CUT(winid, func)
    %define_event wxEVT_COMMAND_TEXT_PASTE // EVT_TEXT_PASTE(winid, func)

    wxClipboardTextEvent(wxEventType type = wxEVT_NULL, wxWindowID winid = 0)

%endclass

%endif //%wxchkver_2_8

%endif //wxLUA_USE_wxClipboard && wxUSE_CLIPBOARD

// ---------------------------------------------------------------------------
// wxDataFormat

%if wxLUA_USE_wxDataObject && wxUSE_DATAOBJ

%include "wx/dataobj.h"

%enum wxDataFormatId

    wxDF_INVALID
    wxDF_TEXT
    wxDF_BITMAP
    wxDF_METAFILE
    wxDF_SYLK
    wxDF_DIF
    wxDF_TIFF
    wxDF_OEMTEXT
    wxDF_DIB
    wxDF_PALETTE
    wxDF_PENDATA
    wxDF_RIFF
    wxDF_WAVE
    wxDF_UNICODETEXT
    wxDF_ENHMETAFILE
    wxDF_FILENAME
    wxDF_LOCALE
    wxDF_PRIVATE
    wxDF_HTML
    wxDF_MAX

%endenum

%class %delete %noclassinfo %encapsulate wxDataFormat

    %define_object wxFormatInvalid

    wxDataFormat(wxDataFormatId format = wxDF_INVALID)
    wxDataFormat(const wxString &format)

    wxString GetId() const
    int GetType() const // returns wxDataFormatId, but it's just an int and msw differs
    void SetId(const wxString &format)
    void SetType(wxDataFormatId format)

    %operator bool operator==(const wxDataFormat& format) const

%endclass

// ---------------------------------------------------------------------------
// wxDataObject

%enum wxDataObject::Direction

    Get
    Set

%endenum

%class %noclassinfo wxDataObject

    //wxDataObject() this is a base class, use simplified derived classes

    // %override [Lua table of wxDataFormat objects] wxDataObject::GetAllFormats(wxDataObject::Direction dir = wxDataObject::Get)
    // C++ Func: virtual void GetAllFormats(wxDataFormat *formats, wxDataObject::Direction dir = wxDataObject::Get) const
    virtual void GetAllFormats(wxDataObject::Direction dir = wxDataObject::Get) const

    // %override [bool, Lua string] wxDataObject::GetDataHere(const wxDataFormat& format)
    // C++ Func: virtual bool GetDataHere(const wxDataFormat& format, void *buf) const
    virtual bool GetDataHere(const wxDataFormat& format) const

    virtual int GetDataSize(const wxDataFormat& format) const
    virtual int GetFormatCount(wxDataObject::Direction dir = wxDataObject::Get) const
    virtual wxDataFormat GetPreferredFormat(wxDataObject::Direction dir = wxDataObject::Get) const

    // %override bool wxDataObject::SetData(const wxDataFormat& format, Lua string)
    // C++ Func: virtual bool SetData(const wxDataFormat& format, int len, const void *buf)
    virtual bool SetData(const wxDataFormat& format, const wxString& str)

%endclass

// ---------------------------------------------------------------------------
// wxDataObjectSimple

%class %delete %noclassinfo %encapsulate wxDataObjectSimple, wxDataObject

    wxDataObjectSimple(const wxDataFormat& format = wxFormatInvalid)

    const wxDataFormat& GetFormat() const
    void SetFormat(const wxDataFormat& format)
    virtual size_t GetDataSize() const

    // %override [bool, Lua string] wxDataObjectSimple::GetDataHere()
    // C++ Func: virtual bool GetDataHere(void *buf) const
    virtual bool GetDataHere() const

    // %override bool wxDataObjectSimple::SetData(Lua string)
    // C++ Func: virtual bool SetData(size_t len, const void *buf)
    virtual bool SetData(const wxString& str)

%endclass

// ---------------------------------------------------------------------------
// wxDataObjectComposite

%class %delete %noclassinfo %encapsulate wxDataObjectComposite, wxDataObject

    wxDataObjectComposite()

    void Add(%ungc wxDataObjectSimple *dataObject, bool preferred = false)
    %wxchkver_2_8 wxDataFormat GetReceivedFormat() const

%endclass

// ---------------------------------------------------------------------------
// wxFileDataObject

%class %delete %noclassinfo %encapsulate wxFileDataObject, wxDataObjectSimple

    wxFileDataObject()

    virtual void AddFile(const wxString& file)
    wxArrayString GetFilenames() const

%endclass

// ---------------------------------------------------------------------------
// wxTextDataObject

%class %delete %noclassinfo %encapsulate wxTextDataObject, wxDataObjectSimple

    wxTextDataObject(const wxString& text = "")

    virtual size_t GetTextLength() const
    virtual wxString GetText() const
    virtual void SetText(const wxString& text)

%endclass

// ---------------------------------------------------------------------------
// wxBitmapDataObject

%class %delete %noclassinfo %encapsulate wxBitmapDataObject, wxDataObjectSimple

    wxBitmapDataObject(const wxBitmap& bitmap = wxNullBitmap)

    virtual wxBitmap GetBitmap() const
    virtual void SetBitmap(const wxBitmap& bitmap)

%endclass

// ---------------------------------------------------------------------------
// wxCustomDataObject - FIXME implement this?

//%class %noclassinfo %encapsulate wxCustomDataObject, wxDataObjectSimple
// wxCustomDataObject(const wxDataFormat& format = wxFormatInvalid)
//
// virtual void *Alloc(size_t size)
// virtual void Free()
// virtual size_t GetSize() const
// virtual void *GetData() const
// virtual void SetData(size_t size, const void *data)
// virtual void TakeData( size_t size, void *data)
//%endclass

// ---------------------------------------------------------------------------
// wxURLDataObject - is simply wxTextDataObject with a different name

%if %wxchkver_2_8

%class %delete %noclassinfo %encapsulate wxURLDataObject, wxTextDataObject

    wxURLDataObject(const wxString& url = "")

    wxString GetURL() const
    void SetURL(const wxString& url)

%endclass

%endif //%wxchkver_2_8

%endif //wxLUA_USE_wxDataObject && wxUSE_DATAOBJ

// ---------------------------------------------------------------------------
// wxDropTarget

%if wxLUA_USE_wxDragDrop && wxUSE_DRAG_AND_DROP

%include "wx/dnd.h"

%enum

    wxDrag_CopyOnly
    wxDrag_AllowMove
    wxDrag_DefaultMove

%endenum

%enum wxDragResult

    wxDragError
    wxDragNone
    wxDragCopy
    wxDragMove
    wxDragLink
    wxDragCancel

%endenum

%function bool wxIsDragResultOk(wxDragResult res)

%class %noclassinfo wxDropTarget // FIXME implement virtual


    //wxDropTarget(wxDataObject* data = NULL) pure virtual functions in MSW
    virtual bool GetData()
    //wxDragResult GetDefaultAction()
    //virtual wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def)
    //virtual bool OnDrop(wxCoord x, wxCoord y)
    //virtual wxDragResult OnEnter(wxCoord x, wxCoord y, wxDragResult def)
    //virtual wxDragResult OnDragOver(wxCoord x, wxCoord y, wxDragResult def)
    //virtual void OnLeave()
    //void SetDataObject(wxDataObject* data)
    //void SetDefaultAction(wxDragResult action)

%endclass

// ---------------------------------------------------------------------------
// wxFileDropTarget

//%class %noclassinfo wxFileDropTarget, wxDropTarget // FIXME implement virtual
// wxFileDropTarget()
// virtual wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def)
// virtual bool OnDrop(long x, long y, const void *data, size_t size)
// virtual bool OnDropFiles(wxCoord x, wxCoord y,const wxArrayString& filenames)
//%endclass

// ---------------------------------------------------------------------------
// wxTextDropTarget

//%class %noclassinfo wxTextDropTarget, wxDropTarget // FIXME implement virtual
// wxTextDropTarget()
// virtual bool OnDropText(wxCoord x, wxCoord y, const wxString& text)
// virtual wxDragResult OnData(wxCoord x, wxCoord y, wxDragResult def)
//%endclass

// ---------------------------------------------------------------------------
// wxDropSource

%class %delete %noclassinfo %encapsulate wxDropSource // FIXME implement virtual

    %win|%mac wxDropSource(wxWindow* win = NULL, const wxCursor& cursorCopy = wxNullCursor, const wxCursor& cursorMove = wxNullCursor, const wxCursor& cursorStop = wxNullCursor)
    %gtk wxDropSource(wxWindow* win = NULL, const wxIcon& iconCopy = wxNullIcon, const wxIcon& iconMove = wxNullIcon, const wxIcon& iconStop = wxNullIcon)
    %win wxDropSource(wxDataObject& data, wxWindow* win = NULL, const wxCursor& cursorCopy = wxNullCursor, const wxCursor& cursorMove = wxNullCursor, const wxCursor& cursorStop = wxNullCursor)
    %gtk wxDropSource(wxDataObject& data, wxWindow* win = NULL, const wxIcon& iconCopy = wxNullIcon, const wxIcon& iconMove = wxNullIcon, const wxIcon& iconStop = wxNullIcon)

    void SetData(wxDataObject& data)
    //virtual wxDragResult DoDragDrop(int flags = wxDrag_CopyOnly)
    wxDataObject* GetDataObject()
    virtual bool GiveFeedback(wxDragResult effect)
    void SetCursor(wxDragResult res, const wxCursor& cursor)

%endclass

// ---------------------------------------------------------------------------
// wxDropFilesEvent

%include "wx/event.h"

%class %delete wxDropFilesEvent, wxEvent

    %define_event wxEVT_DROP_FILES // EVT_DROP_FILES(func)

    // wxDropFilesEvent(WXTYPE id = 0, int noFiles = 0, wxString* files = NULL) only handle this event

    // %override [Lua table of strings] wxDropFilesEvent::GetFiles()
    // C++ Func: wxString* GetFiles() const
    wxString* GetFiles() const

    int GetNumberOfFiles() const
    wxPoint GetPosition() const

%endclass

%endif //wxLUA_USE_wxDragDrop && wxUSE_DRAG_AND_DROP

// ---------------------------------------------------------------------------
// wxMetafile

%if wxLUA_USE_wxMetafile && wxUSE_METAFILE && (%msw|%mac|%os2)

%include "wx/metafile.h"

//%function bool wxMakeMetafilePlaceable(const wxString& filename, int minX, int minY, int maxX, int maxY, float scale = 1.0)

%class %delete %noclassinfo wxMetafile, wxObject

    wxMetafile(const wxString& filename = "")

    bool Ok()
    bool Play(wxDC *dc)
    bool SetClipboard(int width = 0, int height = 0)

%endclass

// ---------------------------------------------------------------------------
// wxMetafileDC
%class %delete %noclassinfo wxMetafileDC, wxDC

    wxMetafileDC(const wxString& filename = "")

    %win %gc wxMetafile* Close()

%endclass

%endif

%endif //wxLUA_USE_wxMetafile && wxUSE_METAFILE && (%msw|%mac|%os2)

wxwidgets/wxcore_controls.i - Lua table = 'wx'
// ===========================================================================
// Purpose: GUI controls like buttons, combos, etc
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// FIXME - handle WX_DECLARE_CONTROL_CONTAINER ?

// ---------------------------------------------------------------------------
// wxButton

%if wxLUA_USE_wxButton && wxUSE_BUTTON

%include "wx/button.h"

%define wxBU_LEFT
%define wxBU_RIGHT
%define wxBU_TOP
%define wxBU_BOTTOM
%define wxBU_EXACTFIT
%wxchkver_2_6 %define wxBU_AUTODRAW

%class wxButton, wxControl

    wxButton()
    wxButton(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxButton")
    bool Create(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxButton")

    static wxSize GetDefaultSize() // static is ok, use on existing button
    void SetDefault()

    //wxString GetLabel() const // in wxWindow
    //void SetLabel(const wxString& label) // in wxWindow

%endclass

// ---------------------------------------------------------------------------
// wxBitmapButton

%if wxLUA_USE_wxBitmapButton && wxUSE_BMPBUTTON

%include "wx/bmpbuttn.h"

%class wxBitmapButton, wxButton

    wxBitmapButton()
    wxBitmapButton( wxWindow* parent, wxWindowID id, const wxBitmap& bitmap, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxBU_AUTODRAW, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxBitmapButton")
    bool Create(wxWindow* parent, wxWindowID id, const wxBitmap& bitmap, const wxPoint& pos, const wxSize& size = wxDefaultSize, long style = wxBU_AUTODRAW, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxBitmapButton")

    wxBitmap GetBitmapDisabled() const
    wxBitmap GetBitmapFocus() const
    %wxchkver_2_8 wxBitmap GetBitmapHover() const
    wxBitmap GetBitmapLabel() const
    wxBitmap GetBitmapSelected() const
    void SetBitmapDisabled(const wxBitmap& bitmap)
    void SetBitmapFocus(const wxBitmap& bitmap)
    %wxchkver_2_8 void SetBitmapHover(const wxBitmap& hover)
    void SetBitmapLabel(const wxBitmap& bitmap)
    void SetBitmapSelected(const wxBitmap& bitmap)

%endclass

%endif //wxLUA_USE_wxBitmapButton && wxUSE_BMPBUTTON
%endif //wxLUA_USE_wxButton && wxUSE_BUTTON

// ---------------------------------------------------------------------------
// wxToggleButton

%if wxLUA_USE_wxToggleButton && wxUSE_TOGGLEBTN

%include "wx/tglbtn.h"

%class wxToggleButton, wxControl

    wxToggleButton()
    wxToggleButton(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxToggleButton")
    bool Create(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxToggleButton")

    void SetValue(bool state)
    bool GetValue() const

    //wxString GetLabel() const // in wxWindow
    //void SetLabel(const wxString& label) // in wxWindow

%endclass

%endif //wxLUA_USE_wxToggleButton && wxUSE_TOGGLEBTN

// ---------------------------------------------------------------------------
// wxCheckBox

%if wxLUA_USE_wxCheckBox && wxUSE_CHECKBOX

%include "wx/checkbox.h"

%define wxCHK_2STATE
%define wxCHK_3STATE
%define wxCHK_ALLOW_3RD_STATE_FOR_USER

%enum wxCheckBoxState

    wxCHK_UNCHECKED
    wxCHK_CHECKED
    wxCHK_UNDETERMINED

%endenum

%class wxCheckBox, wxControl

    wxCheckBox()
    wxCheckBox(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& val = wxDefaultValidator, const wxString& name = "wxCheckBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& val = wxDefaultValidator, const wxString& name = "wxCheckBox")

    bool GetValue() const
    wxCheckBoxState Get3StateValue() const
    bool Is3rdStateAllowedForUser() const
    bool Is3State() const
    bool IsChecked() const
    void SetValue(const bool state)
    void Set3StateValue(const wxCheckBoxState state)

%endclass

%endif //wxLUA_USE_wxCheckBox && wxUSE_CHECKBOX

// ---------------------------------------------------------------------------
// wxControlWithItems

%if (wxLUA_USE_wxChoice|wxLUA_USE_wxComboBox|wxLUA_USE_wxListBox) && wxUSE_CONTROLS

%include "wx/ctrlsub.h"

%class wxControlWithItems, wxControl

    // no constructor, this is just a base class

    int Append(const wxString& item)
    int Append(const wxString& item, voidptr_long number) // C++ is (void *clientData) You can put a number here
    int Append(const wxString& item, wxClientData *clientData)
    void Append(const wxArrayString& strings)
    void Clear()
    void Delete(unsigned int n)
    int FindString(const wxString& string)
    // C++ Func: void* GetClientData(unsigned int n) const
    voidptr_long GetClientData(unsigned int n) const // C++ returns (void *) You get a number here

    wxClientData* GetClientObject(unsigned int n) const
    %rename GetStringClientObject wxStringClientData* GetClientObject(unsigned int n) const
    int GetCount() const
    int GetSelection() const
    wxString GetString(unsigned int n) const
    wxString GetStringSelection() const
    int Insert(const wxString& item, int pos)
    int Insert(const wxString& item, unsigned int pos, voidptr_long number) // C++ is (void *clientData) You can put a number here
    int Insert(const wxString& item, unsigned int pos, wxClientData *clientData)
    bool IsEmpty() const
    // int Number() const // obsolete since 2.2 use GetCount()
    void Select(int n)
    void SetClientData(unsigned int n, voidptr_long number) // C++ is (void *clientData) You can put a number here
    void SetClientObject(unsigned int n, wxClientData *data)
    void SetSelection(unsigned int n)
    void SetString(unsigned int n, const wxString& string)
    bool SetStringSelection(const wxString& string)

%endclass

%endif //(wxLUA_USE_wxChoice|wxLUA_USE_wxComboBox|wxLUA_USE_wxListBox) && wxUSE_CONTROLS

// ---------------------------------------------------------------------------
// wxChoice

%if wxLUA_USE_wxChoice && wxUSE_CHOICE

%include "wx/choice.h"

%class wxChoice, wxControlWithItems

    wxChoice()
    wxChoice(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxChoice")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxChoice")

    int GetCurrentSelection() const
    //int GetColumns() const // Motif only but returns 1 otherwise
    //void SetColumns(int n = 1)

%endclass

%endif //wxLUA_USE_wxChoice && wxUSE_CHOICE

// ---------------------------------------------------------------------------
// wxComboBox

%if wxLUA_USE_wxComboBox && wxUSE_COMBOBOX

%include "wx/combobox.h"

%define wxCB_DROPDOWN
%define wxCB_READONLY
%define wxCB_SIMPLE
%define wxCB_SORT

%class wxComboBox, wxControlWithItems

    wxComboBox()
    wxComboBox(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxComboBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxComboBox")

    bool CanCopy() const
    bool CanCut() const
    bool CanPaste() const
    bool CanRedo() const
    bool CanUndo() const
    void Copy()
    void Cut()
    %wxchkver_2_8 virtual int GetCurrentSelection() const
    long GetInsertionPoint() const
    long GetLastPosition() const
    wxString GetValue() const
    void Paste()
    void Redo()
    void Replace(long from, long to, const wxString& text)
    void Remove(long from, long to)
    void SetInsertionPoint(long pos)
    void SetInsertionPointEnd()
    void SetSelection(long from, long to)
    void SetValue(const wxString& text)
    void Undo()

%endclass

%endif //wxLUA_USE_wxComboBox && wxUSE_COMBOBOX

// ---------------------------------------------------------------------------
// wxGauge

%if wxLUA_USE_wxGauge && wxUSE_GAUGE

%include "wx/gauge.h"

%define wxGA_HORIZONTAL
%wxcompat_2_6 %define wxGA_PROGRESSBAR
%define wxGA_SMOOTH
%define wxGA_VERTICAL

%class wxGauge, wxControl

    wxGauge()
    wxGauge(wxWindow* parent, wxWindowID id, int range, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxGA_HORIZONTAL, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxGauge")
    bool Create(wxWindow* parent, wxWindowID id, int range, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxGA_HORIZONTAL, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxGauge")

    int GetBezelFace() const
    int GetRange() const
    int GetShadowWidth() const
    int GetValue() const
    bool IsVertical() const
    %wxchkver_2_8 void Pulse()
    void SetBezelFace(int width)
    void SetRange(int range)
    void SetShadowWidth(int width)
    void SetValue(int pos)

%endclass

%endif //wxLUA_USE_wxGauge && wxUSE_GAUGE

// ---------------------------------------------------------------------------
// wxListBox

%if wxLUA_USE_wxListBox && wxUSE_LISTBOX

%include "wx/listbox.h"

%define wxLB_SINGLE
%define wxLB_MULTIPLE
%define wxLB_EXTENDED
%define wxLB_HSCROLL
%define wxLB_ALWAYS_SB
%define wxLB_NEEDED_SB
%define wxLB_SORT
%define wxLB_OWNERDRAW

%class wxListBox, wxControlWithItems

    wxListBox()
    wxListBox(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxListBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxListBox")

    void Deselect(int n)

    // %override [Lua table of int selections] wxListBox::GetSelections()
    // C++ Func: int GetSelections(wxArrayInt& selections) const
    int GetSelections() const

    %wxchkver_2_8 int HitTest(const wxPoint& point) const
    //void InsertItems(int nItems, const wxString items[], int pos)
    void InsertItems(const wxArrayString& items, int pos)
    bool IsSelected(int n) const
    //void Set(int n, const wxString* choices)
    void Set(const wxArrayString& choices)
    void SetFirstItem(int n)
    void SetSelection(int n, bool select = true)
    void SetStringSelection(const wxString& string, bool select = true)

%endclass

// ---------------------------------------------------------------------------
// wxCheckListBox

%if wxLUA_USE_wxCheckListBox && wxUSE_CHECKLISTBOX

%include "wx/checklst.h"

%class wxCheckListBox, wxListBox

    wxCheckListBox()
    wxCheckListBox(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCheckListBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCheckListBox")

    void Check(int item, bool check = true)
    bool IsChecked(int item) const

%endclass

%endif //wxLUA_USE_wxCheckListBox && wxUSE_CHECKLISTBOX
%endif //wxLUA_USE_wxListBox && wxUSE_LISTBOX

// ---------------------------------------------------------------------------
// wxListCtrl

%if wxLUA_USE_wxListCtrl && wxUSE_LISTCTRL

%include "wx/listctrl.h"

%define wxLC_ALIGN_LEFT
%define wxLC_ALIGN_TOP
%define wxLC_AUTOARRANGE
%define wxLC_EDIT_LABELS
%define wxLC_HRULES
%define wxLC_ICON
%define wxLC_LIST
%define wxLC_NO_HEADER
%define wxLC_NO_SORT_HEADER
%define wxLC_REPORT
%define wxLC_SINGLE_SEL
%define wxLC_SMALL_ICON
%define wxLC_SORT_ASCENDING
%define wxLC_SORT_DESCENDING
//%define wxLC_USER_TEXT - deprecated - use wxLC_VIRTUAL
%define wxLC_VIRTUAL
%define wxLC_VRULES

%define wxLC_MASK_TYPE // (wxLC_ICON | wxLC_SMALL_ICON | wxLC_LIST | wxLC_REPORT)
%define wxLC_MASK_ALIGN // (wxLC_ALIGN_TOP | wxLC_ALIGN_LEFT)
%define wxLC_MASK_SORT // (wxLC_SORT_ASCENDING | wxLC_SORT_DESCENDING)

%define wxLIST_ALIGN_DEFAULT
%define wxLIST_ALIGN_LEFT
%define wxLIST_ALIGN_SNAP_TO_GRID
%define wxLIST_ALIGN_TOP
%define wxLIST_AUTOSIZE
%define wxLIST_AUTOSIZE_USEHEADER
%define wxLIST_FIND_DOWN
%define wxLIST_FIND_LEFT
%define wxLIST_FIND_RIGHT
%define wxLIST_FIND_UP
%define wxLIST_HITTEST_ABOVE
%define wxLIST_HITTEST_BELOW
%define wxLIST_HITTEST_NOWHERE
%define wxLIST_HITTEST_ONITEM
%define wxLIST_HITTEST_ONITEMICON
%define wxLIST_HITTEST_ONITEMLABEL
%define wxLIST_HITTEST_ONITEMRIGHT
%define wxLIST_HITTEST_ONITEMSTATEICON
%define wxLIST_HITTEST_TOLEFT
%define wxLIST_HITTEST_TORIGHT
%define wxLIST_MASK_DATA
%define wxLIST_MASK_FORMAT
%define wxLIST_MASK_IMAGE
%define wxLIST_MASK_STATE
%define wxLIST_MASK_TEXT
%define wxLIST_MASK_WIDTH
%define wxLIST_NEXT_ABOVE
%define wxLIST_NEXT_ALL
%define wxLIST_NEXT_BELOW
%define wxLIST_NEXT_LEFT
%define wxLIST_NEXT_RIGHT
%define wxLIST_RECT_BOUNDS
%define wxLIST_RECT_ICON
%define wxLIST_RECT_LABEL
%define wxLIST_SET_ITEM
%define wxLIST_STATE_CUT
%define wxLIST_STATE_DONTCARE
%define wxLIST_STATE_DROPHILITED
%define wxLIST_STATE_FOCUSED
%define wxLIST_STATE_SELECTED

%wxchkver_2_8 %define wxLIST_GETSUBITEMRECT_WHOLEITEM

%class wxListCtrl, wxControl

    wxListCtrl()
    wxListCtrl(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxLC_ICON, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxListCtrl")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxLC_ICON, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxListCtrl")

    bool Arrange(int flag = wxLIST_ALIGN_DEFAULT)
    void AssignImageList(%ungc wxImageList *imageList, int which)
    void ClearAll()
    bool DeleteAllItems()
    bool DeleteColumn(int col)
    bool DeleteItem(long item)
    void EditLabel(long item)
    bool EnsureVisible(long item)
    long FindItem(long start, const wxString& str, const bool partial = false)
    long FindItem(long start, long data)
    long FindItem(long start, const wxPoint& pt, int direction)
    bool GetColumn(int col, wxListItem& item) const
    int GetColumnCount() const
    int GetColumnWidth(int col) const
    int GetCountPerPage() const
    %win|%wxchkver_2_8 wxTextCtrl* GetEditControl() const
    wxImageList* GetImageList(int which) const
    bool GetItem(wxListItem& info) const
    int GetItemCount() const
    long GetItemData(long item) const
    wxFont GetItemFont(long item) const
    bool GetItemPosition(long item, wxPoint& pos) const
    bool GetItemRect(long item, wxRect& rect, int code = wxLIST_RECT_BOUNDS) const
    !%wxchkver_2_6 int GetItemSpacing(bool isSmall) const
    %wxchkver_2_6 wxSize GetItemSpacing() const
    int GetItemState(long item, long stateMask) const
    wxString GetItemText(long item) const
    long GetNextItem(long item, int geometry = wxLIST_NEXT_ALL, int state = wxLIST_STATE_DONTCARE) const
    int GetSelectedItemCount() const
    wxColour GetTextColour() const
    long GetTopItem() const
    wxRect GetViewRect() const

    // %override [long, int flags] wxListCtrl::HitTest(const wxPoint& point)
    // C++ Func: long HitTest(const wxPoint& point, int& flags)
    long HitTest(const wxPoint& point)

    long InsertColumn(long col, wxListItem& info)
    long InsertColumn(long col, const wxString& heading, int format = wxLIST_FORMAT_LEFT, int width = -1)
    long InsertItem(wxListItem& info)
    long InsertItem(long index, const wxString& label)
    long InsertItem(long index, int imageIndex)
    long InsertItem(long index, const wxString& label, int imageIndex)
    //virtual wxListItemAttr * OnGetItemAttr(long item) const
    //virtual int OnGetItemImage(long item)
    //virtual wxString OnGetItemText(long item, long column) const
    //void RefreshItem(long item)
    //void RefreshItems(long itemFrom, long itemTo)
    bool ScrollList(int dx, int dy)
    //void SetBackgroundColour(const wxColour& col) - see wxWindow
    bool SetColumn(int col, wxListItem& item)
    bool SetColumnWidth(int col, int width)
    void SetImageList(wxImageList* imageList, int which)
    bool SetItem(wxListItem& info)
    long SetItem(long index, int col, const wxString& label, int imageId = -1)
    void SetItemBackgroundColour(long item, const wxColour& col)
    bool SetItemColumnImage(long item, long column, int image)
    //void SetItemCount(long count)
    bool SetItemData(long item, long data)
    bool SetItemImage(long item, int image) // int selImage) selImage is deprecated and isn't used anyway
    bool SetItemPosition(long item, const wxPoint& pos)
    bool SetItemState(long item, long state, long stateMask)
    void SetItemText(long item, const wxString& text)
    void SetItemTextColour(long item, const wxColour& col)
    void SetSingleStyle(long style, const bool add = true)
    void SetTextColour(const wxColour& col)
    //void SetWindowStyleFlag(long style) - see wxWindow

    // %override bool SortItems(Lua function(long item1, long item2, long data) returning int, long data)
    // C++ Func: bool SortItems(wxListCtrlCompare fnSortCallBack, long data)
    // Note: the data can only be a number, but you can create a table where the data is
    // an index of it if you need more information.
    // Also, the item1 and item2 are NOT the indexes in the wxListCtrl, but are the
    // client data associated with the item. see SetItemData(item, data) and again
    // you may want to make this "data" equal to an index in a table where you
    // store more information needed for sorting.
    // Your Lua function should return 1, 0, -1 for item1 > item2, item1 == item2, item1 < item2
    bool SortItems(LuaFunction fnSortCallBack, long data)

%endclass

// ---------------------------------------------------------------------------
// wxListItemAttr - wxListCtrl

%class %delete %noclassinfo %encapsulate wxListItemAttr

    wxListItemAttr(const wxColour& colText = wxNullColour, const wxColour& colBack = wxNullColour, const wxFont& font = wxNullFont)

    %wxchkver_2_8 void AssignFrom(const wxListItemAttr& source)
    wxColour GetBackgroundColour()
    wxFont GetFont()
    wxColour GetTextColour()
    bool HasBackgroundColour()
    bool HasFont()
    bool HasTextColour()
    void SetBackgroundColour(const wxColour& colBack)
    void SetFont(const wxFont& font)
    void SetTextColour(const wxColour& colText)

%endclass

// ---------------------------------------------------------------------------
// wxListItem - wxListCtrl

%enum wxListColumnFormat

    wxLIST_FORMAT_LEFT
    wxLIST_FORMAT_RIGHT
    wxLIST_FORMAT_CENTRE
    wxLIST_FORMAT_CENTER

%endenum

%class %delete wxListItem, wxObject

    wxListItem()
    wxListItem(const wxListItem& item)

    void Clear()
    void ClearAttributes()
    wxListColumnFormat GetAlign()
    wxListItemAttr *GetAttributes()
    wxColour GetBackgroundColour() const
    int GetColumn()
    long GetData()
    wxFont GetFont() const
    long GetId()
    int GetImage()
    long GetMask()
    long GetState()
    wxString GetText()
    wxColour GetTextColour() const
    int GetWidth()
    bool HasAttributes()
    void SetAlign(wxListColumnFormat align)
    void SetBackgroundColour(const wxColour& colBack)
    void SetColumn(int col)
    void SetData(long data)
    void SetFont(const wxFont& font)
    void SetId(long id)
    void SetImage(int image)
    void SetMask(long mask)
    void SetState(long state)
    void SetStateMask(long stateMask)
    void SetText(const wxString& text)
    void SetTextColour(const wxColour& colText)
    void SetWidth(int width)

%endclass

// ---------------------------------------------------------------------------
// wxListEvent - wxListCtrl

%class %delete wxListEvent, wxNotifyEvent

    %define_event wxEVT_COMMAND_LIST_BEGIN_DRAG // EVT_LIST_BEGIN_DRAG(id, fn)
    %define_event wxEVT_COMMAND_LIST_BEGIN_RDRAG // EVT_LIST_BEGIN_RDRAG(id, fn)
    %define_event wxEVT_COMMAND_LIST_BEGIN_LABEL_EDIT // EVT_LIST_BEGIN_LABEL_EDIT(id, fn)
    %define_event wxEVT_COMMAND_LIST_COL_CLICK // EVT_LIST_COL_CLICK(id, fn)
    %define_event wxEVT_COMMAND_LIST_DELETE_ALL_ITEMS // EVT_LIST_DELETE_ALL_ITEMS(id, fn)
    %define_event wxEVT_COMMAND_LIST_DELETE_ITEM // EVT_LIST_DELETE_ITEM(id, fn)
    %define_event wxEVT_COMMAND_LIST_END_LABEL_EDIT // EVT_LIST_END_LABEL_EDIT(id, fn)
    !%wxchkver_2_6 %define_event wxEVT_COMMAND_LIST_GET_INFO // EVT_LIST_GET_INFO(id, fn)
    !%wxchkver_2_6 %define_event wxEVT_COMMAND_LIST_SET_INFO // EVT_LIST_SET_INFO(id, fn)
    %define_event wxEVT_COMMAND_LIST_INSERT_ITEM // EVT_LIST_INSERT_ITEM(id, fn)
    %define_event wxEVT_COMMAND_LIST_ITEM_ACTIVATED // EVT_LIST_ITEM_ACTIVATED(id, fn)
    %define_event wxEVT_COMMAND_LIST_ITEM_DESELECTED // EVT_LIST_ITEM_DESELECTED(id, fn)
    %define_event wxEVT_COMMAND_LIST_ITEM_MIDDLE_CLICK // EVT_LIST_ITEM_MIDDLE_CLICK(id, fn)
    %define_event wxEVT_COMMAND_LIST_ITEM_RIGHT_CLICK // EVT_LIST_ITEM_RIGHT_CLICK(id, fn)
    %define_event wxEVT_COMMAND_LIST_ITEM_SELECTED // EVT_LIST_ITEM_SELECTED(id, fn)
    %define_event wxEVT_COMMAND_LIST_KEY_DOWN // EVT_LIST_KEY_DOWN(id, fn)
    %define_event wxEVT_COMMAND_LIST_CACHE_HINT // EVT_LIST_CACHE_HINT(id, fn)
    %define_event wxEVT_COMMAND_LIST_COL_RIGHT_CLICK // EVT_LIST_COL_RIGHT_CLICK(id, fn)
    %define_event wxEVT_COMMAND_LIST_COL_BEGIN_DRAG // EVT_LIST_COL_BEGIN_DRAG(id, fn)
    %define_event wxEVT_COMMAND_LIST_COL_DRAGGING // EVT_LIST_COL_DRAGGING(id, fn)
    %define_event wxEVT_COMMAND_LIST_COL_END_DRAG // EVT_LIST_COL_END_DRAG(id, fn)
    %define_event wxEVT_COMMAND_LIST_ITEM_FOCUSED // EVT_LIST_ITEM_FOCUSED(id, fn)

    wxListEvent(wxEventType commandType = 0, int id = 0)

    //long GetCacheFrom() const - only useful for virtual controls
    //long GetCacheTo() const
    int GetKeyCode() const
    long GetIndex() const
    int GetColumn() const
    wxPoint GetPoint() const
    const wxString& GetLabel() const
    const wxString& GetText() const
    int GetImage() const
    long GetData() const
    long GetMask() const
    const wxListItem& GetItem() const
    bool IsEditCancelled() const

%endclass

// ---------------------------------------------------------------------------
// wxListView

%class wxListView, wxListCtrl

    wxListView()
    wxListView(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxLC_ICON, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxListView")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxLC_ICON, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxListView")

    void ClearColumnImage(int col)
    void Focus(long index)
    long GetFirstSelected() const
    long GetFocusedItem() const
    long GetNextSelected(long item) const
    bool IsSelected(long index)
    void Select(long n, bool on = true)
    void SetColumnImage(int col, int image)

%endclass

%endif //wxLUA_USE_wxListCtrl && wxUSE_LISTCTRL

// ---------------------------------------------------------------------------
// wxRadioBox

%if wxLUA_USE_wxRadioBox && wxUSE_RADIOBOX

%include "wx/radiobox.h"

%define wxRA_VERTICAL
%define wxRA_HORIZONTAL
%define wxRA_SPECIFY_COLS
%define wxRA_SPECIFY_ROWS
// %define wxRA_USE_CHECKBOX - only for palm os

%class wxRadioBox, wxControl

    wxRadioBox()
    wxRadioBox(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& point = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, int majorDimension = 0, long style = wxRA_SPECIFY_COLS, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxRadioBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& point = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, int majorDimension = 0, long style = wxRA_SPECIFY_COLS, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxRadioBox")

    // these are marked deprecated in 2.6, use wxWindow::Get/SetLabel and Get/SetString below
    // wxString GetLabel() const - see wxWindow
    // void SetLabel(const wxString& label) - see wxWindow
    // wxString GetLabel(int n) const
    // void SetLabel(int n, const wxString& label)

    void Enable(bool enable)
    void Enable(int n, bool enable)
    int FindString(const wxString& string) const
    int GetCount() const
    int GetSelection() const
    wxString GetStringSelection() const
    wxString GetString(int n) const
    void SetString(int n, const wxString &label)
    void SetSelection(int n)
    void SetStringSelection(const wxString& string)
    //bool Show(bool show = true) // see wxWindow
    bool Show(int item, bool show) // must specify both for overload

%endclass

%endif //wxLUA_USE_wxRadioBox && wxUSE_RADIOBOX

// ---------------------------------------------------------------------------
// wxRadioButton

%if wxLUA_USE_wxRadioButton && wxUSE_RADIOBTN

%include "wx/radiobut.h"

%define wxRB_GROUP
%define wxRB_SINGLE
// %define wxRB_USE_CHECKBOX - only for palm os

%class wxRadioButton, wxControl

    wxRadioButton()
    wxRadioButton(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxRadioButton")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxRadioButton")

    bool GetValue() const
    void SetValue(const bool value)

%endclass

%endif //wxLUA_USE_wxRadioButton && wxUSE_RADIOBTN

// ---------------------------------------------------------------------------
// wxScrollBar

%if wxLUA_USE_wxScrollBar && wxUSE_SCROLLBAR

%include "wx/scrolbar.h"

%define wxSB_HORIZONTAL
%define wxSB_VERTICAL

%class wxScrollBar, wxControl

    wxScrollBar()
    wxScrollBar(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSB_HORIZONTAL, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxScrollBar")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSB_HORIZONTAL, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxScrollBar")

    int GetRange() const
    int GetPageSize() const
    int GetThumbPosition() const
    int GetThumbSize() const
    void SetThumbPosition(int viewStart)
    virtual void SetScrollbar(int position, int thumbSize, int range, int pageSize, const bool refresh = true)

%endclass

%endif //wxLUA_USE_wxScrollBar && wxUSE_SCROLLBAR

// ---------------------------------------------------------------------------
// wxSlider

%if wxLUA_USE_wxSlider && wxUSE_SLIDER

%include "wx/slider.h"

%define wxSL_AUTOTICKS
%define wxSL_BOTH
%define wxSL_BOTTOM
%define wxSL_HORIZONTAL
%define wxSL_LABELS
%define wxSL_LEFT
%define wxSL_NOTIFY_DRAG
%define wxSL_RIGHT
%define wxSL_SELRANGE
%define wxSL_TOP
%define wxSL_VERTICAL

%class wxSlider, wxControl

    wxSlider()
    wxSlider(wxWindow* parent, wxWindowID id, int value , int minValue, int maxValue, const wxPoint& point = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSL_HORIZONTAL, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxSlider")
    bool Create(wxWindow* parent, wxWindowID id, int value , int minValue, int maxValue, const wxPoint& point = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSL_HORIZONTAL, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxSlider")

    void ClearSel()
    void ClearTicks()
    int GetLineSize() const
    int GetMax() const
    int GetMin() const
    int GetPageSize() const
    int GetSelEnd() const
    int GetSelStart() const
    int GetThumbLength() const
    int GetTickFreq() const
    int GetValue() const
    void SetLineSize(int lineSize)
    void SetPageSize(int pageSize)
    void SetRange(int minValue, int maxValue)
    void SetSelection(int startPos, int endPos)
    void SetThumbLength(int len)
    void SetTick(int tickPos)
    void SetTickFreq(int n, int pos)
    void SetValue(int value)

%endclass

%endif //wxLUA_USE_wxSlider && wxUSE_SLIDER

// ---------------------------------------------------------------------------
// wxSpinButton

%if wxLUA_USE_wxSpinButton && wxUSE_SPINBTN

%include "wx/spinbutt.h"

%define wxSP_HORIZONTAL
%define wxSP_VERTICAL
%define wxSP_ARROW_KEYS
%define wxSP_WRAP

%class wxSpinButton, wxControl

    wxSpinButton()
    wxSpinButton(wxWindow *parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSP_VERTICAL | wxSP_ARROW_KEYS, const wxString& name = "wxSpinButton")
    bool Create(wxWindow *parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSP_VERTICAL | wxSP_ARROW_KEYS, const wxString& name = "wxSpinButton")

    int GetMax() const
    int GetMin() const
    int GetValue() const
    void SetRange(int min, int max)
    void SetValue(int value)

%endclass

// ---------------------------------------------------------------------------
// wxSpinEvent - for wxSpinButton

%include "wx/spinbutt.h"
%include "wx/spinctrl.h"

%class %delete wxSpinEvent, wxNotifyEvent

    %define_event wxEVT_SPIN_UP // EVT_SPIN_UP(winid, func)
    %define_event wxEVT_SPIN_DOWN // EVT_SPIN_DOWN(winid, func)
    %define_event wxEVT_SPIN // EVT_SPIN(winid, func)
    //%define_event wxEVT_COMMAND_SPINCTRL_UPDATED - actually a wxCommandEvent is sent

    wxSpinEvent(wxEventType commandType = wxEVT_NULL, int id = 0)

    int GetPosition() const
    void SetPosition(int pos)

%endclass

%endif //wxLUA_USE_wxSpinButton && wxUSE_SPINBTN

// ---------------------------------------------------------------------------
// wxSpinCtrl

%if wxLUA_USE_wxSpinCtrl && wxUSE_SPINCTRL

%include "wx/spinctrl.h"

//%define wxSP_ARROW_KEYS see wxSpinButton
//%define wxSP_WRAP see wxSpinButton

%class wxSpinCtrl, wxControl

    wxSpinCtrl()
    wxSpinCtrl(wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& value = wxEmptyString, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSP_ARROW_KEYS, int min = 0, int max = 100, int initial = 0, const wxString& name = "wxSpinCtrl")
    bool Create(wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& value = wxEmptyString, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSP_ARROW_KEYS, int min = 0, int max = 100, int initial = 0, const wxString& name = "wxSpinCtrl")

    int GetMax() const
    int GetMin() const
    int GetValue() const
    void SetRange(int minVal, int maxVal)
    void SetSelection(long from, long to)
    void SetValue(const wxString& text)
    void SetValue(int iValue)

%endclass

%endif //wxLUA_USE_wxSpinCtrl && wxUSE_SPINCTRL

// ---------------------------------------------------------------------------
// wxTextCtrl

%if wxLUA_USE_wxTextCtrl && wxUSE_TEXTCTRL

%include "wx/textctrl.h"

%define wxTE_PROCESS_ENTER
%define wxTE_PROCESS_TAB
%define wxTE_MULTILINE
%define wxTE_PASSWORD
%define wxTE_READONLY
%define wxTE_RICH
%define wxTE_RICH2
%define wxTE_AUTO_URL
%define wxTE_NOHIDESEL
%define wxTE_LEFT
%define wxTE_CENTRE
%define wxTE_RIGHT
%define wxTE_DONTWRAP
%define wxTE_LINEWRAP
%define wxTE_CHARWRAP
%define wxTE_WORDWRAP
%define wxTE_BESTWRAP
%define wxTE_CAPITALIZE
%define wxTE_AUTO_SCROLL
%define wxTE_NO_VSCROLL

%enum wxTextCtrlHitTestResult

    wxTE_HT_UNKNOWN
    wxTE_HT_BEFORE
    wxTE_HT_ON_TEXT
    wxTE_HT_BELOW
    wxTE_HT_BEYOND

%endenum

%typedef long wxTextCoord
%define wxOutOfRangeTextCoord
%define wxInvalidTextCoord

%class wxTextCtrl, wxControl

    wxTextCtrl()
    wxTextCtrl(wxWindow *parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxTextCtrl")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxTextCtrl")

    void AppendText(const wxString& text)
    virtual bool CanCopy()
    virtual bool CanCut()
    virtual bool CanPaste()
    virtual bool CanRedo()
    virtual bool CanUndo()
    virtual void ChangeValue(const wxString& value)
    virtual void Clear()
    virtual void Copy()
    virtual void Cut()
    void DiscardEdits()
    bool EmulateKeyPress(const wxKeyEvent& event)
    const wxTextAttr& GetDefaultStyle() const
    virtual long GetInsertionPoint() const
    virtual long GetLastPosition() const
    int GetLineLength(long lineNo) const
    wxString GetLineText(long lineNo) const
    int GetNumberOfLines() const
    virtual wxString GetRange(long from, long to) const

    // %override [long from, long to] wxTextCtrl::GetSelection()
    // C++ Func: virtual void GetSelection(long* from, long* to) const
    virtual void GetSelection() const

    virtual wxString GetStringSelection()
    bool GetStyle(long position, wxTextAttr& style)
    wxString GetValue() const

    // %override [wxTextCtrlHitTestResult, int col, int row] wxTextCtrl::HitTest(const wxPoint& pt)
    // C++ Func: wxTextCtrlHitTestResult HitTest(const wxPoint& pt, wxTextCoord *col, wxTextCoord *row) const
    wxTextCtrlHitTestResult HitTest(const wxPoint& pt) const

    // %override [wxTextCtrlHitTestResult, int pos] wxTextCtrl::HitTestPos(const wxPoint& pt)
    // C++ Func: wxTextCtrlHitTestResult HitTest(const wxPoint& pt, long *pos) const
    %rename HitTestPos wxTextCtrlHitTestResult HitTest(const wxPoint& pt) const

    bool IsEditable() const
    bool IsModified() const
    bool IsMultiLine() const
    bool IsSingleLine() const
    bool LoadFile(const wxString& filename)
    void MarkDirty()
    //void OnDropFiles(wxDropFilesEvent& event)
    virtual void Paste()

    // %override [bool, int x, int y] wxTextCtrl::PositionToXY(long pos)
    // C++ Func: bool PositionToXY(long pos, long *x, long *y) const
    bool PositionToXY(long pos) const

    virtual void Redo()
    virtual void Remove(long from, long to)
    virtual void Replace(long from, long to, const wxString& value)
    bool SaveFile(const wxString& filename)
    bool SetDefaultStyle(const wxTextAttr& style)
    virtual void SetEditable(bool editable)
    virtual void SetInsertionPoint(long pos)
    virtual void SetInsertionPointEnd()
    virtual void SetMaxLength(unsigned long value)
    virtual void SetSelection(long from, long to)
    bool SetStyle(long start, long end, const wxTextAttr& style)
    virtual void SetValue(const wxString& value)
    void ShowPosition(long pos)
    virtual void Undo()
    void WriteText(const wxString& text)
    long XYToPosition(long x, long y)

%endclass

%enum wxTextAttrAlignment

    wxTEXT_ALIGNMENT_DEFAULT
    wxTEXT_ALIGNMENT_LEFT
    wxTEXT_ALIGNMENT_CENTRE
    wxTEXT_ALIGNMENT_CENTER
    wxTEXT_ALIGNMENT_RIGHT
    wxTEXT_ALIGNMENT_JUSTIFIED

%endenum

%define wxTEXT_ATTR_TEXT_COLOUR
%define wxTEXT_ATTR_BACKGROUND_COLOUR
%define wxTEXT_ATTR_FONT_FACE
%define wxTEXT_ATTR_FONT_SIZE
%define wxTEXT_ATTR_FONT_WEIGHT
%define wxTEXT_ATTR_FONT_ITALIC
%define wxTEXT_ATTR_FONT_UNDERLINE
%define wxTEXT_ATTR_FONT
%define wxTEXT_ATTR_ALIGNMENT
%define wxTEXT_ATTR_LEFT_INDENT
%define wxTEXT_ATTR_RIGHT_INDENT
%define wxTEXT_ATTR_TABS

%class %delete %noclassinfo %encapsulate wxTextAttr

    //wxTextAttr()
    wxTextAttr(const wxColour& colText = wxNullColour, const wxColour& colBack = wxNullColour, const wxFont& font = wxNullFont, wxTextAttrAlignment alignment = wxTEXT_ALIGNMENT_DEFAULT)

    wxTextAttrAlignment GetAlignment() const
    wxColour GetBackgroundColour() const
    long GetFlags() const
    wxFont GetFont() const
    long GetLeftIndent() const
    long GetLeftSubIndent() const
    long GetRightIndent() const
    const wxArrayInt& GetTabs() const
    wxColour GetTextColour() const
    bool HasAlignment() const
    bool HasBackgroundColour() const
    bool HasFlag(long flag) const
    bool HasFont() const
    bool HasLeftIndent() const
    bool HasRightIndent() const
    bool HasTabs() const
    bool HasTextColour() const
    bool IsDefault() const
    void SetAlignment(wxTextAttrAlignment alignment)
    void SetBackgroundColour(const wxColour& colBack)
    void SetFlags(long flags)
    void SetFont(const wxFont& font, long flags = wxTEXT_ATTR_FONT)
    void SetLeftIndent(int indent, int subIndent = 0)
    void SetRightIndent(int indent)
    void SetTabs(const wxArrayInt& tabs)
    void SetTextColour(const wxColour& colText)

%endclass

// ---------------------------------------------------------------------------
// wxTextUrlEvent

%class %delete wxTextUrlEvent, wxCommandEvent


    %wxchkver_2_8_0 %define_event wxEVT_COMMAND_TEXT_URL // EVT_TEXT_URL(id, fn)

    wxTextUrlEvent(int winid, const wxMouseEvent& evtMouse, long start, long end)

    const wxMouseEvent& GetMouseEvent() const
    long GetURLStart() const
    long GetURLEnd() const

%endclass

%endif //wxLUA_USE_wxTextCtrl && wxUSE_TEXTCTRL

// ---------------------------------------------------------------------------
// wxTreeCtrl

%if wxLUA_USE_wxTreeCtrl && wxUSE_TREECTRL

%include "wx/treectrl.h"

%define wxTR_NO_BUTTONS
%define wxTR_HAS_BUTTONS
%define wxTR_TWIST_BUTTONS
%define wxTR_NO_LINES
%define wxTR_SINGLE
%define wxTR_MULTIPLE
%define wxTR_EXTENDED
%define wxTR_EDIT_LABELS
%define wxTR_LINES_AT_ROOT
%define wxTR_HIDE_ROOT
%define wxTR_ROW_LINES
%define wxTR_HAS_VARIABLE_ROW_HEIGHT
%define wxTR_FULL_ROW_HIGHLIGHT
%define wxTR_DEFAULT_STYLE

//%define wxTR_MAC_BUTTONS both deprecated
//%define wxTR_AQUA_BUTTONS

%enum wxTreeItemIcon

    wxTreeItemIcon_Normal
    wxTreeItemIcon_Selected
    wxTreeItemIcon_Expanded
    wxTreeItemIcon_SelectedExpanded
    wxTreeItemIcon_Max

%endenum

%define wxTREE_HITTEST_ABOVE
%define wxTREE_HITTEST_BELOW
%define wxTREE_HITTEST_NOWHERE
%define wxTREE_HITTEST_ONITEMBUTTON
%define wxTREE_HITTEST_ONITEMICON
%define wxTREE_HITTEST_ONITEMINDENT
%define wxTREE_HITTEST_ONITEMLABEL
%define wxTREE_HITTEST_ONITEMRIGHT
%define wxTREE_HITTEST_ONITEMSTATEICON
%define wxTREE_HITTEST_TOLEFT
%define wxTREE_HITTEST_TORIGHT
%define wxTREE_HITTEST_ONITEMUPPERPART
%define wxTREE_HITTEST_ONITEMLOWERPART
%define wxTREE_HITTEST_ONITEM

%class wxTreeCtrl, wxControl

    wxTreeCtrl()
    wxTreeCtrl(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTR_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxTreeCtrl")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTR_HAS_BUTTONS, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxTreeCtrl")

    wxTreeItemId AddRoot(const wxString& text, int image = -1, int selImage = -1, wxTreeItemData* data = NULL)
    wxTreeItemId AppendItem(const wxTreeItemId& parent, const wxString& text, int image = -1, int selImage = -1, wxTreeItemData* data = NULL)
    //void AssignButtonsImageList(wxImageList* imageList)
    void AssignImageList(%ungc wxImageList* imageList)
    void AssignStateImageList(%ungc wxImageList* imageList)
    void Collapse(const wxTreeItemId& item)
    void CollapseAndReset(const wxTreeItemId& item)
    void Delete(const wxTreeItemId& item)
    void DeleteAllItems()
    void DeleteChildren(const wxTreeItemId& item)
    void EditLabel(const wxTreeItemId& item)
    %win void EndEditLabel(const wxTreeItemId& item, bool discardChanges = false)
    void EnsureVisible(const wxTreeItemId& item)
    void Expand(const wxTreeItemId& item)
    bool GetBoundingRect(const wxTreeItemId& item, wxRect& rect, bool textOnly = false) const
    //wxImageList* GetButtonsImageList() const
    size_t GetChildrenCount(const wxTreeItemId& item, bool recursively = true) const
    int GetCount() const
    //wxTextCtrl* GetEditControl() const

    // %override [wxTreeItemId, wxTreeItemIdValue cookie] wxTreeCtrl::GetFirstChild(const wxTreeItemId& item)
    // C++ Func: wxTreeItemId GetFirstChild(const wxTreeItemId& item, wxTreeItemIdValue& cookie) const
    wxTreeItemId GetFirstChild(const wxTreeItemId& item) const

    wxTreeItemId GetFirstVisibleItem() const
    wxImageList* GetImageList() const
    int GetIndent() const
    wxColour GetItemBackgroundColour(const wxTreeItemId& item) const
    wxTreeItemData* GetItemData(const wxTreeItemId& item) const
    wxFont GetItemFont(const wxTreeItemId& item) const
    int GetItemImage(const wxTreeItemId& item, wxTreeItemIcon which = wxTreeItemIcon_Normal) const
    wxString GetItemText(const wxTreeItemId& item) const
    wxColour GetItemTextColour(const wxTreeItemId& item) const
    wxTreeItemId GetLastChild(const wxTreeItemId& item) const

    // %override [wxTreeItemId, wxTreeItemIdValue cookie] wxTreeCtrl::GetNextChild(const wxTreeItemId& item, long cookie)
    // C++ Func: wxTreeItemId GetNextChild(const wxTreeItemId& item, wxTreeItemIdValue& cookie) const
    wxTreeItemId GetNextChild(const wxTreeItemId& item, long cookie) const

    wxTreeItemId GetNextSibling(const wxTreeItemId& item) const
    wxTreeItemId GetNextVisible(const wxTreeItemId& item) const
    %wxchkver_2_4 wxTreeItemId GetItemParent(const wxTreeItemId& item) const
    wxTreeItemId GetPrevSibling(const wxTreeItemId& item) const
    wxTreeItemId GetPrevVisible(const wxTreeItemId& item) const
    wxTreeItemId GetRootItem() const
    //!%wxchkver_2_6|%wxcompat_2_4 int GetItemSelectedImage(const wxTreeItemId& item) const
    wxTreeItemId GetSelection() const

    // %override [size_t, Lua table of wxTreeItemIds] wxTreeCtrl::GetSelections()
    // C++ Func: size_t GetSelections(wxArrayTreeItemIds& selection) const
    size_t GetSelections() const

    wxImageList* GetStateImageList() const

    // %override [wxTreeItemId, int flags] wxTreeCtrl::HitTest(const wxPoint& point)
    // C++ Func: wxTreeItemId HitTest(const wxPoint& point, int& flags)
    wxTreeItemId HitTest(const wxPoint& point)

    wxTreeItemId InsertItem(const wxTreeItemId& parent, const wxTreeItemId& previous, const wxString& text, int image = -1, int selImage = -1, wxTreeItemData* data = NULL)
    wxTreeItemId InsertItem(const wxTreeItemId& parent, size_t before, const wxString& text, int image = -1, int selImage = -1, wxTreeItemData* data = NULL)
    bool IsBold(const wxTreeItemId& item) const
    bool IsExpanded(const wxTreeItemId& item) const
    bool IsSelected(const wxTreeItemId& item) const
    bool IsVisible(const wxTreeItemId& item) const
    bool ItemHasChildren(const wxTreeItemId& item) const
    //int OnCompareItems(const wxTreeItemId& item1, const wxTreeItemId& item2)
    wxTreeItemId PrependItem(const wxTreeItemId& parent, const wxString& text, int image = -1, int selImage = -1, wxTreeItemData* data = NULL)
    void ScrollTo(const wxTreeItemId& item)
    void SelectItem(const wxTreeItemId& item, bool select = true)
    //void SetButtonsImageList(wxImageList* imageList)
    void SetIndent(int indent)
    void SetImageList(wxImageList* imageList)
    void SetItemBackgroundColour(const wxTreeItemId& item, const wxColour& col)
    void SetItemBold(const wxTreeItemId& item, bool bold = true)
    void SetItemData(const wxTreeItemId& item, wxTreeItemData* data)
    void SetItemDropHighlight(const wxTreeItemId& item, bool highlight = true)
    void SetItemFont(const wxTreeItemId& item, const wxFont& font)
    void SetItemHasChildren(const wxTreeItemId& item, bool hasChildren = true)
    void SetItemImage(const wxTreeItemId& item, int image, wxTreeItemIcon which = wxTreeItemIcon_Normal)
    //!%wxchkver_2_6|%wxcompat_2_4 void SetItemSelectedImage(const wxTreeItemId& item, int selImage)
    void SetItemText(const wxTreeItemId& item, const wxString& text)
    void SetItemTextColour(const wxTreeItemId& item, const wxColour& col)
    void SetStateImageList(wxImageList* imageList)
    // void SetWindowStyle(long styles) - see wxWindow
    void SortChildren(const wxTreeItemId& item)
    void Toggle(const wxTreeItemId& item)
    void ToggleItemSelection(const wxTreeItemId& item)
    void Unselect()
    void UnselectAll()
    void UnselectItem(const wxTreeItemId& item)

%endclass

// ---------------------------------------------------------------------------
// wxTreeItemAttr - wxTreeCtrl
// This is only used internally in wxWidgets with no public accessors to them.

/*
%class %delete %noclassinfo %encapsulate wxTreeItemAttr

    wxTreeItemAttr(const wxColour& colText = wxNullColour, const wxColour& colBack = wxNullColour, const wxFont& font = wxNullFont)

    wxColour GetBackgroundColour() const
    wxFont GetFont() const
    wxColour GetTextColour() const
    bool HasBackgroundColour()
    bool HasFont()
    bool HasTextColour()
    void SetBackgroundColour(const wxColour& colBack)
    void SetFont(const wxFont& font)
    void SetTextColour(const wxColour& colText)

%endclass
*/

// ---------------------------------------------------------------------------
// wxTreeItemIdValue - wxTreeCtrl

//%if %wxchkver_2_6
//%class %noclassinfo wxTreeItemIdValue
//%endclass
//%endif

// ---------------------------------------------------------------------------
// wxTreeItemId - wxTreeCtrl

%enum wxTreeItemIdValue

    // FAKE enum, actually typedef void* wxTreeItemIdValue
    // but Lua only uses double. This gets around compiler errors/warnings

%endenum

%class %delete %noclassinfo %encapsulate wxTreeItemId

    wxTreeItemId()
    wxTreeItemId(const wxTreeItemId& id)

    bool IsOk()
    wxTreeItemIdValue GetValue() const // get a pointer to the internal data to use as a reference in a Lua table

    %operator wxTreeItemId& operator=(const wxTreeItemId& otherId)
    %operator bool operator==(const wxTreeItemId& otherId) const

%endclass

// ---------------------------------------------------------------------------
// wxArrayTreeItemIds - wxTreeCtrl
// This is only used by the function wxTreeCtrl::GetSelections(wxArrayTreeItemIds& arr)
// which we have overridden to return a table. This is not necessary.
//
// Note: This is actually an array of the internal wxTreeItemIdValue data
// which is a void* pointer. This is why we use long.
// See wxLua's wxTreeItemId::GetValue() function

/*
%class %delete %noclassinfo %encapsulate wxArrayTreeItemIds

    wxArrayTreeItemIds()
    wxArrayTreeItemIds(const wxArrayTreeItemIds& array)

    void Add(const wxTreeItemId& id)
    void Alloc(size_t nCount)
    void Clear()
    void Empty()
    int GetCount() const
    int Index(wxTreeItemIdValue treeItemIdValue, bool bFromEnd = false)
    //void Insert(wxTreeItemId& str, int nIndex, size_t copies = 1)
    bool IsEmpty()
    wxTreeItemId Item(size_t nIndex) const
    wxTreeItemId Last()
    void Remove(wxTreeItemIdValue treeItemIdValue)
    void RemoveAt(size_t nIndex, size_t count = 1)
    void Shrink()

%endclass
*/

// ---------------------------------------------------------------------------
// wxTreeItemData - wxTreeCtrl, see also wxLuaTreeItemData
//
// No %delete since the wxTreeCtrl should do it and you should only create one
// of these if you're going to attach it to a wxTreeCtrl to avoid memory leaks.

%class %noclassinfo wxTreeItemData, wxClientData

    wxTreeItemData()

    wxTreeItemId GetId()
    void SetId(const wxTreeItemId& id)

%endclass

// ---------------------------------------------------------------------------
// wxLuaTreeItemData
//
// No %delete since the wxTreeCtrl should do it and you should only create one
// of these if you're going to attach it to a wxTreeCtrl to avoid memory leaks.

%include "wxbind/include/wxcore_wxlcore.h"

%class %noclassinfo wxLuaTreeItemData, wxTreeItemData

    wxLuaTreeItemData(double value = 0)

    double GetValue() const;
    void SetValue(double value);

%endclass


// ---------------------------------------------------------------------------
// wxTreeEvent - wxTreeCtrl

%class %delete wxTreeEvent, wxNotifyEvent

    %define_event wxEVT_COMMAND_TREE_BEGIN_DRAG // EVT_TREE_BEGIN_DRAG(id, fn)
    %define_event wxEVT_COMMAND_TREE_BEGIN_LABEL_EDIT // EVT_TREE_BEGIN_LABEL_EDIT(id, fn)
    %define_event wxEVT_COMMAND_TREE_BEGIN_RDRAG // EVT_TREE_BEGIN_RDRAG(id, fn)
    %define_event wxEVT_COMMAND_TREE_DELETE_ITEM // EVT_TREE_DELETE_ITEM(id, fn)
    %define_event wxEVT_COMMAND_TREE_END_DRAG // EVT_TREE_END_DRAG(id, fn)
    %define_event wxEVT_COMMAND_TREE_END_LABEL_EDIT // EVT_TREE_END_LABEL_EDIT(id, fn)
    %define_event wxEVT_COMMAND_TREE_GET_INFO // EVT_TREE_GET_INFO(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_ACTIVATED // EVT_TREE_ITEM_ACTIVATED(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_COLLAPSED // EVT_TREE_ITEM_COLLAPSED(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_COLLAPSING // EVT_TREE_ITEM_COLLAPSING(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_EXPANDED // EVT_TREE_ITEM_EXPANDED(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_EXPANDING // EVT_TREE_ITEM_EXPANDING(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_MIDDLE_CLICK // EVT_TREE_ITEM_MIDDLE_CLICK(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_RIGHT_CLICK // EVT_TREE_ITEM_RIGHT_CLICK(id, fn)
    %define_event wxEVT_COMMAND_TREE_KEY_DOWN // EVT_TREE_KEY_DOWN(id, fn)
    %define_event wxEVT_COMMAND_TREE_SEL_CHANGED // EVT_TREE_SEL_CHANGED(id, fn)
    %define_event wxEVT_COMMAND_TREE_SEL_CHANGING // EVT_TREE_SEL_CHANGING(id, fn)
    %define_event wxEVT_COMMAND_TREE_SET_INFO // EVT_TREE_SET_INFO(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_MENU // EVT_TREE_ITEM_MENU(id, fn)
    %define_event wxEVT_COMMAND_TREE_STATE_IMAGE_CLICK // EVT_TREE_STATE_IMAGE_CLICK(id, fn)
    %define_event wxEVT_COMMAND_TREE_ITEM_GETTOOLTIP // EVT_TREE_ITEM_GETTOOLTIP(id, fn)

    wxTreeEvent(wxEventType commandType = wxEVT_NULL, int id = 0)

    int GetKeyCode() const
    wxTreeItemId GetItem() const
    wxKeyEvent GetKeyEvent() const
    const wxString& GetLabel() const
    wxTreeItemId GetOldItem() const
    wxPoint GetPoint() const
    bool IsEditCancelled() const
    void SetToolTip(const wxString& tooltip)

%endclass

%endif //wxLUA_USE_wxTreeCtrl && wxUSE_TREECTRL

// ---------------------------------------------------------------------------
// wxGenericDirCtrl

%if wxLUA_USE_wxGenericDirCtrl && wxUSE_DIRDLG

%include "wx/dirctrl.h"

%enum

    wxDIRCTRL_DIR_ONLY
    wxDIRCTRL_SELECT_FIRST
    wxDIRCTRL_SHOW_FILTERS
    wxDIRCTRL_3D_INTERNAL
    wxDIRCTRL_EDIT_LABELS

%endenum

%define_string wxDirDialogDefaultFolderStr

%class wxGenericDirCtrl, wxControl

    wxGenericDirCtrl()
    wxGenericDirCtrl(wxWindow *parent, const wxWindowID id = wxID_ANY, const wxString &dir = wxDirDialogDefaultFolderStr, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDIRCTRL_3D_INTERNAL|wxSUNKEN_BORDER, const wxString& filter = "", int defaultFilter = 0, const wxString& name = "wxGenericDirCtrl")
    bool Create(wxWindow *parent, const wxWindowID id = wxID_ANY, const wxString &dir = wxDirDialogDefaultFolderStr, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDIRCTRL_3D_INTERNAL|wxSUNKEN_BORDER, const wxString& filter = "", int defaultFilter = 0, const wxString& name = "wxGenericDirCtrl")

    void CollapseTree()
    bool ExpandPath(const wxString& path)
    wxString GetDefaultPath() const
    wxString GetPath() const
    wxString GetFilePath() const
    wxString GetFilter() const
    int GetFilterIndex() const
    //wxDirFilterListCtrl* GetFilterListCtrl() const
    wxTreeItemId GetRootId()
    wxTreeCtrl* GetTreeCtrl() const
    void ReCreateTree()
    void SetDefaultPath(const wxString& path)
    void SetFilter(const wxString& filter)
    void SetFilterIndex(int n)
    void SetPath(const wxString& path)
    void ShowHidden( bool show )
    bool GetShowHidden()

    //wxTreeItemId FindChild(wxTreeItemId parentId, const wxString& path, bool& done)

%endclass

%endif //wxLUA_USE_wxGenericDirCtrl && wxUSE_DIRDLG

wxwidgets/wxcore_core.i - Lua table = 'wx'
// ===========================================================================
// Purpose: Various wxCore classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxLog && wxUSE_LOG

// C++ Func: void wxLogStatus(wxFrame *frame, const char *formatString, ...)
// void wxLogStatus(const char *formatString, ...) // this just uses the toplevel frame, use wx.NULL for the frame
%function void wxLogStatus(wxFrame *frame, const wxString& message)

// ---------------------------------------------------------------------------
// wxLogGui - wxWidgets creates and installs one of these at startup,
// just treat it as a wxLog.

%if wxUSE_LOGGUI

%class %delete %noclassinfo %encapsulate wxLogGui, wxLog

    wxLogGui()

%endclass

%endif // wxUSE_LOGGUI

// ---------------------------------------------------------------------------
// wxLogTextCtrl

%if wxLUA_USE_wxTextCtrl && wxUSE_TEXTCTRL

%class %delete %noclassinfo %encapsulate wxLogTextCtrl, wxLog

    wxLogTextCtrl(wxTextCtrl* textCtrl);

%endclass

%endif // wxLUA_USE_wxTextCtrl && wxUSE_TEXTCTRL

// ---------------------------------------------------------------------------
// wxLogWindow

%if wxLUA_USE_wxLogWindow && wxUSE_LOGWINDOW

%class %delete %noclassinfo %encapsulate wxLogWindow, wxLogPassThrough

    wxLogWindow(wxWindow *pParent, const wxString& szTitle, bool bShow = true, bool bPassToOld = true);

    void Show(bool show = true)
    wxFrame* GetFrame() const

    //virtual void OnFrameCreate(wxFrame *frame)
    //virtual bool OnFrameClose(wxFrame *frame)
    //virtual void OnFrameDelete(wxFrame *frame)

%endclass

%endif // wxLUA_USE_wxLogWindow && wxUSE_LOGWINDOW

%endif // wxLUA_USE_wxLog && wxUSE_LOG


// ---------------------------------------------------------------------------
// wxSystemSettings

%if wxLUA_USE_wxSystemSettings

%include "wx/settings.h"

%enum wxSystemScreenType

    wxSYS_SCREEN_NONE
    wxSYS_SCREEN_TINY
    wxSYS_SCREEN_PDA
    wxSYS_SCREEN_SMALL
    wxSYS_SCREEN_DESKTOP

%endenum

%enum wxSystemMetric

    wxSYS_MOUSE_BUTTONS
    wxSYS_BORDER_X
    wxSYS_BORDER_Y
    wxSYS_CURSOR_X
    wxSYS_CURSOR_Y
    wxSYS_DCLICK_X
    wxSYS_DCLICK_Y
    wxSYS_DRAG_X
    wxSYS_DRAG_Y
    wxSYS_EDGE_X
    wxSYS_EDGE_Y
    wxSYS_HSCROLL_ARROW_X
    wxSYS_HSCROLL_ARROW_Y
    wxSYS_HTHUMB_X
    wxSYS_ICON_X
    wxSYS_ICON_Y
    wxSYS_ICONSPACING_X
    wxSYS_ICONSPACING_Y
    wxSYS_WINDOWMIN_X
    wxSYS_WINDOWMIN_Y
    wxSYS_SCREEN_X
    wxSYS_SCREEN_Y
    wxSYS_FRAMESIZE_X
    wxSYS_FRAMESIZE_Y
    wxSYS_SMALLICON_X
    wxSYS_SMALLICON_Y
    wxSYS_HSCROLL_Y
    wxSYS_VSCROLL_X
    wxSYS_VSCROLL_ARROW_X
    wxSYS_VSCROLL_ARROW_Y
    wxSYS_VTHUMB_Y
    wxSYS_CAPTION_Y
    wxSYS_MENU_Y
    wxSYS_NETWORK_PRESENT
    wxSYS_PENWINDOWS_PRESENT
    wxSYS_SHOW_SOUNDS
    wxSYS_SWAP_BUTTONS

%endenum

%enum wxSystemFeature

    wxSYS_CAN_DRAW_FRAME_DECORATIONS
    wxSYS_CAN_ICONIZE_FRAME

%endenum

%enum wxSystemColour

    wxSYS_COLOUR_SCROLLBAR
    wxSYS_COLOUR_BACKGROUND
    wxSYS_COLOUR_DESKTOP
    wxSYS_COLOUR_ACTIVECAPTION
    wxSYS_COLOUR_INACTIVECAPTION
    wxSYS_COLOUR_MENU
    wxSYS_COLOUR_WINDOW
    wxSYS_COLOUR_WINDOWFRAME
    wxSYS_COLOUR_MENUTEXT
    wxSYS_COLOUR_WINDOWTEXT
    wxSYS_COLOUR_CAPTIONTEXT
    wxSYS_COLOUR_ACTIVEBORDER
    wxSYS_COLOUR_INACTIVEBORDER
    wxSYS_COLOUR_APPWORKSPACE
    wxSYS_COLOUR_HIGHLIGHT
    wxSYS_COLOUR_HIGHLIGHTTEXT
    wxSYS_COLOUR_BTNFACE
    wxSYS_COLOUR_3DFACE
    wxSYS_COLOUR_BTNSHADOW
    wxSYS_COLOUR_3DSHADOW
    wxSYS_COLOUR_GRAYTEXT
    wxSYS_COLOUR_BTNTEXT
    wxSYS_COLOUR_INACTIVECAPTIONTEXT
    wxSYS_COLOUR_BTNHIGHLIGHT
    wxSYS_COLOUR_BTNHILIGHT
    wxSYS_COLOUR_3DHIGHLIGHT
    wxSYS_COLOUR_3DHILIGHT
    wxSYS_COLOUR_3DDKSHADOW
    wxSYS_COLOUR_3DLIGHT
    wxSYS_COLOUR_INFOTEXT
    wxSYS_COLOUR_INFOBK
    wxSYS_COLOUR_LISTBOX
    wxSYS_COLOUR_HOTLIGHT
    wxSYS_COLOUR_GRADIENTACTIVECAPTION
    wxSYS_COLOUR_GRADIENTINACTIVECAPTION
    wxSYS_COLOUR_MENUHILIGHT
    wxSYS_COLOUR_MENUBAR
    wxSYS_COLOUR_MAX

%endenum

%enum wxSystemFont

    wxSYS_OEM_FIXED_FONT
    wxSYS_ANSI_FIXED_FONT
    wxSYS_ANSI_VAR_FONT
    wxSYS_SYSTEM_FONT
    wxSYS_DEVICE_DEFAULT_FONT
    wxSYS_DEFAULT_PALETTE
    wxSYS_SYSTEM_FIXED_FONT
    wxSYS_DEFAULT_GUI_FONT

%endenum

%class %noclassinfo wxSystemSettings

    //wxSystemSettings() // No constructor, all members static

    static wxColour GetColour(wxSystemColour index)
    static wxFont GetFont(wxSystemFont index)
    static int GetMetric(wxSystemMetric index, wxWindow* win = NULL)
    static bool HasFeature(wxSystemFeature index)

    static wxSystemScreenType GetScreenType()
    static void SetScreenType( wxSystemScreenType screen )

%endclass

%endif //wxLUA_USE_wxSystemSettings


// ---------------------------------------------------------------------------
// wxValidator

%if wxLUA_USE_wxValidator && wxUSE_VALIDATORS

%include "wx/validate.h"

%class wxValidator, wxEvtHandler

    %define_object wxDefaultValidator

    // No constructor as this is a base class

    static bool IsSilent()
    wxWindow* GetWindow() const
    static void SetBellOnError(bool doIt = true)
    void SetWindow(wxWindow* window)
    virtual bool TransferFromWindow()
    virtual bool TransferToWindow()
    virtual bool Validate(wxWindow* parent)

%endclass

// ---------------------------------------------------------------------------
// wxTextValidator

%if wxLUA_USE_wxTextValidator

%include "wx/valtext.h"

%define wxFILTER_NONE
%define wxFILTER_ASCII
%define wxFILTER_ALPHA
%define wxFILTER_ALPHANUMERIC
%define wxFILTER_NUMERIC
%define wxFILTER_INCLUDE_LIST
%define wxFILTER_EXCLUDE_LIST
%define wxFILTER_INCLUDE_CHAR_LIST
%define wxFILTER_EXCLUDE_CHAR_LIST

%class %delete wxTextValidator, wxValidator

    // %override wxTextValidator(long style = wxFILTER_NONE, wxLuaObject* obj = NULL)
    // C++ Func: wxTextValidator(long style = wxFILTER_NONE, wxString *valPtr = NULL)
    wxTextValidator(long style = wxFILTER_NONE, wxLuaObject* stringObj = NULL)

    %wxchkver_2_6 wxArrayString& GetExcludes()
    %wxchkver_2_6 wxArrayString& GetIncludes()
    long GetStyle() const
    void SetStyle(long style)
    %wxchkver_2_6 void SetIncludes(const wxArrayString& includes)
    %wxchkver_2_6 void SetExcludes(const wxArrayString& excludes)

    //!%wxchkver_2_6|%wxcompat_2_4 wxStringList& GetExcludeList() const
    //!%wxchkver_2_6|%wxcompat_2_4 wxStringList& GetIncludeList() const
    //!%wxchkver_2_6|%wxcompat_2_4 void SetExcludeList(const wxStringList& stringList)
    //!%wxchkver_2_6|%wxcompat_2_4 void SetIncludeList(const wxStringList& stringList)

%endclass

%endif //wxLUA_USE_wxTextValidator

// ---------------------------------------------------------------------------
// wxGenericValidator

%if wxLUA_USE_wxGenericValidator

%include "wx/valgen.h"

%class %delete wxGenericValidator, wxValidator

    // See the validator.wx.Lua sample for usage of this class

    // %override wxGenericValidator wxGenericValidatorBool(wxLuaObject* boolObj)
    // C++ Func: wxGenericValidator(bool *boolPtr)
    // for wxCheckBox and wxRadioButton
    %rename wxGenericValidatorBool wxGenericValidator(wxLuaObject* boolObj)

    // %override wxGenericValidator wxGenericValidatorString(wxLuaObject* stringObj)
    // C++ Func: wxGenericValidator(wxString *valPtr)
    // for wxButton and wxComboBox, wxStaticText and wxTextCtrl
    %rename wxGenericValidatorString wxGenericValidator(wxLuaObject* stringObj)

    // %override wxGenericValidator wxGenericValidatorInt(wxLuaObject* intObj)
    // C++ Func: wxGenericValidator(int *valPtr)
    // for wxGauge, wxScrollBar, wxRadioBox, wxSpinButton, wxChoice
    %rename wxGenericValidatorInt wxGenericValidator(wxLuaObject* intObj)

    // %override wxGenericValidator wxGenericValidatorArrayInt(wxLuaObject* intTableObj)
    // C++ Func: wxGenericValidator(wxArrayInt *valPtr)
    // for wxListBox and wxCheckListBox
    %rename wxGenericValidatorArrayInt wxGenericValidator(wxLuaObject* intTableObj)

%endclass

%endif //wxLUA_USE_wxGenericValidator
%endif //wxLUA_USE_wxValidator && wxUSE_VALIDATORS


// ---------------------------------------------------------------------------
// wxMemoryFSHandler - See also wxbase_file.i for other wxFileSystemHandlers

%if wxUSE_STREAMS && wxUSE_FILESYSTEM

%include "wx/fs_mem.h"

%class %noclassinfo %delete wxMemoryFSHandler, wxFileSystemHandler

    wxMemoryFSHandler()

    // Remove file from memory FS and free occupied memory
    static void RemoveFile(const wxString& filename);

    static void AddFile(const wxString& filename, const wxString& textdata);
    //static void AddFile(const wxString& filename, const void *binarydata, size_t size)

    %if %wxchkver_2_8_5
    static void AddFileWithMimeType(const wxString& filename, const wxString& textdata, const wxString& mimetype);
    //static void AddFileWithMimeType(const wxString& filename, const void *binarydata, size_t size, const wxString& mimetype)
    %endif // %wxchkver_2_8_5

    %if wxUSE_IMAGE
    static void AddFile(const wxString& filename, const wxImage& image, long type);
    static void AddFile(const wxString& filename, const wxBitmap& bitmap, long type);
    %endif // wxUSE_IMAGE

%endclass


%endif // wxUSE_STREAMS && wxUSE_FILESYSTEM

wxwidgets/wxcore_defsutils.i - Lua table = 'wx'
// ===========================================================================
// Purpose: enums, defines from wx/defs.h and other places
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%include "wx/defs.h"
%include "wx/utils.h"

// This list of global functions is taken from the wxWindow's manual

// ---------------------------------------------------------------------------
// Application initialization and termination

%function void wxInitAllImageHandlers()
%function bool wxSafeYield(wxWindow* win = NULL, bool onlyIfNeeded = false)
%function bool wxYield()
%function void wxWakeUpIdle()

// ---------------------------------------------------------------------------
// wxProcess

%if wxLUA_USE_wxProcess

%enum

    wxEXEC_ASYNC
    wxEXEC_SYNC
    wxEXEC_NOHIDE
    wxEXEC_MAKE_GROUP_LEADER
    wxEXEC_NODISABLE

%endenum

%enum

    wxPROCESS_DEFAULT
    wxPROCESS_REDIRECT

%endenum

%enum wxSignal

    wxSIGNONE
    wxSIGHUP
    wxSIGINT
    wxSIGQUIT
    wxSIGILL
    wxSIGTRAP
    wxSIGABRT
    wxSIGEMT
    wxSIGFPE
    wxSIGKILL
    wxSIGBUS
    wxSIGSEGV
    wxSIGSYS
    wxSIGPIPE
    wxSIGALRM
    wxSIGTERM

%endenum

%enum wxKillError

    wxKILL_OK
    wxKILL_BAD_SIGNAL
    wxKILL_ACCESS_DENIED
    wxKILL_NO_PROCESS
    wxKILL_ERROR

%endenum

%enum wxKillFlags

    wxKILL_NOCHILDREN
    wxKILL_CHILDREN

%endenum

%class %delete %encapsulate wxProcess, wxEvtHandler

    wxProcess(wxEvtHandler *parent = NULL, int nId = wxID_ANY)
    //wxProcess(int flags)

    void Detach()
    static wxKillError Kill(int pid, wxSignal sig = wxSIGTERM, int flags = wxKILL_NOCHILDREN)
    static bool Exists(int pid)
    //virtual void OnTerminate(int pid, int status) just handle the event instead
    static wxProcess *Open(const wxString& cmd, int flags = wxEXEC_ASYNC)
    void Redirect()
    bool IsRedirected()

    %if wxUSE_STREAMS
    void CloseOutput()
    wxInputStream *GetErrorStream() const
    wxInputStream *GetInputStream() const
    wxOutputStream *GetOutputStream() const
    bool IsErrorAvailable() const
    bool IsInputAvailable() const
    bool IsInputOpened() const
    void SetPipeStreams(wxInputStream *outStream, wxOutputStream *inStream, wxInputStream *errStream)
    %endif // wxUSE_STREAMS

%endclass

%endif //wxLUA_USE_wxProcess

// ---------------------------------------------------------------------------
// Process control functions

!%wxchkver_2_6 %function long wxExecute(const wxString& command, bool sync = false, wxProcess *callback = NULL)
%wxchkver_2_6 %function long wxExecute(const wxString& command, int flags = wxEXEC_ASYNC, wxProcess *process = NULL)
// %override [long, Lua table of output strings] wxExecuteStdout(const wxString& command, int flags = 0)
%function %rename wxExecuteStdout long wxExecute(const wxString& command, wxArrayString& output, int flags = 0)
// %override [long, Lua table of output strings, Lua table of error strings] wxExecuteStdoutStderr(const wxString& command, int flags = 0)
%function %rename wxExecuteStdoutStderr long wxExecute(const wxString& command, wxArrayString& output, wxArrayString& errors, int flags = 0)
%function void wxExit()

// %override [int, wxKillError rc] wxKill(long pid, wxSignal sig = wxSIGTERM, int flags = 0)
// C++ Func: int wxKill(long pid, wxSignal sig = wxSIGTERM, wxKillError *rc = NULL, int flags = 0)
%function int wxKill(long pid, wxSignal sig = wxSIGTERM, int flags = 0)
%function unsigned long wxGetProcessId()
%function bool wxShell(const wxString& command = "")


%enum wxShutdownFlags

    wxSHUTDOWN_POWEROFF
    wxSHUTDOWN_REBOOT

%endenum

%function bool wxShutdown(wxShutdownFlags flags)

// ---------------------------------------------------------------------------
// File functions - see file.i

// ---------------------------------------------------------------------------
// Network, user, and OS functions - see wxbase_base.i

// ---------------------------------------------------------------------------
// String functions - nothing useful here

// ---------------------------------------------------------------------------
// Dialog functions - see dialogs.i

//%function void wxBeginBusyCursor(wxCursor *cursor = wxHOURGLASS_CURSOR)
//%function void wxBell()
//%function void wxEndBusyCursor()
//%function bool wxIsBusy()

// ---------------------------------------------------------------------------
// Math functions - nothing useful here

// ---------------------------------------------------------------------------
// GDI functions

// %override [int x, int y, int width, int height] wxClientDisplayRect()
// void wxClientDisplayRect(int *x, int *y, int *width, int *height)
%function void wxClientDisplayRect()

%function wxRect wxGetClientDisplayRect()
%function bool wxColourDisplay()
%function int wxDisplayDepth()
// %override [int width, int height] wxDisplaySize()
// void wxDisplaySize(int *width, int *height)
%function void wxDisplaySize()

%function wxSize wxGetDisplaySize()
// %override [int width, int height] wxDisplaySizeMM()
// void wxDisplaySizeMM(int *width, int *height)
%function void wxDisplaySizeMM()

%function wxSize wxGetDisplaySizeMM()

%function void wxSetCursor(const wxCursor &cursor)
// %function wxIconOrCursor wxDROP_ICON(wxString name)

// ---------------------------------------------------------------------------
// Printer settings - are marked obsolete

// ---------------------------------------------------------------------------
// Clipboard functions - are marked obsolete

// ---------------------------------------------------------------------------
// Miscellaneous functions

%function bool wxGetKeyState(wxKeyCode key)
%function long wxNewId()
%function void wxRegisterId(long id)
%function void wxEnableTopLevelWindows(bool enable = true)
%function int wxFindMenuItemId(wxFrame *frame, const wxString& menuString, const wxString& itemString)
%function wxWindow* wxFindWindowByLabel(const wxString& label, wxWindow *parent=NULL)
%function wxWindow* wxFindWindowByName(const wxString& name, wxWindow *parent=NULL)
%function wxWindow* wxFindWindowAtPoint(const wxPoint& pt)
%function wxWindow* wxFindWindowAtPointer(wxPoint& pt)
%wxchkver_2_8_4 %function wxWindow* wxGetActiveWindow()
// wxBatteryState wxGetBatteryState()
// X only %function wxString wxGetDisplayName()
// X only %function void wxSetDisplayName(const wxString& displayName)
// wxPowerType wxGetPowerType()
%function wxPoint wxGetMousePosition()

%if %wxchkver_2_8
// This is in wxWidgets 2.6 docs, but it's only in >=2.7
%class %delete %noclassinfo %encapsulate wxMouseState

    wxMouseState()

    wxCoord GetX()
    wxCoord GetY()
    bool LeftDown()
    bool MiddleDown()
    bool RightDown()
    bool ControlDown()
    bool ShiftDown()
    bool AltDown()
    bool MetaDown()
    bool CmdDown()
    void SetX(wxCoord x)
    void SetY(wxCoord y)
    void SetLeftDown(bool down)
    void SetMiddleDown(bool down)
    void SetRightDown(bool down)
    void SetControlDown(bool down)
    void SetShiftDown(bool down)
    void SetAltDown(bool down)
    void SetMetaDown(bool down)

%endclass

%function wxMouseState wxGetMouseState()
%endif

// %function bool wxGetResource(const wxString& section, const wxString& entry, const wxString& *value, const wxString& file = "")
// %function bool wxWriteResource(const wxString& section, const wxString& entry, const wxString& value, const wxString& file = "")
// wxString wxGetStockLabel(wxWindowID id, bool withCodes = true, wxString accelerator = wxEmptyString)
%function wxWindow* wxGetTopLevelParent(wxWindow *win)
%function bool wxLaunchDefaultBrowser(const wxString& sUrl)
//%win %function wxString wxLoadUserResource(const wxString& resourceName, const wxString& resourceType="TEXT")
%function void wxPostEvent(wxEvtHandler *dest, wxEvent& event)

// ---------------------------------------------------------------------------
// Byte order macros - nothing useful

// ---------------------------------------------------------------------------
// RTTI functions - nothing useful, see wxObject:DynamicCast

// ---------------------------------------------------------------------------
// Log functions - FIXME maybe useful?

// ---------------------------------------------------------------------------
// Time functions - see datetime.i

// ---------------------------------------------------------------------------
// Debugging macros and functions - nothing useful

// ---------------------------------------------------------------------------
// Environmental access functions - see wxbase_base.i

// ---------------------------------------------------------------------------
// wxWidgets window IDs - copied from wx/defs.h

%if wxLUA_USE_wxID_XXX

%define wxID_NONE
%define wxID_SEPARATOR
%define wxID_ANY
%define wxID_LOWEST

%define wxID_OPEN
%define wxID_CLOSE
%define wxID_NEW
%define wxID_SAVE
%define wxID_SAVEAS
%define wxID_REVERT
%define wxID_EXIT
%define wxID_UNDO
%define wxID_REDO
%define wxID_HELP
%define wxID_PRINT
%define wxID_PRINT_SETUP
%wxchkver_2_8 %define wxID_PAGE_SETUP
%define wxID_PREVIEW
%define wxID_ABOUT
%define wxID_HELP_CONTENTS
%wxchkver_2_8 %define wxID_HELP_INDEX
%wxchkver_2_8 %define wxID_HELP_SEARCH
%define wxID_HELP_COMMANDS
%define wxID_HELP_PROCEDURES
%define wxID_HELP_CONTEXT
%define wxID_CLOSE_ALL
%define wxID_PREFERENCES

%wxchkver_2_8 %define wxID_EDIT
%define wxID_CUT
%define wxID_COPY
%define wxID_PASTE
%define wxID_CLEAR
%define wxID_FIND
%define wxID_DUPLICATE
%define wxID_SELECTALL
%define wxID_DELETE
%define wxID_REPLACE
%define wxID_REPLACE_ALL
%define wxID_PROPERTIES

%define wxID_VIEW_DETAILS
%define wxID_VIEW_LARGEICONS
%define wxID_VIEW_SMALLICONS
%define wxID_VIEW_LIST
%define wxID_VIEW_SORTDATE
%define wxID_VIEW_SORTNAME
%define wxID_VIEW_SORTSIZE
%define wxID_VIEW_SORTTYPE

%wxchkver_2_8 %define wxID_FILE
%define wxID_FILE1
%define wxID_FILE2
%define wxID_FILE3
%define wxID_FILE4
%define wxID_FILE5
%define wxID_FILE6
%define wxID_FILE7
%define wxID_FILE8
%define wxID_FILE9

%define wxID_OK
%define wxID_CANCEL
%define wxID_APPLY
%define wxID_YES
%define wxID_NO
%define wxID_STATIC
%define wxID_FORWARD
%define wxID_BACKWARD
%define wxID_DEFAULT
%define wxID_MORE
%define wxID_SETUP
%define wxID_RESET
%define wxID_CONTEXT_HELP
%define wxID_YESTOALL
%define wxID_NOTOALL
%define wxID_ABORT
%define wxID_RETRY
%define wxID_IGNORE
%define wxID_ADD
%define wxID_REMOVE

%define wxID_UP
%define wxID_DOWN
%define wxID_HOME
%define wxID_REFRESH
%define wxID_STOP
%define wxID_INDEX

%define wxID_BOLD
%define wxID_ITALIC
%define wxID_JUSTIFY_CENTER
%define wxID_JUSTIFY_FILL
%define wxID_JUSTIFY_RIGHT
%define wxID_JUSTIFY_LEFT
%define wxID_UNDERLINE
%define wxID_INDENT
%define wxID_UNINDENT
%define wxID_ZOOM_100
%define wxID_ZOOM_FIT
%define wxID_ZOOM_IN
%define wxID_ZOOM_OUT
%define wxID_UNDELETE
%define wxID_REVERT_TO_SAVED

%define wxID_SYSTEM_MENU
%define wxID_CLOSE_FRAME
%define wxID_MOVE_FRAME
%define wxID_RESIZE_FRAME
%define wxID_MAXIMIZE_FRAME
%define wxID_ICONIZE_FRAME
%define wxID_RESTORE_FRAME

// %define wxID_FILEDLGG - probably not useful

%define wxID_HIGHEST

%endif //wxLUA_USE_wxID_XXX

// ---------------------------------------------------------------------------
// Generic defines and enums

%define wxBACKINGSTORE
%define wxBACKWARD
%define wxCANCEL
%define wxCENTER
%define wxCENTER_FRAME
%define wxCENTER_ON_SCREEN
%define wxCENTRE
%define wxCENTRE_ON_SCREEN
%define wxCOLOURED
//%define wxED_BUTTONS_BOTTOM // for wxExtDialog? not used?
//%define wxED_BUTTONS_RIGHT
//%define wxED_CLIENT_MARGIN
//%define wxED_STATIC_LINE
%define wxFIXED_LENGTH
%define wxFORWARD
%define wxHELP
%define wxMORE
%define wxNO
%define wxNO_BORDER
%define wxNO_DEFAULT
%define wxOK
%define wxPASSWORD
%define wxPROCESS_ENTER
%define wxRESET
%define wxRESIZE_BOX
%define wxRETAINED
%define wxSETUP
%define wxSIZE_ALLOW_MINUS_ONE
%define wxSIZE_AUTO
%define wxSIZE_AUTO_HEIGHT
%define wxSIZE_AUTO_WIDTH
%define wxSIZE_NO_ADJUSTMENTS
%define wxSIZE_USE_EXISTING
//%define wxUSER_COLOURS deprecated use wxNO_3D
%define wxYES
%define wxYES_DEFAULT
%define wxYES_NO

%enum wxOrientation

    wxHORIZONTAL
    wxVERTICAL
    wxBOTH

%endenum

%enum wxDirection

    wxLEFT
    wxRIGHT
    wxUP
    wxDOWN
    wxTOP
    wxBOTTOM
    wxNORTH
    wxSOUTH
    wxWEST
    wxEAST
    wxALL

%endenum

%enum wxAlignment

    wxALIGN_NOT
    wxALIGN_CENTER_HORIZONTAL
    wxALIGN_CENTRE_HORIZONTAL
    wxALIGN_LEFT
    wxALIGN_TOP
    wxALIGN_RIGHT
    wxALIGN_BOTTOM
    wxALIGN_CENTER_VERTICAL
    wxALIGN_CENTRE_VERTICAL
    wxALIGN_CENTER
    wxALIGN_CENTRE
    wxALIGN_MASK

%endenum

%enum wxStretch

    wxSTRETCH_NOT
    wxSHRINK
    wxGROW
    wxEXPAND
    wxSHAPED
    wxTILE

    wxADJUST_MINSIZE // deprecated after 2.4 and takes the value of 0

    %wxchkver_2_8_8 wxFIXED_MINSIZE
    %wxchkver_2_8_8 wxRESERVE_SPACE_EVEN_IF_HIDDEN

%endenum

%enum wxBorder

    wxBORDER_DEFAULT
    wxBORDER_NONE
    wxBORDER_STATIC
    wxBORDER_SIMPLE
    wxBORDER_RAISED
    wxBORDER_SUNKEN
    wxBORDER_DOUBLE
    wxBORDER_MASK

%endenum

%enum wxBackgroundStyle

    wxBG_STYLE_SYSTEM
    wxBG_STYLE_COLOUR
    wxBG_STYLE_CUSTOM

%endenum

%if wxUSE_HOTKEY
%enum wxHotkeyModifier

    wxMOD_NONE
    wxMOD_ALT
    wxMOD_CONTROL
    %wxchkver_2_8 wxMOD_ALTGR
    wxMOD_SHIFT
    %wxchkver_2_8 wxMOD_META
    wxMOD_WIN
    %wxchkver_2_8 wxMOD_CMD
    %wxchkver_2_8 wxMOD_ALL

%endenum
%endif

// ---------------------------------------------------------------------------
// wxBusyCursor

%if wxLUA_USE_wxBusyCursor

%include "wx/utils.h"

%class %delete %noclassinfo %encapsulate wxBusyCursor

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxBusyCursor(wxCursor* cursor = wxHOURGLASS_CURSOR)

%endclass

// ---------------------------------------------------------------------------
// wxBusyCursorSuspender - we don't wrap this since Lua's garbage collector doesn't
// automatically collect items when they go out of scope so you would have to
// delete() this anyway which is just as easy as wxBegin/EndBusyCursor

//%class %delete %noclassinfo %encapsulate wxBusyCursorSuspender
// NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
// wxBusyCursorSuspender()

//%endclass

%endif //wxLUA_USE_wxBusyCursor

// ---------------------------------------------------------------------------
// wxBusyInfo

%if wxLUA_USE_wxBusyInfo && wxUSE_BUSYINFO

%include "wx/busyinfo.h"

%class %delete %noclassinfo wxBusyInfo, wxObject

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxBusyInfo(const wxString& message, wxWindow *parent = NULL)

%endclass

%endif //wxLUA_USE_wxBusyInfo && wxUSE_BUSYINFO

// ---------------------------------------------------------------------------
// wxTimer

%if wxLUA_USE_wxTimer && wxUSE_TIMER

%include "wx/timer.h"

%define wxTIMER_CONTINUOUS
%define wxTIMER_ONE_SHOT

%class %delete wxTimer, wxEvtHandler

    wxTimer(wxEvtHandler *owner, int id = -1)

    int GetInterval() const
    bool IsOneShot() const
    bool IsRunning() const
    void Notify()
    void SetOwner(wxEvtHandler *owner, int id = -1)
    bool Start(int milliseconds = -1, bool oneShot = false)
    void Stop()

%endclass

// ---------------------------------------------------------------------------
// wxTimerEvent

%include "wx/timer.h"

%class %delete wxTimerEvent, wxEvent

    %define_event wxEVT_TIMER // EVT_TIMER(id, fn)

    int GetInterval() const

%endclass

%endif //wxLUA_USE_wxTimer && wxUSE_TIMER

wxwidgets/wxcore_dialogs.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxDialog and all dialog classes and functions
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================


%define wxICON_ASTERISK
%define wxICON_ERROR
%define wxICON_EXCLAMATION
%define wxICON_HAND
%define wxICON_INFORMATION
%define wxICON_MASK
%define wxICON_QUESTION
%define wxICON_STOP
%define wxICON_WARNING

%if %wxcompat_2_6
%enum // for wxFileSelector and wxFileDialog

    wxOPEN
    wxSAVE
    wxOVERWRITE_PROMPT
    %wxcompat_2_4 wxHIDE_READONLY
    wxFILE_MUST_EXIST
    wxMULTIPLE
    wxCHANGE_DIR

%endenum
%endif //%wxcompat_2_6

%if %wxchkver_2_8
%enum

    wxFD_OPEN
    wxFD_SAVE
    wxFD_OVERWRITE_PROMPT
    wxFD_FILE_MUST_EXIST
    wxFD_MULTIPLE
    wxFD_CHANGE_DIR
    wxFD_PREVIEW

    wxFD_DEFAULT_STYLE

%endenum
%endif //%wxchkver_2_8

// ---------------------------------------------------------------------------
// Dialog functions from wxWidgets functions documentation

%function void wxBeginBusyCursor(wxCursor *cursor = wxHOURGLASS_CURSOR)
%function void wxEndBusyCursor()
%function void wxBell()
// %function wxTipProvider* wxCreateFileTipProvider(const wxString& filename, size_t currentTip)

%define_string wxDirSelectorPromptStr wxT("Select a directory")
%function wxString wxDirSelector(const wxString& message = wxDirSelectorPromptStr, const wxString& default_path = "", long style = wxDD_DEFAULT_STYLE, const wxPoint& pos = wxDefaultPosition, wxWindow *parent = NULL)
%function wxString wxFileSelector(const wxString& message, const wxString& default_path = "", const wxString& default_filename = "", const wxString& default_extension = "", const wxString& wildcard = "*.*", int flags = 0, wxWindow *parent = NULL, int x = -1, int y = -1)
wxUSE_COLOURDLG&&!%wxchkver_2_8 %function wxColour wxGetColourFromUser(wxWindow *parent, const wxColour& colInit)
wxUSE_COLOURDLG&&%wxchkver_2_8 %function wxColour wxGetColourFromUser(wxWindow *parent, const wxColour& colInit, const wxString& caption = "")
!%wxchkver_2_8&&wxUSE_FONTDLG %function wxFont wxGetFontFromUser(wxWindow *parent, const wxFont& fontInit)
%wxchkver_2_8&&wxUSE_FONTDLG %function wxFont wxGetFontFromUser(wxWindow *parent = NULL, const wxFont& fontInit = wxNullFont, const wxString& caption = "")
// %override [int, Lua int table] wxGetMultipleChoices(const wxString& message, const wxString& caption, Lua string table, wxWindow *parent = NULL, int x = -1, int y = -1, bool centre = true, int width=150, int height=200)
// int wxGetMultipleChoices(const wxString& message, const wxString& caption, int n, const wxString choices[], int nsel, int *selection, wxWindow *parent = NULL, int x = -1, int y = -1, bool centre = true, int width=150, int height=200)
wxUSE_CHOICEDLG %function int wxGetMultipleChoices(const wxString& message, const wxString& caption, LuaTable strTable, wxWindow *parent = NULL, int x = -1, int y = -1, bool centre = true, int width=150, int height=200)

%if wxUSE_NUMBERDLG
%wxchkver_2_6 %include "wx/numdlg.h" // FIXME not in 2.4
%function long wxGetNumberFromUser(const wxString& message, const wxString& prompt, const wxString& caption, long value, long min = 0, long max = 100, wxWindow *parent = NULL, const wxPoint& pos = wxDefaultPosition)
%endif // wxUSE_NUMBERDLG

wxUSE_TEXTDLG %function wxString wxGetPasswordFromUser(const wxString& message, const wxString& caption = "Input text", const wxString& default_value = "", wxWindow *parent = NULL)
wxUSE_TEXTDLG %function wxString wxGetTextFromUser(const wxString& message, const wxString& caption = "Input text", const wxString& default_value = "", wxWindow *parent = NULL, int x = -1, int y = -1, bool centre = true)
// int wxGetMultipleChoice(const wxString& message, const wxString& caption, int n, const wxString& choices[], int nsel, int *selection, wxWindow *parent = NULL, int x = -1, int y = -1, bool centre = true, int width=150, int height=200)
wxUSE_CHOICEDLG %function wxString wxGetSingleChoice(const wxString& message, const wxString& caption, const wxArrayString& choices, wxWindow *parent = NULL, int x = wxDefaultCoord, int y = wxDefaultCoord, bool centre = true, int width = wxCHOICE_WIDTH, int height = wxCHOICE_HEIGHT)
wxUSE_CHOICEDLG %function int wxGetSingleChoiceIndex(const wxString& message, const wxString& caption, const wxArrayString& choices, wxWindow *parent = NULL, int x = wxDefaultCoord, int y = wxDefaultCoord, bool centre = true, int width = wxCHOICE_WIDTH, int height = wxCHOICE_HEIGHT)
%function bool wxIsBusy()
%function int wxMessageBox(const wxString& message, const wxString& caption = "Message", int style = wxOK | wxCENTRE, wxWindow *parent = NULL, int x = -1, int y = -1)
// bool wxShowTip(wxWindow *parent, wxTipProvider *tipProvider, bool showAtStartup = true)

// ---------------------------------------------------------------------------
// wxDialog

%if wxLUA_USE_wxDialog

%include "wx/dialog.h"

%define wxDIALOG_MODAL
%define wxDIALOG_MODELESS
%define wxDEFAULT_DIALOG_STYLE
%define wxDIALOG_NO_PARENT
%define wxDIALOG_EX_CONTEXTHELP
// %define wxDIALOG_EX_METAL mac only
%define wxCHOICEDLG_STYLE

%class wxDialog, wxTopLevelWindow

    wxDialog()
    wxDialog(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxDialog")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxDialog")

    //void Centre(int direction = wxBOTH) - see wxWindow
    wxUSE_BUTTON wxSizer* CreateButtonSizer(long flags)
    %wxchkver_2_8&&wxUSE_BUTTON wxSizer *CreateSeparatedButtonSizer(long flags)
    wxUSE_BUTTON wxStdDialogButtonSizer* CreateStdDialogButtonSizer(long flags)
    wxUSE_STATTEXT wxSizer *CreateTextSizer( const wxString &message )
    // virtual bool DoOK() - pocketpc only
    void EndModal(int retCode)
    // int GetAffirmativeId() const - pocketpc only
    int GetReturnCode()
    // wxString GetTitle() const - see wxToplevelWindow
    //void Iconize(bool iconize) - in wxToplevelWindow
    //bool IsIconized() const - in wxToplevelWindow
    bool IsModal() const
    //void SetAffirmativeId(int affirmativeId)
    // void SetIcon(const wxIcon& icon) - in wxToplevelWindow
    // void SetModal(const bool flag) - deprecated
    void SetReturnCode(int retCode)
    // void SetTitle(const wxString& title) - in wxToplevelWindow
    // bool Show(const bool show) - see wxWindow
    int ShowModal()

%endclass

%endif // wxLUA_USE_wxDialog


// ---------------------------------------------------------------------------
// wxColourDialog

%if wxLUA_USE_wxColourDialog && wxUSE_COLOURDLG

%include "wx/colordlg.h"

%class wxColourDialog, wxDialog

    wxColourDialog(wxWindow* parent, wxColourData* data = NULL)
    //bool Create(wxWindow* parent, wxColourData* data = NULL)

    wxColourData& GetColourData()
    //int ShowModal() - in wxDialog

%endclass

// ---------------------------------------------------------------------------
// wxColourData

%include "wx/cmndata.h"

%class %delete wxColourData, wxObject

    wxColourData()
    wxColourData(const wxColourData& cData)

    bool GetChooseFull() const
    wxColour GetColour() const
    wxColour GetCustomColour(int i) const
    void SetChooseFull(bool flag)
    void SetColour(wxColour &colour)
    void SetCustomColour(int i, wxColour &colour)

%endclass

%endif // wxLUA_USE_wxColourDialog && wxUSE_COLOURDLG

// ---------------------------------------------------------------------------
// wxFileDialog

%if wxLUA_USE_wxFileDialog && wxUSE_FILEDLG

%include "wx/filedlg.h"

%define_string wxFileSelectorPromptStr wxT("Select a file")
%define_string wxFileSelectorDefaultWildcardStr

%class wxFileDialog, wxDialog

    // wxFileDialog() no default constructor in MSW
    %not_overload !%wxchkver_2_8 wxFileDialog(wxWindow* parent, const wxString& message = "Choose a file", const wxString& defaultDir = "", const wxString& defaultFile = "", const wxString& wildcard = "*.*", long style = 0, const wxPoint& pos = wxDefaultPosition)
    %not_overload %wxchkver_2_8 wxFileDialog(wxWindow *parent, const wxString& message = wxFileSelectorPromptStr, const wxString& defaultDir = "", const wxString& defaultFile = "", const wxString& wildCard = wxFileSelectorDefaultWildcardStr, long style = wxFD_DEFAULT_STYLE, const wxPoint& pos = wxDefaultPosition, const wxSize& sz = wxDefaultSize, const wxString& name = "wxFileDialog")
    //%wxchkver_2_8 bool Create(wxWindow *parent, const wxString& message = wxFileSelectorPromptStr, const wxString& defaultDir = "", const wxString& defaultFile = "", const wxString& wildCard = wxFileSelectorDefaultWildcardStr, long style = wxFD_DEFAULT_STYLE, const wxPoint& pos = wxDefaultPosition, const wxSize& sz = wxDefaultSize, const wxString& name = "wxFileDialog")

    wxString GetDirectory() const
    wxString GetFilename() const

    // %override [Lua string table] wxFileDialog::GetFilenames()
    // C++ Func: void GetFilenames(wxArrayString& filenames) const
    void GetFilenames() const

    int GetFilterIndex() const
    wxString GetMessage() const
    wxString GetPath() const

    // %override [Lua string table] wxFileDialog::GetPaths()
    // C++ Func: void GetPaths(wxArrayString& paths) const
    void GetPaths() const

    !%wxchkver_2_8 long GetStyle() const
    wxString GetWildcard() const
    void SetDirectory(const wxString& directory)
    void SetFilename(const wxString& setfilename)
    void SetFilterIndex(int filterIndex)
    void SetMessage(const wxString& message)
    void SetPath(const wxString& path)
    !%wxchkver_2_8 void SetStyle(long style)
    void SetWildcard(const wxString& wildCard)
    // int ShowModal() - in wxDialog

%endclass

%endif //wxLUA_USE_wxFileDialog && wxUSE_FILEDLG

// ---------------------------------------------------------------------------
// wxDirDialog

%if wxLUA_USE_wxDirDialog && wxUSE_DIRDLG

%include "wx/dirdlg.h"

%define wxDD_DEFAULT_STYLE
!%wxchkver_2_8 %define wxDD_NEW_DIR_BUTTON
%wxchkver_2_8 %define wxDD_CHANGE_DIR
%wxchkver_2_8 %define wxDD_DIR_MUST_EXIST

%class wxDirDialog, wxDialog

    wxDirDialog(wxWindow* parent, const wxString& message = "Choose a directory", const wxString& defaultPath = "", long style = 0, const wxPoint& pos = wxDefaultPosition)

    wxString GetPath() const
    wxString GetMessage() const
    !%wxchkver_2_8 long GetStyle() const
    void SetMessage(const wxString& message)
    void SetPath(const wxString& path)
    !%wxchkver_2_8 void SetStyle(long style)
    // int ShowModal() - in wxDialog

%endclass

%endif //wxLUA_USE_wxDirDialog && wxUSE_DIRDLG

// ---------------------------------------------------------------------------
// wxMessageDialog

%if wxLUA_USE_wxMessageDialog && wxUSE_MSGDLG

%class wxMessageDialog, wxDialog

    wxMessageDialog(wxWindow* parent, const wxString& message, const wxString& caption = "Message box", long style = wxOK | wxCANCEL | wxCENTRE, const wxPoint& pos = wxDefaultPosition)

    // int ShowModal() - in wxDialog

%endclass

%endif //wxLUA_USE_wxMessageDialog && wxUSE_MSGDLG

// ---------------------------------------------------------------------------
// wxMultiChoiceDialog - use wxGetMultipleChoices

%if wxUSE_CHOICEDLG && wxLUA_USE_wxMultiChoiceDialog

%class wxMultiChoiceDialog, wxDialog

    wxMultiChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition)

    wxArrayInt GetSelections() const // FIXME
    void SetSelections(const wxArrayInt& selections) const // FIXME
    //int ShowModal() - in wxDialog

%endclass

%endif //wxUSE_CHOICEDLG && wxLUA_USE_wxMultiChoiceDialog

// ---------------------------------------------------------------------------
// wxSingleChoiceDialog - use wxGetSingleChoice or wxGetSingleChoiceIndex

%if wxUSE_CHOICEDLG && wxLUA_USE_wxSingleChoiceDialog

%class wxSingleChoiceDialog, wxDialog

    // %override wxSingleChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition)
    // C++ Func: wxSingleChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, void** clientData = NULL, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition)
    wxSingleChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition)

    int GetSelection() const
    wxString GetStringSelection() const
    void SetSelection(int selection) const
    // int ShowModal() - in wxDialog

%endclass

%endif //wxUSE_CHOICEDLG && wxLUA_USE_wxSingleChoiceDialog

// ---------------------------------------------------------------------------
// wxTextEntryDialog - see also wxGetTextFromUser

%if wxUSE_TEXTDLG && wxLUA_USE_wxTextEntryDialog

%define wxTextEntryDialogStyle

%class wxTextEntryDialog, wxDialog

    wxTextEntryDialog(wxWindow* parent, const wxString& message, const wxString& caption = "Please enter text", const wxString& defaultValue = "", long style = wxOK | wxCANCEL | wxCENTRE, const wxPoint& pos = wxDefaultPosition)

    wxString GetValue() const
    void SetValue(const wxString& value)
    // int ShowModal() - in wxDialog

%endclass

// ---------------------------------------------------------------------------
// wxPasswordEntryDialog - see also wxGetPasswordFromUser

%define_string wxGetPasswordFromUserPromptStr

%class wxPasswordEntryDialog, wxTextEntryDialog

    wxPasswordEntryDialog(wxWindow *parent, const wxString& message, const wxString& caption = wxGetPasswordFromUserPromptStr, const wxString& value = "", long style = wxTextEntryDialogStyle, const wxPoint& pos = wxDefaultPosition)

%endclass

%endif //wxUSE_TEXTDLG && wxLUA_USE_wxTextEntryDialog

// ---------------------------------------------------------------------------
// wxFontDialog

%if wxUSE_FONTDLG && wxLUA_USE_wxFontDialog

%include "wx/fontdlg.h"

%class wxFontDialog, wxDialog

    wxFontDialog(wxWindow* parent, const wxFontData& data)

    wxFontData& GetFontData()
    // int ShowModal() - in wxDialog

%endclass

// ---------------------------------------------------------------------------
// wxFontData - for wxFontDialog

%include "wx/cmndata.h"

%class %delete wxFontData, wxObject

    wxFontData()
    wxFontData(const wxFontData& data)

    void EnableEffects(bool enable)
    bool GetAllowSymbols()
    wxColour GetColour()
    wxFont GetChosenFont()
    bool GetEnableEffects()
    wxFont GetInitialFont()
    bool GetShowHelp()
    void SetAllowSymbols(bool allowSymbols)
    void SetChosenFont(const wxFont &font)
    void SetColour(const wxColour &colour)
    void SetInitialFont(const wxFont &font)
    void SetRange(int minimum, int maximum)
    void SetShowHelp(bool showHelp)

%endclass

%endif //wxUSE_FONTDLG && wxLUA_USE_wxFontDialog

// ---------------------------------------------------------------------------
// wxFindReplaceDialog

%if wxUSE_FINDREPLDLG && wxLUA_USE_wxFindReplaceDialog

%include "wx/fdrepdlg.h"

%enum wxFindReplaceDialogStyles

    wxFR_REPLACEDIALOG
    wxFR_NOUPDOWN
    wxFR_NOMATCHCASE
    wxFR_NOWHOLEWORD

%endenum

%class wxFindReplaceDialog, wxDialog

    wxFindReplaceDialog()
    wxFindReplaceDialog(wxWindow *parent, wxFindReplaceData *findData, const wxString &title, int style = 0)
    bool Create(wxWindow *parent, wxFindReplaceData *findData, const wxString &title, int style = 0)

    const wxFindReplaceData *GetData()
    void SetData(wxFindReplaceData *findData)

%endclass

// ---------------------------------------------------------------------------
// wxFindReplaceData - Note this must exist while used in a wxFindReplaceDialog
// and you should delete() it only when the dialog is closed.

%enum wxFindReplaceFlags

    wxFR_DOWN
    wxFR_WHOLEWORD
    wxFR_MATCHCASE

%endenum

%class %delete %noclassinfo wxFindReplaceData, wxObject

    wxFindReplaceData(int flags = 0)

    wxString GetFindString()
    wxString GetReplaceString()
    int GetFlags()
    void SetFlags(int flags)
    void SetFindString(const wxString& string)
    void SetReplaceString(const wxString& string)

%endclass

// ---------------------------------------------------------------------------
// wxFindDialogEvent

%class %delete wxFindDialogEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_FIND // EVT_FIND(id, fn)
    %define_event wxEVT_COMMAND_FIND_NEXT // EVT_FIND_NEXT(id, fn)
    %define_event wxEVT_COMMAND_FIND_REPLACE // EVT_FIND_REPLACE(id, fn)
    %define_event wxEVT_COMMAND_FIND_REPLACE_ALL // EVT_FIND_REPLACE_ALL(id, fn)
    %define_event wxEVT_COMMAND_FIND_CLOSE // EVT_FIND_CLOSE(id, fn)

    wxFindDialogEvent(wxEventType commandType = wxEVT_NULL, int id = 0)

    int GetFlags()
    wxString GetFindString()
    wxString GetReplaceString()
    wxFindReplaceDialog *GetDialog()
    void SetFlags(int flags)
    void SetFindString(const wxString& str)
    void SetReplaceString(const wxString& str)

%endclass

%endif //wxUSE_FINDREPLDLG && wxLUA_USE_wxFindReplaceDialog

// ---------------------------------------------------------------------------
// wxProgressDialog

%if wxUSE_PROGRESSDLG && wxLUA_USE_wxProgressDialog

%include "wx/generic/progdlgg.h"

%define wxPD_APP_MODAL
%define wxPD_AUTO_HIDE
%define wxPD_SMOOTH
%define wxPD_CAN_ABORT
%define wxPD_CAN_SKIP
%define wxPD_ELAPSED_TIME
%define wxPD_ESTIMATED_TIME
%define wxPD_REMAINING_TIME

%class wxProgressDialog, wxDialog

    wxProgressDialog(const wxString& title, const wxString& message, int maximum = 100, wxWindow* parent = NULL, int style = wxPD_AUTO_HIDE | wxPD_APP_MODAL)

    void Resume()

    // %override [bool, bool skip] Update(int value, const wxString& newmsg = "")
    // C++ Func: bool Update(int value, const wxString& newmsg = "", bool* skip = NULL)
    bool Update(int value, const wxString& newmsg = "")

%endclass

%endif //wxUSE_PROGRESSDLG && wxLUA_USE_wxProgressDialog

// ---------------------------------------------------------------------------
// wxTabbedDialog deprecated; use wxNotebook instead
//
// %class wxTabbedDialog, wxDialog
// %include "wx/wxtab.h"
// wxTabbedDialog(wxWindow *parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style=wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxTabbedDialog")
// void SetTabView(wxTabView *view)
// wxTabView * GetTabView()
// %endclass


wxwidgets/wxcore_event.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxEvent and other generic event classes and types
// events specific to a single control are with that control
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================


// ---------------------------------------------------------------------------
// wxEvtHandler

%class %delete wxEvtHandler, wxObject

    wxEvtHandler()

    void AddPendingEvent(wxEvent& event)

    // NOTE: Connect used to be called ConnectEvent in wxLua which is not the name of any C++ function.

    // %override void wxEvtHandler::Connect(int id, int lastId, wxEventType eventType, Lua function)
    // %override void wxEvtHandler::Connect(int id, wxEventType eventType, Lua function)
    // %override void wxEvtHandler::Connect(wxEventType eventType, Lua function)
    // The function type above is determined at runtime depending on the inputs.
    // C++ Func: void Connect(int id, int lastId, wxEventType eventType, wxObjectEventFunction function, wxObject* userData = NULL, wxEvtHandler* eventSink = NULL)
    // Note: wxLua uses the userdata and the event sink and so they're not available
    void Connect(int id, int lastId, wxEventType eventType, LuaFunction func)

    // %override bool Disconnect(int winid, int lastId, wxEventType eventType)
    // %override bool Disconnect(int winid, wxEventType eventType)
    // %override bool Disconnect(wxEventType eventType)
    // The function type above is determined at runtime depending on the inputs.
    // C++ Func: bool Disconnect(int id, int lastId = wxID_ANY, wxEventType eventType = wxEVT_NULL, wxObjectEventFunction function = NULL, wxObject* userData = NULL, wxEvtHandler* eventSink = NULL)
    // Note: wxLua uses the userdata and the event sink and so they're not available
    bool Disconnect(int id, int lastId, wxEventType eventType)

    voidptr_long GetClientData() // C++ returns (void *) You get a number here
    wxClientData* GetClientObject() const
    bool GetEvtHandlerEnabled()
    wxEvtHandler* GetNextHandler()
    wxEvtHandler* GetPreviousHandler()
    virtual bool ProcessEvent(wxEvent& event)
    //virtual bool SearchEventTable(wxEventTable& table, wxEvent& event)
    void SetClientData(voidptr_long number) // C++ is (void *clientData) You can put a number here
    void SetClientObject(wxClientData* data)
    void SetEvtHandlerEnabled(bool enabled)
    void SetNextHandler(wxEvtHandler* handler)
    void SetPreviousHandler(wxEvtHandler* handler)

%endclass

// ---------------------------------------------------------------------------
// wxEvent

%include "wx/event.h"

%enum Propagation_state

    wxEVENT_PROPAGATE_NONE // don't propagate it at all
    wxEVENT_PROPAGATE_MAX // propagate it until it is processed

%endenum

%class %delete wxEvent, wxObject

    // wxEvent(int id = 0, wxEventType eventType = wxEVT_NULL) virtual base class

    wxObject* GetEventObject()
    wxEventType GetEventType()
    int GetId()
    bool GetSkipped()
    long GetTimestamp()
    bool IsCommandEvent() const
    void ResumePropagation(int propagationLevel)
    void SetEventObject(wxObject* object)
    void SetEventType(wxEventType type)
    void SetId(int id)
    void SetTimestamp(long timeStamp)
    bool ShouldPropagate() const
    void Skip(bool skip = true)
    int StopPropagation()

%endclass

// ---------------------------------------------------------------------------
// wxPropagationDisabler

%include "wx/event.h"

%class %delete %noclassinfo %encapsulate wxPropagationDisabler

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxPropagationDisabler(wxEvent& event)

%endclass

// ---------------------------------------------------------------------------
// wxPropagateOnce

%include "wx/event.h"

%class %delete %noclassinfo %encapsulate wxPropagateOnce

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxPropagateOnce(wxEvent& event)

%endclass

// ---------------------------------------------------------------------------
// wxCommandEvent

%include "wx/event.h"
%wxchkver_2_4 %include "wx/tglbtn.h" // for wxEVT_COMMAND_TOGGLEBUTTON_CLICKED

%class %delete wxCommandEvent, wxEvent


    %define_event wxEVT_NULL // dummy placeholder nobody sends this event

    %define_event wxEVT_COMMAND_ENTER // EVT_COMMAND_ENTER(winid, func)
    %define_event wxEVT_COMMAND_KILL_FOCUS // EVT_COMMAND_KILL_FOCUS(winid, func)
    %define_event wxEVT_COMMAND_LEFT_CLICK // EVT_COMMAND_LEFT_CLICK(winid, func)
    %define_event wxEVT_COMMAND_LEFT_DCLICK // EVT_COMMAND_LEFT_DCLICK(winid, func)
    %define_event wxEVT_COMMAND_RIGHT_CLICK // EVT_COMMAND_RIGHT_CLICK(winid, func)
    %define_event wxEVT_COMMAND_RIGHT_DCLICK // EVT_COMMAND_RIGHT_DCLICK(winid, func)
    //%define_event wxEVT_COMMAND_SCROLLBAR_UPDATED // EVT_SCROLLBAR(winid, func) obsolete use wxEVT_SCROLL...
    %define_event wxEVT_COMMAND_SET_FOCUS // EVT_COMMAND_SET_FOCUS(winid, func)
    //%define_event wxEVT_COMMAND_VLBOX_SELECTED // EVT_VLBOX(winid, func) unused?

    %define_event wxEVT_COMMAND_MENU_SELECTED // EVT_MENU(winid, func) EVT_MENU_RANGE(id1, id2, func)

    %define_event wxEVT_COMMAND_TOOL_CLICKED // EVT_TOOL(winid, func) EVT_TOOL_RANGE(id1, id2, func)
    %define_event wxEVT_COMMAND_TOOL_ENTER // EVT_TOOL_ENTER(winid, func)
    %define_event wxEVT_COMMAND_TOOL_RCLICKED // EVT_TOOL_RCLICKED(winid, func) EVT_TOOL_RCLICKED_RANGE(id1, id2, func)

    %define_event wxEVT_COMMAND_TEXT_ENTER // EVT_TEXT_ENTER(id, fn)
    %define_event wxEVT_COMMAND_TEXT_UPDATED // EVT_TEXT(id, fn)
    %define_event wxEVT_COMMAND_TEXT_MAXLEN // EVT_TEXT_MAXLEN(id, fn)
    !%wxchkver_2_8_0 %define_event wxEVT_COMMAND_TEXT_URL // EVT_TEXT_URL(id, fn)

    %define_event wxEVT_COMMAND_SPINCTRL_UPDATED // EVT_SPINCTRL(id, fn)
    %define_event wxEVT_COMMAND_SLIDER_UPDATED // EVT_SLIDER(winid, func)
    %define_event wxEVT_COMMAND_RADIOBUTTON_SELECTED // EVT_RADIOBUTTON(winid, func)
    %define_event wxEVT_COMMAND_RADIOBOX_SELECTED // EVT_RADIOBOX(winid, func)
    %define_event wxEVT_COMMAND_CHECKLISTBOX_TOGGLED // EVT_CHECKLISTBOX(winid, func)
    %define_event wxEVT_COMMAND_LISTBOX_DOUBLECLICKED // EVT_LISTBOX_DCLICK(winid, func)
    %define_event wxEVT_COMMAND_LISTBOX_SELECTED // EVT_LISTBOX(winid, func)
    %define_event wxEVT_COMMAND_COMBOBOX_SELECTED // EVT_COMBOBOX(winid, func)
    %define_event wxEVT_COMMAND_CHOICE_SELECTED // EVT_CHOICE(winid, func)
    %define_event wxEVT_COMMAND_CHECKBOX_CLICKED // EVT_CHECKBOX(winid, func)
    %define_event wxEVT_COMMAND_BUTTON_CLICKED // EVT_BUTTON(winid, func)
    %wxchkver_2_4 %define_event wxEVT_COMMAND_TOGGLEBUTTON_CLICKED // EVT_TOGGLEBUTTON(id, fn)

    wxCommandEvent(wxEventType commandEventType = wxEVT_NULL, int id = 0)

    voidptr_long GetClientData() // C++ returns (void *) You get a number here
    wxClientData* GetClientObject()
    %rename GetStringClientObject wxStringClientData* GetClientObject()
    long GetExtraLong()
    int GetInt()
    int GetSelection()
    wxString GetString()
    bool IsChecked() const
    bool IsSelection()
    void SetClientData(voidptr_long number) // C++ is (void *clientData) You can put a number here
    void SetExtraLong(int extraLong)
    void SetInt(int intCommand)
    void SetString(const wxString &string)

%endclass

// ---------------------------------------------------------------------------
// wxNotifyEvent

%include "wx/event.h"

%class %delete wxNotifyEvent, wxCommandEvent

    wxNotifyEvent(wxEventType eventType = wxEVT_NULL, int id = 0)

    void Allow()
    bool IsAllowed() const
    void Veto()

%endclass

// ---------------------------------------------------------------------------
// wxActivateEvent

%include "wx/event.h"

%class %delete wxActivateEvent, wxEvent

    %define_event wxEVT_ACTIVATE // EVT_ACTIVATE(func)
    %define_event wxEVT_ACTIVATE_APP // EVT_ACTIVATE_APP(func)
    %define_event wxEVT_HIBERNATE // EVT_HIBERNATE(func)

    wxActivateEvent(wxEventType eventType = wxEVT_NULL, bool active = true, int id = 0)

    bool GetActive() const

%endclass

// ---------------------------------------------------------------------------
// wxCloseEvent

%include "wx/event.h"

%class %delete wxCloseEvent, wxEvent

    %define_event wxEVT_CLOSE_WINDOW // EVT_CLOSE(func)
    %define_event wxEVT_QUERY_END_SESSION // EVT_QUERY_END_SESSION(func)
    %define_event wxEVT_END_SESSION // EVT_END_SESSION(func)

    wxCloseEvent(wxEventType commandEventType = wxEVT_NULL, int id = 0)

    bool CanVeto()
    bool GetLoggingOff() const
    void SetCanVeto(bool canVeto)
    void SetLoggingOff(bool loggingOff) const
    void Veto(bool veto = true)

%endclass

// ---------------------------------------------------------------------------
// wxDialUpEvent - TODO - the rest of wxDialUp is missing, anyone care?

//%if !%mac
//%include "wx/dialup.h"

//%class %delete %noclassinfo wxDialUpEvent, wxCommandEvent
// %define_event wxEVT_DIALUP_CONNECTED // EVT_DIALUP_CONNECTED(func)
// %define_event wxEVT_DIALUP_DISCONNECTED // EVT_DIALUP_DISCONNECTED(func)

// wxDialUpEvent(bool isConnected, bool isOwnEvent)
// bool IsConnectedEvent() const
// bool IsOwnEvent() const
//%endclass
//%endif

// ---------------------------------------------------------------------------
// wxEraseEvent

%include "wx/event.h"

%class %delete wxEraseEvent, wxEvent

    %define_event wxEVT_ERASE_BACKGROUND // EVT_ERASE_BACKGROUND(func)

    wxEraseEvent(int id = 0, wxDC* dc = NULL)

    wxDC* GetDC() const

%endclass

// ---------------------------------------------------------------------------
// wxFocusEvent

%include "wx/event.h"

%class %delete wxFocusEvent, wxEvent

    %define_event wxEVT_SET_FOCUS // EVT_SET_FOCUS(func)
    %define_event wxEVT_KILL_FOCUS // EVT_KILL_FOCUS(func)

    wxFocusEvent(wxEventType eventType = wxEVT_NULL, int id = 0)

    wxWindow* GetWindow()
    void SetWindow(wxWindow *win)

%endclass

// ---------------------------------------------------------------------------
// wxChildFocusEvent

%include "wx/event.h"

%class %delete wxChildFocusEvent, wxCommandEvent

    %define_event wxEVT_CHILD_FOCUS // EVT_CHILD_FOCUS(func)

    wxChildFocusEvent(wxWindow *win = NULL)

    wxWindow *GetWindow() const

%endclass

// ---------------------------------------------------------------------------
// wxQueryNewPaletteEvent

%include "wx/event.h"

%class %delete wxQueryNewPaletteEvent, wxEvent

    %define_event wxEVT_QUERY_NEW_PALETTE // EVT_QUERY_NEW_PALETTE(func)

    wxQueryNewPaletteEvent(wxWindowID winid = 0)

    void SetPaletteRealized(bool realized)
    bool GetPaletteRealized() const

%endclass

// ---------------------------------------------------------------------------
// wxPaletteChangedEvent

%include "wx/event.h"

%class %delete wxPaletteChangedEvent, wxEvent

    %define_event wxEVT_PALETTE_CHANGED // EVT_PALETTE_CHANGED(func)

    wxPaletteChangedEvent(wxWindowID winid = 0)

    void SetChangedWindow(wxWindow* win)
    wxWindow* GetChangedWindow() const

%endclass

// ---------------------------------------------------------------------------
// wxKeyEvent

%enum wxKeyCode

    WXK_ADD
    WXK_ALT
    WXK_BACK
    WXK_CANCEL
    WXK_CAPITAL
    WXK_CLEAR
    WXK_CONTROL
    WXK_DECIMAL
    WXK_DELETE
    WXK_DIVIDE
    WXK_DOWN
    WXK_END
    WXK_ESCAPE
    WXK_EXECUTE
    WXK_F1
    WXK_F10
    WXK_F11
    WXK_F12
    WXK_F13
    WXK_F14
    WXK_F15
    WXK_F16
    WXK_F17
    WXK_F18
    WXK_F19
    WXK_F2
    WXK_F20
    WXK_F21
    WXK_F22
    WXK_F23
    WXK_F24
    WXK_F3
    WXK_F4
    WXK_F5
    WXK_F6
    WXK_F7
    WXK_F8
    WXK_F9
    WXK_HELP
    WXK_HOME
    WXK_INSERT
    WXK_LBUTTON
    WXK_LEFT
    WXK_MBUTTON
    WXK_MENU
    WXK_MULTIPLY
    WXK_NEXT
    WXK_NUMLOCK
    WXK_NUMPAD_ADD
    WXK_NUMPAD_BEGIN
    WXK_NUMPAD_DECIMAL
    WXK_NUMPAD_DELETE
    WXK_NUMPAD_DIVIDE
    WXK_NUMPAD_DOWN
    WXK_NUMPAD_END
    WXK_NUMPAD_ENTER
    WXK_NUMPAD_EQUAL
    WXK_NUMPAD_F1
    WXK_NUMPAD_F2
    WXK_NUMPAD_F3
    WXK_NUMPAD_F4
    WXK_NUMPAD_HOME
    WXK_NUMPAD_INSERT
    WXK_NUMPAD_LEFT
    WXK_NUMPAD_MULTIPLY
    WXK_NUMPAD_NEXT
    WXK_NUMPAD_PAGEDOWN
    WXK_NUMPAD_PAGEUP
    WXK_NUMPAD_PRIOR
    WXK_NUMPAD_RIGHT
    WXK_NUMPAD_SEPARATOR
    WXK_NUMPAD_SPACE
    WXK_NUMPAD_SUBTRACT
    WXK_NUMPAD_TAB
    WXK_NUMPAD_UP
    WXK_NUMPAD0
    WXK_NUMPAD1
    WXK_NUMPAD2
    WXK_NUMPAD3
    WXK_NUMPAD4
    WXK_NUMPAD5
    WXK_NUMPAD6
    WXK_NUMPAD7
    WXK_NUMPAD8
    WXK_NUMPAD9
    WXK_PAGEDOWN
    WXK_PAGEUP
    WXK_PAUSE
    WXK_PRINT
    WXK_PRIOR
    WXK_RBUTTON
    WXK_RETURN
    WXK_RIGHT
    WXK_SCROLL
    WXK_SELECT
    WXK_SEPARATOR
    WXK_SHIFT
    WXK_SNAPSHOT
    WXK_SPACE
    WXK_START
    WXK_SUBTRACT
    WXK_TAB
    WXK_UP

%endenum

%include "wx/event.h"

%class %delete wxKeyEvent, wxEvent

    %define_event wxEVT_KEY_DOWN // EVT_KEY_DOWN(func)
    %define_event wxEVT_KEY_UP // EVT_KEY_UP(func)
    %define_event wxEVT_CHAR // EVT_CHAR(func)
    %define_event wxEVT_CHAR_HOOK // EVT_CHAR_HOOK(func)
    wxUSE_HOTKEY %define_event wxEVT_HOTKEY // EVT_HOTKEY(winid, func)

    wxKeyEvent(wxEventType keyEventType)

    bool AltDown() const
    bool CmdDown() const
    bool ControlDown() const
    int GetKeyCode() const
    %wxchkver_2_8 int GetModifiers() const
    wxPoint GetPosition() const

    // %override [long x, long y] wxKeyEvent::GetPositionXY()
    // C++ Func: void GetPosition(long *x, long *y) const
    %rename GetPositionXY void GetPosition() const

    //wxUint32 GetRawKeyCode() const
    //wxUint32 GetRawKeyFlags() const
    //wxChar GetUnicodeKey() const
    long GetX()
    long GetY() const
    bool HasModifiers() const
    bool MetaDown() const
    bool ShiftDown() const

%endclass

// ---------------------------------------------------------------------------
// wxNavigationKeyEvent

%include "wx/event.h"

%enum wxNavigationKeyEvent::dummy

    IsBackward
    IsForward
    WinChange
    FromTab

%endenum

%class %delete wxNavigationKeyEvent, wxEvent

    %define_event wxEVT_NAVIGATION_KEY // EVT_NAVIGATION_KEY(func)

    wxNavigationKeyEvent()

    bool GetDirection() const
    void SetDirection(bool bForward)
    bool IsWindowChange() const
    void SetWindowChange(bool bIs)
    bool IsFromTab() const
    void SetFromTab(bool bIs)
    wxWindow* GetCurrentFocus() const
    void SetCurrentFocus(wxWindow *win)
    void SetFlags(long flags)

%endclass

// ---------------------------------------------------------------------------
// wxIdleEvent

%include "wx/event.h"

%enum wxIdleMode

    wxIDLE_PROCESS_ALL
    wxIDLE_PROCESS_SPECIFIED

%endenum

%class %delete wxIdleEvent, wxEvent

    %define_event wxEVT_IDLE // EVT_IDLE(func)

    wxIdleEvent()

    static bool CanSend(wxWindow* window)
    static wxIdleMode GetMode()
    void RequestMore(bool needMore = true)
    bool MoreRequested() const
    static void SetMode(wxIdleMode mode)

%endclass

// ---------------------------------------------------------------------------
// wxInitDialogEvent - for dialogs and panels

%include "wx/event.h"

%class %delete wxInitDialogEvent, wxEvent

    %define_event wxEVT_INIT_DIALOG // EVT_INIT_DIALOG(func)

    wxInitDialogEvent(int id = 0)

%endclass

// ---------------------------------------------------------------------------
// wxContextMenuEvent

%class %delete wxContextMenuEvent, wxCommandEvent

    %define_event wxEVT_CONTEXT_MENU // EVT_CONTEXT_MENU(func) EVT_COMMAND_CONTEXT_MENU(winid, func)

    wxContextMenuEvent(wxEventType type = wxEVT_NULL, wxWindowID winid = 0, const wxPoint& pt = wxDefaultPosition)
    //wxContextMenuEvent(const wxContextMenuEvent& event)

    wxPoint GetPosition() const
    void SetPosition(const wxPoint& pos)

%endclass

// ---------------------------------------------------------------------------
// wxMouseEvent

%include "wx/event.h"

%enum

    wxMOUSE_BTN_ANY
    wxMOUSE_BTN_NONE
    wxMOUSE_BTN_LEFT
    wxMOUSE_BTN_MIDDLE
    wxMOUSE_BTN_RIGHT

%endenum

%class %delete wxMouseEvent, wxEvent

    %define_event wxEVT_ENTER_WINDOW // EVT_ENTER_WINDOW(func)
    %define_event wxEVT_LEAVE_WINDOW // EVT_LEAVE_WINDOW(func)
    %define_event wxEVT_LEFT_DCLICK // EVT_LEFT_DCLICK(func)
    %define_event wxEVT_LEFT_DOWN // EVT_LEFT_DOWN(func)
    %define_event wxEVT_LEFT_UP // EVT_LEFT_UP(func)
    %define_event wxEVT_MIDDLE_DCLICK // EVT_MIDDLE_DCLICK(func)
    %define_event wxEVT_MIDDLE_DOWN // EVT_MIDDLE_DOWN(func)
    %define_event wxEVT_MIDDLE_UP // EVT_MIDDLE_UP(func)
    %define_event wxEVT_MOTION // EVT_MOTION(func)
    %define_event wxEVT_MOUSEWHEEL // EVT_MOUSEWHEEL(func)
    %define_event wxEVT_RIGHT_DCLICK // EVT_RIGHT_DCLICK(func)
    %define_event wxEVT_RIGHT_DOWN // EVT_RIGHT_DOWN(func)
    %define_event wxEVT_RIGHT_UP // EVT_RIGHT_UP(func)

    //%define_event wxEVT_NC_ENTER_WINDOW // FIXME - these are not used in wxWidgets
    //%define_event wxEVT_NC_LEAVE_WINDOW
    //%define_event wxEVT_NC_LEFT_DCLICK
    //%define_event wxEVT_NC_LEFT_DOWN
    //%define_event wxEVT_NC_LEFT_UP
    //%define_event wxEVT_NC_MIDDLE_DCLICK
    //%define_event wxEVT_NC_MIDDLE_DOWN
    //%define_event wxEVT_NC_MIDDLE_UP
    //%define_event wxEVT_NC_MOTION
    //%define_event wxEVT_NC_RIGHT_DCLICK
    //%define_event wxEVT_NC_RIGHT_DOWN
    //%define_event wxEVT_NC_RIGHT_UP

    wxMouseEvent(wxEventType mouseEventType = wxEVT_NULL)

    bool AltDown()
    bool Button(int button)
    bool ButtonDClick(int but = wxMOUSE_BTN_ANY)
    bool ButtonDown(int but = wxMOUSE_BTN_ANY)
    bool ButtonUp(int but = wxMOUSE_BTN_ANY)
    bool CmdDown() const
    bool ControlDown()
    bool Dragging()
    bool Entering()
    wxPoint GetPosition() const

    // %override [long x, long y] wxMouseEvent::GetPositionXY()
    // C++ Func: void GetPosition(wxCoord* x, wxCoord* y) const
    %rename GetPositionXY void GetPosition() const

    wxPoint GetLogicalPosition(const wxDC& dc) const
    int GetLinesPerAction() const
    int GetWheelRotation() const
    int GetWheelDelta() const
    long GetX() const
    long GetY()
    bool IsButton() const
    bool Leaving() const
    bool LeftDClick() const
    bool LeftDown() const
    bool LeftIsDown() const
    bool LeftUp() const
    bool MetaDown() const
    bool MiddleDClick() const
    bool MiddleDown() const
    bool MiddleIsDown() const
    bool MiddleUp() const
    bool Moving() const
    bool RightDClick() const
    bool RightDown() const
    bool RightIsDown() const
    bool RightUp() const
    bool ShiftDown() const

%endclass

// ---------------------------------------------------------------------------
// wxMouseCaptureChangedEvent

%include "wx/event.h"

%class %delete wxMouseCaptureChangedEvent, wxEvent

    %define_event wxEVT_MOUSE_CAPTURE_CHANGED // EVT_MOUSE_CAPTURE_CHANGED(func)

    wxMouseCaptureChangedEvent(wxWindowID winid = 0, wxWindow* gainedCapture = NULL)

    wxWindow* GetCapturedWindow() const

%endclass

// ---------------------------------------------------------------------------
// wxMouseCaptureLostEvent

%if %wxchkver_2_8

%include "wx/event.h"

%class %delete wxMouseCaptureLostEvent, wxEvent

    %define_event wxEVT_MOUSE_CAPTURE_LOST // EVT_MOUSE_CAPTURE_LOST(func)

    wxMouseCaptureLostEvent(wxWindowID winid = 0)

%endclass

%endif //%wxchkver_2_8

// ---------------------------------------------------------------------------
// wxMoveEvent

%include "wx/event.h"

%class %delete wxMoveEvent, wxEvent

    %define_event wxEVT_MOVE // EVT_MOVE(func)
    %wxchkver_2_6 %define_event wxEVT_MOVING // EVT_MOVING(func)

    wxMoveEvent(const wxPoint& pt, int id = 0)

    wxPoint GetPosition() const

%endclass

// ---------------------------------------------------------------------------
// wxPaintEvent -
//
// Note: You must ALWAYS create a wxPaintDC for the window and delete() when
// done to have the exposed area marked as painted, otherwise you'll continue
// to get endless paint events.
// Tip: local dc = wx.wxPaintDC(event:GetEventObject():DynamicCast("wxWindow"))
// do stuff with dc...
// dc:delete() -- Absolutely necessary since the garbage collector may
// -- not immediatelly run.

%include "wx/event.h"

%class %delete wxPaintEvent, wxEvent

    %define_event wxEVT_PAINT // EVT_PAINT(func)

    wxPaintEvent(int id = 0)

%endclass

// ---------------------------------------------------------------------------
// wxNcPaintEvent - this is not sent from anything in wxWidgets

//%include "wx/event.h"

//%class %delete class wxNcPaintEvent, wxEvent
// %define_event wxEVT_NC_PAINT // EVT_NC_PAINT(func)
// wxNcPaintEvent(int winid = 0)
//%endclass

// ---------------------------------------------------------------------------
// wxProcessEvent

%include "wx/process.h"

%class %delete wxProcessEvent, wxEvent

    %define_event wxEVT_END_PROCESS // EVT_END_PROCESS(id, func)

    !%wxchkver_2_6 wxProcessEvent(int id = 0, int pid = 0)
    %wxchkver_2_6 wxProcessEvent(int nId = 0, int pid = 0, int exitcode = 0)
    int GetPid() const
    %wxchkver_2_6 int GetExitCode()

%endclass

// ---------------------------------------------------------------------------
// wxScrollEvent - for independent scrollbars and sliders

%include "wx/event.h"

%class %delete wxScrollEvent, wxCommandEvent

    %define_event wxEVT_SCROLL_TOP // EVT_SCROLL_TOP(func)
    %define_event wxEVT_SCROLL_BOTTOM // EVT_SCROLL_BOTTOM(func)
    %define_event wxEVT_SCROLL_LINEUP // EVT_SCROLL_LINEUP(func)
    %define_event wxEVT_SCROLL_LINEDOWN // EVT_SCROLL_LINEDOWN(func)
    %define_event wxEVT_SCROLL_PAGEUP // EVT_SCROLL_PAGEUP(func)
    %define_event wxEVT_SCROLL_PAGEDOWN // EVT_SCROLL_PAGEDOWN(func)
    %define_event wxEVT_SCROLL_THUMBTRACK // EVT_SCROLL_THUMBTRACK(func)
    %define_event wxEVT_SCROLL_THUMBRELEASE // EVT_SCROLL_THUMBRELEASE(func)
    %wxcompat_2_6 %define_event wxEVT_SCROLL_ENDSCROLL // EVT_SCROLL_ENDSCROLL(func) FIXME called wxEVT_SCROLL_CHANGED in 2.8
    %wxchkver_2_8 %define_event wxEVT_SCROLL_CHANGED // EVT_SCROLL_CHANGED(func)

    wxScrollEvent(wxEventType commandType = wxEVT_NULL, int id = 0, int pos = 0, int orientation = 0)

    int GetOrientation() const
    int GetPosition() const

%endclass

// ---------------------------------------------------------------------------
// wxScrollWinEvent - for wxScrolledWindows only

%include "wx/event.h"

%class %delete wxScrollWinEvent, wxEvent

    %define_event wxEVT_SCROLLWIN_BOTTOM // EVT_SCROLLWIN_BOTTOM(func)
    %define_event wxEVT_SCROLLWIN_LINEDOWN // EVT_SCROLLWIN_LINEDOWN(func)
    %define_event wxEVT_SCROLLWIN_LINEUP // EVT_SCROLLWIN_LINEUP(func)
    %define_event wxEVT_SCROLLWIN_PAGEDOWN // EVT_SCROLLWIN_PAGEDOWN(func)
    %define_event wxEVT_SCROLLWIN_PAGEUP // EVT_SCROLLWIN_PAGEUP(func)
    %define_event wxEVT_SCROLLWIN_THUMBRELEASE // EVT_SCROLLWIN_THUMBRELEASE(func)
    %define_event wxEVT_SCROLLWIN_THUMBTRACK // EVT_SCROLLWIN_THUMBTRACK(func)
    %define_event wxEVT_SCROLLWIN_TOP // EVT_SCROLLWIN_TOP(func)

    wxScrollWinEvent(wxEventType commandType = wxEVT_NULL, int pos = 0, int orientation = 0)

    int GetOrientation() const
    int GetPosition() const

%endclass

// ---------------------------------------------------------------------------
// wxSizeEvent

%include "wx/event.h"

%class %delete wxSizeEvent, wxEvent

    %define_event wxEVT_SIZE // EVT_SIZE(func)
    %wxchkver_2_6 %define_event wxEVT_SIZING // EVT_SIZING(func)

    wxSizeEvent(const wxSize& sz, int id = 0)

    wxSize GetSize() const

%endclass

// ---------------------------------------------------------------------------
// wxShowEvent

%include "wx/event.h"

%class %delete wxShowEvent, wxEvent

    %define_event wxEVT_SHOW // EVT_SHOW(func)

    wxShowEvent(int winid = 0, bool show = false)

    void SetShow(bool show)
    bool GetShow() const

%endclass

// ---------------------------------------------------------------------------
// wxIconizeEvent

%include "wx/event.h"

%class %delete wxIconizeEvent, wxEvent

    %define_event wxEVT_ICONIZE // EVT_ICONIZE(func)

    wxIconizeEvent(int winid = 0, bool iconized = true)

    bool Iconized() const

%endclass

// ---------------------------------------------------------------------------
// wxMaximizeEvent

%include "wx/event.h"

%class %delete wxMaximizeEvent, wxEvent

    %define_event wxEVT_MAXIMIZE // EVT_MAXIMIZE(func)

    wxMaximizeEvent(int winid = 0)

%endclass

// ---------------------------------------------------------------------------
// wxWindowCreateEvent

%include "wx/event.h"

%class %delete wxWindowCreateEvent, wxEvent

    %define_event wxEVT_CREATE // EVT_WINDOW_CREATE(func)

    wxWindowCreateEvent(wxWindow *win = NULL)

    wxWindow *GetWindow() const

%endclass

// ---------------------------------------------------------------------------
// wxWindowDestroyEvent

%include "wx/event.h"

%class %delete wxWindowDestroyEvent, wxEvent

    %define_event wxEVT_DESTROY // EVT_WINDOW_DESTROY(func)

    wxWindowDestroyEvent(wxWindow *win = NULL)

    wxWindow *GetWindow() const

%endclass

// ---------------------------------------------------------------------------
// wxSysColourChangedEvent

%include "wx/event.h"

%class %delete wxSysColourChangedEvent, wxEvent

    %define_event wxEVT_SYS_COLOUR_CHANGED // EVT_SYS_COLOUR_CHANGED(func)

    wxSysColourChangedEvent()

%endclass

// ---------------------------------------------------------------------------
// wxDisplayChangedEvent

%include "wx/event.h"

%class %delete wxDisplayChangedEvent, wxEvent

    %define_event wxEVT_DISPLAY_CHANGED // EVT_DISPLAY_CHANGED(func)

    wxDisplayChangedEvent()

%endclass


// ---------------------------------------------------------------------------
// wxPowerEvent

%if %wxchkver_2_8

%include "wx/power.h"

%enum wxPowerType

    wxPOWER_SOCKET
    wxPOWER_BATTERY
    wxPOWER_UNKNOWN

%endenum

%enum wxBatteryState

    wxBATTERY_NORMAL_STATE // system is fully usable
    wxBATTERY_LOW_STATE // start to worry
    wxBATTERY_CRITICAL_STATE // save quickly
    wxBATTERY_SHUTDOWN_STATE // too late
    wxBATTERY_UNKNOWN_STATE

%endenum

%function wxPowerType wxGetPowerType()
%function wxBatteryState wxGetBatteryState()

%if wxHAS_POWER_EVENTS

%class %delete wxPowerEvent, wxEvent

    %define_event wxEVT_POWER_SUSPENDING // EVT_POWER_SUSPENDING(func)
    %define_event wxEVT_POWER_SUSPENDED // EVT_POWER_SUSPENDED(func)
    %define_event wxEVT_POWER_SUSPEND_CANCEL // EVT_POWER_SUSPEND_CANCEL(func)
    %define_event wxEVT_POWER_RESUME // EVT_POWER_RESUME(func)

    wxPowerEvent(wxEventType evtType)

    void Veto()
    bool IsVetoed() const

%endclass

%endif // wxHAS_POWER_EVENTS

%endif // %wxchkver_2_8


// ---------------------------------------------------------------------------
// wxSetCursorEvent

%include "wx/event.h"

%class %delete wxSetCursorEvent, wxEvent

    %define_event wxEVT_SET_CURSOR // EVT_SET_CURSOR(func)

    wxSetCursorEvent(wxCoord x = 0, wxCoord y = 0)

    wxCoord GetX() const
    wxCoord GetY() const
    void SetCursor(const wxCursor& cursor)
    wxCursor GetCursor() const
    bool HasCursor() const

%endclass

// ---------------------------------------------------------------------------
// wxUpdateUIEvent

%include "wx/event.h"

%enum wxUpdateUIMode

    wxUPDATE_UI_PROCESS_ALL
    wxUPDATE_UI_PROCESS_SPECIFIED

%endenum

%class %delete wxUpdateUIEvent, wxCommandEvent

    %define_event wxEVT_UPDATE_UI // EVT_UPDATE_UI(winid, func) EVT_UPDATE_UI_RANGE(id1, id2, func)

    wxUpdateUIEvent(wxWindowID commandId = wxID_ANY)

    static bool CanUpdate(wxWindow* window)
    void Check(bool check)
    void Enable(bool enable)
    bool GetChecked() const
    bool GetEnabled() const
    %wxchkver_2_8 bool GetShown() const
    bool GetSetChecked() const
    bool GetSetEnabled() const
    %wxchkver_2_8 bool GetSetShown() const
    bool GetSetText() const
    wxString GetText() const
    static wxUpdateUIMode GetMode()
    static long GetUpdateInterval()
    static void ResetUpdateTime()
    static void SetMode(wxUpdateUIMode mode)
    void SetText(const wxString& text)
    static void SetUpdateInterval(long updateInterval)
    %wxchkver_2_8 void Show(bool show)

%endclass

// ---------------------------------------------------------------------------
// wxHelpEvent

%include "wx/event.h"

%if %wxchkver_2_8
%enum wxHelpEvent::Origin

    Origin_Unknown // unrecognized event source
    Origin_Keyboard // event generated from F1 key press
    Origin_HelpButton // event from [?] button on the title bar (Windows)

%endenum
%endif //%wxchkver_2_8

%class %delete wxHelpEvent, wxCommandEvent

    %define_event wxEVT_HELP // EVT_HELP(winid, func) EVT_HELP_RANGE(id1, id2, func)
    %define_event wxEVT_DETAILED_HELP // EVT_DETAILED_HELP(winid, func) EVT_DETAILED_HELP_RANGE(id1, id2, func)

    !%wxchkver_2_8 wxHelpEvent(wxEventType type = wxEVT_NULL, wxWindowID id = 0, const wxPoint& pt = wxDefaultPosition)
    %wxchkver_2_8 wxHelpEvent(wxEventType type = wxEVT_NULL, wxWindowID id = 0, const wxPoint& pt = wxDefaultPosition, wxHelpEvent::Origin origin = wxHelpEvent::Origin_Unknown)

    wxString GetLink()
    %wxchkver_2_8 wxHelpEvent::Origin GetOrigin() const
    wxPoint GetPosition()
    wxString GetTarget()
    void SetLink(const wxString& link)
    %wxchkver_2_8 void SetOrigin(wxHelpEvent::Origin origin)
    void SetPosition(const wxPoint& pos)
    void SetTarget(const wxString& target)

%endclass

wxwidgets/wxcore_gdi.i - Lua table = 'wx'
// ===========================================================================
// Purpose: GDI classes, Colour, Pen, Brush, Font, DC, Bitmap...
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxPoint

%if wxLUA_USE_wxPointSizeRect

%include "wx/gdicmn.h"

%define wxDefaultCoord

%class %delete %noclassinfo %encapsulate wxPoint

    %define_object wxDefaultPosition

    wxPoint(int x = 0, int y = 0)
    wxPoint(const wxPoint& pt)

    // %override [int x, int y] wxPoint::GetXY()
    // wxLua added function
    int GetXY() const

    // %override void wxPoint::Set(int x, int y)
    // wxLua added function
    void Set(int x, int y)

    %rename X %member_func int x // GetX() and SetX(int x)
    %rename Y %member_func int y // GetY() and SetY(int y)

    %operator wxPoint& operator=(const wxPoint& p) const

    %operator bool operator==(const wxPoint& p) const //{ return x == p.x && y == p.y; }
    %operator bool operator!=(const wxPoint& p) const //{ return !(*this == p); }

    // arithmetic operations (component wise)
    %operator wxPoint operator+(const wxPoint& p) const //{ return wxPoint(x + p.x, y + p.y); }
    %operator wxPoint operator-(const wxPoint& p) const //{ return wxPoint(x - p.x, y - p.y); }

    %operator wxPoint& operator+=(const wxPoint& p) //{ x += p.x; y += p.y; return *this; }
    %operator wxPoint& operator-=(const wxPoint& p) //{ x -= p.x; y -= p.y; return *this; }

    %operator wxPoint& operator+=(const wxSize& s) //{ x += s.GetWidth(); y += s.GetHeight(); return *this; }
    %operator wxPoint& operator-=(const wxSize& s) //{ x -= s.GetWidth(); y -= s.GetHeight(); return *this; }

    %operator wxPoint operator+(const wxSize& s) const //{ return wxPoint(x + s.GetWidth(), y + s.GetHeight()); }
    %operator wxPoint operator-(const wxSize& s) const //{ return wxPoint(x - s.GetWidth(), y - s.GetHeight()); }

    %operator wxPoint operator-() const //{ return wxPoint(-x, -y); }

%endclass

// ---------------------------------------------------------------------------
// wxRealPoint - Used nowhere in wxWidgets

//%class %delete %noclassinfo %encapsulate wxRealPoint
// wxRealPoint(double xx = 0, double yy = 0)
//
// %rename X %member double x // GetX() and SetX(int x)
// %rename Y %member double y // GetY() and SetY(int y)
//%endclass

// ---------------------------------------------------------------------------
// wxSize

%class %delete %noclassinfo %encapsulate wxSize

    %define_object wxDefaultSize

    wxSize(int width = 0, int height = 0)
    wxSize(const wxSize& size)

    %wxchkver_2_8 void DecBy(int dx, int dy)
    //%wxchkver_2_8 void DecBy(const wxSize& sz)
    //%wxchkver_2_8 void DecBy(int d)
    void DecTo(const wxSize& sz)
    bool IsFullySpecified() const
    int GetHeight() const
    int GetWidth() const
    %wxchkver_2_8 void IncBy(int dx, int dy)
    //%wxchkver_2_8 void IncBy(const wxSize& sz)
    //%wxchkver_2_8 void IncBy(int d)
    void IncTo(const wxSize& sz)
    %wxchkver_2_8 wxSize& Scale(float xscale, float yscale)
    void Set(int width, int height)
    void SetDefaults(const wxSize& size)
    void SetHeight(int height)
    void SetWidth(int width)

    %operator wxSize& operator=(const wxSize& s) const

    %operator bool operator==(const wxSize& sz) const //{ return x == sz.x && y == sz.y; }
    %operator bool operator!=(const wxSize& sz) const //{ return x != sz.x || y != sz.y; }

    %operator wxSize operator+(const wxSize& sz) const //{ return wxSize(x + sz.x, y + sz.y); }
    %operator wxSize operator-(const wxSize& sz) const //{ return wxSize(x - sz.x, y - sz.y); }
    %operator wxSize operator/(int i) const //{ return wxSize(x / i, y / i); }
    %operator wxSize operator*(int i) const //{ return wxSize(x * i, y * i); }

    %operator wxSize& operator+=(const wxSize& sz) //{ x += sz.x; y += sz.y; return *this; }
    %operator wxSize& operator-=(const wxSize& sz) //{ x -= sz.x; y -= sz.y; return *this; }
    %operator wxSize& operator/=(const int i) //{ x /= i; y /= i; return *this; }
    %operator wxSize& operator*=(const int i) //{ x *= i; y *= i; return *this; }

%endclass

// ---------------------------------------------------------------------------
// wxRect

%class %delete %noclassinfo %encapsulate wxRect

    wxRect(int x = 0, int y = 0, int w = 0, int h = 0)
    wxRect(const wxRect& rect)
    wxRect(const wxPoint& topLeft, const wxPoint& bottomRight)
    wxRect(const wxPoint& pos, const wxSize& size)
    wxRect(const wxSize& size)

    %if %wxchkver_2_8
    wxRect CentreIn(const wxRect& r, int dir = wxBOTH) const // CenterIn
    bool Contains(wxCoord dx, wxCoord dy) const
    bool Contains(const wxPoint& pt) const
    bool Contains(const wxRect& rect) const
    %endif // %wxchkver_2_8

    wxRect Deflate(wxCoord dx, wxCoord dy) const //wxRect& Deflate(wxCoord dx, wxCoord dy)
    int GetBottom()
    int GetHeight()
    int GetLeft()
    wxPoint GetPosition()
    wxPoint GetTopLeft() const // GetLeftTop
    %wxchkver_2_8 wxPoint GetTopRight() const // GetRightTop
    wxPoint GetBottomRight() const // GetRightBottom
    %wxchkver_2_8 wxPoint GetBottomLeft() const // GetLeftBottom
    int GetRight()
    wxSize GetSize()
    int GetTop()
    int GetWidth()
    int GetX()
    int GetY()
    wxRect Inflate(wxCoord dx, wxCoord dy) const //wxRect& Inflate(wxCoord dx, wxCoord dy)
    %wxcompat_2_6 bool Inside(wxCoord cx, wxCoord cy)
    bool Intersects(const wxRect& rect) const
    bool IsEmpty() const
    void Offset(wxCoord dx, wxCoord dy) //void Offset(const wxPoint& pt)
    void SetBottom(int bottom)
    void SetHeight(int height)
    void SetLeft(int left)
    void SetPosition(const wxPoint &p)
    %wxchkver_2_8 void SetBottomLeft(const wxPoint &p) // SetLeftBottom
    void SetBottomRight(const wxPoint &p) // SetRightBottom
    void SetRight(int right)
    void SetSize(const wxSize &s)
    void SetTop(int top)
    %wxchkver_2_8 void SetTopRight(const wxPoint &p) // SetRightTop
    void SetWidth(int width)
    void SetX(int X)
    void SetY(int Y)
    wxRect Union(const wxRect& rect) const //wxRect& Union(const wxRect& rect);

    %operator wxRect& operator=(const wxRect& r) const

    %operator bool operator==(const wxRect& rect) const
    %operator wxRect operator+(const wxRect& rect) const
    %operator wxRect& operator+=(const wxRect& rect)

%endclass

%endif //wxLUA_USE_wxPointSizeRect

// ---------------------------------------------------------------------------
// wxGDIObject

%class %delete wxGDIObject, wxObject

    //wxGDIObject() - base class, no constructor since it doesn't do anything

    //bool GetVisible() these are NOT USED and have been removed in 2.7
    //void SetVisible(bool visible)
    bool IsNull()

%endclass

// ---------------------------------------------------------------------------
// wxRegion

%if wxLUA_USE_wxRegion

%include "wx/region.h"

%enum wxRegionContain

    wxOutRegion
    wxPartRegion
    wxInRegion

%endenum

%if defined(wxHAS_REGION_COMBINE) // MSW and MAC
%enum wxRegionOp

    wxRGN_AND // Creates the intersection of the two combined regions.
    wxRGN_COPY // Creates a copy of the region
    wxRGN_DIFF // Combines the parts of first region that are not in the second one
    wxRGN_OR // Creates the union of two combined regions.
    wxRGN_XOR // Creates the union of two regions except for any overlapping areas.

%endenum

%define wxHAS_REGION_COMBINE 1
%endif // defined(wxHAS_REGION_COMBINE)

%class %delete wxRegion, wxGDIObject

    wxRegion(long x = 0, long y = 0, long width = 0, long height = 0)
    wxRegion(const wxPoint& topLeft, const wxPoint& bottomRight)
    // wxRegion(const wxPoint& pos, const wxSize& size)
    wxRegion(const wxRect& rect)
    wxRegion(const wxRegion& region)

    void Clear()

    %if defined(wxHAS_REGION_COMBINE) // MSW and MAC
    bool Combine(wxCoord x, wxCoord y, wxCoord w, wxCoord h, wxRegionOp op);
    bool Combine(const wxRect& rect, wxRegionOp op);
    bool Combine(const wxRegion& region, wxRegionOp op)
    %endif // defined(wxHAS_REGION_COMBINE)

    wxRegionContain Contains(long x, long y)
    wxRegionContain Contains(const wxPoint& pt)
    wxRegionContain Contains(const wxRect& rect)
    wxRegionContain Contains(long x, long y, long w, long h)
    wxBitmap ConvertToBitmap() const
    wxRect GetBox() const

    // %override [int x, int y, int width, int height] wxRegion::GetBoxXYWH()
    // C++ Func: void GetBox(int &x, int &y, int &width, int &height)
    %rename GetBoxXYWH void GetBox()

    bool Intersect(long x, long y, long width, long height)
    bool Intersect(const wxRect& rect)
    bool Intersect(const wxRegion& region)
    bool IsEmpty() const
    %wxchkver_2_8 bool IsEqual(const wxRegion& region) const
    %wxchkver_2_8 bool Ok() const
    bool Subtract(long x, long y, long width, long height)
    bool Subtract(const wxRect& rect)
    bool Subtract(const wxRegion& region)
    bool Offset(wxCoord x, wxCoord y)
    bool Union(long x, long y, long width, long height)
    bool Union(const wxRect& rect)
    bool Union(const wxRegion& region)
    bool Union(const wxBitmap& bmp)
    bool Union(const wxBitmap& bmp, const wxColour& transColour, int tolerance = 0)
    bool Xor(long x, long y, long width, long height)
    bool Xor(const wxRect& rect)
    bool Xor(const wxRegion& region)

    %operator wxRegion& operator=(const wxRegion& r) const
    // operator == just calls IsEqual()

%endclass

// ---------------------------------------------------------------------------
// wxRegionIterator

%class %delete wxRegionIterator, wxObject

    wxRegionIterator(const wxRegion& region)

    long GetX()
    long GetY()
    long GetWidth() // long GetW()
    long GetHeight() // long GetH()
    wxRect GetRect()
    bool HaveRects()
    void Reset()

    // %override void wxRegionIterator::Next() is ++ operator
    // This is a wxLua added function.
    void Next() // operator++

%endclass

%endif //wxLUA_USE_wxRegion

// ---------------------------------------------------------------------------
// wxFont

%if wxLUA_USE_wxFont

%include "wx/font.h"

%enum

    wxDEFAULT // these are deprecated use wxFONTFAMILY_XXX
    wxDECORATIVE
    wxROMAN
    wxSCRIPT
    wxSWISS
    wxMODERN
    wxTELETYPE

    wxVARIABLE // unused ?
    wxFIXED // unused ?

    wxNORMAL
    wxLIGHT
    wxBOLD
    wxITALIC
    wxSLANT

%endenum

%enum wxFontFamily

    wxFONTFAMILY_DEFAULT
    wxFONTFAMILY_DECORATIVE
    wxFONTFAMILY_ROMAN
    wxFONTFAMILY_SCRIPT
    wxFONTFAMILY_SWISS
    wxFONTFAMILY_MODERN
    wxFONTFAMILY_TELETYPE
    wxFONTFAMILY_MAX
    wxFONTFAMILY_UNKNOWN

%endenum

%enum wxFontStyle

    wxFONTSTYLE_NORMAL
    wxFONTSTYLE_ITALIC
    wxFONTSTYLE_SLANT
    wxFONTSTYLE_MAX

%endenum

%enum wxFontWeight

    wxFONTWEIGHT_NORMAL
    wxFONTWEIGHT_LIGHT
    wxFONTWEIGHT_BOLD
    wxFONTWEIGHT_MAX

%endenum

%enum

    wxFONTFLAG_DEFAULT
    wxFONTFLAG_ITALIC
    wxFONTFLAG_SLANT
    wxFONTFLAG_LIGHT
    wxFONTFLAG_BOLD
    wxFONTFLAG_ANTIALIASED
    wxFONTFLAG_NOT_ANTIALIASED
    wxFONTFLAG_UNDERLINED
    wxFONTFLAG_STRIKETHROUGH
    wxFONTFLAG_MASK

%endenum

%class %delete wxFont, wxGDIObject

    // Note: use wxNullFont as the object for static functions

    %define_object wxNullFont
    %rename wxNORMAL_FONT %define_pointer wxLua_wxNORMAL_FONT // hack for wxWidgets >2.7
    %rename wxSMALL_FONT %define_pointer wxLua_wxSMALL_FONT
    %rename wxITALIC_FONT %define_pointer wxLua_wxITALIC_FONT
    %rename wxSWISS_FONT %define_pointer wxLua_wxSWISS_FONT

    //wxFont(int pointSize, wxFontFamily family, int style, wxFontWeight weight, const bool underline = false, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)
    wxFont(int pointSize, int family, int style, int weight, const bool underline = false, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)
    wxFont(const wxFont& font)

    bool IsFixedWidth() const
    static wxFontEncoding GetDefaultEncoding()
    wxString GetFaceName() const
    int GetFamily() const
    wxString GetNativeFontInfoDesc() const
    int GetPointSize() const
    int GetStyle() const
    bool GetUnderlined() const
    int GetWeight() const
    static %gc wxFont* New(int pointSize, wxFontFamily family, int style, wxFontWeight weight, const bool underline = false, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)
    static %gc wxFont* New(int pointSize, wxFontFamily family, int flags = wxFONTFLAG_DEFAULT, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)
    static %gc wxFont* New(const wxSize& pixelSize, wxFontFamily family, int style, wxFontWeight weight, const bool underline = false, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)
    static %gc wxFont* New(const wxSize& pixelSize, wxFontFamily family, int flags = wxFONTFLAG_DEFAULT, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)
    bool Ok()
    static void SetDefaultEncoding(wxFontEncoding encoding)
    %not_overload !%wxchkver_2_8 void SetFaceName(const wxString& faceName)
    %not_overload %wxchkver_2_8 bool SetFaceName(const wxString& faceName)
    void SetFamily(int family)
    %not_overload !%wxchkver_2_8 void SetNativeFontInfo(const wxString& info)
    %not_overload %wxchkver_2_8 bool SetNativeFontInfo(const wxString& info)
    %wxchkver_2_8 bool SetNativeFontInfoUserDesc(const wxString& info)
    void SetPointSize(int pointSize)
    void SetStyle(int style)
    void SetUnderlined(const bool underlined)
    void SetWeight(int weight)

    %operator wxFont& operator=(const wxFont& f) const
    %operator bool operator == (const wxFont& font) const

%endclass

// ---------------------------------------------------------------------------
// wxNativeFontInfo

%include "wx/fontutil.h"

%class %delete %noclassinfo %encapsulate wxNativeFontInfo

    wxNativeFontInfo()
    wxNativeFontInfo(const wxNativeFontInfo& info)

    // accessors and modifiers for the font elements
    int GetPointSize() const
    %msw wxSize GetPixelSize() const // FIXME wxWidgets has undefined symbol in gtk/mac
    wxFontStyle GetStyle() const
    wxFontWeight GetWeight() const
    bool GetUnderlined() const
    wxString GetFaceName() const
    wxFontFamily GetFamily() const
    wxFontEncoding GetEncoding() const

    void SetPointSize(int pointsize)
    %msw void SetPixelSize(const wxSize& pixelSize)
    void SetStyle(wxFontStyle style)
    void SetWeight(wxFontWeight weight)
    void SetUnderlined(bool underlined)
    %wxchkver_2_8 bool SetFaceName(const wxString& facename)
    !%wxchkver_2_8 void SetFaceName(const wxString& facename)
    void SetFamily(wxFontFamily family)
    void SetEncoding(wxFontEncoding encoding)

    // sets the first facename in the given array which is found
    // to be valid. If no valid facename is given, sets the
    // first valid facename returned by wxFontEnumerator::GetFacenames().
    // Does not return a bool since it cannot fail.
    %wxchkver_2_8 void SetFaceName(const wxArrayString& facenames)

    // it is important to be able to serialize wxNativeFontInfo objects to be
    // able to store them (in config file, for example)
    bool FromString(const wxString& s);
    wxString ToString() const

    // we also want to present the native font descriptions to the user in some
    // human-readable form (it is not platform independent neither, but can
    // hopefully be understood by the user)
    bool FromUserString(const wxString& s)
    wxString ToUserString() const

%endclass

%endif //wxLUA_USE_wxFont

// ---------------------------------------------------------------------------
// wxFontEnumerator

%if wxLUA_USE_wxFontEnumerator

%include "wx/fontenum.h"

%class %delete %noclassinfo %encapsulate wxFontEnumerator

    wxFontEnumerator()

    virtual bool EnumerateFacenames( wxFontEncoding encoding = wxFONTENCODING_SYSTEM, bool fixedWidthOnly = false)
    virtual bool EnumerateEncodings( const wxString &font = "" )

    %wxchkver_2_8 static wxArrayString GetEncodings(const wxString& facename = "")
    %wxchkver_2_8 static wxArrayString GetFacenames(wxFontEncoding encoding = wxFONTENCODING_SYSTEM, bool fixedWidthOnly = false)
    !%wxchkver_2_8 wxArrayString* GetEncodings()
    !%wxchkver_2_8 wxArrayString* GetFacenames()

    // Use GetEncodings/Facenames after calling EnumerateXXX
    //virtual bool OnFacename(const wxString& facename)
    //virtual bool OnFontEncoding(const wxString& facename, const wxString& encoding)

%endclass

%endif //wxLUA_USE_wxFontEnumerator

// ---------------------------------------------------------------------------
// wxFontList

%if wxLUA_USE_wxFontList

%class %noclassinfo wxFontList

    %define_pointer wxTheFontList

    // No constructor, use wxTheFontList

    // Note: we don't gc the returned font as the list will delete it
    wxFont* FindOrCreateFont(int pointSize, int family, int style, int weight, bool underline = false, const wxString &faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT)

    // Only use FindOrCreateFont - others deprecated in >2.7
    //void AddFont(wxFont* font)
    //void RemoveFont(wxFont* font)

%endclass

%endif //wxLUA_USE_wxFontList

// ---------------------------------------------------------------------------
// wxFontMapper

%if wxLUA_USE_wxFontMapper

%include "wx/fontmap.h"

%class %noclassinfo wxFontMapper

    // No constructor, use static Get() function

    wxFontEncoding CharsetToEncoding(const wxString &charset, bool interactive = true)
    static wxFontMapper *Get()

    // %override [bool, wxFontEncoding *altEncoding] wxFontMapper::GetAltForEncoding(wxFontEncoding encoding, const wxString &faceName = "", bool interactive = true)
    // C++ Func: bool GetAltForEncoding(wxFontEncoding encoding, wxFontEncoding *altEncoding, const wxString &faceName = "", bool interactive = true)
    bool GetAltForEncoding(wxFontEncoding encoding, const wxString &faceName = "", bool interactive = true)

    // This function is really for wxWidgets internal use
    // %rename GetAltForEncodingInternal bool GetAltForEncoding(wxFontEncoding encoding, wxNativeEncodingInfo *info, const wxString &faceName = "", bool interactive = true)

    static wxString GetDefaultConfigPath()
    static wxFontEncoding GetEncoding(size_t n)
    static wxString GetEncodingDescription(wxFontEncoding encoding)
    static wxFontEncoding GetEncodingFromName(const wxString& encoding)
    static wxString GetEncodingName(wxFontEncoding encoding)
    static size_t GetSupportedEncodingsCount()
    bool IsEncodingAvailable(wxFontEncoding encoding, const wxString &facename = "")
    %wxchkver_2_8 static void Reset()
    void SetDialogParent(wxWindow *parent)
    void SetDialogTitle(const wxString &title)
    //static wxFontMapper *Set(wxFontMapper *mapper) // wxLua probably doesn't need this
    !%wxchkver_2_8 void SetConfig(wxConfigBase *config = NULL)
    void SetConfigPath(const wxString &prefix)

%endclass

%endif //wxLUA_USE_wxFontMapper

// ---------------------------------------------------------------------------
// wxColour

%if wxLUA_USE_wxColourPenBrush

%include "wx/colour.h"
%include "wx/gdicmn.h"

%if %wxchkver_2_8
%define wxC2S_NAME // return colour name, when possible
%define wxC2S_CSS_SYNTAX // return colour in rgb(r,g,b) syntax
%define wxC2S_HTML_SYNTAX // return colour in #rrggbb syntax

%define wxALPHA_TRANSPARENT
%define wxALPHA_OPAQUE
%endif // %wxchkver_2_8

%class %delete wxColour, wxGDIObject

    %define_object wxNullColour
    %rename wxBLACK %define_pointer wxLua_wxBLACK // hack for wxWidgets >2.7 wxStockGDI::GetColour
    %rename wxWHITE %define_pointer wxLua_wxWHITE
    %rename wxRED %define_pointer wxLua_wxRED
    %rename wxBLUE %define_pointer wxLua_wxBLUE
    %rename wxGREEN %define_pointer wxLua_wxGREEN
    %rename wxCYAN %define_pointer wxLua_wxCYAN
    %rename wxLIGHT_GREY %define_pointer wxLua_wxLIGHT_GREY

    !%wxchkver_2_8 wxColour(unsigned char red, unsigned char green, unsigned char blue)
    %wxchkver_2_8 wxColour(unsigned char red, unsigned char green, unsigned char blue, unsigned char alpha = wxALPHA_OPAQUE)
    wxColour(const wxString& colourName)
    wxColour(const wxColour& colour)

    %wxchkver_2_8 unsigned char Alpha() const
    unsigned char Blue() const
    %wxchkver_2_8 virtual wxString GetAsString(long flags = wxC2S_NAME | wxC2S_CSS_SYNTAX) const
    !%mac long GetPixel() const
    unsigned char Green() const
    bool Ok() const
    unsigned char Red() const
    !%wxchkver_2_8 void Set(unsigned char red, unsigned char green, unsigned char blue)

    %if %wxchkver_2_8
    void Set(unsigned char red, unsigned char green, unsigned char blue, unsigned char alpha = wxALPHA_OPAQUE)
    bool Set(const wxString &str)
    void Set(unsigned long colRGB)
    %endif // %wxchkver_2_8

    %operator wxColour& operator=(const wxColour& c) const
    %operator bool operator == (const wxColour& c) const

%endclass

// ---------------------------------------------------------------------------
// wxColourDatabase

%class %delete %noclassinfo %encapsulate wxColourDatabase

    wxColourDatabase()

    wxColour Find(const wxString& name) const
    wxString FindName(const wxColour& colour) const
    void AddColour(const wxString& name, const wxColour& colour)

%endclass

// ---------------------------------------------------------------------------
// wxPen

%include "wx/pen.h"

%define wxCAP_BUTT
%define wxCAP_PROJECTING
%define wxCAP_ROUND

%define wxDOT
%define wxDOT_DASH
%define wxSOLID
%define wxLONG_DASH
%define wxSHORT_DASH
%define wxUSER_DASH

%define wxJOIN_BEVEL
%define wxJOIN_MITER
%define wxJOIN_ROUND

%enum

    wxTRANSPARENT

    wxSTIPPLE_MASK_OPAQUE
    wxSTIPPLE_MASK
    wxSTIPPLE
    wxBDIAGONAL_HATCH
    wxCROSSDIAG_HATCH
    wxFDIAGONAL_HATCH
    wxCROSS_HATCH
    wxHORIZONTAL_HATCH
    wxVERTICAL_HATCH

%endenum

%class %delete wxPen, wxGDIObject

    %define_object wxNullPen
    %rename wxRED_PEN %define_pointer wxLua_wxRED_PEN // hack for wxWidgets >2.7 wxStockGDI::GetPen
    %rename wxCYAN_PEN %define_pointer wxLua_wxCYAN_PEN
    %rename wxGREEN_PEN %define_pointer wxLua_wxGREEN_PEN
    %rename wxBLACK_PEN %define_pointer wxLua_wxBLACK_PEN
    %rename wxWHITE_PEN %define_pointer wxLua_wxWHITE_PEN
    %rename wxTRANSPARENT_PEN %define_pointer wxLua_wxTRANSPARENT_PEN
    %rename wxBLACK_DASHED_PEN %define_pointer wxLua_wxBLACK_DASHED_PEN
    %rename wxGREY_PEN %define_pointer wxLua_wxGREY_PEN
    %rename wxMEDIUM_GREY_PEN %define_pointer wxLua_wxMEDIUM_GREY_PEN
    %rename wxLIGHT_GREY_PEN %define_pointer wxLua_wxLIGHT_GREY_PEN

    wxPen()
    wxPen(const wxColour& colour, int width, int style)
    wxPen(const wxString& colourName, int width, int style)
    %win wxPen(const wxBitmap& stipple, int width)
    wxPen(const wxPen& pen)

    int GetCap() const
    wxColour GetColour() const // not wxColur& so we allocate a new one
    // int GetDashes(wxDash** dashes) const
    int GetJoin() const
    %win wxBitmap* GetStipple() const
    int GetStyle() const
    int GetWidth() const
    bool Ok() const
    void SetCap(int capStyle)

    void SetColour(wxColour& colour)
    void SetColour(const wxString& colourName)
    void SetColour(unsigned char red, unsigned char green, unsigned char blue)

    //void SetDashes(int nb_dashes, const wxDash *dash)
    void SetJoin(int join_style)
    %win void SetStipple(const wxBitmap& stipple)
    void SetStyle(int style)
    void SetWidth(int width)

    %operator wxPen& operator=(const wxPen& p) const
    %operator bool operator == (const wxPen& p) const

%endclass

// ---------------------------------------------------------------------------
// wxPenList

%if wxLUA_USE_wxPenList

%class %noclassinfo wxPenList, wxList

    %define_pointer wxThePenList

    // No constructor, use wxThePenList

    // Note: we don't gc the returned pen as the list will delete it
    wxPen* FindOrCreatePen(const wxColour& colour, int width, int style)

    // Use the wxList methods, see also wxNode
    //void AddPen(wxPen *pen) internal use for wxWidgets
    //void RemovePen(wxPen *pen)

%endclass

%endif //wxLUA_USE_wxPenList

// ---------------------------------------------------------------------------
// wxBrush

%include "wx/brush.h"

%class %delete wxBrush, wxGDIObject

    %define_object wxNullBrush
    %rename wxBLUE_BRUSH %define_pointer wxLua_wxBLUE_BRUSH // hack for wxWidgets >2.7 wxStockGDI::GetBrush
    %rename wxGREEN_BRUSH %define_pointer wxLua_wxGREEN_BRUSH
    %rename wxWHITE_BRUSH %define_pointer wxLua_wxWHITE_BRUSH
    %rename wxBLACK_BRUSH %define_pointer wxLua_wxBLACK_BRUSH
    %rename wxGREY_BRUSH %define_pointer wxLua_wxGREY_BRUSH
    %rename wxMEDIUM_GREY_BRUSH %define_pointer wxLua_wxMEDIUM_GREY_BRUSH
    %rename wxLIGHT_GREY_BRUSH %define_pointer wxLua_wxLIGHT_GREY_BRUSH
    %rename wxTRANSPARENT_BRUSH %define_pointer wxLua_wxTRANSPARENT_BRUSH
    %rename wxCYAN_BRUSH %define_pointer wxLua_wxCYAN_BRUSH
    %rename wxRED_BRUSH %define_pointer wxLua_wxRED_BRUSH

    wxBrush()
    wxBrush(const wxColour& colour, int style)
    wxBrush(const wxString& colourName, int style)
    wxBrush(const wxBitmap& stippleBitmap)
    wxBrush(const wxBrush& brush)

    wxColour GetColour() const
    wxBitmap* GetStipple() const
    int GetStyle() const
    bool IsHatch() const
    bool Ok() const
    void SetColour(wxColour& colour)
    void SetColour(const wxString& colourName)
    void SetColour(const unsigned char red, const unsigned char green, const unsigned char blue)
    void SetStipple(const wxBitmap& bitmap)
    void SetStyle(int style)

    %operator wxBrush& operator=(const wxBrush& b) const
    %operator bool operator == (const wxBrush& b) const

%endclass

// ---------------------------------------------------------------------------
// wxBrushList

%if wxLUA_USE_wxBrushList

%class %noclassinfo wxBrushList, wxList

    %define_pointer wxTheBrushList

    // No constructor, use wxTheBrushList

    // Note: we don't gc the returned brush as the list will delete it
    wxBrush* FindOrCreateBrush(const wxColour& colour, int style)

    // Use the wxList methods, see also wxNode
    //void AddBrush(wxBrush *brush) internal use for wxWidgets
    //void RemoveBrush(wxBrush *brush)

%endclass

%endif //wxLUA_USE_wxBrushList


// ---------------------------------------------------------------------------
// wxStockGDI

%include "wx/gdicmn.h"

%if %wxchkver_2_8

%enum wxStockGDI::Item

    BRUSH_BLACK
    BRUSH_BLUE
    BRUSH_CYAN
    BRUSH_GREEN
    BRUSH_GREY
    BRUSH_LIGHTGREY
    BRUSH_MEDIUMGREY
    BRUSH_RED
    BRUSH_TRANSPARENT
    BRUSH_WHITE
    COLOUR_BLACK
    COLOUR_BLUE
    COLOUR_CYAN
    COLOUR_GREEN
    COLOUR_LIGHTGREY
    COLOUR_RED
    COLOUR_WHITE
    CURSOR_CROSS
    CURSOR_HOURGLASS
    CURSOR_STANDARD
    FONT_ITALIC
    FONT_NORMAL
    FONT_SMALL
    FONT_SWISS
    PEN_BLACK
    PEN_BLACKDASHED
    PEN_CYAN
    PEN_GREEN
    PEN_GREY
    PEN_LIGHTGREY
    PEN_MEDIUMGREY
    PEN_RED
    PEN_TRANSPARENT
    PEN_WHITE
    ITEMCOUNT

%endenum

%class %noclassinfo %encapsulate wxStockGDI

    //wxStockGDI() use instance to get the implemented wxStockGDI

    //static void DeleteAll()
    static wxStockGDI& instance()

    static const wxBrush* GetBrush(wxStockGDI::Item item)
    static const wxColour* GetColour(wxStockGDI::Item item)
    static const wxCursor* GetCursor(wxStockGDI::Item item)
    // Can be overridden by platform-specific derived classes
    virtual const wxFont* GetFont(wxStockGDI::Item item)
    static const wxPen* GetPen(wxStockGDI::Item item)

%endclass

%endif // %wxchkver_2_8
%endif //wxLUA_USE_wxColourPenBrush

// ---------------------------------------------------------------------------
// wxPalette

%if wxLUA_USE_wxPalette && wxUSE_PALETTE

%include "wx/palette.h"

%class %delete wxPalette, wxGDIObject

    %define_object wxNullPalette

    wxPalette()
    // wxPalette(int n, const unsigned char* red, const unsigned char* green, const unsigned char* blue) - use Create
    wxPalette(const wxPalette& palette)

    // %override bool wxPalette::Create(int n, Lua string red, Lua string green, Lua string blue)
    // C++ Func: bool Create(int n, const unsigned char* red, const unsigned char* green, const unsigned char* blue)
    bool Create(int n, const unsigned char* red, const unsigned char* green, const unsigned char* blue)

    int GetColoursCount() const
    int GetPixel(unsigned char red, unsigned char green, unsigned char blue) const

    // %override [bool, char red, char green, char blue] wxPalette::GetRGB(int pixel) const
    // C++ Func: bool GetRGB(int pixel, unsigned char* red, unsigned char* green, unsigned char* blue) const
    bool GetRGB(int pixel) const

    bool Ok() const

%endclass

%endif //wxLUA_USE_wxPalette && wxUSE_PALETTE

// ---------------------------------------------------------------------------
// wxIcon

%if wxLUA_USE_wxIcon
// %typedef void* WXHANDLE // GloaEdit: Unused type.

%class %delete wxIcon, wxGDIObject

    %define_object wxNullIcon

    wxIcon()
    wxIcon(const wxString& name, wxBitmapType type, int desiredWidth = -1, int desiredHeight = -1)
    //wxIcon(int width, int height, int depth = -1) // constructor does not exist

    %win|%mac|%wxchkver_2_6 void CopyFromBitmap(const wxBitmap& bmp)
    int GetDepth()
    int GetHeight()
    int GetWidth()
    bool LoadFile(const wxString& name, wxBitmapType flags)
    bool Ok()
    void SetDepth(int d)
    void SetHeight(int h)
    void SetWidth(int w)
    //%win void SetSize(const wxSize& size)

    %operator wxIcon& operator=(const wxIcon& i) const

%endclass

// ---------------------------------------------------------------------------
// wxIconBundle

%include "wx/iconbndl.h"

%class %delete %noclassinfo %encapsulate wxIconBundle

    wxIconBundle()
    wxIconBundle( const wxString& file, long type )
    wxIconBundle( const wxIcon& icon )
    wxIconBundle( const wxIconBundle& ic )

    void AddIcon( const wxString& file, long type )
    void AddIcon( const wxIcon& icon );

    const wxIcon& GetIcon( const wxSize& size ) const;
    // equivalent to GetIcon( wxSize( size, size ) )
    const wxIcon& GetIcon( int size = wxDefaultCoord ) const

%endclass

%endif //wxLUA_USE_wxIcon

// ---------------------------------------------------------------------------
// wxBitmap

%if wxLUA_USE_wxBitmap

%include "wx/bitmap.h"

//%win %class %delete %noclassinfo wxBitmapHandler // are these even necessary?
//%endclass
//%win %class %delete %noclassinfo wxGDIImageHandler
//%endclass
//%wxchkver_2_6&%win %class %noclassinfo wxGDIImageHandlerList, wxList
//%endclass

%class %delete wxBitmap, wxGDIObject

    %define_object wxNullBitmap

    wxBitmap()
    wxBitmap(const wxBitmap& bitmap)
    wxBitmap( int width, int height, int depth = -1)
    wxBitmap(const wxString& name, wxBitmapType type = wxBITMAP_TYPE_ANY)
    wxBitmap(const wxImage &image, int depth = -1)

    // %override wxBitmap(Lua string, int width, int height, int depth)
    // C++ Func: wxBitmap(const char bits[], int width, int height, int depth = 1)
    // Creates a bitmap from an array of bits in the form of a Lua string.
    %override_name wxLua_wxBitmapFromBits_constructor wxBitmap(const char* mono_bits, int width, int height, int depth /* = 1 */);
    // %override wxBitmap(LuaTable charTable, int width, int height, int depth)
    // C++ Func: wxBitmap(const char bits[], int width, int height, int depth = 1)
    // Creates a bitmap from an array of chars in a Lua table.
    %override_name wxLua_wxBitmapFromBitTable_constructor wxBitmap(LuaTable charTable, int width, int height, int depth /* = 1 */);

    // %override wxBitmap(LuaTable stringTable where each index is a row in the image)
    // C++ Func: wxBitmap(const char **data) Load from XPM
    %override_name wxLua_wxBitmapFromXPMData_constructor wxBitmap(LuaTable charTable)

    // %override wxBitmap(Lua string of data, int type, int width, int height, int depth)
    // C++ Func: wxBitmap(const void* data, int type, int width, int height, int depth = -1)
    %override_name wxLua_wxBitmapFromData_constructor %win wxBitmap(const wxString& data, int type, int width, int height, int depth /* = -1 */)

    //%win static void AddHandler(wxBitmapHandler* handler)
    //%win static void CleanUpHandlers()
    wxImage ConvertToImage()
    bool CopyFromIcon(const wxIcon& icon)
    virtual bool Create(int width, int height, int depth = -1)
    //static wxBitmapHandler* FindHandler(const wxString& name)
    //static wxBitmapHandler* FindHandler(const wxString& extension, wxBitmapType bitmapType)
    //static wxBitmapHandler* FindHandler(wxBitmapType bitmapType)
    int GetDepth() const
    //%wxchkver_2_6&%win static wxGDIImageHandlerList& GetHandlers()
    //!%wxchkver_2_6&%win static wxList& GetHandlers()
    int GetHeight() const
    wxPalette* GetPalette() const
    wxMask* GetMask() const
    wxBitmap GetSubBitmap(const wxRect&rect) const
    int GetWidth() const
    //%win static void InitStandardHandlers()
    //%win static void InsertHandler(wxBitmapHandler* handler)
    bool LoadFile(const wxString& name, wxBitmapType type)
    bool Ok() const
    !%msw&%wxchkver_2_8 virtual wxColour QuantizeColour(const wxColour& colour) const // msw doesn't derive from wxBitmapBase
    //%win static bool RemoveHandler(const wxString& name)
    bool SaveFile(const wxString& name, wxBitmapType type, wxPalette* palette = NULL)
    void SetDepth(int depth)
    void SetHeight(int height)
    void SetMask(%ungc wxMask* mask)
    %win void SetPalette(const wxPalette& palette)
    void SetWidth(int width)

    %operator wxBitmap& operator=(const wxBitmap& b) const

%endclass

%endif //wxLUA_USE_wxBitmap

// ---------------------------------------------------------------------------
// wxCursor

%if wxLUA_USE_wxCursor

//%typedef void* WXHANDLE

%include "wx/cursor.h"

%enum wxStockCursor

    wxCURSOR_NONE
    wxCURSOR_ARROW
    wxCURSOR_RIGHT_ARROW
    wxCURSOR_BULLSEYE
    wxCURSOR_CHAR
    wxCURSOR_CROSS
    wxCURSOR_HAND
    wxCURSOR_IBEAM
    wxCURSOR_LEFT_BUTTON
    wxCURSOR_MAGNIFIER
    wxCURSOR_MIDDLE_BUTTON
    wxCURSOR_NO_ENTRY
    wxCURSOR_PAINT_BRUSH
    wxCURSOR_PENCIL
    wxCURSOR_POINT_LEFT
    wxCURSOR_POINT_RIGHT
    wxCURSOR_QUESTION_ARROW
    wxCURSOR_RIGHT_BUTTON
    wxCURSOR_SIZENESW
    wxCURSOR_SIZENS
    wxCURSOR_SIZENWSE
    wxCURSOR_SIZEWE
    wxCURSOR_SIZING
    wxCURSOR_SPRAYCAN
    wxCURSOR_WAIT
    wxCURSOR_WATCH
    wxCURSOR_BLANK
    wxCURSOR_DEFAULT
    %mac wxCURSOR_COPY_ARROW

    %if defined(__X__)
    // Not yet implemented for Windows
    wxCURSOR_CROSS_REVERSE,
    wxCURSOR_DOUBLE_ARROW,
    wxCURSOR_BASED_ARROW_UP,
    wxCURSOR_BASED_ARROW_DOWN,
    %endif // X11

    wxCURSOR_ARROWWAIT
    wxCURSOR_MAX

%endenum

%class %delete wxCursor, wxObject // wxObject in gtk, wxGDIImage in msw, wxBitmap in osx

    %define_object wxNullCursor
    %rename wxSTANDARD_CURSOR %define_pointer wxLua_wxSTANDARD_CURSOR // hack for wxWidgets >2.7
    %rename wxHOURGLASS_CURSOR %define_pointer wxLua_wxHOURGLASS_CURSOR
    %rename wxCROSS_CURSOR %define_pointer wxLua_wxCROSS_CURSOR

    wxCursor()
    wxCursor(int id)
    wxCursor(const wxImage& image)
    %win|%mac wxCursor(const wxString& cursorName, long type, int hotSpotX = 0, int hotSpotY = 0)

    bool Ok()

    %win int GetWidth()
    %win int GetHeight()
    %win int GetDepth()
    //%win void SetWidth(int width)
    //%win void SetHeight(int height)
    //%win void SetDepth(int depth)
    //%win void SetSize(const wxSize& size)

    %operator wxCursor& operator=(const wxCursor& c) const

%endclass

%endif //wxLUA_USE_wxCursor

// ---------------------------------------------------------------------------
// wxMask

%if wxLUA_USE_wxMask

%include "wx/bitmap.h"

%class %delete wxMask, wxObject

    wxMask()
    wxMask(const wxBitmap& bitmap)
    wxMask(const wxBitmap& bitmap, const wxColour& colour)
    %win wxMask(const wxBitmap& bitmap, int index)

    bool Create(const wxBitmap& bitmap)
    bool Create(const wxBitmap& bitmap, const wxColour& colour)
    %win bool Create(const wxBitmap& bitmap, int index)

    %operator wxMask& operator=(const wxMask& m) const

%endclass

%endif //wxLUA_USE_wxMask

// ---------------------------------------------------------------------------
// wxImageList

%if wxLUA_USE_wxImageList

%include "wx/imaglist.h"

%define wxIMAGELIST_DRAW_NORMAL
%define wxIMAGELIST_DRAW_TRANSPARENT
%define wxIMAGELIST_DRAW_SELECTED
%define wxIMAGELIST_DRAW_FOCUSED

%define wxIMAGE_LIST_NORMAL
%define wxIMAGE_LIST_SMALL
%define wxIMAGE_LIST_STATE

%class %delete wxImageList, wxObject

    wxImageList(int width, int height, bool mask = true, int initialCount = 1)

    int Add(const wxBitmap& bitmap, const wxBitmap& mask = wxNullBitmap)
    int Add(const wxBitmap& bitmap, const wxColour& maskColour)
    int Add(const wxIcon& icon)
    bool Draw(int index, wxDC& dc, int x, int y, int flags = wxIMAGELIST_DRAW_NORMAL, bool solidBackground = false)
    wxBitmap GetBitmap(int index) const
    wxIcon GetIcon(int index) const
    int GetImageCount()

    // %override [int width, int height] wxImageList::GetSize(int index)
    // C++ Func: void GetSize(int index, int& width, int& height)
    void GetSize(int index)

    bool Remove(int index)
    bool RemoveAll()
    %win bool Replace(int index, const wxBitmap& bitmap, const wxBitmap& mask = wxNullBitmap)
    %gtk|%mac bool Replace(int index, const wxBitmap& bitmap)
    //bool ReplaceIcon(int index, const wxIcon& icon)

%endclass

%endif //wxLUA_USE_wxImageList

// ---------------------------------------------------------------------------
// wxDC

%if wxLUA_USE_wxDC

%include "wx/dc.h"

%enum

    wxMM_TEXT
    wxMM_LOMETRIC
    wxMM_HIMETRIC
    wxMM_LOENGLISH
    wxMM_HIENGLISH
    wxMM_TWIPS
    wxMM_ISOTROPIC
    wxMM_ANISOTROPIC
    wxMM_POINTS
    wxMM_METRIC

%endenum

%define wxROP_BLACK
%define wxROP_COPYPEN
%define wxROP_MASKNOTPEN
%define wxROP_MASKPEN
%define wxROP_MASKPENNOT
%define wxROP_MERGENOTPEN
%define wxROP_MERGEPEN
%define wxROP_MERGEPENNOT
%define wxROP_NOP
%define wxROP_NOT
%define wxROP_NOTCOPYPEN
%define wxROP_NOTMASKPEN
%define wxROP_NOTMERGEPEN
%define wxROP_NOTXORPEN
%define wxROP_WHITE
%define wxROP_XORPEN

%define wxBLIT_00220326
%define wxBLIT_007700E6
%define wxBLIT_00990066
%define wxBLIT_00AA0029
%define wxBLIT_00DD0228
%define wxBLIT_BLACKNESS
%define wxBLIT_DSTINVERT
%define wxBLIT_MERGEPAINT
%define wxBLIT_NOTSCRCOPY
%define wxBLIT_NOTSRCERASE
%define wxBLIT_SRCAND
%define wxBLIT_SRCCOPY
%define wxBLIT_SRCERASE
%define wxBLIT_SRCINVERT
%define wxBLIT_SRCPAINT
%define wxBLIT_WHITENESS

%define wxCLEAR
%define wxXOR
%define wxINVERT
%define wxOR_REVERSE
%define wxAND_REVERSE
%define wxCOPY
%define wxAND
%define wxAND_INVERT
%define wxNO_OP
%define wxNOR
%define wxEQUIV
%define wxSRC_INVERT
%define wxOR_INVERT
%define wxNAND
%define wxOR
%define wxSET

%define wxFLOOD_BORDER
%define wxFLOOD_SURFACE

%define wxODDEVEN_RULE
%define wxWINDING_RULE


%class %delete wxDC, wxObject

    // %win wxDC() wxDC is abstract use wxXXXDC

    //void BeginDrawing() // these are deprecated in 2.8 and didn't do anything anyway
    bool Blit(wxCoord xdest, wxCoord ydest, wxCoord width, wxCoord height, wxDC* source, wxCoord xsrc, wxCoord ysrc, int logicalFunc = wxCOPY, bool useMask = false)
    void CalcBoundingBox(wxCoord x, wxCoord y)
    void Clear()
    //void ComputeScaleAndOrigin() used internally
    void CrossHair(wxCoord x, wxCoord y)
    void DestroyClippingRegion()
    wxCoord DeviceToLogicalX(wxCoord x)
    wxCoord DeviceToLogicalXRel(wxCoord x)
    wxCoord DeviceToLogicalY(wxCoord y)
    wxCoord DeviceToLogicalYRel(wxCoord y)
    void DrawArc(wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2, wxCoord xc, wxCoord yc)
    void DrawBitmap(const wxBitmap& bitmap, wxCoord x, wxCoord y, bool transparent)
    void DrawCheckMark(wxCoord x, wxCoord y, wxCoord width, wxCoord height)
    void DrawCheckMark(const wxRect &rect)
    void DrawCircle(wxCoord x, wxCoord y, wxCoord radius)
    //void DrawCircle(const wxPoint& pt, wxCoord radius)
    void DrawEllipse(wxCoord x, wxCoord y, wxCoord width, wxCoord height)
    //void DrawEllipse(const wxPoint& pt, const wxSize& size)
    //void DrawEllipse(const wxRect& rect)
    void DrawEllipticArc(wxCoord x, wxCoord y, wxCoord width, wxCoord height, double start, double end)
    void DrawIcon(const wxIcon& icon, wxCoord x, wxCoord y)
    void DrawLabel(const wxString& text, const wxBitmap& image, const wxRect& rect, int alignment = wxALIGN_LEFT | wxALIGN_TOP, int indexAccel = -1) //, wxRect *rectBounding = NULL)
    void DrawLabel(const wxString& text, const wxRect& rect, int alignment = wxALIGN_LEFT | wxALIGN_TOP, int indexAccel = -1)
    void DrawLine(wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2)
    //void DrawLines(int n, wxPoint points[], wxCoord xoffset = 0, wxCoord yoffset = 0) // FIXME add this
    %rename DrawLinesList void DrawLines(wxList *points, wxCoord xoffset = 0, wxCoord yoffset = 0)
    //void DrawPolygon(int n, wxPoint points[], wxCoord xoffset = 0, wxCoord yoffset = 0, int fill_style = wxODDEVEN_RULE) // FIXME add this
    %rename DrawPolygonList void DrawPolygon(wxList *points, wxCoord xoffset = 0, wxCoord yoffset = 0, int fill_style = wxODDEVEN_RULE)
    //void DrawPolyPolygon(int n, int count[], wxPoint points[], wxCoord xoffset = 0, wxCoord yoffset = 0, int fill_style = wxODDEVEN_RULE)
    void DrawPoint(wxCoord x, wxCoord y)
    void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height)
    void DrawRotatedText(const wxString& text, wxCoord x, wxCoord y, double angle)
    void DrawRoundedRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height, double radius = 20)
    //%if wxUSE_SPLINES
    //void DrawSpline(int n, wxPoint points[])
    //void DrawSpline(wxList *points)
    //%endif wxUSE_SPLINES
    void DrawText(const wxString& text, wxCoord x, wxCoord y)
    void EndDoc()
    //void EndDrawing() // these are deprecated in 2.8 and didn't do anything anyway
    void EndPage()
    void FloodFill(wxCoord x, wxCoord y, const wxColour& colour, int style=wxFLOOD_SURFACE)

    %if %wxchkver_2_8
    //void GradientFillConcentric(const wxRect& rect, const wxColour& initialColour, const wxColour& destColour)
    void GradientFillConcentric(const wxRect& rect, const wxColour& initialColour, const wxColour& destColour, const wxPoint& circleCenter)
    void GradientFillLinear(const wxRect& rect, const wxColour& initialColour, const wxColour& destColour, wxDirection nDirection = wxEAST)
    wxBitmap GetAsBitmap(const wxRect *subrect = NULL) const
    %endif //%wxchkver_2_8

    // alias
    const wxBrush& GetBackground()
    int GetBackgroundMode() const
    const wxBrush& GetBrush()
    wxCoord GetCharHeight()
    wxCoord GetCharWidth()
    void GetClippingBox(wxCoord *x, wxCoord *y, wxCoord *width, wxCoord *height)
    const wxFont& GetFont()
    %wxchkver_2_8 wxLayoutDirection GetLayoutDirection() const
    int GetLogicalFunction()
    int GetMapMode()
    //bool GetPartialTextExtents(const wxString& text, wxArrayInt& widths) const
    const wxPen& GetPen()
    bool GetPixel(wxCoord x, wxCoord y, wxColour *colour)
    wxSize GetPPI() const
    void GetSize(wxCoord *width, wxCoord *height) // wxSize GetSize() const
    //void GetSizeMM(wxCoord *width, wxCoord *height) const // wxSize GetSizeMM() const
    const wxColour& GetTextBackground() const

    // %override [int x, int y, int descent, int externalLeading] wxDC::GetTextExtent(const wxString& string, const wxFont* font = NULL )
    // C++ Func: void GetTextExtent(const wxString& string, wxCoord* x, wxCoord* y, wxCoord* descent = NULL, wxCoord* externalLeading = NULL, const wxFont* font = NULL)
    void GetTextExtent(const wxString& string, wxFont *font = NULL)

    %wxchkver_2_8 %rename GetTextExtentSize wxSize GetTextExtent(const wxString& string) const

    // %override [int x, int y, int heightLine] wxDC::GetMultiLineTextExtent(const wxString& string, const wxFont* font = NULL )
    // C++ Func: void GetMultiLineTextExtent(const wxString& string, wxCoord* x, wxCoord* y, wxCoord* heightLine = NULL, const wxFont* font = NULL)
    %wxchkver_2_8 void GetMultiLineTextExtent(const wxString& string, wxFont *font = NULL) const

    %wxchkver_2_8 %rename GetMultiLineTextExtentSize wxSize GetMultiLineTextExtent(const wxString& string) const

    const wxColour& GetTextForeground()

    // %override [int x, int y] wxDC::GetUserScale()
    // C++ Func: void GetUserScale(double *x, double *y)
    void GetUserScale()

    wxCoord LogicalToDeviceX(wxCoord x)
    wxCoord LogicalToDeviceXRel(wxCoord x)
    wxCoord LogicalToDeviceY(wxCoord y)
    wxCoord LogicalToDeviceYRel(wxCoord y)
    wxCoord MaxX()
    wxCoord MaxY()
    wxCoord MinX()
    wxCoord MinY()
    bool Ok()
    void ResetBoundingBox()
    void SetAxisOrientation(bool xLeftRight, bool yBottomUp)
    void SetBackground(const wxBrush& brush)
    void SetBackgroundMode(int mode)
    void SetBrush(const wxBrush& brush)
    void SetClippingRegion(wxCoord x, wxCoord y, wxCoord width, wxCoord height)
    void SetClippingRegion(const wxRegion& region)
    //void SetClippingRegion(const wxPoint& pt, const wxSize& sz)
    //void SetClippingRegion(const wxRect& rect)
    void SetDeviceOrigin(wxCoord x, wxCoord y)
    void SetFont(const wxFont& font)
    %wxchkver_2_8 void SetLayoutDirection(wxLayoutDirection dir)
    void SetLogicalFunction(int function)
    void SetMapMode(int unit)
    void SetPalette(const wxPalette& palette)
    void SetPen(const wxPen& pen)
    void SetTextBackground(const wxColour& colour)
    void SetTextForeground(const wxColour& colour)
    void SetUserScale(double xScale, double yScale)
    bool StartDoc(const wxString& message)
    void StartPage()

%endclass

// ---------------------------------------------------------------------------
// wxMemoryDC

%include "wx/dcmemory.h"

%class %delete wxMemoryDC, wxDC

    wxMemoryDC()
    void SelectObject(wxBitmap& bitmap) // not const in >=2.8

    %wxchkver_2_8 virtual void SelectObjectAsSource(const wxBitmap& bmp)

%endclass

// ---------------------------------------------------------------------------
// wxWindowDC

%include "wx/dcclient.h"

%class %delete wxWindowDC, wxDC

    wxWindowDC(wxWindow* window)

%endclass

// ---------------------------------------------------------------------------
// wxClientDC

%include "wx/dcclient.h"

%class %delete wxClientDC, wxWindowDC

    wxClientDC(wxWindow* window)

%endclass

// ---------------------------------------------------------------------------
// wxPaintDC

%include "wx/dcclient.h"

%class %delete wxPaintDC, wxWindowDC // base ok as wxWindowDC since only some platforms have wxClientDC as base

    wxPaintDC(wxWindow* window)

%endclass

// ---------------------------------------------------------------------------
// wxScreenDC

%include "wx/dcscreen.h"

%class %delete wxScreenDC, wxDC

    wxScreenDC()

    static bool StartDrawingOnTop(wxWindow* window)
    static bool StartDrawingOnTop(wxRect* rect = NULL)
    static bool EndDrawingOnTop()

%endclass

// ---------------------------------------------------------------------------
// wxBufferedDC

%include "wx/dcbuffer.h"

%class %delete wxBufferedDC, wxMemoryDC

    wxBufferedDC()
    wxBufferedDC(wxDC *dc, const wxSize& area, int style = wxBUFFER_CLIENT_AREA)
    wxBufferedDC(wxDC *dc, wxBitmap& buffer, int style = wxBUFFER_CLIENT_AREA) // not const bitmap >= 2.8

    void Init(wxDC *dc, const wxSize& area, int style = wxBUFFER_CLIENT_AREA)
    void Init(wxDC *dc, wxBitmap& buffer, int style = wxBUFFER_CLIENT_AREA) // not const bitmap in >= 2.8

%endclass

// ---------------------------------------------------------------------------
// wxBufferedPaintDC

%include "wx/dcbuffer.h"

%class %delete wxBufferedPaintDC, wxBufferedDC

    wxBufferedPaintDC(wxWindow *window, int style = wxBUFFER_CLIENT_AREA)
    wxBufferedPaintDC(wxWindow *window, wxBitmap& buffer, int style = wxBUFFER_CLIENT_AREA) // not const bitmap in >= 2.8

%endclass

// ---------------------------------------------------------------------------
// wxAutoBufferedPaintDC

%include "wx/dcbuffer.h"

%if %wxchkver_2_8

%define wxALWAYS_NATIVE_DOUBLE_BUFFER

// This class is derived from a wxPaintDC if wxALWAYS_NATIVE_DOUBLE_BUFFER else wxBufferedPaintDC
// In fact in release mode it's only a #define to either

%class %delete wxAutoBufferedPaintDC, wxDC // base ok as wxDC since no need for others

    wxAutoBufferedPaintDC(wxWindow *window)

%endclass

%endif // %wxchkver_2_8

// ---------------------------------------------------------------------------
// wxMirrorDC

%include "wx/dcmirror.h"

%class %delete wxMirrorDC, wxDC

    wxMirrorDC(wxDC& dc, bool mirror)

%endclass

// ---------------------------------------------------------------------------
// wxDCClipper

%include "wx/dc.h"

%class %delete %noclassinfo %encapsulate wxDCClipper

    wxDCClipper(wxDC& dc, const wxRect& r)
    //wxDCClipper(wxDC& dc, const wxRegion& r)
    wxDCClipper(wxDC& dc, wxCoord x, wxCoord y, wxCoord w, wxCoord h)

%endclass

%endif //wxLUA_USE_wxDC

// ---------------------------------------------------------------------------
// wxCaret

%if wxLUA_USE_wxCaret && wxUSE_CARET

%include "wx/caret.h"

%class %delete %noclassinfo %encapsulate wxCaret

    wxCaret()
    wxCaret(wxWindow* window, const wxSize& size)
    wxCaret(wxWindow* window, int width, int height)

    bool Create(wxWindow* window, const wxSize& size)
    bool Create(wxWindow* window, int width, int height)
    static int GetBlinkTime()

    // %override [int x, int y] wxCaret::GetPositionXY()
    // C++ Func: void GetPosition(int *x, int *y)
    %rename GetPositionXY void GetPosition()

    wxPoint GetPosition()

    // %override [int x, int y] wxCaret::GetSizeWH()
    // C++ Func: void GetSize(int *x, int *y)
    %rename GetSizeWH void GetSize()

    wxSize GetSize()
    wxWindow *GetWindow()
    void Hide()
    bool IsOk()
    bool IsVisible()
    void Move(int x, int y)
    void Move(const wxPoint& pt)
    static void SetBlinkTime(int ms)
    void SetSize(int width, int height)
    void SetSize(const wxSize& size)
    void Show(bool show = true)

%endclass

// ---------------------------------------------------------------------------
// wxCaretSuspend

%include "wx/caret.h"

%class %delete %noclassinfo %encapsulate wxCaretSuspend

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxCaretSuspend(wxWindow *win = NULL)

%endclass

%endif //wxLUA_USE_wxCaret && wxUSE_CARET

// ---------------------------------------------------------------------------
// wxVideoMode

%if wxLUA_USE_wxDisplay && wxUSE_DISPLAY

%include "wx/display.h"

%class %delete %noclassinfo %encapsulate wxVideoMode

    %define_object wxDefaultVideoMode

    wxVideoMode(int width = 0, int height = 0, int depth = 0, int freq = 0)

    bool Matches(const wxVideoMode& other) const
    int GetWidth() const
    int GetHeight() const
    int GetDepth() const
    bool IsOk() const

    %operator bool operator==(const wxVideoMode& v) const

%endclass

// ---------------------------------------------------------------------------
// wxArrayVideoModes

%class %delete %noclassinfo %encapsulate wxArrayVideoModes

    wxArrayVideoModes()
    wxArrayVideoModes(const wxArrayVideoModes& array)

    void Add(const wxVideoMode& vm, size_t copies = 1)
    void Alloc(size_t nCount)
    void Clear()
    void Empty()
    int GetCount() const
    void Insert(const wxVideoMode& vm, int nIndex, size_t copies = 1)
    bool IsEmpty()
    wxVideoMode Item(size_t nIndex) const
    wxVideoMode Last()
    void RemoveAt(size_t nIndex, size_t count = 1)
    void Shrink()

    %operator wxVideoMode& operator[](size_t nIndex)

%endclass

// ---------------------------------------------------------------------------
// wxDisplay

%class %delete %noclassinfo %encapsulate wxDisplay

    wxDisplay(size_t index = 0)

    bool ChangeMode(const wxVideoMode& mode = wxDefaultVideoMode)
    static size_t GetCount()
    wxVideoMode GetCurrentMode() const
    // int GetDepth() const // in docs BUT not in C++ header
    static int GetFromPoint(const wxPoint& pt)
    %wxchkver_2_8|!%gtk static int GetFromWindow(wxWindow* win)
    wxRect GetGeometry() const
    %wxchkver_2_8 wxRect GetClientArea() const
    wxArrayVideoModes GetModes(const wxVideoMode& mode = wxDefaultVideoMode) const
    wxString GetName() const
    bool IsOk() const
    bool IsPrimary()

%endclass

%endif //wxLUA_USE_wxDisplay && wxUSE_DISPLAY

// ---------------------------------------------------------------------------
// wxEffects

%include "wx/effects.h"

%class %delete wxEffects, wxObject

    wxEffects() // use system default colours
    wxEffects(const wxColour& highlightColour, const wxColour& lightShadow, const wxColour& faceColour, const wxColour& mediumShadow, const wxColour& darkShadow)

    wxColour GetHighlightColour() const
    wxColour GetLightShadow() const
    wxColour GetFaceColour() const
    wxColour GetMediumShadow() const
    wxColour GetDarkShadow() const

    void SetHighlightColour(const wxColour& c)
    void SetLightShadow(const wxColour& c)
    void SetFaceColour(const wxColour& c)
    void SetMediumShadow(const wxColour& c)
    void SetDarkShadow(const wxColour& c)

    void Set(const wxColour& highlightColour, const wxColour& lightShadow, const wxColour& faceColour, const wxColour& mediumShadow, const wxColour& darkShadow)

    void DrawSunkenEdge(wxDC& dc, const wxRect& rect, int borderSize = 1)
    bool TileBitmap(const wxRect& rect, wxDC& dc, wxBitmap& bitmap)

%endclass

// ---------------------------------------------------------------------------
// wxRenderer

%if wxLUA_USE_wxRenderer

%include "wx/renderer.h"

%wxHAS_NATIVE_RENDERER %define wxHAS_NATIVE_RENDERER 1

%enum

    wxCONTROL_DISABLED //= 0x00000001, // control is disabled
    wxCONTROL_FOCUSED //= 0x00000002, // currently has keyboard focus
    wxCONTROL_PRESSED //= 0x00000004, // (button) is pressed
    wxCONTROL_SPECIAL //= 0x00000008, // control-specific bit:
    wxCONTROL_ISDEFAULT //= wxCONTROL_SPECIAL, // only for the buttons
    wxCONTROL_ISSUBMENU //= wxCONTROL_SPECIAL, // only for the menu items
    wxCONTROL_EXPANDED //= wxCONTROL_SPECIAL, // only for the tree items
    wxCONTROL_SIZEGRIP //= wxCONTROL_SPECIAL, // only for the status bar panes
    wxCONTROL_CURRENT //= 0x00000010, // mouse is currently over the control
    wxCONTROL_SELECTED //= 0x00000020, // selected item in e.g. listbox
    wxCONTROL_CHECKED //= 0x00000040, // (check/radio button) is checked
    wxCONTROL_CHECKABLE //= 0x00000080, // (menu) item can be checked
    wxCONTROL_UNDETERMINED //= wxCONTROL_CHECKABLE, // (check) undetermined state

    wxCONTROL_FLAGS_MASK //= 0x000000ff,

    // this is a pseudo flag not used directly by wxRenderer but rather by some
    // controls internally
    wxCONTROL_DIRTY //= 0x80000000

%endenum

%struct %delete %encapsulate wxSplitterRenderParams

    // the only way to initialize this struct is by using this ctor
    wxSplitterRenderParams(wxCoord widthSash_, wxCoord border_, bool isSens_)

    %member const wxCoord widthSash // the width of the splitter sash
    %member const wxCoord border // the width of the border of the splitter window
    %member const bool isHotSensitive // true if the splitter changes its appearance when the mouse is over it

%endstruct


// extra optional parameters for DrawHeaderButton
%struct %delete %encapsulate wxHeaderButtonParams

    wxHeaderButtonParams()

    %member wxColour m_arrowColour;
    %member wxColour m_selectionColour;
    %member wxString m_labelText;
    %member wxFont m_labelFont;
    %member wxColour m_labelColour;
    %member wxBitmap m_labelBitmap;
    %member int m_labelAlignment;

%endstruct

%enum wxHeaderSortIconType

    wxHDR_SORT_ICON_NONE, // Header button has no sort arrow
    wxHDR_SORT_ICON_UP, // Header button an an up sort arrow icon
    wxHDR_SORT_ICON_DOWN // Header button an a down sort arrow icon

%endenum

// the current version and age of wxRendererNative interface: different
// versions are incompatible (in both ways) while the ages inside the same
// version are upwards compatible, i.e. the version of the renderer must
// match the version of the main program exactly while the age may be
// highergreater or equal to it
%enum wxRendererVersion::dummy

    Current_Version //= 1,
    Current_Age //= 5

%endenum

// wxRendererNative interface version
%struct %delete %encapsulate wxRendererVersion

    wxRendererVersion(int version_, int age_)

    // check if the given version is compatible with the current one
    static bool IsCompatible(const wxRendererVersion& ver)

    %member const int version;
    %member const int age;

%endstruct


%class %delete %noclassinfo %encapsulate wxRendererNative

    // pseudo constructors
    // -------------------
    // return the currently used renderer
    static wxRendererNative& Get();
    // return the generic implementation of the renderer
    static wxRendererNative& GetGeneric();
    // return the default (native) implementation for this platform
    static wxRendererNative& GetDefault();


    // draw the header control button (used by wxListCtrl) Returns optimal
    // width for the label contents.
    virtual int DrawHeaderButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0, wxHeaderSortIconType sortArrow = wxHDR_SORT_ICON_NONE, wxHeaderButtonParams* params=NULL) //= 0;

    // Draw the contents of a header control button (label, sort arrows, etc.)
    // Normally only called by DrawHeaderButton.
    virtual int DrawHeaderButtonContents(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0, wxHeaderSortIconType sortArrow = wxHDR_SORT_ICON_NONE, wxHeaderButtonParams* params=NULL) //= 0;

    // Returns the default height of a header button, either a fixed platform
    // height if available, or a generic height based on the window's font.
    virtual int GetHeaderButtonHeight(wxWindow *win) //= 0;

    // draw the expanded/collapsed icon for a tree control item
    virtual void DrawTreeItemButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // draw the border for sash window: this border must be such that the sash
    // drawn by DrawSash() blends into it well
    virtual void DrawSplitterBorder(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // draw a (vertical) sash
    virtual void DrawSplitterSash(wxWindow *win, wxDC& dc, const wxSize& size, wxCoord position, wxOrientation orient, int flags = 0) //= 0;

    // draw a combobox dropdown button
    // flags may use wxCONTROL_PRESSED and wxCONTROL_CURRENT
    virtual void DrawComboBoxDropButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // draw a dropdown arrow
    // flags may use wxCONTROL_PRESSED and wxCONTROL_CURRENT
    virtual void DrawDropArrow(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // draw check button
    // flags may use wxCONTROL_CHECKED, wxCONTROL_UNDETERMINED and wxCONTROL_CURRENT
    virtual void DrawCheckBox(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // draw blank button
    // flags may use wxCONTROL_PRESSED, wxCONTROL_CURRENT and wxCONTROL_ISDEFAULT
    virtual void DrawPushButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // draw rectangle indicating that an item in e.g. a list control has been selected or focused
    // flags may use
    // wxCONTROL_SELECTED (item is selected, e.g. draw background)
    // wxCONTROL_CURRENT (item is the current item, e.g. dotted border)
    // wxCONTROL_FOCUSED (the whole control has focus, e.g. blue background vs. grey otherwise)
    virtual void DrawItemSelectionRect(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0) //= 0;

    // geometry functions
    // ------------------

    // get the splitter parameters: the x field of the returned point is the
    // sash width and the y field is the border width
    virtual wxSplitterRenderParams GetSplitterParams(const wxWindow *win) //= 0;

    // changing the global renderer
    // ----------------------------

    %if wxUSE_DYNLIB_CLASS
    // load the renderer from the specified DLL, the returned pointer must be
    // deleted by caller if not NULL when it is not used any more
    static %gc wxRendererNative *Load(const wxString& name);
    %endif // wxUSE_DYNLIB_CLASS

    // set the renderer to use, passing NULL reverts to using the default
    // renderer
    //
    // return the previous renderer used with Set() or NULL if none
    static %gc wxRendererNative *Set(%ungc wxRendererNative *renderer);

    // this function is used for version checking: Load() refuses to load any
    // DLLs implementing an older or incompatible version; it should be
    // implemented simply by returning wxRendererVersion::Current_XXX values
    virtual wxRendererVersion GetVersion() const //= 0;

%endclass

%endif // wxLUA_USE_wxRenderer

wxwidgets/wxcore_geometry.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxPoint2DInt, wxRect2DInt and other classes from wx/geometry.h
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_Geometry && wxUSE_GEOMETRY

%typedef int wxInt32
%typedef double wxDouble

%enum wxOutCode

    wxInside
    wxOutLeft
    wxOutRight
    wxOutTop
    wxOutBottom

%endenum

// ---------------------------------------------------------------------------
// wxPoint2DInt

%include "wx/geometry.h"
%class %delete %noclassinfo %encapsulate wxPoint2DInt

    //wxPoint2DInt()
    wxPoint2DInt( wxInt32 x=0, wxInt32 y=0 )
    wxPoint2DInt( const wxPoint2DInt &pt )
    wxPoint2DInt( const wxPoint &pt )

    //void GetFloor( wxInt32 *x , wxInt32 *y ) const
    //void GetRounded( wxInt32 *x , wxInt32 *y ) const
    wxDouble GetVectorLength() const
    wxDouble GetVectorAngle() const
    void SetVectorLength( wxDouble length )
    void SetVectorAngle( wxDouble degrees )
    //void SetPolarCoordinates( wxInt32 angle, wxInt32 length ) - no function body in wxWidgets
    void Normalize()
    wxDouble GetDistance( const wxPoint2DInt &pt ) const
    wxDouble GetDistanceSquare( const wxPoint2DInt &pt ) const
    wxInt32 GetDotProduct( const wxPoint2DInt &vec ) const
    wxInt32 GetCrossProduct( const wxPoint2DInt &vec ) const

    //void WriteTo( wxDataOutputStream &stream ) const
    //void ReadFrom( wxDataInputStream &stream )

    %rename X %member_func wxInt32 m_x
    %rename Y %member_func wxInt32 m_y

    %operator wxPoint2DInt operator-()
    %operator wxPoint2DInt& operator=(const wxPoint2DInt& pt)
    %operator wxPoint2DInt& operator+=(const wxPoint2DInt& pt)
    %operator wxPoint2DInt& operator-=(const wxPoint2DInt& pt)
    %operator wxPoint2DInt& operator*=(const wxPoint2DInt& pt)
    //wxPoint2DInt& operator*=(wxDouble n) - no function body in wxWidgets
    //wxPoint2DInt& operator*=(wxInt32 n) - no function body in wxWidgets
    %operator wxPoint2DInt& operator/=(const wxPoint2DInt& pt)
    //wxPoint2DInt& operator/=(wxDouble n) - no function body in wxWidgets
    //wxPoint2DInt& operator/=(wxInt32 n) - no function body in wxWidgets
    //operator wxPoint() const
    %operator bool operator==(const wxPoint2DInt& pt) const
    //bool operator!=(const wxPoint2DInt& pt) const

    %operator wxPoint2DInt operator*(wxInt32 n)

%endclass

// ---------------------------------------------------------------------------
// wxPoint2DDouble

%include "wx/geometry.h"
%class %delete %noclassinfo %encapsulate wxPoint2DDouble

    //wxPoint2DDouble()
    wxPoint2DDouble( wxDouble x=0, wxDouble y=0 )
    wxPoint2DDouble( const wxPoint2DDouble &pt )
    wxPoint2DDouble( const wxPoint2DInt &pt )
    wxPoint2DDouble( const wxPoint &pt )

    //void GetFloor( wxInt32 *x , wxInt32 *y ) const
    //void GetRounded( wxInt32 *x , wxInt32 *y ) const
    wxDouble GetVectorLength() const
    wxDouble GetVectorAngle() const
    void SetVectorLength( wxDouble length )
    void SetVectorAngle( wxDouble degrees )
    //void SetPolarCoordinates( wxDouble angle, wxDouble length ) - no function body in wxWidgets
    //void Normalize() - no function body in wxWidgets
    wxDouble GetDistance( const wxPoint2DDouble &pt ) const
    wxDouble GetDistanceSquare( const wxPoint2DDouble &pt ) const
    wxDouble GetDotProduct( const wxPoint2DDouble &vec ) const
    wxDouble GetCrossProduct( const wxPoint2DDouble &vec ) const

    %rename X %member_func wxDouble m_x
    %rename Y %member_func wxDouble m_y

    %operator wxPoint2DDouble operator-()
    %operator wxPoint2DDouble& operator=(const wxPoint2DDouble& pt)
    %operator wxPoint2DDouble& operator+=(const wxPoint2DDouble& pt)
    %operator wxPoint2DDouble& operator-=(const wxPoint2DDouble& pt)
    %operator wxPoint2DDouble& operator*=(const wxPoint2DDouble& pt)
    //wxPoint2DDouble& operator*=(wxDouble n)
    //wxPoint2DDouble& operator*=(wxInt32 n)
    %operator wxPoint2DDouble& operator/=(const wxPoint2DDouble& pt)
    //wxPoint2DDouble& operator/=(wxDouble n)
    //wxPoint2DDouble& operator/=(wxInt32 n)
    %operator bool operator==(const wxPoint2DDouble& pt) const
    //bool operator!=(const wxPoint2DDouble& pt) const

%endclass

// ---------------------------------------------------------------------------
// wxRect2DDouble

%include "wx/geometry.h"
%class %delete %noclassinfo %encapsulate wxRect2DDouble

    //wxRect2DDouble()
    wxRect2DDouble(wxDouble x=0, wxDouble y=0, wxDouble w=0, wxDouble h=0)
    wxRect2DDouble(const wxRect2DDouble& rect)

    wxPoint2DDouble GetPosition()
    wxSize GetSize()
    wxDouble GetLeft() const
    void SetLeft( wxDouble n )
    void MoveLeftTo( wxDouble n )
    wxDouble GetTop() const
    void SetTop( wxDouble n )
    void MoveTopTo( wxDouble n )
    wxDouble GetBottom() const
    void SetBottom( wxDouble n )
    void MoveBottomTo( wxDouble n )
    wxDouble GetRight() const
    void SetRight( wxDouble n )
    void MoveRightTo( wxDouble n )
    wxPoint2DDouble GetLeftTop() const
    void SetLeftTop( const wxPoint2DDouble &pt )
    void MoveLeftTopTo( const wxPoint2DDouble &pt )
    wxPoint2DDouble GetLeftBottom() const
    void SetLeftBottom( const wxPoint2DDouble &pt )
    void MoveLeftBottomTo( const wxPoint2DDouble &pt )
    wxPoint2DDouble GetRightTop() const
    void SetRightTop( const wxPoint2DDouble &pt )
    void MoveRightTopTo( const wxPoint2DDouble &pt )
    wxPoint2DDouble GetRightBottom() const
    void SetRightBottom( const wxPoint2DDouble &pt )
    void MoveRightBottomTo( const wxPoint2DDouble &pt )
    wxPoint2DDouble GetCentre() const
    void SetCentre( const wxPoint2DDouble &pt )
    void MoveCentreTo( const wxPoint2DDouble &pt )
    wxOutCode GetOutCode( const wxPoint2DDouble &pt ) const
    bool Contains( const wxPoint2DDouble &pt ) const
    bool Contains( const wxRect2DDouble &rect ) const
    bool IsEmpty() const
    bool HaveEqualSize( const wxRect2DDouble &rect ) const
    //void Inset( wxDouble x, wxDouble y )
    void Inset( wxDouble left, wxDouble top, wxDouble right, wxDouble bottom )
    void Offset( const wxPoint2DDouble &pt )
    void ConstrainTo( const wxRect2DDouble &rect )
    wxPoint2DDouble Interpolate( wxInt32 widthfactor , wxInt32 heightfactor )
    //static void Intersect( const wxRect2DDouble &src1 , const wxRect2DDouble &src2 , wxRect2DDouble *dest )
    void Intersect( const wxRect2DDouble &otherRect )
    wxRect2DDouble CreateIntersection( const wxRect2DDouble &otherRect ) const
    bool Intersects( const wxRect2DDouble &rect ) const
    //static void Union( const wxRect2DDouble &src1 , const wxRect2DDouble &src2 , wxRect2DDouble *dest )
    void Union( const wxRect2DDouble &otherRect )
    void Union( const wxPoint2DDouble &pt )
    wxRect2DDouble CreateUnion( const wxRect2DDouble &otherRect ) const
    void Scale( wxDouble f )
    //void Scale( wxInt32 num , wxInt32 denum )

    %rename X %member_func wxDouble m_x
    %rename Y %member_func wxDouble m_y
    %rename Width %member_func wxDouble m_width
    %rename Height %member_func wxDouble m_height

    //wxRect2DDouble& operator = (const wxRect2DDouble& rect) - use copy constructor
    %operator bool operator==(const wxRect2DDouble& rect)
    //bool operator != (const wxRect2DDouble& rect) const

%endclass

// ---------------------------------------------------------------------------
// wxRect2DInt

%include "wx/geometry.h"
%class %delete %noclassinfo %encapsulate wxRect2DInt

    //wxRect2DInt()
    wxRect2DInt(wxInt32 x=0, wxInt32 y=0, wxInt32 w=0, wxInt32 h=0)
    wxRect2DInt(const wxRect2DInt& rect)
    wxRect2DInt( const wxRect& r )
    wxRect2DInt(const wxPoint2DInt& topLeft, const wxPoint2DInt& bottomRight)
    wxRect2DInt(const wxPoint2DInt& pos, const wxSize& size)

    wxPoint2DInt GetPosition()
    wxSize GetSize()
    wxInt32 GetLeft() const
    void SetLeft( wxInt32 n )
    void MoveLeftTo( wxInt32 n )
    wxInt32 GetTop() const
    void SetTop( wxInt32 n )
    void MoveTopTo( wxInt32 n )
    wxInt32 GetBottom() const
    void SetBottom( wxInt32 n )
    void MoveBottomTo( wxInt32 n )
    wxInt32 GetRight() const
    void SetRight( wxInt32 n )
    void MoveRightTo( wxInt32 n )
    wxPoint2DInt GetLeftTop() const
    void SetLeftTop( const wxPoint2DInt &pt )
    void MoveLeftTopTo( const wxPoint2DInt &pt )
    wxPoint2DInt GetLeftBottom() const
    void SetLeftBottom( const wxPoint2DInt &pt )
    void MoveLeftBottomTo( const wxPoint2DInt &pt )
    wxPoint2DInt GetRightTop() const
    void SetRightTop( const wxPoint2DInt &pt )
    void MoveRightTopTo( const wxPoint2DInt &pt )
    wxPoint2DInt GetRightBottom() const
    void SetRightBottom( const wxPoint2DInt &pt )
    void MoveRightBottomTo( const wxPoint2DInt &pt )
    wxPoint2DInt GetCentre() const
    void SetCentre( const wxPoint2DInt &pt )
    void MoveCentreTo( const wxPoint2DInt &pt )
    wxOutCode GetOutCode( const wxPoint2DInt &pt ) const
    bool Contains( const wxPoint2DInt &pt ) const
    bool Contains( const wxRect2DInt &rect ) const
    bool IsEmpty() const
    bool HaveEqualSize( const wxRect2DInt &rect ) const
    //void Inset( wxInt32 x , wxInt32 y )
    void Inset( wxInt32 left, wxInt32 top, wxInt32 right, wxInt32 bottom )
    void Offset( const wxPoint2DInt &pt )
    void ConstrainTo( const wxRect2DInt &rect )
    wxPoint2DInt Interpolate( wxInt32 widthfactor , wxInt32 heightfactor )
    //static void Intersect( const wxRect2DInt &src1 , const wxRect2DInt &src2 , wxRect2DInt *dest )
    void Intersect( const wxRect2DInt &otherRect )
    wxRect2DInt CreateIntersection( const wxRect2DInt &otherRect ) const
    bool Intersects( const wxRect2DInt &rect ) const
    //static void Union( const wxRect2DInt &src1 , const wxRect2DInt &src2 , wxRect2DInt *dest )
    void Union( const wxRect2DInt &otherRect )
    void Union( const wxPoint2DInt &pt )
    wxRect2DInt CreateUnion( const wxRect2DInt &otherRect ) const
    void Scale( wxInt32 f )
    //void Scale( wxInt32 num , wxInt32 denum )

    //void WriteTo( wxDataOutputStream &stream ) const
    //void ReadFrom( wxDataInputStream &stream )

    %rename X %member_func wxInt32 m_x
    %rename Y %member_func wxInt32 m_y
    %rename Width %member_func wxInt32 m_width
    %rename Height %member_func wxInt32 m_height

    //wxRect2DInt& operator = (const wxRect2DInt& rect) - use copy constructor
    %operator bool operator == (const wxRect2DInt& rect) const
    //bool operator != (const wxRect2DInt& rect) const

%endclass

// ---------------------------------------------------------------------------
// wxTransform2D - an abstract class

//%include "wx/geometry.h"
//%class %delete %noclassinfo %encapsulate wxTransform2D
// virtual void Transform( wxPoint2DInt* pt )const = 0
// virtual void Transform( wxRect2DInt* r ) const
// virtual wxPoint2DInt Transform( const wxPoint2DInt &pt ) const
// virtual wxRect2DInt Transform( const wxRect2DInt &r ) const
// virtual void InverseTransform( wxPoint2DInt* pt ) const = 0
// virtual void InverseTransform( wxRect2DInt* r ) const
// virtual wxPoint2DInt InverseTransform( const wxPoint2DInt &pt ) const
// virtual wxRect2DInt InverseTransform( const wxRect2DInt &r ) const
// void wxTransform2D::Transform( wxRect2DInt* r ) const
// wxPoint2DInt wxTransform2D::Transform( const wxPoint2DInt &pt ) const
// wxRect2DInt wxTransform2D::Transform( const wxRect2DInt &r ) const
// void wxTransform2D::InverseTransform( wxRect2DInt* r ) const
// wxPoint2DInt wxTransform2D::InverseTransform( const wxPoint2DInt &pt ) const
// wxRect2DInt wxTransform2D::InverseTransform( const wxRect2DInt &r ) const
//%endclass

%endif //wxLUA_USE_Geometry && wxUSE_GEOMETRY

wxwidgets/wxcore_help.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxHelpController and help related classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// See wxhtml_html.i for wxHtmlHelp classes


// ---------------------------------------------------------------------------
// wxContextHelp

%if wxLUA_USE_wxHelpController && wxUSE_HELP

%include "wx/cshelp.h"

%class %delete wxContextHelp, wxObject

    wxContextHelp(wxWindow* win = NULL, bool beginHelp = true)

    bool BeginContextHelp(wxWindow* win)
    bool EndContextHelp()

    //bool EventLoop()
    //bool DispatchEvent(wxWindow* win, const wxPoint& pt)
    //void SetStatus(bool status)

%endclass

// ---------------------------------------------------------------------------
// wxContextHelpButton

%if wxLUA_USE_wxBitmapButton && wxUSE_BMPBUTTON

%include "wx/cshelp.h"

%class wxContextHelpButton, wxBitmapButton

    wxContextHelpButton(wxWindow* parent, wxWindowID id = wxID_CONTEXT_HELP, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxBU_AUTODRAW)

    //void OnContextHelp(wxCommandEvent& event)

%endclass

%endif //wxLUA_USE_wxBitmapButton && wxUSE_BMPBUTTON

// ---------------------------------------------------------------------------
// wxHelpProvider

%class %delete %noclassinfo %encapsulate wxHelpProvider

    // No constructor see wxSimpleHelpProvider

    // Note that the wxHelpProviderModule will delete the set wxHelpProvider
    // so you do not have to delete() it when the program exits. However,
    // if you set a different wxHelpProvider you must delete() the previous one.
    static %gc wxHelpProvider *Set(%ungc wxHelpProvider *helpProvider)
    static wxHelpProvider *Get()
    virtual wxString GetHelp(const wxWindow *window) // pure virtual
    %wxchkver_2_8 virtual bool ShowHelpAtPoint(wxWindow *window, const wxPoint& pt, wxHelpEvent::Origin origin)
    virtual bool ShowHelp(wxWindow *window)
    virtual void AddHelp(wxWindow *window, const wxString& text)
    //virtual void AddHelp(wxWindowID id, const wxString& text)
    virtual void RemoveHelp(wxWindow* window)

%endclass

// ---------------------------------------------------------------------------
// wxSimpleHelpProvider

%class %delete %noclassinfo %encapsulate wxSimpleHelpProvider, wxHelpProvider

    wxSimpleHelpProvider()

%endclass

// ---------------------------------------------------------------------------
// wxHelpControllerHelpProvider

%class %delete %noclassinfo %encapsulate wxHelpControllerHelpProvider, wxSimpleHelpProvider

    wxHelpControllerHelpProvider(wxHelpController* hc = NULL)

    // The wxHelpController you set must exist for the life of this.
    // And this will not delete() it when done.
    void SetHelpController(wxHelpController* hc)
    wxHelpController* GetHelpController() const

%endclass

%endif //wxLUA_USE_wxHelpController && wxUSE_HELP


// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// wxHelpControllerBase and derived help controller classes

%if wxLUA_USE_wxHelpController && wxUSE_HELP

%include "wx/help.h"

%define wxHELP_NETSCAPE // Flags for SetViewer

%enum wxHelpSearchMode

    wxHELP_SEARCH_INDEX
    wxHELP_SEARCH_ALL

%endenum

%class %delete wxHelpControllerBase, wxObject

    //wxHelpControllerBase() - base class no constructor

    virtual void Initialize(const wxString& file)
    // virtual void Initialize(const wxString& file, int server) - marked obsolete
    virtual bool DisplayBlock(long blockNo)
    virtual bool DisplayContents()
    virtual bool DisplayContextPopup(int contextId)
    virtual bool DisplaySection(int sectionNo)
    virtual bool DisplaySection(const wxString &section)
    virtual bool DisplayTextPopup(const wxString& text, const wxPoint& pos)

    // %override [wxFrame*, wxSize* size, wxPoint* pos, bool *newFrameEachTime] wxHelpControllerBase::GetFrameParameters()
    // C++ Func: virtual wxFrame* GetFrameParameters(wxSize* size = NULL, wxPoint* pos = NULL, bool *newFrameEachTime = NULL)
    virtual wxFrame* GetFrameParameters()

    %wxchkver_2_8 virtual wxWindow* GetParentWindow() const
    virtual bool KeywordSearch(const wxString& keyWord, wxHelpSearchMode mode = wxHELP_SEARCH_ALL)
    virtual bool LoadFile(const wxString& file = "")
    //virtual bool OnQuit()
    virtual void SetFrameParameters(const wxString& title, const wxSize& size, const wxPoint& pos = wxDefaultPosition, bool newFrameEachTime = false)
    %wxchkver_2_8 virtual void SetParentWindow(wxWindow* win)
    virtual void SetViewer(const wxString& viewer, long flags)
    virtual bool Quit()

%endclass

// ---------------------------------------------------------------------------
// wxHelpController - wxWidgets #defines it appropriately per platform

%class %delete wxHelpController, wxHelpControllerBase

    wxHelpController()
    //%wxchkver_2_8 wxHelpController(wxWindow* parentWindow = NULL) wxHTMLHelpController takes different params

%endclass

// ---------------------------------------------------------------------------
// wxWinHelpController

%if %msw

%include "wx/helpwin.h"

%class %delete wxWinHelpController, wxHelpControllerBase

    wxWinHelpController()

%endclass

%endif //%msw

// ---------------------------------------------------------------------------
// wxCHMHelpController

//%class %delete wxCHMHelpController, wxHelpControllerBase
//%include "wx/msw/helpchm.h"
//wxCHMHelpController()
//%endclass

// ---------------------------------------------------------------------------
// wxBestHelpController

%if %msw

%include "wx/msw/helpbest.h"

%class %delete wxBestHelpController, wxHelpControllerBase

    wxBestHelpController(wxWindow* parentWindow = NULL, int style = wxHF_DEFAULT_STYLE)

%endclass

%endif //%msw

// ---------------------------------------------------------------------------
// wxExtHelpController

%if !%win

%include "wx/generic/helpext.h"

%class %delete wxExtHelpController, wxHelpControllerBase

    wxExtHelpController()

%endclass

%endif //!%win

%endif //wxLUA_USE_wxHelpController && wxUSE_HELP

wxwidgets/wxcore_image.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxImage
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================


%define wxIMAGE_ALPHA_TRANSPARENT
%define wxIMAGE_ALPHA_THRESHOLD
%define wxIMAGE_ALPHA_OPAQUE

%enum wxBitmapType

    wxBITMAP_TYPE_INVALID
    wxBITMAP_TYPE_BMP
    wxBITMAP_TYPE_BMP_RESOURCE
    wxBITMAP_TYPE_RESOURCE
    wxBITMAP_TYPE_ICO
    wxBITMAP_TYPE_ICO_RESOURCE
    wxBITMAP_TYPE_CUR
    wxBITMAP_TYPE_CUR_RESOURCE
    wxBITMAP_TYPE_XBM
    wxBITMAP_TYPE_XBM_DATA
    wxBITMAP_TYPE_XPM
    wxBITMAP_TYPE_XPM_DATA
    wxBITMAP_TYPE_TIF
    wxBITMAP_TYPE_TIF_RESOURCE
    wxBITMAP_TYPE_GIF
    wxBITMAP_TYPE_GIF_RESOURCE
    wxBITMAP_TYPE_PNG
    wxBITMAP_TYPE_PNG_RESOURCE
    wxBITMAP_TYPE_JPEG
    wxBITMAP_TYPE_JPEG_RESOURCE
    wxBITMAP_TYPE_PNM
    wxBITMAP_TYPE_PNM_RESOURCE
    wxBITMAP_TYPE_PCX
    wxBITMAP_TYPE_PCX_RESOURCE
    wxBITMAP_TYPE_PICT
    wxBITMAP_TYPE_PICT_RESOURCE
    wxBITMAP_TYPE_ICON
    wxBITMAP_TYPE_ICON_RESOURCE
    wxBITMAP_TYPE_ANI
    wxBITMAP_TYPE_IFF
    %wxchkver_2_8 wxBITMAP_TYPE_TGA
    wxBITMAP_TYPE_MACCURSOR
    wxBITMAP_TYPE_MACCURSOR_RESOURCE
    wxBITMAP_TYPE_ANY

%endenum

// ---------------------------------------------------------------------------
// wxImage

%if wxLUA_USE_wxImage && wxUSE_IMAGE

%include "wx/image.h"

%wxchkver_2_6 %define_string wxIMAGE_OPTION_CUR_HOTSPOT_X
%wxchkver_2_6 %define_string wxIMAGE_OPTION_CUR_HOTSPOT_Y

//%define_string wxIMAGE_OPTION_PNG_FORMAT see wxPNGHandler
//%define_string wxIMAGE_OPTION_PNG_BITDEPTH see wxPNGHandler
//%define_string wxIMAGE_OPTION_BMP_FORMAT see wxBMPHandler

%define_string wxIMAGE_OPTION_QUALITY _T("quality")
%define_string wxIMAGE_OPTION_FILENAME _T("FileName")

%define_string wxIMAGE_OPTION_RESOLUTION _T("Resolution")
%define_string wxIMAGE_OPTION_RESOLUTIONX _T("ResolutionX")
%define_string wxIMAGE_OPTION_RESOLUTIONY _T("ResolutionY")
%define_string wxIMAGE_OPTION_RESOLUTIONUNIT _T("ResolutionUnit")

%enum

    // constants used with wxIMAGE_OPTION_RESOLUTIONUNIT
    wxIMAGE_RESOLUTION_INCHES
    wxIMAGE_RESOLUTION_CM

    // Constants for wxImage::Scale() for determining the level of quality
    %wxchkver_2_8 wxIMAGE_QUALITY_NORMAL
    %wxchkver_2_8 wxIMAGE_QUALITY_HIGH

%endenum

%class %delete wxImage, wxObject

    %define_object wxNullImage

    wxImage()
    wxImage(const wxImage& image)
    wxImage(int width, int height, bool clear=true)
    wxImage(const wxString& name, long type = wxBITMAP_TYPE_ANY)

    // %override wxImage(int width, int height, unsigned char* data, bool static_data = false)
    // C++ Func: wxImage(int width, int height, unsigned char* data, bool static_data = false)
    %override_name wxLua_wxImageFromData_constructor wxImage(int width, int height, unsigned char* data, bool static_data = false)

    // %override - wxLua provides this constructor
    %override_name wxLua_wxImageFromBitmap_constructor wxImage(const wxBitmap& bitmap)

    static void AddHandler(%ungc wxImageHandler* handler)
    %wxchkver_2_8 wxImage Blur(int radius)
    %wxchkver_2_8 wxImage BlurHorizontal(int radius)
    %wxchkver_2_8 wxImage BlurVertical(int radius)
    static void CleanUpHandlers()
    unsigned long ComputeHistogram(wxImageHistogram& histogram) const
    //wxBitmap ConvertToBitmap() const - deprecated use wxBitmap constructor
    %wxchkver_2_8 wxImage ConvertToGreyscale( double lr = 0.299, double lg = 0.587, double lb = 0.114 ) const
    wxImage ConvertToMono(unsigned char r, unsigned char g, unsigned char b) const
    wxImage Copy() const
    void Create(int width, int height, bool clear=true)
    void Destroy()

    // %override [bool, uchar r, uchar g, char b] wxImage::FindFirstUnusedColour(unsigned char startR = 1, unsigned char startG = 0, unsigned char startB = 0)
    // C++ Func: bool FindFirstUnusedColour(unsigned char* r, unsigned char* g, unsigned char* b, unsigned char startR = 1, unsigned char startG = 0, unsigned char startB = 0)
    bool FindFirstUnusedColour(unsigned char startR = 1, unsigned char startG = 0, unsigned char startB = 0)

    static wxImageHandler* FindHandler(const wxString& name)
    static wxImageHandler* FindHandler(const wxString& extension, long imageType)
    static wxImageHandler* FindHandler(long imageType)
    static wxImageHandler* FindHandlerMime(const wxString& mimetype)
    static wxString GetImageExtWildcard()
    unsigned char GetAlpha(int x, int y) const
    unsigned char GetBlue(int x, int y) const

    // %override [Lua string] wxImage::GetData() const
    // C++ Func: unsigned char* GetData() const
    unsigned char* GetData() const

    unsigned char GetGreen(int x, int y) const
    static int GetImageCount(const wxString& filename, long type = wxBITMAP_TYPE_ANY)
    static int GetImageCount(wxInputStream& stream, long type = wxBITMAP_TYPE_ANY)
    static wxList& GetHandlers()
    int GetHeight() const
    unsigned char GetMaskBlue() const
    unsigned char GetMaskGreen() const
    unsigned char GetMaskRed() const

    // %override [bool, uchar r, uchar g, uchar b] wxImage::GetOrFindMaskColour() const
    // C++ Func: bool GetOrFindMaskColour(unsigned char *r, unsigned char *g, unsigned char *b) const
    bool GetOrFindMaskColour() const

    wxPalette GetPalette() const
    unsigned char GetRed(int x, int y) const
    wxImage GetSubImage(const wxRect& rect) const
    int GetWidth() const

    // note: we're tricking generator to not gag on RGB/HSVValue, so pretend to return an int
    // %override [uchar r, uchar g, uchar b] wxImage::HSVtoRGB(double h, double s, double v)
    // C++ Func: static RGBValue HSVtoRGB(const HSVValue& hsv)
    static int HSVtoRGB(double h, double s, double v)

    // %override [double h, double s, double v] wxImage::RGBtoHSV(unsigned char r, unsigned char g, unsigned char b)
    // C++ Func: static HSVValue RGBtoHSV(const RGBValue& rgb)
    static int RGBtoHSV(unsigned char r, unsigned char g, unsigned char b)

    bool HasAlpha() const
    bool HasMask() const
    wxString GetOption(const wxString &name) const
    int GetOptionInt(const wxString &name) const
    int HasOption(const wxString &name) const
    void InitAlpha()
    static void InitStandardHandlers()
    static void InsertHandler(%ungc wxImageHandler* handler)
    bool IsTransparent(int x, int y, unsigned char threshold = 128) const

    bool LoadFile(const wxString& name, long type = wxBITMAP_TYPE_ANY, int index = -1)
    bool LoadFile(const wxString& name, const wxString& mimetype, int index = -1)
    bool LoadFile(wxInputStream& stream, long type = wxBITMAP_TYPE_ANY, int index = -1)
    bool LoadFile(wxInputStream& stream, const wxString& mimetype, int index = -1)

    bool Ok() const
    static bool RemoveHandler(const wxString& name)
    wxImage Mirror(bool horizontally = true) const
    void Replace(unsigned char r1, unsigned char g1, unsigned char b1, unsigned char r2, unsigned char g2, unsigned char b2)
    %wxchkver_2_8 wxImage ResampleBox(int width, int height) const
    %wxchkver_2_8 wxImage ResampleBicubic(int width, int height) const
    !%wxchkver_2_8 wxImage& Rescale(int width, int height)
    %wxchkver_2_8 wxImage& Rescale( int width, int height, int quality = wxIMAGE_QUALITY_NORMAL )
    wxImage& Resize(const wxSize& size, const wxPoint& pos, int red = -1, int green = -1, int blue = -1)
    wxImage Rotate(double angle, const wxPoint& rotationCentre, bool interpolating = true, wxPoint* offsetAfterRotation = NULL)
    void RotateHue(double angle)
    wxImage Rotate90(bool clockwise = true) const
    bool SaveFile(const wxString& name)
    bool SaveFile(const wxString& name, int type)
    bool SaveFile(const wxString& name, const wxString& mimetype)
    !%wxchkver_2_8 wxImage Scale(int width, int height) const
    %wxchkver_2_8 wxImage Scale( int width, int height, int quality = wxIMAGE_QUALITY_NORMAL ) const
    wxImage Size(const wxSize& size, const wxPoint& pos, int red = -1, int green = -1, int blue = -1) const
    void SetAlpha(int x, int y, unsigned char alpha)

    // %override void wxImage::SetAlpha(Lua string) - copy contents of string to image
    // C++ Func: void SetAlpha(unsigned char *alpha = NULL,bool static_data = false)
    %override_name wxLua_wxImage_SetAlphaData void SetAlpha(const wxString& dataStr)

    // %override void wxImage::SetData(Lua string) - copy contents of string to image
    // C++ Func: void SetData(unsigned char *data)
    void SetData(const wxString& data)

    void SetMask(bool hasMask = true)
    void SetMaskColour(unsigned char red, unsigned char blue, unsigned char green)
    bool SetMaskFromImage(const wxImage& mask, unsigned char mr, unsigned char mg, unsigned char mb)
    void SetOption(const wxString &name, const wxString &value)
    void SetOption(const wxString &name, int value)
    void SetPalette(const wxPalette& palette)
    void SetRGB(int x, int y, unsigned char red, unsigned char green, unsigned char blue)
    void SetRGB(wxRect& rect, unsigned char red, unsigned char green, unsigned char blue)

    %operator wxImage& operator=(const wxImage& image)
    //%operator bool operator==(const wxImage& image) const // not in 2.8

%endclass

// ---------------------------------------------------------------------------
// wxImageHistogram

%class %delete %noclassinfo %encapsulate wxImageHistogramEntry

    wxImageHistogramEntry()
    %member unsigned long index // GetIndex() only, SetIndex(idx) is not allowed
    %member unsigned long value // GetValue() and SetValue(val)

%endclass

%class %delete %noclassinfo %encapsulate wxImageHistogram::iterator

    %member long first
    %member wxImageHistogramEntry second

    // operator used to compare with wxImageHistogram::end() iterator
    %operator bool operator==(const wxImageHistogram::iterator& other) const
    %operator wxImageHistogram::iterator& operator++()

%endclass

%class %delete %noclassinfo %encapsulate wxImageHistogram // wxImageHistogramBase actually a hash map

    wxImageHistogram()

    // get the key in the histogram for the given RGB values
    static unsigned long MakeKey(unsigned char r, unsigned char g, unsigned char b)

    // Use the function wxImage::FindFirstUnusedColour
    //bool FindFirstUnusedColour(unsigned char *r, unsigned char *g, unsigned char *b, unsigned char startR = 1, unsigned char startG = 0, unsigned char startB = 0 ) const

    // Selected functions from the base wxHashMap class
    const wxImageHistogram::iterator begin() const
    void clear()
    size_t count(long key) const
    bool empty() const
    const wxImageHistogram::iterator end() const
    size_t erase(long key)
    wxImageHistogram::iterator find(long key)
    //Insert_Result insert(const value_type& v)
    size_t size() const
    //mapped_type& operator[](const key_type& key)

%endclass

// ---------------------------------------------------------------------------
// wxQuantize

%include "wx/quantize.h"

%define wxQUANTIZE_INCLUDE_WINDOWS_COLOURS
%define wxQUANTIZE_RETURN_8BIT_DATA
%define wxQUANTIZE_FILL_DESTINATION_IMAGE

%class wxQuantize, wxObject

    // No constructor - all methods static

    // %override bool wxQuantize::Quantize(const wxImage& src, wxImage& dest, int desiredNoColours = 236, int flags = wxQUANTIZE_INCLUDE_WINDOWS_COLOURS|wxQUANTIZE_FILL_DESTINATION_IMAGE|wxQUANTIZE_RETURN_8BIT_DATA);
    // C++ Func: static bool Quantize(const wxImage& src, wxImage& dest, wxPalette** pPalette, int desiredNoColours = 236, unsigned char** eightBitData = 0, int flags = wxQUANTIZE_INCLUDE_WINDOWS_COLOURS|wxQUANTIZE_FILL_DESTINATION_IMAGE|wxQUANTIZE_RETURN_8BIT_DATA);
    static bool Quantize(const wxImage& src, wxImage& dest, int desiredNoColours = 236, int flags = wxQUANTIZE_INCLUDE_WINDOWS_COLOURS|wxQUANTIZE_FILL_DESTINATION_IMAGE|wxQUANTIZE_RETURN_8BIT_DATA);

    //static bool Quantize(const wxImage& src, wxImage& dest, int desiredNoColours = 236, unsigned char** eightBitData = 0, int flags = wxQUANTIZE_INCLUDE_WINDOWS_COLOURS|wxQUANTIZE_FILL_DESTINATION_IMAGE|wxQUANTIZE_RETURN_8BIT_DATA);
    //static void DoQuantize(unsigned w, unsigned h, unsigned char **in_rows, unsigned char **out_rows, unsigned char *palette, int desiredNoColours);

%endclass

// ---------------------------------------------------------------------------
// wxImageHandler and derived classes

%class %delete wxImageHandler, wxObject

    // no constructor - abstract class

    wxString GetName() const
    wxString GetExtension() const
    int GetImageCount(wxInputStream& stream)
    long GetType() const
    wxString GetMimeType() const
    bool LoadFile(wxImage* image, wxInputStream& stream, bool verbose=true, int index=0)
    bool SaveFile(wxImage* image, wxOutputStream& stream)
    void SetName(const wxString& name)
    void SetExtension(const wxString& extension)
    void SetMimeType(const wxString& mimetype)
    void SetType(long type)

%endclass

// ---------------------------------------------------------------------------
// wxBMPHandler and friends in imagbmp.h

%include "wx/imagbmp.h"

%enum

    wxBMP_24BPP
    //wxBMP_16BPP - remmed out in wxWidgets
    wxBMP_8BPP
    wxBMP_8BPP_GREY
    wxBMP_8BPP_GRAY
    wxBMP_8BPP_RED
    wxBMP_8BPP_PALETTE
    wxBMP_4BPP
    wxBMP_1BPP
    wxBMP_1BPP_BW

%endenum

%define_string wxIMAGE_OPTION_BMP_FORMAT _T("wxBMP_FORMAT") // wxString(_T("wxBMP_FORMAT"))

%class %delete wxBMPHandler, wxImageHandler

    wxBMPHandler()

%endclass

%if wxUSE_ICO_CUR

%class %delete wxICOHandler, wxBMPHandler

    wxICOHandler()

%endclass

%class %delete wxCURHandler, wxICOHandler

    wxCURHandler()

%endclass

%class %delete wxANIHandler, wxCURHandler

    wxANIHandler()

%endclass

%endif // wxUSE_ICO_CUR

// ---------------------------------------------------------------------------
// wxIFFHandler and friends in imagiff.h

%include "wx/imagiff.h"

%if wxUSE_IFF

%class %delete wxIFFHandler, wxImageHandler

    wxIFFHandler()

%endclass

%endif //wxUSE_IFF

// ---------------------------------------------------------------------------
// wxGIFHandler and friends in imaggif.h

%include "wx/imaggif.h"

%if wxUSE_GIF

%class %delete wxGIFHandler, wxImageHandler

    wxGIFHandler()

%endclass

%endif //wxUSE_GIF

// ---------------------------------------------------------------------------
// wxJPEGHandler and friends in imagjpeg.h

%include "wx/imagjpeg.h"

%if wxUSE_LIBJPEG

%class %delete wxJPEGHandler, wxImageHandler

    wxJPEGHandler()

%endclass

%endif //wxUSE_LIBJPEG

// ---------------------------------------------------------------------------
// wxPCXHandler and friends in imagpcx.h

%include "wx/imagpcx.h"

%if wxUSE_PCX

%class %delete wxPCXHandler, wxImageHandler

    wxPCXHandler()

%endclass

%endif //wxUSE_PCX

// ---------------------------------------------------------------------------
// wxPNGHandler and friends in imagpng.h

%include "wx/imagpng.h"

%if wxUSE_LIBPNG

%define_string wxIMAGE_OPTION_PNG_FORMAT // wxT("PngFormat")
%define_string wxIMAGE_OPTION_PNG_BITDEPTH // wxT("PngBitDepth")

%enum

    wxPNG_TYPE_COLOUR
    wxPNG_TYPE_GREY
    wxPNG_TYPE_GREY_RED

%endenum

%class %delete wxPNGHandler, wxImageHandler

    wxPNGHandler()

%endclass

%endif //wxUSE_LIBPNG

// ---------------------------------------------------------------------------
// wxPNMHandler and friends in imagpnm.h

%include "wx/imagpnm.h"

%if wxUSE_PNM

%class %delete wxPNMHandler, wxImageHandler

    wxPNMHandler()

%endclass

%endif //wxUSE_PNM

// ---------------------------------------------------------------------------
// wxTIFFHandler and friends in imagtiff.h

%include "wx/imagtiff.h"

%if wxUSE_LIBTIFF

%define_string wxIMAGE_OPTION_BITSPERSAMPLE _T("BitsPerSample")
%define_string wxIMAGE_OPTION_SAMPLESPERPIXEL _T("SamplesPerPixel")
%define_string wxIMAGE_OPTION_COMPRESSION _T("Compression")
%define_string wxIMAGE_OPTION_IMAGEDESCRIPTOR _T("ImageDescriptor")

%class %delete wxTIFFHandler, wxImageHandler

    wxTIFFHandler()

%endclass

%endif //wxUSE_LIBTIFF

// ---------------------------------------------------------------------------
// wxTGAHandler and friends in imagtga.h

%if %wxchkver_2_8 && wxUSE_TGA

%include "wx/imagtga.h"

%class %delete wxTGAHandler, wxImageHandler

    wxTGAHandler()

%endclass

%endif // %wxchkver_2_8 && wxUSE_TGA

// ---------------------------------------------------------------------------
// wxXPMHandler and friends in imagxpm.h

%include "wx/imagxpm.h"

%class %delete wxXPMHandler, wxImageHandler

    wxXPMHandler()

%endclass


%endif //wxLUA_USE_wxImage && wxUSE_IMAGE

// ---------------------------------------------------------------------------
// wxArtProvider and friends

%if wxLUA_USE_wxArtProvider

%include "wx/artprov.h"

//%typedef wxString wxArtClient Just treat these as wxStrings
//%typedef wxString wxArtID

// ----------------------------------------------------------------------------
// Art clients
// ----------------------------------------------------------------------------

%define_string wxART_TOOLBAR
%define_string wxART_MENU
%define_string wxART_FRAME_ICON

%define_string wxART_CMN_DIALOG
%define_string wxART_HELP_BROWSER
%define_string wxART_MESSAGE_BOX
%define_string wxART_BUTTON

%define_string wxART_OTHER

// ----------------------------------------------------------------------------
// Art IDs
// ----------------------------------------------------------------------------

%define_string wxART_ADD_BOOKMARK
%define_string wxART_DEL_BOOKMARK
%define_string wxART_HELP_SIDE_PANEL
%define_string wxART_HELP_SETTINGS
%define_string wxART_HELP_BOOK
%define_string wxART_HELP_FOLDER
%define_string wxART_HELP_PAGE
%define_string wxART_GO_BACK
%define_string wxART_GO_FORWARD
%define_string wxART_GO_UP
%define_string wxART_GO_DOWN
%define_string wxART_GO_TO_PARENT
%define_string wxART_GO_HOME
%define_string wxART_FILE_OPEN
%define_string wxART_FILE_SAVE
%define_string wxART_FILE_SAVE_AS
%define_string wxART_PRINT
%define_string wxART_HELP
%define_string wxART_TIP
%define_string wxART_REPORT_VIEW
%define_string wxART_LIST_VIEW
%define_string wxART_NEW_DIR
%define_string wxART_HARDDISK
%define_string wxART_FLOPPY
%define_string wxART_CDROM
%define_string wxART_REMOVABLE
%define_string wxART_FOLDER
%define_string wxART_FOLDER_OPEN
%define_string wxART_GO_DIR_UP
%define_string wxART_EXECUTABLE_FILE
%define_string wxART_NORMAL_FILE
%define_string wxART_TICK_MARK
%define_string wxART_CROSS_MARK
%define_string wxART_ERROR
%define_string wxART_QUESTION
%define_string wxART_WARNING
%define_string wxART_INFORMATION
%define_string wxART_MISSING_IMAGE
%define_string wxART_COPY
%define_string wxART_CUT
%define_string wxART_PASTE
%define_string wxART_DELETE
%define_string wxART_NEW

%define_string wxART_UNDO
%define_string wxART_REDO

%define_string wxART_QUIT

%define_string wxART_FIND
%define_string wxART_FIND_AND_REPLACE

%class wxArtProvider, wxObject

    // wxArtProvider() - abstract class

    %if %wxchkver_2_8
    static void Push(%ungc wxArtProvider *provider)
    static void Insert(%ungc wxArtProvider *provider)
    static bool Pop()
    static bool Remove(%gc wxArtProvider *provider) // FIXME - mem leak if not found
    static bool Delete(%ungc wxArtProvider *provider)
    %endif // %wxchkver_2_8

    //%if !%wxcompat_2_6
    //static void PushProvider(wxArtProvider *provider) FIXME add wxLuaArtProvider maybe?
    //static bool PopProvider()
    //static bool RemoveProvider(wxArtProvider *provider)
    //%endif // !%wxcompat_2_6

    static wxBitmap GetBitmap(const wxString& id, const wxString& client = wxART_OTHER, const wxSize& size = wxDefaultSize)
    static wxIcon GetIcon(const wxString& id, const wxString& client = wxART_OTHER, const wxSize& size = wxDefaultSize)
    static wxSize GetSizeHint(const wxString& client, bool platform_dependent = false)

%endclass

%class %delete wxLuaArtProvider, wxArtProvider

    // %override - the C++ function takes the wxLuaState as the first param
    wxLuaArtProvider()

    // virtual function that you can override in Lua.
    virtual wxSize DoGetSizeHint(const wxString& client) // { return GetSizeHint(client, true); }

    // virtual function that you can override in Lua.

    // Derived classes must override this method to create requested
    // art resource. This method is called only once per instance's
    // lifetime for each requested wxArtID.
    virtual wxBitmap CreateBitmap(const wxString& id, const wxString& client, const wxSize& size);

%endclass

%endif //wxLUA_USE_wxArtProvider

wxwidgets/wxcore_mdi.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxMDI classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_MDI && wxUSE_MDI && wxUSE_DOC_VIEW_ARCHITECTURE

%include "wx/cmdproc.h"

// ---------------------------------------------------------------------------
// wxMDIClientWindow

%class wxMDIClientWindow, wxWindow

%endclass

// ---------------------------------------------------------------------------
// wxMDIParentFrame

%class wxMDIParentFrame, wxFrame

    wxMDIParentFrame()
    wxMDIParentFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL, const wxString& name = "wxMDIParentFrame")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL, const wxString& name = "wxMDIParentFrame")

    void ActivateNext()
    void ActivatePrevious()
    void ArrangeIcons()
    void Cascade()
    wxMDIChildFrame* GetActiveChild() const
    wxMDIClientWindow* GetClientWindow() const
    // virtual wxToolBar* GetToolBar() const - see wxFrame
    %win wxMenu* GetWindowMenu() const
    // virtual void SetToolBar(wxToolBar* toolbar) - see wxFrame
    %win void SetWindowMenu(%ungc wxMenu* menu)
    void Tile(wxOrientation orient = wxHORIZONTAL)

%endclass

// ---------------------------------------------------------------------------
// wxMDIChildFrame

%class wxMDIChildFrame, wxFrame

    wxMDIChildFrame()
    wxMDIChildFrame(wxMDIParentFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMDIChildFrame")
    bool Create(wxMDIParentFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMDIChildFrame")

    void Activate()
    %win void Maximize()
    void Restore()

%endclass

// ---------------------------------------------------------------------------
// wxDocMDIParentFrame

%include "wx/docmdi.h"

%class wxDocMDIParentFrame, wxMDIParentFrame

    wxDocMDIParentFrame()
    wxDocMDIParentFrame(wxDocManager *manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIParentFrame")
    bool Create(wxDocManager *manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIParentFrame")

    wxDocManager *GetDocumentManager() const

%endclass

// ---------------------------------------------------------------------------
// wxDocMDIChildFrame

%class wxDocMDIChildFrame, wxMDIChildFrame

    wxDocMDIChildFrame()
    wxDocMDIChildFrame(wxDocument *doc, wxView *view, wxMDIParentFrame *frame, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize,long type = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIChildFrame")
    bool Create(wxDocument *doc, wxView *view, wxMDIParentFrame *frame, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long type = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIChildFrame")

    wxDocument *GetDocument() const
    wxView *GetView() const
    void SetDocument(wxDocument *doc)
    void SetView(wxView *view)

%endclass

// ---------------------------------------------------------------------------
// wxDocChildFrame

%include "wx/docview.h"

%class wxDocChildFrame, wxFrame

    wxDocChildFrame(wxDocument* doc, wxView* view, wxFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocChildFrame")

    wxDocument* GetDocument() const
    wxView* GetView() const
    void SetDocument(wxDocument *doc)
    void SetView(wxView *view)

%endclass

// ---------------------------------------------------------------------------
// wxDocManager

%define wxDEFAULT_DOCMAN_FLAGS
%define wxDOC_NEW
%define wxDOC_SILENT

%class wxDocManager, wxEvtHandler

    wxDocManager(long flags = wxDEFAULT_DOCMAN_FLAGS, bool initialize = true)

    %wxchkver_2_6 void ActivateView(wxView* view, bool activate)
    !%wxchkver_2_6 void ActivateView(wxView* view, bool activate, bool deleting)
    void AddDocument(wxDocument *doc)
    void AddFileToHistory(const wxString& filename)
    void AssociateTemplate(wxDocTemplate *temp)
    bool CloseDocuments(bool force = true)
    wxDocument* CreateDocument(const wxString& path, long flags)
    wxView* CreateView(wxDocument*doc, long flags)
    void DisassociateTemplate(wxDocTemplate *temp)
    void FileHistoryAddFilesToMenu()
    void FileHistoryAddFilesToMenu(wxMenu* menu)
    void FileHistoryLoad(wxConfigBase& config)
    void FileHistoryRemoveMenu(wxMenu* menu)
    void FileHistorySave(wxConfigBase& resourceFile)
    void FileHistoryUseMenu(wxMenu* menu)
    wxDocTemplate * FindTemplateForPath(const wxString& path)
    wxDocument * GetCurrentDocument()
    wxView * GetCurrentView()
    // %overide wxList& wxDocManager::GetDocuments() - returns a copied list
    wxList& GetDocuments()
    wxFileHistory * GetFileHistory()
    wxString GetLastDirectory() const
    int GetMaxDocsOpen()
    !%wxchkver_2_6 int GetNoHistoryFiles()
    %wxchkver_2_6 size_t GetHistoryFilesCount() const
    // %overide wxList& wxDocManager::GetTemplates() - returns a copied list
    wxList& GetTemplates()
    bool Initialize()

    // %override [bool, string buf] wxDocManager::MakeDefaultName(wxString& buf)
    // C++ Func: bool MakeDefaultName(wxString& buf)
    bool MakeDefaultName(wxString& buf)

    wxFileHistory* OnCreateFileHistory()
    void OnFileClose(wxCommandEvent &event)
    void OnFileCloseAll(wxCommandEvent& event)
    void OnFileNew(wxCommandEvent &event)
    void OnFileOpen(wxCommandEvent &event)
    void OnFileRevert(wxCommandEvent& event)
    void OnFileSave(wxCommandEvent &event)
    void OnFileSaveAs(wxCommandEvent &event)
    //void OnMenuCommand(int cmd)
    void RemoveDocument(wxDocument *doc)
    //wxDocTemplate * SelectDocumentPath(wxDocTemplate **templates, int noTemplates, const wxString& path, const wxString& bufSize, long flags, bool save)
    //wxDocTemplate * SelectDocumentType(wxDocTemplate **templates, int noTemplates, bool sort = false)
    //wxDocTemplate * SelectViewType(wxDocTemplate **templates, int noTemplates, bool sort = false)
    void SetLastDirectory(const wxString& dir)
    void SetMaxDocsOpen(int n)

%endclass

// ---------------------------------------------------------------------------
// wxDocMDIChildFrame

//%include "wx/docmdi.h"

//%class wxDocMDIChildFrame, wxMDIChildFrame FIXME
// wxDocMDIChildFrame(wxDocument* doc, wxView* view, wxFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIChildFrame")
//
// wxDocument* GetDocument() const
// wxView* GetView() const
// void OnActivate(wxActivateEvent event)
// void OnCloseWindow(wxCloseEvent& event)
// void SetDocument(wxDocument *doc)
// void SetView(wxView *view)
//%endclass

// ---------------------------------------------------------------------------
// wxDocMDIParentFrame

//%include "wx/docmdi.h"

//%class wxDocMDIParentFrame, wxMDIParentFrame FIXME
// wxDocMDIParentFrame(wxDocManager* manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIParentFrame")
//
// void OnCloseWindow(wxCloseEvent& event)
//%endclass

// ---------------------------------------------------------------------------
// wxDocParentFrame

%class wxDocParentFrame, wxFrame

    wxDocParentFrame(wxDocManager* manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocParentFrame")

    //void OnCloseWindow(wxCloseEvent& event)

%endclass

// ---------------------------------------------------------------------------
// wxDocTemplate

%define wxTEMPLATE_VISIBLE
%define wxTEMPLATE_INVISIBLE
%define wxDEFAULT_TEMPLATE_FLAGS

%class wxDocTemplate, wxObject

    wxDocTemplate(wxDocManager* manager, const wxString& descr, const wxString& filter, const wxString& dir, const wxString& ext, const wxString& docTypeName, const wxString& viewTypeName, wxClassInfo* docClassInfo = NULL, wxClassInfo* viewClassInfo = NULL, long flags = wxDEFAULT_TEMPLATE_FLAGS)

    wxDocument* CreateDocument(const wxString& path, long flags = 0)
    wxView* CreateView(wxDocument *doc, long flags = 0)
    wxString GetDefaultExtension()
    wxString GetDescription()
    wxString GetDirectory()
    wxDocManager * GetDocumentManager()
    wxString GetDocumentName()
    wxString GetFileFilter()
    long GetFlags()
    wxString GetViewName()
    bool InitDocument(wxDocument* doc, const wxString& path, long flags = 0)
    bool IsVisible()
    void SetDefaultExtension(const wxString& ext)
    void SetDescription(const wxString& descr)
    void SetDirectory(const wxString& dir)
    void SetDocumentManager(wxDocManager *manager)
    void SetFileFilter(const wxString& filter)
    void SetFlags(long flags)

%endclass

// ---------------------------------------------------------------------------
// wxDocument

%class wxDocument, wxEvtHandler

    wxDocument()

    virtual bool AddView(wxView *view)
    virtual bool Close()
    virtual bool DeleteAllViews()
    wxCommandProcessor* GetCommandProcessor() const
    wxDocTemplate* GetDocumentTemplate() const
    wxDocManager* GetDocumentManager() const
    wxString GetDocumentName() const
    wxWindow* GetDocumentWindow() const
    wxString GetFilename() const
    wxView * GetFirstView() const

    // %override [string name] wxDocument::GetPrintableName(wxString& name) const
    // C++ Func: virtual void GetPrintableName(wxString& name) const
    virtual void GetPrintableName(wxString& name) const

    wxString GetTitle() const
    wxList& GetViews() const
    virtual bool IsModified() const
    //virtual istream& LoadObject(istream& stream)
    //virtual wxInputStream& LoadObject(wxInputStream& stream)
    virtual void Modify(bool modify)
    virtual void OnChangedViewList()
    virtual bool OnCloseDocument()
    virtual bool OnCreate(const wxString& path, long flags)
    virtual wxCommandProcessor* OnCreateCommandProcessor()
    virtual bool OnNewDocument()
    virtual bool OnOpenDocument(const wxString& filename)
    virtual bool OnSaveDocument(const wxString& filename)
    virtual bool OnSaveModified()
    virtual bool RemoveView(wxView* view)
    virtual bool Save()
    virtual bool SaveAs()
    //virtual ostream& SaveObject(ostream& stream)
    //virtual wxOutputStream& SaveObject(wxOutputStream& stream)
    virtual void SetCommandProcessor(wxCommandProcessor *processor)
    void SetDocumentName(const wxString& name)
    void SetDocumentTemplate(wxDocTemplate* templ)
    void SetFilename(const wxString& filename, bool notifyViews = false)
    void SetTitle(const wxString& title)
    void UpdateAllViews(wxView* sender = NULL, wxObject* hint = NULL)

%endclass

// ---------------------------------------------------------------------------
// wxView

%class wxView, wxEvtHandler

    //wxView()

    virtual void Activate(bool activate)
    virtual bool Close(bool deleteWindow = true)
    wxDocument* GetDocument() const
    wxDocManager* GetDocumentManager() const
    wxWindow * GetFrame()
    wxString GetViewName() const
    virtual void OnActivateView(bool activate, wxView *activeView, wxView *deactiveView)
    virtual void OnChangeFilename()
    virtual bool OnClose(bool deleteWindow)
    //virtual void OnClosingDoocument()
    virtual bool OnCreate(wxDocument* doc, long flags)
    virtual wxPrintout* OnCreatePrintout()
    //virtual void OnDraw(wxDC& dc)
    virtual void OnUpdate(wxView* sender, wxObject* hint)
    void SetDocument(wxDocument* doc)
    void SetFrame(wxFrame* frame)
    void SetViewName(const wxString& name)

%endclass

%endif //wxLUA_USE_MDI && wxUSE_MDI && wxUSE_DOC_VIEW_ARCHITECTURE

// ---------------------------------------------------------------------------
// wxCommandProcessor

%if wxLUA_USE_wxCommandProcessor

%include "wx/cmdproc.h"

%class wxCommandProcessor, wxObject

    wxCommandProcessor(int maxCommands = -1)

    virtual bool CanRedo() const
    virtual bool CanUndo() const
    virtual bool Redo()
    virtual bool Undo()
    virtual void ClearCommands()
    wxList& GetCommands() const
    int GetMaxCommands() const
    wxMenu *GetEditMenu() const
    wxString GetRedoAccelerator() const
    wxString GetRedoMenuLabel() const
    wxString GetUndoAccelerator() const
    wxString GetUndoMenuLabel() const
    virtual void Initialize()
    virtual bool IsDirty()
    virtual void MarkAsSaved()
    void SetEditMenu(wxMenu *menu)
    virtual void SetMenuStrings()
    void SetRedoAccelerator(const wxString& accel)
    void SetUndoAccelerator(const wxString& accel)
    virtual bool Submit(wxCommand *command, bool storeIt = true)
    virtual void Store(wxCommand *command)
    wxCommand *GetCurrentCommand() const

%endclass

// ---------------------------------------------------------------------------
// wxCommand

%class wxCommand, wxObject

    //wxCommand(bool canUndo = false, const wxString& name = "")

    virtual bool CanUndo()
    virtual bool Do() // pure virtual
    virtual wxString GetName()
    virtual bool Undo() // pure virtual

%endclass

%endif //wxLUA_USE_wxCommandProcessor

// ---------------------------------------------------------------------------
// wxFileHistory

%if wxLUA_USE_wxFileHistory && wxUSE_DOC_VIEW_ARCHITECTURE

%include "wx/docview.h"

%class %delete wxFileHistory, wxObject

    wxFileHistory(int maxFiles = 9, wxWindowID idBase = wxID_FILE1)

    void AddFileToHistory(const wxString& filename)
    void AddFilesToMenu()
    void AddFilesToMenu(wxMenu* menu)
    wxString GetHistoryFile(int index) const
    int GetMaxFiles() const
    size_t GetCount() const
    void Load(wxConfigBase& config)
    void RemoveFileFromHistory(size_t i)
    void RemoveMenu(wxMenu* menu)
    void Save(wxConfigBase& config)
    void UseMenu(wxMenu* menu)

%endclass

%endif //wxLUA_USE_wxFileHistory && wxUSE_DOC_VIEW_ARCHITECTURE


wxwidgets/wxcore_menutool.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxMenu and wxToolbar classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxMenu

%if wxLUA_USE_wxMenu && wxUSE_MENUS

%include "wx/menu.h"

%enum wxItemKind

    wxITEM_SEPARATOR
    wxITEM_NORMAL
    wxITEM_CHECK
    wxITEM_RADIO
    wxITEM_MAX

%endenum

%define wxMB_DOCKABLE
%define wxMENU_TEAROFF

%class %delete wxMenu, wxEvtHandler

    wxMenu(const wxString& title = "", long style = 0)

    // %override wxMenu({{wx.wxID_NEW, "&New\tCtrl-N", "New doc", [wx.wxITEM_NORMAL]}, {}, {item 2}}, const wxString& title = "", long style = 0) - empty tables are separators
    // wxLua provides this function
    %override_name wxLua_wxCreateMenu_constructor wxMenu(LuaTable, const wxString& title = "", long style = 0)

    wxMenuItem* Append(int id, const wxString& item, const wxString& helpString = "", wxItemKind kind = wxITEM_NORMAL)
    wxMenuItem* Append(int id, const wxString& item, %ungc wxMenu *subMenu, const wxString& helpString = "")
    wxMenuItem* Append(%ungc wxMenuItem* menuItem)
    wxMenuItem* AppendCheckItem(int id, const wxString& item, const wxString& helpString = "")
    wxMenuItem* AppendRadioItem(int id, const wxString& item, const wxString& helpString = "")
    wxMenuItem* AppendSeparator()
    void Break()
    void Check(int id, bool check)
    void Delete(int id)
    void Delete(wxMenuItem *item)
    void Destroy(int id)
    void Destroy(wxMenuItem *item)
    void Enable(int id, bool enable)
    int FindItem(const wxString& itemString) const

    // %override [wxMenuItem* menuItem, wxMenu* ownerMenu] wxMenu::FindItem(int id)
    // C++ Func: wxMenuItem* FindItem(int id, wxMenu **menu = NULL) const
    %override_name wxLua_wxMenu_FindItemById wxMenuItem* FindItem(int id) const

    wxMenuItem* FindItemByPosition(size_t position) const
    wxString GetHelpString(int id) const
    wxString GetLabel(int id) const
    size_t GetMenuItemCount() const
    wxMenuItemList& GetMenuItems() const
    wxString GetTitle() const
    wxMenuItem* Insert(size_t pos, int id, const wxString& item, const wxString& helpString = "", wxItemKind kind = wxITEM_NORMAL)
    wxMenuItem* Insert(size_t pos, %ungc wxMenuItem *item)
    wxMenuItem* InsertCheckItem(size_t pos, int id, const wxString& item, const wxString& helpString = "")
    wxMenuItem* InsertRadioItem(size_t pos, int id, const wxString& item, const wxString& helpString = "")
    wxMenuItem* InsertSeparator(size_t pos)
    bool IsChecked(int id) const
    bool IsEnabled(int id) const
    wxMenuItem* Prepend(int id, const wxString& item, const wxString& helpString = "", wxItemKind kind = wxITEM_NORMAL)
    wxMenuItem* Prepend(%ungc wxMenuItem *item)
    wxMenuItem* PrependCheckItem(int id, const wxString& item, const wxString& helpString = "")
    wxMenuItem* PrependRadioItem(int id, const wxString& item, const wxString& helpString = "")
    wxMenuItem* PrependSeparator()
    %gc wxMenuItem* Remove(wxMenuItem *item)
    %gc wxMenuItem* Remove(int id)
    void SetHelpString(int id, const wxString& helpString)
    void SetLabel(int id, const wxString& label)
    void SetTitle(const wxString& title)
    void UpdateUI(wxEvtHandler* source = NULL) const

%endclass

// ---------------------------------------------------------------------------
// wxMenuBar

%class wxMenuBar, wxWindow

    wxMenuBar(long style = 0)
    // void wxMenuBar(int n, wxMenu* menus[], const wxString titles[])

    bool Append(%ungc wxMenu *menu, const wxString& title)
    void Check(int id, bool check)
    void Enable(int id, bool enable)
    void EnableTop(int pos, bool enable)
    int FindMenu(const wxString& title) const
    int FindMenuItem(const wxString& menuString, const wxString& itemString) const
    wxMenuItem* FindItem(int id, wxMenu **menu = NULL) const
    wxString GetHelpString(int id) const
    wxString GetLabel(int id) const
    wxString GetLabelTop(int pos) const
    wxMenu* GetMenu(int menuIndex) const
    int GetMenuCount() const
    bool Insert(size_t pos, %ungc wxMenu *menu, const wxString& title)
    bool IsChecked(int id) const
    bool IsEnabled(int id) const
    void Refresh()
    %gc wxMenu* Remove(size_t pos)
    %gc wxMenu* Replace(size_t pos, %ungc wxMenu *menu, const wxString& title)
    void SetHelpString(int id, const wxString& helpString)
    void SetLabel(int id, const wxString& label)
    void SetLabelTop(int pos, const wxString& label)

    %wxchkver_2_8 virtual void UpdateMenus()

%endclass

// ---------------------------------------------------------------------------
// wxMenuItem
//
// Note: this is almost always owned by a wxMenu, however you can get an
// unattached one from wxMenu::Remove() so that's why we gc collect it.


%include "wx/menuitem.h"

%class %delete wxMenuItem, wxObject

    %ungc_this wxMenuItem(wxMenu *parentMenu = NULL, int id = wxID_SEPARATOR, const wxString& text = "", const wxString& help = "", wxItemKind kind = wxITEM_NORMAL, wxMenu *subMenu = NULL)

    void Check(bool check)
    void Enable(bool enable)
    //%win wxColour GetBackgroundColour() const
    //%win wxBitmap GetBitmap(bool checked = true) const
    //%win wxFont GetFont() const
    wxString GetHelp() const
    int GetId() const
    wxItemKind GetKind() const
    wxString GetLabel() const
    static wxString GetLabelFromText(const wxString& text)
    //%win int GetMarginWidth() const
    wxMenu* GetMenu() const
    // wxString GetName() const - deprecated
    wxString GetText() const
    wxMenu* GetSubMenu() const
    //%win wxColour& GetTextColour() const
    bool IsCheckable() const
    bool IsChecked() const
    bool IsEnabled() const
    bool IsSeparator() const
    bool IsSubMenu() const
    //%win void SetBackgroundColour(const wxColour& colour) const
    void SetBitmap(const wxBitmap& bmp)
    //%win void SetBitmaps(const wxBitmap& checked, const wxBitmap& unchecked = wxNullBitmap) const
    //%win void SetFont(const wxFont& font) const
    void SetHelp(const wxString& helpString) const
    //%win void SetMarginWidth(int width) const
    //void SetMenu(wxMenu* menu)
    void SetSubMenu(wxMenu* menu)
    void SetText(const wxString& text)
    // void SetName(const wxString& text) const - deprecated
    %win void SetTextColour(const wxColour& colour) const

    %if %wxchkver_2_8
    void SetItemLabel(const wxString& str)
    wxString GetItemLabel() const
    wxString GetItemLabelText() const

    static wxString GetLabelText(const wxString& label)
    %endif

%endclass

// ---------------------------------------------------------------------------
// wxMenuItemList

%class %noclassinfo wxMenuItemList, wxList

    // no constructor, you only get this back from wxMenu::GetMenuItems

    // Use the wxList methods, see also wxNode

%endclass

// ---------------------------------------------------------------------------
// wxMenuEvent

%include "wx/event.h"

%class %delete wxMenuEvent, wxEvent

    %define_event wxEVT_MENU_HIGHLIGHT // EVT_MENU_HIGHLIGHT(winid, func) EVT_MENU_HIGHLIGHT_ALL(func)
    %define_event wxEVT_MENU_OPEN // EVT_MENU_OPEN(func)
    %define_event wxEVT_MENU_CLOSE // EVT_MENU_CLOSE(func)

    wxMenuEvent(wxEventType type = wxEVT_NULL, int id = 0, wxMenu* menu = NULL)
    wxMenu* GetMenu() const
    int GetMenuId() const
    bool IsPopup() const

%endclass

%endif //wxLUA_USE_wxMenu && wxUSE_MENUS

// ---------------------------------------------------------------------------
// wxToolBarBase

%if wxLUA_USE_wxToolbar

%include "wx/tbarbase.h"

%define wxTB_FLAT
%define wxTB_DOCKABLE
%define wxTB_HORIZONTAL
%define wxTB_VERTICAL
%define wxTB_3DBUTTONS
%define wxTB_TEXT
%define wxTB_NOICONS
%define wxTB_NODIVIDER
%define wxTB_NOALIGN
%define wxTB_HORZ_LAYOUT
%define wxTB_HORZ_TEXT

%class %noclassinfo wxToolBarBase, wxControl

    // no constructors base class

    wxToolBarToolBase* AddControl(wxControl *control)
    wxToolBarToolBase* AddSeparator()
    wxToolBarToolBase* AddTool(int toolId, const wxString& label, const wxBitmap& bitmap1, const wxBitmap& bitmap2 = wxNullBitmap, wxItemKind kind = wxITEM_NORMAL, const wxString& shortHelpString = "", const wxString& longHelpString = "", wxObject* clientData = NULL)
    wxToolBarToolBase* AddTool(int toolId, const wxString& label, const wxBitmap& bitmap1, const wxString& shortHelpString /*= "" GloaEdit*/, wxItemKind kind = wxITEM_NORMAL)
    //wxToolBarToolBase* AddTool(wxToolBarToolBase* tool)
    wxToolBarToolBase *AddCheckTool(int toolid, const wxString& label, const wxBitmap& bitmap, const wxBitmap& bmpDisabled = wxNullBitmap, const wxString& shortHelp = "", const wxString& longHelp = "", wxObject *data = NULL)
    wxToolBarToolBase *AddRadioTool(int toolid, const wxString& label, const wxBitmap& bitmap, const wxBitmap& bmpDisabled = wxNullBitmap, const wxString& shortHelp = "", const wxString& longHelp = "", wxObject *data = NULL)
    void ClearTools()
    bool DeleteTool(int toolId)
    bool DeleteToolByPos(size_t pos)
    void EnableTool(int toolId, const bool enable)
    wxToolBarToolBase* FindById(int id)
    wxControl* FindControl(int id)
    wxToolBarToolBase *FindToolForPosition(wxCoord x, wxCoord y) const
    int GetMaxRows()
    int GetMaxCols()
    wxSize GetToolSize()
    wxSize GetToolBitmapSize()
    wxObject* GetToolClientData(int toolId) const
    bool GetToolEnabled(int toolId) const
    wxString GetToolLongHelp(int toolId) const
    wxSize GetToolMargins() // GetMargins is deprecated
    int GetToolPacking()
    int GetToolPos(int toolId) const
    int GetToolSeparation() const
    wxString GetToolShortHelp(int toolId) const
    bool GetToolState(int id)
    wxToolBarToolBase* InsertControl(size_t pos, wxControl *control)
    wxToolBarToolBase* InsertSeparator(size_t pos)
    wxToolBarToolBase* InsertTool(size_t pos, int id, const wxBitmap& bitmap, const wxBitmap& pushedBitmap = wxNullBitmap, bool isToggle = false, wxObject *clientData = NULL, const wxString& shortHelpString = "", const wxString& longHelpString = "")
    wxToolBarToolBase* InsertTool(size_t pos, int toolid, const wxString& label, const wxBitmap& bitmap, const wxBitmap& bmpDisabled = wxNullBitmap, wxItemKind kind = wxITEM_NORMAL, const wxString& shortHelp = "", const wxString& longHelp = "", wxObject *clientData = NULL)
    //wxToolBarToolBase * InsertTool(size_t pos, wxToolBarToolBase* tool)
    wxToolBarToolBase* RemoveTool(int id)
    bool Realize()
    void SetMargins(int x, int y)
    void SetMargins(const wxSize& size)
    void SetToolBitmapSize(const wxSize& size)
    void SetToolClientData(int id, wxObject* clientData)
    void SetToolLongHelp(int toolId, const wxString& helpString)
    void SetToolPacking(int packing)
    void SetToolShortHelp(int id, const wxString& helpString)
    void SetToolSeparation(int separation)
    void SetToggle(int id, bool toggle)
    void SetRows(int nRows)
    void SetMaxRowsCols(int rows, int cols)
    void ToggleTool(int toolId, const bool toggle)

%endclass

// ---------------------------------------------------------------------------
// wxToolBar

%include "wx/toolbar.h"

%class wxToolBar, wxToolBarBase

    wxToolBar()
    wxToolBar(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxNO_BORDER | wxTB_HORIZONTAL, const wxString &name = "wxToolBar")
    bool Create(wxWindow *parent,wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxNO_BORDER | wxTB_HORIZONTAL, const wxString &name = "wxToolBar")

%endclass

// ---------------------------------------------------------------------------
// wxToolBarSimple

%if !%wxchkver_2_6

%include "wx/tbarsmpl.h"

%class wxToolBarSimple, wxToolBarBase

    wxToolBarSimple()
    wxToolBarSimple(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxNO_BORDER | wxTB_HORIZONTAL, const wxString &name = wxToolBarNameStr)
    bool Create(wxWindow *parent,wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxNO_BORDER | wxTB_HORIZONTAL, const wxString &name = wxToolBarNameStr)

%endclass

%endif // !%wxchkver_2_6

// ---------------------------------------------------------------------------
// wxToolBarToolBase

// these are unused
//%define wxTOOL_BOTTOM
//%define wxTOOL_LEFT
//%define wxTOOL_RIGHT
//%define wxTOOL_TOP

%enum wxToolBarToolStyle

    wxTOOL_STYLE_BUTTON
    wxTOOL_STYLE_SEPARATOR
    wxTOOL_STYLE_CONTROL

%endenum

%class wxToolBarToolBase, wxObject

    // no constructors

    int GetId()
    wxControl *GetControl()
    wxToolBarBase *GetToolBar()
    int IsButton()
    int IsControl()
    int IsSeparator()
    int GetStyle()
    wxItemKind GetKind() const
    bool IsEnabled()
    bool IsToggled()
    bool CanBeToggled()
    wxBitmap GetNormalBitmap()
    wxBitmap GetDisabledBitmap()
    wxBitmap GetBitmap()
    wxString GetLabel()
    wxString GetShortHelp()
    wxString GetLongHelp()
    bool Enable(bool enable)
    bool Toggle(bool toggle)
    bool SetToggle(bool toggle)
    bool SetShortHelp(const wxString& help)
    bool SetLongHelp(const wxString& help)
    void SetNormalBitmap(const wxBitmap& bmp)
    void SetDisabledBitmap(const wxBitmap& bmp)
    void SetLabel(const wxString& label)
    void Detach()
    void Attach(wxToolBarBase *tbar)
    wxObject *GetClientData()
    void SetClientData(wxObject* clientData)

%endclass

// ---------------------------------------------------------------------------
// wxToolBarTool

%class %noclassinfo wxToolBarTool, wxToolBarToolBase

%endclass

%endif //wxLUA_USE_wxToolbar


// ---------------------------------------------------------------------------
// wxAcceleratorTable

%if wxLUA_USE_wxAcceleratorTable && wxUSE_ACCEL

%include "wx/accel.h"

%class %delete wxAcceleratorTable, wxObject

    %define_object wxNullAcceleratorTable

    // %override wxAcceleratorTable(Lua table with this format)
    // { { wx.wxACCEL_NORMAL, string.byte('0'), ID_0 },
    // { wx.wxACCEL_NORMAL, wx.VXK_NUMPAD0, ID_0 } }
    // C++ Func: wxAcceleratorTable(int n, wxAcceleratorEntry* entries)
    wxAcceleratorTable(LuaTable accelTable)
    wxAcceleratorTable(const wxAcceleratorTable& accel)

    bool Ok() const
    //%wxchkver_2_8 bool IsOk() const

    // believe it or not, there aren't functions to add or remove wxAcceleratorEntries for MSW

    // operators are WXWIN_COMPATIBILITY_2_4

%endclass

// ---------------------------------------------------------------------------
// wxAcceleratorEntry

%wxcompat_2_6 %function wxAcceleratorEntry* wxGetAccelFromString(const wxString& label) // deprecated in 2.8 use wxAcceleratorEntry::Create() or FromString()

%include "wx/accel.h"

%enum

    wxACCEL_NORMAL
    wxACCEL_ALT
    wxACCEL_CTRL
    wxACCEL_SHIFT
    %wxchkver_2_8 wxACCEL_CMD // Command key on OS X else wxACCEL_CTRL

%endenum

%class %delete %noclassinfo %encapsulate wxAcceleratorEntry

    wxAcceleratorEntry(int flags = 0, int keyCode = 0, int cmd = 0, wxMenuItem *item = NULL)
    wxAcceleratorEntry(const wxAcceleratorEntry& entry)

    int GetCommand() const
    int GetFlags() const
    int GetKeyCode() const
    void Set(int flags, int keyCode, int Cmd, wxMenuItem *item = NULL)

    %if %wxchkver_2_8
    static %gc wxAcceleratorEntry *Create(const wxString& str)
    bool IsOk() const
    wxString ToString() const
    bool FromString(const wxString& str)
    wxMenuItem *GetMenuItem() const
    %endif // %wxchkver_2_8

    // these are probably not necessary
    //%operator wxAcceleratorEntry& operator=(const wxAcceleratorEntry& entry)
    //%operator bool operator==(const wxAcceleratorEntry& entry) const
    //%operator bool operator!=(const wxAcceleratorEntry& entry) const

%endclass

%endif //wxLUA_USE_wxAcceleratorTable && wxUSE_ACCEL

wxwidgets/wxcore_picker.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxPickerXXX controls
// Author: John Labenski
// Created: 14/11/2001
// Copyright: (c) 2007 John Labenski
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if %wxchkver_2_8 && wxLUA_USE_wxPicker

// ---------------------------------------------------------------------------
// wxPickerBase

%include "wx/pickerbase.h"

%define wxPB_USE_TEXTCTRL

%class wxPickerBase, wxControl

    // No construcor - this is a base class

    // margin between the text control and the picker
    void SetInternalMargin(int newmargin)
    int GetInternalMargin() const

    // proportion of the text control
    void SetTextCtrlProportion(int prop)
    int GetTextCtrlProportion() const

    // proportion of the picker control
    void SetPickerCtrlProportion(int prop)
    int GetPickerCtrlProportion() const

    bool IsTextCtrlGrowable() const
    void SetTextCtrlGrowable(bool grow = true)

    bool IsPickerCtrlGrowable() const
    void SetPickerCtrlGrowable(bool grow = true)

    bool HasTextCtrl() const
    wxTextCtrl *GetTextCtrl()
    wxControl *GetPickerCtrl()

    // methods that derived class must/may override
    virtual void UpdatePickerFromTextCtrl()
    virtual void UpdateTextCtrlFromPicker()

%endclass

// ---------------------------------------------------------------------------
// wxColourPickerCtrl

%if wxLUA_USE_wxColourPickerCtrl && wxUSE_COLOURPICKERCTRL

%include "wx/clrpicker.h"

%define wxCLRP_SHOW_LABEL
%define wxCLRP_USE_TEXTCTRL
%define wxCLRP_DEFAULT_STYLE

%class wxColourPickerCtrl, wxPickerBase

    wxColourPickerCtrl()
    // Note default color is *wxBLACK
    wxColourPickerCtrl(wxWindow *parent, wxWindowID id, const wxColour& col, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCLRP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxColourPickerCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxColour& col, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCLRP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxColourPickerCtrl")

    // get the colour chosen
    wxColour GetColour() const
    // set currently displayed color
    void SetColour(const wxColour& col)
    // set colour using RGB(r,g,b) syntax or considering given text as a colour name;
    // returns true if the given text was successfully recognized.
    bool SetColour(const wxString& text)

%endclass

// ---------------------------------------------------------------------------
// wxColourPickerEvent

%class %delete wxColourPickerEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_COLOURPICKER_CHANGED // EVT_COLOURPICKER_CHANGED(id, func)

    wxColourPickerEvent()
    wxColourPickerEvent(wxObject *generator, int id, const wxColour &col)

    wxColour GetColour() const
    void SetColour(const wxColour &c)

%endclass

%endif //wxLUA_USE_wxColourPickerCtrl && wxUSE_COLOURPICKERCTRL

// ---------------------------------------------------------------------------
// wxDatePickerCtrl

%if wxLUA_USE_wxDatePickerCtrl && wxUSE_DATEPICKCTRL

%include "wx/datectrl.h"

// Note: this sends a wxDateEvent wxEVT_DATE_CHANGED // EVT_DATE_CHANGED(id, fn)

%enum

    wxDP_SPIN // MSW only
    wxDP_DROPDOWN
    wxDP_DEFAULT
    wxDP_ALLOWNONE
    wxDP_SHOWCENTURY

%endenum

%class wxDatePickerCtrl, wxControl

    wxDatePickerCtrl()
    wxDatePickerCtrl(wxWindow *parent, wxWindowID id, const wxDateTime& dt = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDP_DEFAULT | wxDP_SHOWCENTURY, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxDatePickerCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxDateTime& dt = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDP_DEFAULT | wxDP_SHOWCENTURY, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxDatePickerCtrl")

    // %override [bool, wxDateTime dt1, wxDateTime dt2] wxDatePickerCtrl::GetRange() const
    // C++ Func: bool GetRange(wxDateTime *dt1, wxDateTime *dt2) const
    bool GetRange() const
    wxDateTime GetValue() const
    void SetRange(const wxDateTime& dt1, const wxDateTime& dt2)
    void SetValue(const wxDateTime& dt)

%endclass

%endif //wxLUA_USE_wxDatePickerCtrl && wxUSE_DATEPICKCTRL

// ---------------------------------------------------------------------------
// wxFileDirPickerCtrlBase

%if (wxLUA_USE_wxDirPickerCtrl || wxLUA_USE_wxFilePickerCtrl) && (wxUSE_FILEPICKERCTRL || wxUSE_DIRPICKERCTRL)

%include "wx/filepicker.h"

%class wxFileDirPickerCtrlBase, wxPickerBase

    // No constructor - this is a base class

    wxString GetPath() const
    void SetPath(const wxString &str)

    // return true if the given path is valid for this control
    bool CheckPath(const wxString& path) const
    // return the text control value in canonical form
    wxString GetTextCtrlValue() const

%endclass

// ---------------------------------------------------------------------------
// wxFileDirPickerEvent

%class %delete wxFileDirPickerEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_FILEPICKER_CHANGED // EVT_FILEPICKER_CHANGED(id, fn)
    %define_event wxEVT_COMMAND_DIRPICKER_CHANGED // EVT_DIRPICKER_CHANGED(id, fn)

    //wxFileDirPickerEvent()
    wxFileDirPickerEvent(wxEventType type, wxObject *generator, int id, const wxString &path)

    wxString GetPath() const
    void SetPath(const wxString &p)

%endclass

%endif // (wxLUA_USE_wxDirPickerCtrl || wxLUA_USE_wxFilePickerCtrl) && (wxUSE_FILEPICKERCTRL || wxUSE_DIRPICKERCTRL)

// ---------------------------------------------------------------------------
// wxDirPickerCtrl

%if wxLUA_USE_wxDirPickerCtrl && (wxUSE_FILEPICKERCTRL || wxUSE_DIRPICKERCTRL)

%define wxDIRP_DIR_MUST_EXIST
%define wxDIRP_CHANGE_DIR

%define wxDIRP_DEFAULT_STYLE
%define wxDIRP_USE_TEXTCTRL

%class wxDirPickerCtrl, wxFileDirPickerCtrlBase

    wxDirPickerCtrl()
    wxDirPickerCtrl(wxWindow *parent, wxWindowID id, const wxString& path = "", const wxString& message = wxDirSelectorPromptStr, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDIRP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxDirPickerCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxString& path = "", const wxString& message = wxDirSelectorPromptStr, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDIRP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxDirPickerCtrl")

%endclass

%endif wxLUA_USE_wxDirPickerCtrl && (wxUSE_FILEPICKERCTRL || wxUSE_DIRPICKERCTRL)

// ---------------------------------------------------------------------------
// wxFilePickerCtrl

%if wxLUA_USE_wxDirPickerCtrl && (wxUSE_FILEPICKERCTRL || wxUSE_DIRPICKERCTRL)

%define wxFLP_OPEN
%define wxFLP_SAVE
%define wxFLP_OVERWRITE_PROMPT
%define wxFLP_FILE_MUST_EXIST
%define wxFLP_CHANGE_DIR

%define wxFLP_DEFAULT_STYLE
%define wxFLP_USE_TEXTCTRL

%class wxFilePickerCtrl, wxFileDirPickerCtrlBase

    wxFilePickerCtrl()
    wxFilePickerCtrl(wxWindow *parent, wxWindowID id, const wxString& path = "", const wxString& message = wxFileSelectorPromptStr, const wxString& wildcard = wxFileSelectorDefaultWildcardStr, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxFLP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxFilePickerCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxString& path = "", const wxString& message = wxFileSelectorPromptStr, const wxString& wildcard = wxFileSelectorDefaultWildcardStr, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxFLP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxFilePickerCtrl")

%endclass

%endif // wxLUA_USE_wxDirPickerCtrl && (wxUSE_FILEPICKERCTRL || wxUSE_DIRPICKERCTRL)

// ---------------------------------------------------------------------------
// wxFontPickerCtrl

%if wxLUA_USE_wxFontPickerCtrl && wxUSE_FONTPICKERCTRL

%include "wx/fontpicker.h"

%define wxFNTP_FONTDESC_AS_LABEL
%define wxFNTP_USEFONT_FOR_LABEL
%define wxFNTP_USE_TEXTCTRL // (wxFNTP_FONTDESC_AS_LABEL|wxFNTP_USEFONT_FOR_LABEL)
%define wxFNTP_DEFAULT_STYLE

%define wxFNTP_MAXPOINT_SIZE // 100 the default max size to allow

%class wxFontPickerCtrl, wxPickerBase

    wxFontPickerCtrl()
    wxFontPickerCtrl(wxWindow *parent, wxWindowID id, const wxFont& initial = wxNullFont, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxFNTP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxFontPickerCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxFont& initial = wxNullFont, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxFNTP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxFontPickerCtrl")

    wxFont GetSelectedFont() const
    virtual void SetSelectedFont(const wxFont &f)

    void SetMaxPointSize(unsigned int max)
    unsigned int GetMaxPointSize() const

%endclass

// ---------------------------------------------------------------------------
// wxFontPickerEvent

%class %delete wxFontPickerEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_FONTPICKER_CHANGED // EVT_FONTPICKER_CHANGED(id, fn)

    //wxFontPickerEvent()
    wxFontPickerEvent(wxObject *generator, int id, const wxFont &f)

    wxFont GetFont() const
    void SetFont(const wxFont &c)

%endclass

%endif // wxLUA_USE_wxFontPickerCtrl && wxUSE_FONTPICKERCTRL

%endif // %wxchkver_2_8 && wxLUA_USE_wxPicker



wxwidgets/wxcore_print.i - Lua table = 'wx'
// ===========================================================================
// Purpose: printing related classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxPrint && wxUSE_PRINTING_ARCHITECTURE

// %typedef wxScrolledWindow wxPreviewWindow // GloaEdit: Unused type.

%include "wx/print.h"

// ---------------------------------------------------------------------------
// wxPrintout

%class wxPrintout, wxObject

    // virtual class, use wxLuaPrintout

    wxDC * GetDC()

    // %override [int minPage, int maxPage, int pageFrom, int pageTo] wxPrintout::GetPageInfo()
    // C++ Func: void GetPageInfo(int *minPage, int *maxPage, int *pageFrom, int *pageTo)
    void GetPageInfo()

    // %override [int w, int h] wxPrintout::GetPageSizeMM()
    // C++ Func: void GetPageSizeMM(int *w, int *h)
    void GetPageSizeMM()

    // %override [int w, int h] wxPrintout::GetPageSizePixels()
    // C++ Func: void GetPageSizePixels(int *w, int *h)
    void GetPageSizePixels()

    // %override [int w, int h] wxPrintout::GetPPIPrinter()
    // C++ Func: void GetPPIPrinter(int *w, int *h)
    void GetPPIPrinter()

    // %override [int w, int h] wxPrintout::GetPPIScreen()
    // C++ Func: void GetPPIScreen(int *w, int *h)
    void GetPPIScreen()

    wxString GetTitle()
    bool HasPage(int pageNum)
    bool IsPreview()
    bool OnBeginDocument(int startPage, int endPage)
    void OnEndDocument()
    void OnBeginPrinting()
    void OnEndPrinting()
    void OnPreparePrinting()
    bool OnPrintPage(int pageNum)

%endclass

// ---------------------------------------------------------------------------
// wxLuaPrintout

%if wxLUA_USE_wxLuaPrintout

%include "wxlua/include/wxlua_bind.h" // for wxLuaObject tag
%include "wxbind/include/wxcore_wxlcore.h"

%class %delete wxLuaPrintout, wxPrintout

    // %override - the C++ function takes the wxLuaState as the first param
    wxLuaPrintout(const wxString& title = "Printout", wxLuaObject *pObject = NULL)

    wxLuaObject *GetID()

    // This is an added function to wxPrintout so you don't have to override GetPageInfo
    void SetPageInfo(int minPage, int maxPage, int pageFrom = 0, int pageTo = 0)

    // The functions below are all virtual functions that you can override in Lua.
    // See the printing sample and wxPrintout for proper parameters and usage.
    //void GetPageInfo(int *minPage, int *maxPage, int *pageFrom, int *pageTo)
    //bool HasPage(int pageNum)
    //bool OnBeginDocument(int startPage, int endPage)
    //void OnEndDocument()
    //void OnBeginPrinting()
    //void OnEndPrinting()
    //void OnPreparePrinting()
    //bool OnPrintPage(int pageNum)

    // Dummy test function to directly verify that the binding virtual functions really work.
    // This base class function appends "-Base" to the val string and returns it.
    virtual wxString TestVirtualFunctionBinding(const wxString& val) // { return val + wxT("-Base"); }

    %member static int ms_test_int

%endclass


// ---------------------------------------------------------------------------
// wxPrinter

%enum wxPrinterError

    wxPRINTER_NO_ERROR
    wxPRINTER_CANCELLED
    wxPRINTER_ERROR

%endenum

%class %delete wxPrinter, wxObject

    wxPrinter(wxPrintDialogData* data = NULL)

    //bool Abort()
    virtual void CreateAbortWindow(wxWindow* parent, wxLuaPrintout* printout)
    bool GetAbort() const
    static wxPrinterError GetLastError()
    wxPrintDialogData& GetPrintDialogData()
    bool Print(wxWindow *parent, wxLuaPrintout *printout, bool prompt=true)
    wxDC* PrintDialog(wxWindow *parent)
    void ReportError(wxWindow *parent, wxLuaPrintout *printout, const wxString& message)
    bool Setup(wxWindow *parent)

%endclass

%endif //wxLUA_USE_wxLuaPrintout

// ---------------------------------------------------------------------------
// wxPrintData

%define wxPORTRAIT
%define wxLANDSCAPE

%enum wxDuplexMode

    wxDUPLEX_HORIZONTAL
    wxDUPLEX_SIMPLEX
    wxDUPLEX_VERTICAL

%endenum

%enum wxPaperSize

    wxPAPER_NONE
    wxPAPER_LETTER
    wxPAPER_LEGAL
    wxPAPER_A4
    wxPAPER_CSHEET
    wxPAPER_DSHEET
    wxPAPER_ESHEET
    wxPAPER_LETTERSMALL
    wxPAPER_TABLOID
    wxPAPER_LEDGER
    wxPAPER_STATEMENT
    wxPAPER_EXECUTIVE
    wxPAPER_A3
    wxPAPER_A4SMALL
    wxPAPER_A5
    wxPAPER_B4
    wxPAPER_B5
    wxPAPER_FOLIO
    wxPAPER_QUARTO
    wxPAPER_10X14
    wxPAPER_11X17
    wxPAPER_NOTE
    wxPAPER_ENV_9
    wxPAPER_ENV_10
    wxPAPER_ENV_11
    wxPAPER_ENV_12
    wxPAPER_ENV_14
    wxPAPER_ENV_DL
    wxPAPER_ENV_C5
    wxPAPER_ENV_C3
    wxPAPER_ENV_C4
    wxPAPER_ENV_C6
    wxPAPER_ENV_C65
    wxPAPER_ENV_B4
    wxPAPER_ENV_B5
    wxPAPER_ENV_B6
    wxPAPER_ENV_ITALY
    wxPAPER_ENV_MONARCH
    wxPAPER_ENV_PERSONAL
    wxPAPER_FANFOLD_US
    wxPAPER_FANFOLD_STD_GERMAN
    wxPAPER_FANFOLD_LGL_GERMAN

    wxPAPER_ISO_B4
    wxPAPER_JAPANESE_POSTCARD
    wxPAPER_9X11
    wxPAPER_10X11
    wxPAPER_15X11
    wxPAPER_ENV_INVITE
    wxPAPER_LETTER_EXTRA
    wxPAPER_LEGAL_EXTRA
    wxPAPER_TABLOID_EXTRA
    wxPAPER_A4_EXTRA
    wxPAPER_LETTER_TRANSVERSE
    wxPAPER_A4_TRANSVERSE
    wxPAPER_LETTER_EXTRA_TRANSVERSE
    wxPAPER_A_PLUS
    wxPAPER_B_PLUS
    wxPAPER_LETTER_PLUS
    wxPAPER_A4_PLUS
    wxPAPER_A5_TRANSVERSE
    wxPAPER_B5_TRANSVERSE
    wxPAPER_A3_EXTRA
    wxPAPER_A5_EXTRA
    wxPAPER_B5_EXTRA
    wxPAPER_A2
    wxPAPER_A3_TRANSVERSE
    wxPAPER_A3_EXTRA_TRANSVERSE

    wxPAPER_DBL_JAPANESE_POSTCARD
    wxPAPER_A6
    wxPAPER_JENV_KAKU2
    wxPAPER_JENV_KAKU3
    wxPAPER_JENV_CHOU3
    wxPAPER_JENV_CHOU4
    wxPAPER_LETTER_ROTATED
    wxPAPER_A3_ROTATED
    wxPAPER_A4_ROTATED
    wxPAPER_A5_ROTATED
    wxPAPER_B4_JIS_ROTATED
    wxPAPER_B5_JIS_ROTATED
    wxPAPER_JAPANESE_POSTCARD_ROTATED
    wxPAPER_DBL_JAPANESE_POSTCARD_ROTATED
    wxPAPER_A6_ROTATED
    wxPAPER_JENV_KAKU2_ROTATED
    wxPAPER_JENV_KAKU3_ROTATED
    wxPAPER_JENV_CHOU3_ROTATED
    wxPAPER_JENV_CHOU4_ROTATED
    wxPAPER_B6_JIS
    wxPAPER_B6_JIS_ROTATED
    wxPAPER_12X11
    wxPAPER_JENV_YOU4
    wxPAPER_JENV_YOU4_ROTATED
    wxPAPER_P16K
    wxPAPER_P32K
    wxPAPER_P32KBIG
    wxPAPER_PENV_1
    wxPAPER_PENV_2
    wxPAPER_PENV_3
    wxPAPER_PENV_4
    wxPAPER_PENV_5
    wxPAPER_PENV_6
    wxPAPER_PENV_7
    wxPAPER_PENV_8
    wxPAPER_PENV_9
    wxPAPER_PENV_10
    wxPAPER_P16K_ROTATED
    wxPAPER_P32K_ROTATED
    wxPAPER_P32KBIG_ROTATED
    wxPAPER_PENV_1_ROTATED
    wxPAPER_PENV_2_ROTATED
    wxPAPER_PENV_3_ROTATED
    wxPAPER_PENV_4_ROTATED
    wxPAPER_PENV_5_ROTATED
    wxPAPER_PENV_6_ROTATED
    wxPAPER_PENV_7_ROTATED
    wxPAPER_PENV_8_ROTATED
    wxPAPER_PENV_9_ROTATED
    wxPAPER_PENV_10_ROTATED

%endenum

%enum wxPrintQuality // actually not an enum, but a typedef int

    wxPRINT_QUALITY_DRAFT
    wxPRINT_QUALITY_HIGH
    wxPRINT_QUALITY_LOW
    wxPRINT_QUALITY_MEDIUM

%endenum

%enum wxPrintMode

    wxPRINT_MODE_FILE
    wxPRINT_MODE_NONE
    wxPRINT_MODE_PREVIEW
    wxPRINT_MODE_PRINTER

%endenum

%if %wxchkver_2_6
%enum wxPrintBin

    wxPRINTBIN_DEFAULT

    wxPRINTBIN_ONLYONE
    wxPRINTBIN_LOWER
    wxPRINTBIN_MIDDLE
    wxPRINTBIN_MANUAL
    wxPRINTBIN_ENVELOPE
    wxPRINTBIN_ENVMANUAL
    wxPRINTBIN_AUTO
    wxPRINTBIN_TRACTOR
    wxPRINTBIN_SMALLFMT
    wxPRINTBIN_LARGEFMT
    wxPRINTBIN_LARGECAPACITY
    wxPRINTBIN_CASSETTE
    wxPRINTBIN_FORMSOURCE

    wxPRINTBIN_USER

%endenum
%endif

%class %delete wxPrintData, wxObject

    wxPrintData()
    wxPrintData(const wxPrintData& data)

    wxPrintData *Copy()

    // copied straight from cmndata.h not docs
    int GetNoCopies() const
    bool GetCollate() const
    int GetOrientation() const
    bool Ok() const
    wxString GetPrinterName() const
    bool GetColour() const
    wxDuplexMode GetDuplex() const
    %wxchkver_2_8 int GetMedia() const
    wxPaperSize GetPaperId() const
    wxSize GetPaperSize() const
    wxPrintQuality GetQuality() const
    wxPrintBin GetBin() const
    wxPrintMode GetPrintMode() const
    %wxchkver_2_8 bool IsOrientationReversed() const
    void SetNoCopies(int v)
    void SetCollate(bool flag)
    void SetOrientation(int orient)
    void SetPrinterName(const wxString& name)
    void SetColour(bool colour)
    void SetDuplex(wxDuplexMode duplex)
    %wxchkver_2_8 void SetOrientationReversed(bool reversed)
    %wxchkver_2_8 void SetMedia(int media)
    void SetPaperId(wxPaperSize sizeId)
    void SetPaperSize(const wxSize& sz)
    void SetQuality(wxPrintQuality quality)
    void SetBin(wxPrintBin bin)
    void SetPrintMode(wxPrintMode printMode)
    wxString GetFilename() const
    void SetFilename( const wxString &filename )

    %operator void operator=(const wxPrintData& data)

    // these are all WXWIN_COMPATIBILITY_2_4 and for postscript printing only
    //!%wxchkver_2_8 wxString GetPrinterCommand()
    //!%wxchkver_2_8 wxString GetPrinterOptions()
    //!%wxchkver_2_8 wxString GetPreviewCommand()
    //!%wxchkver_2_8 const wxString& GetFontMetricPath()
    //!%wxchkver_2_8 double GetPrinterScaleX()
    //!%wxchkver_2_8 double GetPrinterScaleY()
    //!%wxchkver_2_8 long GetPrinterTranslateX()
    //!%wxchkver_2_8 long GetPrinterTranslateY()
    //!%wxchkver_2_8 void SetPrinterCommand(const wxString& command)
    //!%wxchkver_2_8 void SetPrinterOptions(const wxString& options)
    //!%wxchkver_2_8 void SetPreviewCommand(const wxString& command)
    //!%wxchkver_2_8 void SetFontMetricPath(const wxString& path)
    //!%wxchkver_2_8 void SetPrinterScaleX(double x)
    //!%wxchkver_2_8 void SetPrinterScaleY(double y)
    //!%wxchkver_2_8 void SetPrinterScaling(double x, double y)
    //!%wxchkver_2_8 void SetPrinterTranslateX(long x)
    //!%wxchkver_2_8 void SetPrinterTranslateY(long y)
    //!%wxchkver_2_8 void SetPrinterTranslation(long x, long y)

%endclass

// ---------------------------------------------------------------------------
// wxPageSetupDialogData

%class %delete wxPageSetupDialogData, wxObject

    wxPageSetupDialogData()
    wxPageSetupDialogData(const wxPageSetupDialogData& data)

    wxPageSetupDialogData *Copy()

    // copied straight from cmndata.h not docs
    wxSize GetPaperSize() const
    wxPaperSize GetPaperId() const
    wxPoint GetMinMarginTopLeft() const
    wxPoint GetMinMarginBottomRight() const
    wxPoint GetMarginTopLeft() const
    wxPoint GetMarginBottomRight() const
    bool GetDefaultMinMargins() const
    bool GetEnableMargins() const
    bool GetEnableOrientation() const
    bool GetEnablePaper() const
    bool GetEnablePrinter() const
    bool GetDefaultInfo() const
    bool GetEnableHelp() const
    bool Ok() const
    void SetPaperSize(const wxSize& sz)
    void SetPaperSize(wxPaperSize id)
    void SetPaperId(wxPaperSize id)
    void SetMinMarginTopLeft(const wxPoint& pt)
    void SetMinMarginBottomRight(const wxPoint& pt)
    void SetMarginTopLeft(const wxPoint& pt)
    void SetMarginBottomRight(const wxPoint& pt)
    void SetDefaultMinMargins(bool flag)
    void SetDefaultInfo(bool flag)
    void EnableMargins(bool flag)
    void EnableOrientation(bool flag)
    void EnablePaper(bool flag)
    void EnablePrinter(bool flag)
    void EnableHelp(bool flag)
    void CalculateIdFromPaperSize()
    void CalculatePaperSizeFromId()
    wxPrintData& GetPrintData()
    void SetPrintData(const wxPrintData& printData)

    //wxPageSetupDialogData& operator=(const wxPageSetupData& data)
    //wxPageSetupDialogData& operator=(const wxPrintData& data)

%endclass

// ---------------------------------------------------------------------------
// wxPageSetupDialog

%include "wx/printdlg.h"

//%typedef wxPageSetupDialogBase wxPageSetupDialog

%class wxPageSetupDialog, wxObject // NOT a wxDialog in 2.6

    wxPageSetupDialog(wxWindow* parent, wxPageSetupDialogData* data = NULL)

    wxPageSetupDialogData& GetPageSetupDialogData()
    int ShowModal()

%endclass

// ---------------------------------------------------------------------------
// wxPrintDialog

%class wxPrintDialog, wxObject // NOT a wxDialog in 2.6

    wxPrintDialog(wxWindow* parent, wxPrintDialogData* data = NULL)

    wxPrintDialogData& GetPrintDialogData()
    wxPrintData& GetPrintData();
    wxDC* GetPrintDC()
    int ShowModal()

%endclass

// ---------------------------------------------------------------------------
// wxPrintDialogData

%class %delete wxPrintDialogData, wxObject

    wxPrintDialogData()
    wxPrintDialogData(const wxPrintDialogData& dialogData)
    wxPrintDialogData(const wxPrintData& data)

    // copied straight from cmndata.h not docs
    int GetFromPage() const
    int GetToPage() const
    int GetMinPage() const
    int GetMaxPage() const
    int GetNoCopies() const
    bool GetAllPages() const
    bool GetSelection() const
    bool GetCollate() const
    bool GetPrintToFile() const
    // WXWIN_COMPATIBILITY_2_4 //bool GetSetupDialog() const
    void SetFromPage(int v)
    void SetToPage(int v)
    void SetMinPage(int v)
    void SetMaxPage(int v)
    void SetNoCopies(int v)
    void SetAllPages(bool flag)
    void SetSelection(bool flag)
    void SetCollate(bool flag)
    void SetPrintToFile(bool flag)
    // WXWIN_COMPATIBILITY_2_4 //void SetSetupDialog(bool flag) { m_printSetupDialog = flag; };
    void EnablePrintToFile(bool flag)
    void EnableSelection(bool flag)
    void EnablePageNumbers(bool flag)
    void EnableHelp(bool flag)
    bool GetEnablePrintToFile() const
    bool GetEnableSelection() const
    bool GetEnablePageNumbers() const
    bool GetEnableHelp() const
    bool Ok() const
    wxPrintData& GetPrintData()
    void SetPrintData(const wxPrintData& printData)

    %operator void operator=(const wxPrintDialogData& data)

%endclass

// ---------------------------------------------------------------------------
// wxPreviewCanvas

%class wxPreviewCanvas, wxWindow

    wxPreviewCanvas(wxPrintPreview *preview, wxWindow *parent, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxPreviewCanvas")

%endclass

// ---------------------------------------------------------------------------
// wxPreviewControlBar

%define wxPREVIEW_PRINT
%define wxPREVIEW_PREVIOUS
%define wxPREVIEW_NEXT
%define wxPREVIEW_ZOOM
%define wxPREVIEW_FIRST
%define wxPREVIEW_LAST
%define wxPREVIEW_GOTO

%define wxID_PREVIEW_CLOSE
%define wxID_PREVIEW_NEXT
%define wxID_PREVIEW_PREVIOUS
%define wxID_PREVIEW_PRINT
%define wxID_PREVIEW_ZOOM
%define wxID_PREVIEW_FIRST
%define wxID_PREVIEW_LAST
%define wxID_PREVIEW_GOTO

%class wxPreviewControlBar, wxWindow

    wxPreviewControlBar(wxPrintPreview* preview, long buttons, wxWindow* parent, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxPreviewControlBar")

    //void CreateButtons()
    virtual void SetZoomControl(int zoom)
    virtual int GetZoomControl()
    //virtual wxPrintPreviewBase *GetPrintPreview() const

%endclass

// ---------------------------------------------------------------------------
// wxPrintPreview
%if wxLUA_USE_wxLuaPrintout

%class wxPrintPreview, wxObject

    wxPrintPreview(wxLuaPrintout* printout, wxLuaPrintout* printoutForPrinting, wxPrintData* data=NULL)

    bool DrawBlankPage(wxPreviewCanvas* window, wxDC& dc)
    wxPreviewCanvas* GetCanvas()
    int GetCurrentPage()
    wxFrame * GetFrame()
    int GetMaxPage()
    int GetMinPage()
    wxPrintout* GetPrintout()
    wxPrintout* GetPrintoutForPrinting()
    bool Ok()
    bool PaintPage(wxPreviewCanvas* window, wxDC &dc)
    bool Print(bool prompt)
    bool RenderPage(int pageNum)
    void SetCanvas(wxPreviewCanvas* window)
    void SetCurrentPage(int pageNum)
    void SetFrame(wxFrame *frame)
    void SetPrintout(wxLuaPrintout *printout)
    void SetZoom(int percent)

%endclass

// ---------------------------------------------------------------------------
// wxPreviewFrame

%class wxPreviewFrame, wxFrame

    wxPreviewFrame(wxPrintPreview *preview, wxFrame *parent, const wxString &title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString &name = "wxPreviewFrame")

    void CreateControlBar()
    void CreateCanvas()
    void Initialize()
    wxPreviewControlBar* GetControlBar() const

%endclass

%endif //wxLUA_USE_wxLuaPrintout

// ---------------------------------------------------------------------------
// wxPostScriptDC

%if wxUSE_POSTSCRIPT

%include "wx/dcps.h"

%class %delete wxPostScriptDC, wxDC

    wxPostScriptDC(const wxPrintData& printData)

    static void SetResolution(int ppi)
    static int GetResolution()

%endclass

%endif //wxUSE_POSTSCRIPT

// ---------------------------------------------------------------------------
// wxPrinterDC

%if %msw|%mac
%include "wx/dcprint.h"

%class %delete wxPrinterDC, wxDC

    wxPrinterDC(const wxPrintData& printData)

%endclass
%endif // %msw|%mac

%endif //wxLUA_USE_wxPrint && wxUSE_PRINTING_ARCHITECTURE


wxwidgets/wxcore_sizer.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxSizers and wxLayoutConstraints
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxSizer

%if %wxchkver_2_8

// ---------------------------------------------------------------------------
// wxSizerFlags

%class %delete %encapsulate %noclassinfo wxSizerFlags

    wxSizerFlags(int proportion = 0)

    // setters for all sizer flags, they all return the object itself so that
    // calls to them can be chained

    wxSizerFlags& Proportion(int proportion)
    wxSizerFlags& Align(int alignment) // combination of wxAlignment values
    wxSizerFlags& Expand() // wxEXPAND

    // some shortcuts for Align()
    wxSizerFlags& Centre() // { return Align(wxCENTRE); }
    wxSizerFlags& Center() // { return Centre(); }
    wxSizerFlags& Left() // { return Align(wxALIGN_LEFT); }
    wxSizerFlags& Right() // { return Align(wxALIGN_RIGHT); }
    wxSizerFlags& Top() // { return Align(wxALIGN_TOP); }
    wxSizerFlags& Bottom() // { return Align(wxALIGN_BOTTOM); }

    static int GetDefaultBorder() // default border size used by Border() below
    wxSizerFlags& Border(int direction, int borderInPixels)
    wxSizerFlags& Border(int direction = wxALL)
    wxSizerFlags& DoubleBorder(int direction = wxALL)

    wxSizerFlags& TripleBorder(int direction = wxALL)
    wxSizerFlags& HorzBorder()
    wxSizerFlags& DoubleHorzBorder()
    wxSizerFlags& Shaped()
    wxSizerFlags& FixedMinSize()

    // accessors for wxSizer only
    int GetProportion() const
    int GetFlags() const
    int GetBorderInPixels() const

%endclass

// ---------------------------------------------------------------------------
// wxSizerItem

%class wxSizerItem, wxObject

    wxSizerItem(int width, int height, int proportion, int flag, int border, wxObject* userData)
    wxSizerItem(wxWindow* window, int proportion, int flag, int border, wxObject* userData)
    wxSizerItem(wxSizer* sizer, int proportion, int flag, int border, wxObject* userData)
    //wxSizerItem(wxWindow* window, const wxSizerFlags& flags)
    //wxSizerItem(wxSizer* window, const wxSizerFlags& flags)

    wxSize CalcMin()
    void DeleteWindows()
    void DetachSizer()
    int GetBorder() const
    int GetFlag() const
    wxSize GetMinSize() const
    wxPoint GetPosition() const
    int GetProportion() const
    float GetRatio() const
    wxRect GetRect()
    wxSize GetSize() const
    wxSizer* GetSizer() const
    wxSize GetSpacer() const
    wxObject* GetUserData() const
    wxWindow* GetWindow() const
    bool IsShown() const
    bool IsSizer() const
    bool IsSpacer() const
    bool IsWindow() const
    void SetBorder(int border)
    void SetDimension(const wxPoint& pos, const wxSize& size)
    void SetFlag(int flag)
    void SetInitSize(int x, int y)
    void SetProportion(int proportion)
    void SetRatio(int width, int height)
    //void SetRatio(const wxSize& size)
    void SetRatio(float ratio)
    void SetSizer(wxSizer* sizer)
    void SetSpacer(const wxSize& size)
    void SetWindow(wxWindow* window)
    void Show(bool show)

%endclass

// ---------------------------------------------------------------------------
// wxSizer

%class wxSizer, wxObject

    // base class no constructors

    wxSizerItem* Add(wxWindow* window, int proportion = 0,int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Add(wxSizer* sizer, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Add(int width, int height, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
    //wxSizerItem* Add(wxWindow* window, const wxSizerFlags& flags)
    //wxSizerItem* Add(wxSizer* sizer, const wxSizerFlags& flags)
    wxSizerItem* AddSpacer(int size)
    wxSizerItem* AddStretchSpacer(int prop = 1)
    wxSize CalcMin()
    bool Detach(wxWindow* window)
    bool Detach(wxSizer* sizer)
    bool Detach(size_t index)
    void Fit(wxWindow* window)
    void FitInside(wxWindow* window)
    wxSizerItem* GetItem(wxWindow* window, bool recursive = false)
    wxSizerItem* GetItem(wxSizer* sizer, bool recursive = false)
    wxSizerItem* GetItem(size_t index)
    wxSize GetSize()
    wxPoint GetPosition()
    wxSize GetMinSize()
    wxSizerItem* Insert(size_t index, wxWindow* window, int proportion = 0,int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Insert(size_t index, wxSizer* sizer, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Insert(size_t index, int width, int height, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
    //wxSizerItem* Insert(size_t index, wxWindow* window, const wxSizerFlags& flags)
    //wxSizerItem* Insert(size_t index, wxSizer* sizer, const wxSizerFlags& flags)
    wxSizerItem* InsertSpacer(size_t index, int size)
    wxSizerItem* InsertStretchSpacer(size_t index, int prop = 1)
    void Layout()
    void Prepend(wxWindow* window, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
    void Prepend(wxSizer* sizer, int proportion = 0, int flag = 0, int border = 0, wxObject* userData = NULL)
    void Prepend(int width, int height, int proportion = 0, int flag = 0, int border= 0, wxObject* userData = NULL)
    //wxSizerItem* Prepend(wxWindow* window, const wxSizerFlags& flags)
    //wxSizerItem* Prepend(wxSizer* sizer, const wxSizerFlags& flags)
    wxSizerItem* PrependSpacer(int size)
    wxSizerItem* PrependStretchSpacer(int prop = 1)
    void RecalcSizes()
    //bool Remove(wxWindow* window) - deprecated use Detach
    //bool Remove(wxSizer* sizer)
    //bool Remove(size_t index)
    void SetDimension(int x, int y, int width, int height)
    void SetMinSize(int width, int height)
    void SetMinSize(const wxSize& size)
    void SetItemMinSize(wxWindow* window, int width, int height)
    void SetItemMinSize(wxSizer* sizer, int width, int height)
    void SetItemMinSize(int pos, int width, int height)
    void SetSizeHints(wxWindow* window)
    void SetVirtualSizeHints(wxWindow* window)
    bool Show(wxWindow* window, bool show = true, bool recursive = false)
    bool Show(wxSizer* sizer, bool show = true, bool recursive = false)
    bool Show(size_t index, bool show = true)

%endclass

// ---------------------------------------------------------------------------
// wxBoxSizer

%class wxBoxSizer, wxSizer

    wxBoxSizer(int orient)

    //void RecalcSizes()
    //wxSize CalcMin()
    int GetOrientation()

%endclass

// ---------------------------------------------------------------------------
// wxGridSizer

%class wxGridSizer, wxSizer

    wxGridSizer(int cols, int rows, int vgap, int hgap)
    // wxGridSizer(int cols, int vgap = 0, int hgap = 0)

    int GetCols()
    int GetHGap()
    int GetRows()
    int GetVGap()
    void SetCols(int cols)
    void SetHGap(int gap)
    void SetRows(int rows)
    void SetVGap(int gap)

%endclass

// ---------------------------------------------------------------------------
// wxFlexGridSizer

%enum wxFlexSizerGrowMode

    wxFLEX_GROWMODE_NONE
    wxFLEX_GROWMODE_SPECIFIED
    wxFLEX_GROWMODE_ALL

%endenum

%class wxFlexGridSizer, wxGridSizer

    wxFlexGridSizer(int rows, int cols, int vgap=0, int hgap=0)
    // wxFlexGridSizer(int cols, int vgap = 0, int hgap = 0) // just use the above constructor

    void AddGrowableCol( size_t idx, int proportion = 0 )
    void AddGrowableRow( size_t idx, int proportion = 0 )
    int GetFlexibleDirection() const
    wxFlexSizerGrowMode GetNonFlexibleGrowMode() const
    void RemoveGrowableCol( size_t idx )
    void RemoveGrowableRow( size_t idx)
    void SetFlexibleDirection(int direction)
    void SetNonFlexibleGrowMode(wxFlexSizerGrowMode mode)

%endclass

// ---------------------------------------------------------------------------
// wxGridBagSizer

%include "wx/gbsizer.h"

%class wxGridBagSizer, wxFlexGridSizer

    wxGridBagSizer(int vgap=0, int hgap=0)

    wxSizerItem* Add(wxWindow* window, const wxGBPosition& pos, const wxGBSpan& span = wxDefaultSpan, int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Add(wxSizer* sizer, const wxGBPosition& pos, const wxGBSpan& span = wxDefaultSpan, int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Add(int width, int height, const wxGBPosition& pos, const wxGBSpan& span = wxDefaultSpan, int flag = 0, int border = 0, wxObject* userData = NULL)
    wxSizerItem* Add(wxGBSizerItem* item)

    bool CheckForIntersection(wxGBSizerItem* item, wxGBSizerItem* excludeItem = NULL)
    bool CheckForIntersection(const wxGBPosition& pos, const wxGBSpan& span, wxGBSizerItem* excludeItem = NULL)

    wxGBSizerItem* FindItem(wxWindow* window)
    wxGBSizerItem* FindItem(wxSizer* sizer)
    wxGBSizerItem* FindItemAtPoint(const wxPoint& pt)
    wxGBSizerItem* FindItemAtPosition(const wxGBPosition& pos)
    wxGBSizerItem* FindItemWithData(const wxObject* userData)
    wxSize GetCellSize(int row, int col) const
    wxSize GetEmptyCellSize() const

    wxGBPosition GetItemPosition(wxWindow* window)
    wxGBPosition GetItemPosition(wxSizer* sizer)
    wxGBPosition GetItemPosition(size_t index)

    wxGBSpan GetItemSpan(wxWindow* window)
    wxGBSpan GetItemSpan(wxSizer* sizer)
    wxGBSpan GetItemSpan(size_t index)
    //void RecalcSizes()
    void SetEmptyCellSize(const wxSize& sz)
    bool SetItemPosition(wxWindow* window, const wxGBPosition& pos)
    bool SetItemPosition(wxSizer* sizer, const wxGBPosition& pos)
    bool SetItemPosition(size_t index, const wxGBPosition& pos)
    bool SetItemSpan(wxWindow* window, const wxGBSpan& span)
    bool SetItemSpan(wxSizer* sizer, const wxGBSpan& span)
    bool SetItemSpan(size_t index, const wxGBSpan& span)

%endclass

// ---------------------------------------------------------------------------
// wxGBPosition

%class %delete %noclassinfo %encapsulate wxGBPosition

    wxGBPosition(int row=0, int col=0)
    wxGBPosition(const wxGBPosition& pos)

    int GetRow() const
    int GetCol() const
    void SetRow(int row)
    void SetCol(int col)

    %operator bool operator==(const wxGBPosition& p) const

%endclass

// ---------------------------------------------------------------------------
// wxGBSpan

%class %delete %noclassinfo %encapsulate wxGBSpan

    wxGBSpan(int rowspan=1, int colspan=1)
    wxGBSpan(const wxGBSpan& span)

    int GetRowspan() const
    int GetColspan() const
    void SetRowspan(int rowspan)
    void SetColspan(int colspan)

    %operator bool operator==(const wxGBSpan& o) const

%endclass

// ---------------------------------------------------------------------------
// wxGBSizerItem

%class wxGBSizerItem, wxSizerItem

    wxGBSizerItem()
    wxGBSizerItem( int width, int height, const wxGBPosition& pos, const wxGBSpan& span, int flag, int border, wxObject* userData)
    wxGBSizerItem( wxWindow *window, const wxGBPosition& pos, const wxGBSpan& span, int flag, int border, wxObject* userData )
    wxGBSizerItem( wxSizer *sizer, const wxGBPosition& pos, const wxGBSpan& span, int flag, int border, wxObject* userData )

    wxGBPosition GetPos() const
    //void GetPos(int& row, int& col) const;
    wxGBSpan GetSpan() const
    //void GetSpan(int& rowspan, int& colspan) const;
    bool SetPos( const wxGBPosition& pos )
    bool SetSpan( const wxGBSpan& span )
    bool Intersects(const wxGBSizerItem& other)
    bool Intersects(const wxGBPosition& pos, const wxGBSpan& span)

    // %override [int row, int col] wxGBSizerItem::GetEndPos()
    // C++ Func: void GetEndPos(int& row, int& col)
    void GetEndPos()

    wxGridBagSizer* GetGBSizer() const
    void SetGBSizer(wxGridBagSizer* sizer)

%endclass

// ---------------------------------------------------------------------------
// wxNotebookSizer - deprecated

%if wxUSE_NOTEBOOK && (!%wxchkver_2_6)

%class wxNotebookSizer, wxSizer

    wxNotebookSizer(wxNotebook* notebook)
    wxNotebook* GetNotebook()

%endclass

%endif //wxUSE_NOTEBOOK && (!%wxchkver_2_6)

// ---------------------------------------------------------------------------
// wxBookCtrlSizer - also depricated since 2.6

// ---------------------------------------------------------------------------
// wxStaticBoxSizer

%if wxUSE_STATBOX

%class wxStaticBoxSizer, wxBoxSizer

    wxStaticBoxSizer(wxStaticBox* box, int orient)
    wxStaticBoxSizer(int orient, wxWindow *parent, const wxString& label = "")

    wxStaticBox* GetStaticBox()

%endclass

%endif //wxUSE_STATBOX

// ---------------------------------------------------------------------------
// wxStdDialogButtonSizer

%if wxUSE_BUTTON

%class wxStdDialogButtonSizer, wxBoxSizer

    wxStdDialogButtonSizer()

    void AddButton(wxButton *button)
    void SetAffirmativeButton( wxButton *button )
    void SetNegativeButton( wxButton *button )
    void SetCancelButton( wxButton *button )

    void Realize()

    wxButton *GetAffirmativeButton() const
    wxButton *GetApplyButton() const
    wxButton *GetNegativeButton() const
    wxButton *GetCancelButton() const
    wxButton *GetHelpButton() const

%endclass

%endif //wxUSE_BUTTON

%endif //wxLUA_USE_wxSizer

// ---------------------------------------------------------------------------
// wxLayoutConstraints - deprecated since 2.2, not updated to 2.6

%if wxLUA_USE_wxLayoutConstraints && (!%wxchkver_2_6)

%include "wx/layout.h"

%enum wxRelationship

    wxUnconstrained
    wxAsIs
    wxPercentOf
    wxAbove
    wxBelow
    wxLeftOf
    wxRightOf
    wxSameAs
    wxAbsolute

%endenum

%enum wxEdge

    wxLeft
    wxTop
    wxRight
    wxBottom
    wxWidth
    wxHeight
    wxCentre
    wxCenter
    wxCentreX
    wxCentreY

%endenum

%class wxLayoutConstraints, wxObject

    wxLayoutConstraints()

%endclass

// ---------------------------------------------------------------------------
// wxIndividualLayoutConstraint

%include "wx/layout.h"

%class wxIndividualLayoutConstraint, wxObject

    wxIndividualLayoutConstraint()
    void Above(wxWindow *otherWin, int margin = 0)
    void Absolute(int value)
    void AsIs()
    void Below(wxWindow *otherWin, int margin = 0)
    void Unconstrained()
    void LeftOf(wxWindow *otherWin, int margin = 0)
    void PercentOf(wxWindow *otherWin, wxEdge edge, int per)
    void RightOf(wxWindow *otherWin, int margin = 0)
    void SameAs(wxWindow *otherWin, wxEdge edge, int margin = 0)
    void Set(wxRelationship rel, wxWindow *otherWin, wxEdge otherEdge, int value = 0, int margin = 0)

%endclass

%endif //wxLUA_USE_wxLayoutConstraints && (!%wxchkver_2_6)


wxwidgets/wxcore_windows.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxWindow and other container type windows
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================


%wxchkver_2_8 %function wxWindow* wxFindFocusDescendant(wxWindow* ancestor)

// ---------------------------------------------------------------------------
// wxTooltip

%if wxLUA_USE_wxTooltip && wxUSE_TOOLTIPS

%include "wx/tooltip.h"

%class %delete wxToolTip, wxObject

    wxToolTip(const wxString &tip)

    static void Enable(bool flag)
    static void SetDelay(long milliseconds)
    void SetTip(const wxString& tip)
    wxString GetTip()
    wxWindow *GetWindow() const

%endclass

%endif //wxLUA_USE_wxTooltip && wxUSE_TOOLTIPS


// ---------------------------------------------------------------------------
// wxWindowDisabler

%include "wx/utils.h"

%class %delete %noclassinfo %encapsulate wxWindowDisabler

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxWindowDisabler(wxWindow *winToSkip = NULL)

%endclass

// ---------------------------------------------------------------------------
// wxWindowUpdateLocker - Note this only calls wxWindow::Freeze() -> Thaw()

%include "wx/wupdlock.h"

%class %delete %noclassinfo %encapsulate wxWindowUpdateLocker

    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxWindowUpdateLocker(wxWindow *winToLock = NULL)

%endclass

// ---------------------------------------------------------------------------
// wxWindow
%define wxSIMPLE_BORDER
%define wxDOUBLE_BORDER
%define wxSUNKEN_BORDER
%define wxRAISED_BORDER
%define wxSTATIC_BORDER
//%define wxNO_BORDER in defsutils.i
%define wxTRANSPARENT_WINDOW
%define wxNO_3D
%define wxTAB_TRAVERSAL
%define wxWANTS_CHARS
%define wxVSCROLL
%define wxHSCROLL
%define wxALWAYS_SHOW_SB
%define wxCLIP_CHILDREN
%define wxNO_FULL_REPAINT_ON_RESIZE
%define wxFULL_REPAINT_ON_RESIZE

%define wxWS_EX_VALIDATE_RECURSIVELY
%define wxWS_EX_BLOCK_EVENTS
%define wxWS_EX_TRANSIENT
%define wxWS_EX_PROCESS_IDLE
%define wxWS_EX_PROCESS_UI_UPDATES

%enum wxWindowVariant

    wxWINDOW_VARIANT_NORMAL
    wxWINDOW_VARIANT_SMALL
    wxWINDOW_VARIANT_MINI
    wxWINDOW_VARIANT_LARGE
    wxWINDOW_VARIANT_MAX

%endenum

%enum wxUpdateUI

    wxUPDATE_UI_NONE
    wxUPDATE_UI_RECURSE
    wxUPDATE_UI_FROMIDLE

%endenum

//%mac|%x11|%motif %typedef void* WXWidget
//%gtk %typedef unsigned long WXWidget // GtkWidget* what could you do with it?
//%mgl %typedef window_t WXWidget
//%msw|%os2 %typedef unsigned long WXWidget

%class %delete %noclassinfo %encapsulate wxVisualAttributes

    %member wxFont font
    %member wxColour colFg
    %member wxColour colBg

%endclass


%class wxWindow, wxEvtHandler

    wxWindow()
    wxWindow(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxWindow")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxWindow")

    virtual void AddChild(wxWindow* child)
    void CacheBestSize(const wxSize& size) const
    virtual void CaptureMouse()
    void Center(int direction = wxBOTH)
    void CenterOnParent(int direction = wxBOTH)
    !%wxchkver_2_8 void CenterOnScreen(int direction = wxBOTH)
    void Centre(int direction = wxBOTH)
    void CentreOnParent(int direction = wxBOTH)
    !%wxchkver_2_8 void CentreOnScreen(int direction = wxBOTH)
    !%wxchkver_2_6 void Clear()
    %wxchkver_2_6 void ClearBackground()

    // %override [int x, int y] ClientToScreen(int x, int y) const
    // C++ Func: virtual void ClientToScreen(int* x, int* y) const
    %override_name wxLua_wxWindow_ClientToScreenXY virtual void ClientToScreen(int x, int y) const

    virtual wxPoint ClientToScreen(const wxPoint& pt) const
    virtual bool Close(bool force = false)
    wxPoint ConvertDialogToPixels(const wxPoint& pt)
    wxSize ConvertDialogToPixels(const wxSize& sz)
    wxPoint ConvertPixelsToDialog(const wxPoint& pt)
    wxSize ConvertPixelsToDialog(const wxSize& sz)
    virtual bool Destroy()
    virtual void DestroyChildren()
    bool Disable()
    // virtual wxSize DoGetBestSize() const protected
    //virtual void DoUpdateWindowUI(wxUpdateUIEvent& event)
    %win virtual void DragAcceptFiles(bool accept)
    virtual void Enable(bool enable)
    static wxWindow* FindFocus()
    wxWindow* FindWindow(long id)
    wxWindow* FindWindow(const wxString& name)
    static wxWindow* FindWindowById(long id, wxWindow* parent = NULL)
    static wxWindow* FindWindowByName(const wxString& name, wxWindow* parent = NULL)
    static wxWindow* FindWindowByLabel(const wxString& label, wxWindow* parent = NULL)
    virtual void Fit()
    virtual void FitInside()
    virtual void Freeze()
    wxAcceleratorTable* GetAcceleratorTable() const
    //wxAccessible* GetAccessible()
    !%wxchkver_2_8 wxSize GetAdjustedBestSize() const
    virtual wxColour GetBackgroundColour() const
    virtual wxBackgroundStyle GetBackgroundStyle() const
    wxSize GetBestFittingSize() const // deprecated in 2.8 use GetEffectiveMinSize
    virtual wxSize GetBestSize() const
    wxCaret* GetCaret() const
    static wxWindow* GetCapture()
    virtual int GetCharHeight() const
    virtual int GetCharWidth() const
    wxWindowList& GetChildren()
    //static wxVisualAttributes GetClassDefaultAttributes(wxWindowVariant variant = wxWINDOW_VARIANT_NORMAL)

    // %override [int width, int height] wxWindow::GetClientSizeWH() const
    // C++ Func: virtual void GetClientSize(int* width, int* height) const
    %rename GetClientSizeWH virtual void GetClientSize() const

    wxSize GetClientSize() const
    !%wxchkver_2_6 wxLayoutConstraints* GetConstraints() const // deprecated use sizers
    const wxSizer* GetContainingSizer() const
    wxCursor GetCursor() const
    virtual wxVisualAttributes GetDefaultAttributes() const
    !%wxchkver_2_8 wxWindow* GetDefaultItem() const
    wxDropTarget* GetDropTarget() const
    wxEvtHandler* GetEventHandler() const
    long GetExtraStyle() const
    wxFont GetFont() const
    virtual wxColour GetForegroundColour()
    wxWindow* GetGrandParent() const
    void* GetHandle() const
    virtual wxString GetHelpText() const
    int GetId() const
    virtual wxString GetLabel() const
    wxSize GetMaxSize() const
    wxSize GetMinSize() const
    virtual wxString GetName() const
    virtual wxWindow* GetParent() const

    // %override [int x, int y] wxWindow::GetPositionXY() const
    // C++ Func: virtual void GetPosition(int* x, int* y) const
    %override_name wxLua_wxWindow_GetPositionXY %rename GetPositionXY virtual void GetPosition() const

    wxPoint GetPosition() const
    virtual wxRect GetRect() const

    // %override [int x, int y] wxWindow::GetScreenPositionXY() const
    // C++ Func: virtual void GetScreenPosition(int* x, int* y) const
    %override_name wxLua_wxWindow_GetScreenPositionXY %rename GetScreenPositionXY virtual void GetScreenPosition() const

    virtual wxPoint GetScreenPosition()
    virtual wxRect GetScreenRect() const
    virtual int GetScrollPos(int orientation)
    virtual int GetScrollRange(int orientation)
    virtual int GetScrollThumb(int orientation)
    virtual wxSize GetSize() const

    // %override [int width, int height] wxWindow::GetSizeWH() const
    // C++ Func: virtual void GetSize(int* width, int* height) const
    %rename GetSizeWH virtual void GetSize() const

    wxSizer* GetSizer() const

    // %override [int x, int y, int descent, int externalLeading] wxWindow::GetTextExtent(const wxString& string, const wxFont* font = NULL ) const
    // Note: Cannot use use16 from Lua, virtual void GetTextExtent(const wxString& string, int* x, int* y, int* descent = NULL, int* externalLeading = NULL, const wxFont* font = NULL, bool use16 = false) const
    // C++ Func: virtual void GetTextExtent(const wxString& string, int* x, int* y, int* descent = NULL, int* externalLeading = NULL, const wxFont* font = NULL ) const
    virtual void GetTextExtent(const wxString& string, const wxFont* font = NULL ) const

    !%wxchkver_2_8 virtual wxString GetTitle()
    wxToolTip* GetToolTip() const
    virtual wxRegion GetUpdateRegion() const
    wxValidator* GetValidator() const

    // %override [int width, int height] wxWindow::GetVirtualSizeWH() const
    // C++ Func: void GetVirtualSize(int* width, int* height) const
    %override_name wxLua_wxWindow_GetVirtualSizeWH %rename GetVirtualSizeWH void GetVirtualSize() const

    wxSize GetVirtualSize() const
    long GetWindowStyleFlag() const
    wxWindowVariant GetWindowVariant() const
    %wxchkver_2_4 bool HasCapture() const
    virtual bool HasScrollbar(int orient) const
    virtual bool HasTransparentBackground() const
    bool Hide()
    void InheritAttributes()
    void InitDialog()
    void InvalidateBestSize()
    virtual bool IsEnabled() const
    bool IsExposed(int x, int y) const
    bool IsExposed(const wxPoint &pt) const
    bool IsExposed(int x, int y, int w, int h) const
    bool IsExposed(const wxRect &rect) const
    virtual bool IsRetained() const
    virtual bool IsShown() const
    bool IsTopLevel() const
    void Layout()
    void Lower()
    virtual void MakeModal(bool flag)
    void Move(int x, int y)
    void Move(const wxPoint& pt)
    void MoveAfterInTabOrder(wxWindow *win)
    void MoveBeforeInTabOrder(wxWindow *win)
    bool Navigate(int flags = wxNavigationKeyEvent::IsForward)
    wxEvtHandler* PopEventHandler(bool deleteHandler = false) const
    bool PopupMenu(wxMenu* menu, const wxPoint& pos = wxDefaultPosition)
    bool PopupMenu(wxMenu* menu, int x, int y)
    void PushEventHandler(wxEvtHandler* handler)
    void Raise()
    virtual void Refresh(bool eraseBackground = true, const wxRect* rect = NULL)
    // don't need to worry about rect, void RefreshRect(const wxRect& rect, bool eraseBackground = true)
    // %win bool RegisterHotKey(int hotkeyId, int modifiers, int virtualKeyCode) - only under WinCE
    virtual void ReleaseMouse()
    virtual void RemoveChild(wxWindow* child)
    bool RemoveEventHandler(wxEvtHandler *handler)
    virtual bool Reparent(wxWindow* newParent)
    virtual wxPoint ScreenToClient(const wxPoint& pt) const

    // %override [int x, int y] wxWindow::ScreenToClient(int x, int y) const
    // C++ Func: virtual void ScreenToClient(int* x, int* y) const
    %override_name wxLua_wxWindow_ScreenToClientXY virtual void ScreenToClient(int x, int y) const

    virtual bool ScrollLines(int lines)
    virtual bool ScrollPages(int pages)
    virtual void ScrollWindow(int dx, int dy, const wxRect* rect = NULL)
    virtual void SetAcceleratorTable(const wxAcceleratorTable& accel)
    //void SetAccessible(wxAccessible* accessible)
    void SetAutoLayout(bool autoLayout)
    virtual void SetBackgroundColour(const wxColour& colour)
    virtual void SetBackgroundStyle(wxBackgroundStyle style)
    !%wxchkver_2_8 void SetBestFittingSize(const wxSize& size = wxDefaultSize) // deprecated in 2.8 use SetInitialSize
    void SetCaret(wxCaret *caret) const
    virtual void SetClientSize(const wxSize& size)
    virtual void SetClientSize(int width, int height)
    void SetContainingSizer(wxSizer* sizer)
    virtual void SetCursor(const wxCursor& cursor)
    !%wxchkver_2_6 void SetConstraints(wxLayoutConstraints* constraints)
    !%wxchkver_2_8 wxWindow* SetDefaultItem(wxWindow *win)
    // virtual void SetInitialBestSize(const wxSize& size) protected
    %wxchkver_2_8 void SetInitialSize(const wxSize& size = wxDefaultSize)
    void SetMaxSize(const wxSize& size)
    void SetMinSize(const wxSize& size)
    void SetOwnBackgroundColour(const wxColour& colour)
    void SetOwnFont(const wxFont& font)
    void SetOwnForegroundColour(const wxColour& colour)
    void SetDropTarget(wxDropTarget* target)
    void SetEventHandler(wxEvtHandler* handler)
    void SetExtraStyle(long exStyle)
    virtual void SetFocus()
    //virtual void SetFocusFromKbd()
    void SetFont(const wxFont& font)
    virtual void SetForegroundColour(const wxColour& colour)
    virtual void SetHelpText(const wxString& helpText)
    void SetId(int id)
    virtual void SetLabel(const wxString& label)
    virtual void SetName(const wxString& name)
    // virtual void SetPalette(wxPalette* palette) - obsolete
    virtual void SetScrollbar(int orientation, int position, int thumbSize, int range, bool refresh = true)
    virtual void SetScrollPos(int orientation, int pos, bool refresh = true)
    virtual void SetSize(int x, int y, int width, int height, int sizeFlags = wxSIZE_AUTO)
    virtual void SetSize(int width, int height)
    void SetSize(const wxSize& size)
    virtual void SetSize(const wxRect& rect)
    virtual void SetSizeHints(int minW, int minH, int maxW=-1, int maxH=-1, int incW=-1, int incH=-1)
    void SetSizeHints(const wxSize& minSize, const wxSize& maxSize=wxDefaultSize, const wxSize& incSize=wxDefaultSize)
    void SetSizer(wxSizer* sizer, bool deleteOld=true)
    void SetSizerAndFit(wxSizer* sizer, bool deleteOld=true)
    !%wxchkver_2_8 virtual void SetTitle(const wxString& title)
    virtual void SetThemeEnabled(bool enable)
    void SetToolTip(const wxString& tip)
    void SetToolTip(%ungc wxToolTip* tip)
    virtual void SetValidator(const wxValidator& validator)
    void SetVirtualSize(int width, int height)
    void SetVirtualSize(const wxSize& size)
    virtual void SetVirtualSizeHints(int minW,int minH, int maxW=-1, int maxH=-1)
    void SetVirtualSizeHints(const wxSize& minSize=wxDefaultSize, const wxSize& maxSize=wxDefaultSize)
    void SetWindowStyle(long style)
    virtual void SetWindowStyleFlag(long style)
    void SetWindowVariant(wxWindowVariant variant)
    virtual bool ShouldInheritColours()
    virtual bool Show(bool show = true)
    virtual void Thaw()
    virtual bool TransferDataFromWindow()
    virtual bool TransferDataToWindow()
    //%win bool UnregisterHotKey(int hotkeyId) - only under WinCE
    virtual void Update()
    virtual void UpdateWindowUI(long flags = wxUPDATE_UI_NONE)
    virtual bool Validate()
    void WarpPointer(int x, int y)

%endclass

// ---------------------------------------------------------------------------
// wxWindowList

%if wxLUA_USE_wxWindowList && !wxUSE_STL

%class %noclassinfo wxWindowList, wxList

    //wxWindowList() - no constructor, just get this from wxWindow::GetChildren()

    // This is returned from wxWindow::GetChildren(), use wxList methods and
    // wxNode::GetData():DynamicCast("wxWindow") to retrieve the wxWindow

    // Use the wxList methods, see also wxNode

%endclass

%endif //wxLUA_USE_wxWindowList && !wxUSE_STL

// ---------------------------------------------------------------------------
// wxPanel

%class wxPanel, wxWindow

    wxPanel()
    wxPanel(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTAB_TRAVERSAL, const wxString& name = "wxPanel")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTAB_TRAVERSAL, const wxString& name = "wxPanel")

    //!%wxchkver_2_8 wxWindow* GetDefaultItem() const - see wxWindow
    // void InitDialog() see wxWindow
    //!%wxchkver_2_8 wxWindow* SetDefaultItem(wxWindow *win) - see wxWindow
    //virtual void SetFocus() - see wxWindow
    virtual void SetFocusIgnoringChildren()

%endclass

// ---------------------------------------------------------------------------
// wxControl

%include "wx/control.h"

%class wxControl, wxWindow

    wxControl()
    wxControl(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxControl")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxControl")

    void Command(wxCommandEvent& event)
    // wxString GetLabel() // see wxWindow
    // void SetLabel(const wxString& label) // see wxWindow

    //static wxString GetLabelText(const wxString& label) translates arbitrary string, removes mnemonic characters ('&')
    %wxchkver_2_8 wxString GetLabelText() const

%endclass


// ---------------------------------------------------------------------------
// wxBookCtrlBase

%if wxLUA_USE_wxNotebook && wxUSE_BOOKCTRL

%include "wx/bookctrl.h"

%if %wxchkver_2_8
%define wxBK_DEFAULT
%define wxBK_TOP
%define wxBK_LEFT
%define wxBK_RIGHT
%define wxBK_BOTTOM
%define wxBK_ALIGN_MASK

%enum

    wxBK_HITTEST_NOWHERE
    wxBK_HITTEST_ONICON
    wxBK_HITTEST_ONLABEL
    wxBK_HITTEST_ONITEM
    wxBK_HITTEST_ONPAGE

%endenum
%endif // %wxchkver_2_8

%class wxBookCtrlBase, wxControl

    // no constructors, base class

    void AdvanceSelection(bool forward = true)
    virtual bool AddPage(wxWindow *page, const wxString& text, bool bSelect = false, int imageId = -1)
    //void AssignImageList(wxImageList *imageList)
    virtual wxSize CalcSizeFromPage(const wxSize& sizePage) const
    virtual bool DeleteAllPages()
    virtual bool DeletePage(size_t n)
    wxWindow *GetCurrentPage() const
    wxImageList* GetImageList() const
    virtual wxWindow *GetPage(size_t n)
    virtual size_t GetPageCount() const
    virtual int GetPageImage(size_t n) const
    virtual wxString GetPageText(size_t n) const
    virtual int GetSelection() const
    virtual bool InsertPage(size_t n, wxWindow *page, const wxString& text, bool bSelect = false, int imageId = -1)
    virtual bool RemovePage(size_t n)
    virtual void SetImageList(wxImageList *imageList)
    virtual bool SetPageImage(size_t n, int imageId)
    virtual void SetPageSize(const wxSize& size)
    virtual bool SetPageText(size_t n, const wxString& strText)
    virtual int SetSelection(size_t n)

    %if %wxchkver_2_8
    unsigned int GetInternalBorder() const
    void SetInternalBorder(unsigned int border)
    void SetControlMargin(int margin)
    int GetControlMargin() const
    bool IsVertical() const
    void SetFitToCurrentPage(bool fit)
    bool GetFitToCurrentPage() const

    %wxchkver_2_8 virtual int ChangeSelection(size_t n)

    //virtual int HitTest(const wxPoint& pt, long* flags = NULL) const FIXME add this
    //virtual bool HasMultiplePages() const - FIXME do we need this?

    wxSizer* GetControlSizer() const
    %endif // %wxchkver_2_8

%endclass

// ---------------------------------------------------------------------------
// wxBookCtrlBaseEvent

%class %delete wxBookCtrlBaseEvent, wxNotifyEvent

    wxBookCtrlBaseEvent(wxEventType commandType = wxEVT_NULL, int winid = 0, int nSel = -1, int nOldSel = -1)

    int GetOldSelection() const
    int GetSelection() const // note : must override wxCommandEvent func since it's not virtual
    void SetOldSelection(int page)
    void SetSelection(int page)

%endclass

%endif //wxLUA_USE_wxNotebook && wxUSE_BOOKCTRL

// ---------------------------------------------------------------------------
// wxNotebook

%if wxLUA_USE_wxNotebook && wxUSE_NOTEBOOK

%include "wx/notebook.h"

//%if !%wxchkver_2_8|%wxcompat_2_6
%define wxNB_TOP // use wxBK_XXX after 2.6
%define wxNB_LEFT
%define wxNB_RIGHT
%define wxNB_BOTTOM
%define wxNB_FIXEDWIDTH
%define wxNB_MULTILINE
%define wxNB_NOPAGETHEME
//%endif // !%wxchkver_2_8|%wxcompat_2_6

%enum

    wxNB_HITTEST_NOWHERE
    wxNB_HITTEST_ONICON
    wxNB_HITTEST_ONLABEL
    wxNB_HITTEST_ONITEM

%endenum

// %typedef wxWindow wxNotebookPage // GloaEdit: Effectively unused.

%class wxNotebook, wxBookCtrlBase

    wxNotebook()
    wxNotebook(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxNotebook")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxNotebook")

    // NOTE: All remmed out functions are located in wxBookCtrlBase

    //bool AddPage(wxNotebookPage* page, const wxString& text, bool select = false, int imageId = -1)
    //void AdvanceSelection(bool forward = true)
    //void AssignImageList(wxImageList* imageList)
    //bool DeleteAllPages()
    //bool DeletePage(int page)
    //wxWindow* GetCurrentPage() const
    //wxImageList* GetImageList() const
    //wxNotebookPage* GetPage(int page)
    //int GetPageCount() const
    //int GetPageImage(int nPage) const
    //wxString GetPageText(int nPage) const
    int GetRowCount() const
    //int GetSelection() const
    wxColour GetThemeBackgroundColour() const

    // %override [int page, int flags] wxNotebook::HitTest(const wxPoint& pt)
    // C++ Func: int HitTest(const wxPoint& pt, long *flags = NULL)
    int HitTest(const wxPoint& pt)

    //bool InsertPage(int index, wxNotebookPage* page, const wxString& text, bool select = false, int imageId = -1)
    //bool RemovePage(int page)
    //void SetImageList(wxImageList* imageList)
    void SetPadding(const wxSize& padding)
    //void SetPageSize(const wxSize& size)
    //bool SetPageImage(int page, int image)
    //bool SetPageText(int page, const wxString& text)
    //int SetSelection(int page)

%endclass

// ---------------------------------------------------------------------------
// wxNotebookEvent

%class %delete wxNotebookEvent, wxBookCtrlBaseEvent

    %define_event wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED // EVT_NOTEBOOK_PAGE_CHANGED(winid, fn)
    %define_event wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING // EVT_NOTEBOOK_PAGE_CHANGING(winid, fn)

    wxNotebookEvent(wxEventType eventType = wxEVT_NULL, int id = 0, int sel = -1, int oldSel = -1)

    // functions in wxBookCtrlBaseEvent
    //int GetOldSelection() const
    //int GetSelection() const
    //void SetOldSelection(int page)
    //void SetSelection(int page)

%endclass

%endif //wxLUA_USE_wxNotebook && wxUSE_NOTEBOOK

// ---------------------------------------------------------------------------
// wxListbook

%if wxLUA_USE_wxNotebook && wxLUA_USE_wxListCtrl && wxUSE_LISTBOOK

%include "wx/listbook.h"

%define wxLB_DEFAULT
%define wxLB_TOP
%define wxLB_BOTTOM
%define wxLB_LEFT
%define wxLB_RIGHT
%define wxLB_ALIGN_MASK

%class wxListbook, wxBookCtrlBase

    wxListbook()
    wxListbook(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxListbook")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxListbook")

    // NOTE: See functions in wxBookCtrlBase

    !%wxchkver_2_8 bool IsVertical() const // in wxBookCtrlBase in 2.8
    wxListView* GetListView()

%endclass

// ---------------------------------------------------------------------------
// wxListbookEvent

%class %delete wxListbookEvent, wxBookCtrlBaseEvent

    %define_event wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED // EVT_LISTBOOK_PAGE_CHANGED(winid, fn)
    %define_event wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING // EVT_LISTBOOK_PAGE_CHANGING(winid, fn)

    wxListbookEvent(wxEventType eventType = wxEVT_NULL, int id = 0, int sel = -1, int oldSel = -1)

    // functions in wxBookCtrlBaseEvent
    //int GetOldSelection() const
    //int GetSelection() const
    //void SetOldSelection(int page)
    //void SetSelection(int page)

%endclass

%endif //wxLUA_USE_wxNotebook && wxLUA_USE_wxListCtrl && wxUSE_LISTBOOK

// ---------------------------------------------------------------------------
// wxChoicebook

%if wxLUA_USE_wxNotebook && wxLUA_USE_wxChoice && wxUSE_CHOICEBOOK

%include "wx/choicebk.h"

%define wxCHB_DEFAULT
%define wxCHB_TOP
%define wxCHB_BOTTOM
%define wxCHB_LEFT
%define wxCHB_RIGHT
%define wxCHB_ALIGN_MASK

%class wxChoicebook, wxBookCtrlBase

    wxChoicebook()
    wxChoicebook(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxChoicebook")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxChoicebook")

    // NOTE: See functions in wxBookCtrlBase

    !%wxchkver_2_8 bool IsVertical() const // in wxBookCtrlBase in 2.8
    wxChoice* GetChoiceCtrl() const

%endclass

// ---------------------------------------------------------------------------
// wxChoicebookEvent

%class %delete wxChoicebookEvent, wxBookCtrlBaseEvent

    %define_event wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED // EVT_CHOICEBOOK_PAGE_CHANGED(winid, fn)
    %define_event wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING // EVT_CHOICEBOOK_PAGE_CHANGING(winid, fn)

    wxChoicebookEvent(wxEventType eventType = wxEVT_NULL, int id = 0, int sel = -1, int oldSel = -1)

    // functions in wxBookCtrlBaseEvent
    //int GetOldSelection() const
    //int GetSelection() const
    //void SetOldSelection(int page)
    //void SetSelection(int page)

%endclass

%endif //wxLUA_USE_wxNotebook && wxLUA_USE_wxChoice && wxUSE_CHOICEBOOK

// ---------------------------------------------------------------------------
// wxTreebook

%if %wxchkver_2_8 && wxUSE_TREEBOOK && wxLUA_USE_wxTreebook

%include "wx/treebook.h"

%class wxTreebook, wxBookCtrlBase

    wxTreebook()
    wxTreebook(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxBK_DEFAULT, const wxString& name = "wxTreebook")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxBK_DEFAULT,const wxString& name = "wxTreebook")

    virtual bool InsertPage(size_t pos, wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool InsertSubPage(size_t pos, wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool AddPage(wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool AddSubPage(wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool IsNodeExpanded(size_t pos) const;

    virtual bool ExpandNode(size_t pos, bool expand = true);
    bool CollapseNode(size_t pos)
    int GetPageParent(size_t pos) const;
    wxTreeCtrl* GetTreeCtrl() const

%endclass

// ---------------------------------------------------------------------------
// wxTreebookEvent

%class %delete wxTreebookEvent, wxBookCtrlBaseEvent

    %define_event wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED // EVT_TREEBOOK_PAGE_CHANGED(winid, fn)
    %define_event wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING // EVT_TREEBOOK_PAGE_CHANGING(winid, fn)
    %define_event wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED // EVT_TREEBOOK_NODE_COLLAPSED(winid, fn)
    %define_event wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED // EVT_TREEBOOK_NODE_EXPANDED(winid, fn)

    wxTreebookEvent(const wxTreebookEvent& event)
    wxTreebookEvent(wxEventType commandType = wxEVT_NULL, int id = 0, int nSel = wxNOT_FOUND, int nOldSel = wxNOT_FOUND)

%endclass

%endif // %wxchkver_2_8 && wxUSE_TREEBOOK && wxLUA_USE_wxTreebook

// ---------------------------------------------------------------------------
// wxToolbook

%if %wxchkver_2_8 && wxUSE_TOOLBOOK && wxLUA_USE_wxToolbook

%include "wx/toolbook.h"

%class wxToolbook, wxBookCtrlBase

    wxToolbook()
    wxToolbook(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxToolbook")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxToolbook")

    wxToolBarBase* GetToolBar() const
    // must be called in OnIdle or by application to realize the toolbar and select the initial page.
    void Realize();

%endclass

// ---------------------------------------------------------------------------
// wxToolbookEvent

%class %delete wxToolbookEvent, wxBookCtrlBaseEvent

    %define_event wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED // EVT_TOOLBOOK_PAGE_CHANGED(winid, fn)
    %define_event wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING // EVT_TOOLBOOK_PAGE_CHANGING(winid, fn)

    wxToolbookEvent(const wxToolbookEvent& event)
    wxToolbookEvent(wxEventType commandType = wxEVT_NULL, int id = 0, int nSel = wxNOT_FOUND, int nOldSel = wxNOT_FOUND)

%endclass

%endif // %wxchkver_2_8 && wxUSE_TOOLBOOK && wxLUA_USE_wxToolbook

// ---------------------------------------------------------------------------
// wxTabCtrl

%if %wxchkver_2_4 && %msw && wxLUA_USE_wxTabCtrl && wxUSE_TAB_DIALOG // note: wxUSE_TAB_DIALOG is correct

%include "wx/tabctrl.h"

%class wxTabCtrl, wxControl

    %define wxTC_RIGHTJUSTIFY
    %define wxTC_FIXEDWIDTH
    %define wxTC_TOP
    %define wxTC_LEFT
    %define wxTC_RIGHT
    %define wxTC_BOTTOM
    %define wxTC_MULTILINE
    %define wxTC_OWNERDRAW

    wxTabCtrl(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxTabCtrl")
    //bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxTabCtrl")

    bool DeleteAllItems()
    bool DeleteItem(int item)
    int GetCurFocus() const
    wxImageList* GetImageList() const
    int GetItemCount() const
    wxObject * GetItemData(int item) const
    int GetItemImage(int item) const
    bool GetItemRect(int item, wxRect& rect) const
    wxString GetItemText(int item) const
    int GetRowCount() const
    int GetSelection() const
    int HitTest(const wxPoint& pt, long& flags)
    void InsertItem(int item, const wxString& text, int imageId = -1, wxObject *clientData = NULL)
    bool SetItemData(int item, wxObject * data)
    bool SetItemImage(int item, int image)
    void SetImageList(wxImageList* imageList)
    void SetItemSize(const wxSize& size)
    bool SetItemText(int item, const wxString& text)
    void SetPadding(const wxSize& padding)
    int SetSelection(int item)

%endclass

// ---------------------------------------------------------------------------
// wxTabEvent

%class %delete wxTabEvent, wxCommandEvent

    %win %define_event wxEVT_COMMAND_TAB_SEL_CHANGED // EVT_TAB_SEL_CHANGED(id, fn)
    %win %define_event wxEVT_COMMAND_TAB_SEL_CHANGING // EVT_TAB_SEL_CHANGING(id, fn)

    wxTabEvent(wxEventType commandType = 0, int id = 0)

%endclass

%endif //%wxchkver_2_4 && %msw && wxLUA_USE_wxTabCtrl && wxUSE_TAB_DIALOG


// ---------------------------------------------------------------------------
// wxScrolledWindow

%if wxLUA_USE_wxScrolledWindow

%class wxScrolledWindow, wxPanel

    wxScrolledWindow()
    wxScrolledWindow(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHSCROLL | wxVSCROLL, const wxString& name = "wxScrolledWindow")
    bool Create(wxWindow* parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHSCROLL | wxVSCROLL, const wxString& name = "wxScrolledWindow")

    // %override [int xx, int yy] wxScrolledWindow::CalcScrolledPosition(int x, int y) const
    // C++ Func: void CalcScrolledPosition( int x, int y, int *xx, int *yy) const
    void CalcScrolledPosition( int x, int y) const

    // %override [int xx, int yy] wxScrolledWindow::CalcUnscrolledPosition(int x, int y) const
    // C++ Func: void CalcUnscrolledPosition( int x, int y, int *xx, int *yy) const
    void CalcUnscrolledPosition( int x, int y) const

    void EnableScrolling(const bool xScrolling, const bool yScrolling)

    // %override [int xUnit, int yUnit] wxScrolledWindow::GetScrollPixelsPerUnit() const
    // C++ Func: void GetScrollPixelsPerUnit(int* xUnit, int* yUnit) const
    void GetScrollPixelsPerUnit() const

    // %override [int x, int y] wxScrolledWindow::GetViewStart() const
    // C++ Func: void GetViewStart(int* x, int* y) const
    void GetViewStart() const

    //// %override [int x, int y] wxScrolledWindow::GetVirtualSize() const
    //// C++ Func: void GetVirtualSize(int* x, int* y) const
    //void GetVirtualSize() const // see wxWindow::GetVirtualSize

    //bool IsRetained() const // see wxWindow::IsRetained
    void PrepareDC(wxDC& dc)
    void Scroll(int x, int y)
    void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY, int xPos = 0, int yPos = 0, bool noRefresh = false)
    void SetScrollRate(int xstep, int ystep)
    void SetTargetWindow(wxWindow* window)
    // void SetVirtualSize(int width, int height) -- see wxWindow

    //void DoPrepareDC(wxDC& dc)

%endclass

%endif //wxLUA_USE_wxScrolledWindow

// ---------------------------------------------------------------------------
// wxSplitterWindow

%if wxLUA_USE_wxSplitterWindow

%include "wx/splitter.h"

%define wxSP_NOBORDER
%define wxSP_NOSASH
%define wxSP_BORDER
%define wxSP_PERMIT_UNSPLIT
%define wxSP_LIVE_UPDATE
%define wxSP_3DSASH
%define wxSP_3DBORDER
%define wxSP_FULLSASH
%define wxSP_3D
%wxchkver_2_4 %define wxSP_NO_XP_THEME
%define wxSP_SASH_AQUA

%class wxSplitterWindow, wxWindow

    wxSplitterWindow()
    wxSplitterWindow(wxWindow* parent, wxWindowID id, const wxPoint& point = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=wxSP_3D, const wxString& name = "wxSplitterWindow")
    bool Create(wxWindow *parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSP_3D|wxCLIP_CHILDREN, const wxString& name = "wxSplitterWindow")

    int GetMinimumPaneSize() const
    double GetSashGravity()
    int GetSashPosition()
    int GetSplitMode() const
    wxWindow *GetWindow1() const
    wxWindow *GetWindow2() const
    void Initialize(wxWindow* window)
    bool IsSplit() const
    bool ReplaceWindow(wxWindow * winOld, wxWindow * winNew)
    void SetSashGravity(double gravity)
    void SetSashPosition(int position, const bool redraw = true)
    void SetSashSize(int size)
    void SetMinimumPaneSize(int paneSize)
    void SetSplitMode(int mode)
    bool SplitHorizontally(wxWindow* window1, wxWindow* window2, int sashPosition = 0)
    bool SplitVertically(wxWindow* window1, wxWindow* window2, int sashPosition = 0)
    bool Unsplit(wxWindow* toRemove = NULL)
    void UpdateSize()

%endclass

// ---------------------------------------------------------------------------
// wxSplitterEvent

%class %delete wxSplitterEvent, wxNotifyEvent

    %define_event wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING // EVT_SPLITTER_SASH_POS_CHANGING(id, fn)
    %define_event wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED // EVT_SPLITTER_SASH_POS_CHANGED(id, fn)
    %define_event wxEVT_COMMAND_SPLITTER_DOUBLECLICKED // EVT_SPLITTER_DCLICK(id, fn)
    %define_event wxEVT_COMMAND_SPLITTER_UNSPLIT // EVT_SPLITTER_UNSPLIT(id, fn)

    wxSplitterEvent(wxEventType type = wxEVT_NULL, wxSplitterWindow *splitter = NULL)

    // NOTE! These functions will assert if you call them for an unspupported
    // event type. Please refer to the wxWidgets C++ manual.
    int GetSashPosition()
    int GetX()
    int GetY()
    wxWindow* GetWindowBeingRemoved()
    void SetSashPosition(int pos)

%endclass

%endif //wxLUA_USE_wxSplitterWindow


// ---------------------------------------------------------------------------
// wxCollapsiblePane

%if %wxchkver_2_8 && wxLUA_USE_wxCollapsiblePane && wxUSE_COLLPANE

%include "wx/collpane.h"

%define wxCP_DEFAULT_STYLE

%class wxCollapsiblePane, wxControl

    wxCollapsiblePane()
    wxCollapsiblePane(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCollapsiblePane")
    bool Create(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCollapsiblePane")

    bool IsCollapsed() const
    bool IsExpanded() const
    void Collapse(bool collapse = true)
    void Expand()
    wxWindow* GetPane() const

%endclass

// ---------------------------------------------------------------------------
// wxCollapsiblePaneEvent

%class %delete wxCollapsiblePaneEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_COLLPANE_CHANGED // EVT_COLLAPSIBLEPANE_CHANGED(id, fn)

    wxCollapsiblePaneEvent()
    wxCollapsiblePaneEvent(wxObject *generator, int id, bool collapsed)

    bool GetCollapsed() const
    void SetCollapsed(bool c)

%endclass

%endif // %wxchkver_2_8 && wxLUA_USE_wxCollapsiblePane && wxUSE_COLLPANE

// ---------------------------------------------------------------------------
// wxStaticBox

%if wxLUA_USE_wxStaticBox && wxUSE_STATBOX

%include "wx/statbox.h"

%class wxStaticBox, wxControl

    wxStaticBox()
    wxStaticBox(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBox")

%endclass

%endif //wxLUA_USE_wxStaticBox && wxUSE_STATBOX

// ---------------------------------------------------------------------------
// wxStaticBitmap

%if wxLUA_USE_wxStaticBitmap && wxUSE_STATBMP

%include "wx/statbmp.h"

%class wxStaticBitmap, wxControl

    wxStaticBitmap()
    wxStaticBitmap(wxWindow* parent, wxWindowID id, const wxBitmap& label = wxNullBitmap, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBitmap")
    bool Create(wxWindow* parent, wxWindowID id, const wxBitmap& label = wxNullBitmap, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBitmap")

    wxBitmap GetBitmap() const
    virtual void SetBitmap(const wxBitmap& label)

%endclass

%endif //wxLUA_USE_wxStaticBitmap && wxUSE_STATBMP

// ---------------------------------------------------------------------------
// wxStaticText

%if wxLUA_USE_wxStaticText && wxUSE_STATTEXT

%include "wx/stattext.h"

%define wxST_NO_AUTORESIZE
%wxchkver_2_8 %define wxST_DOTS_MIDDLE
%wxchkver_2_8 %define wxST_DOTS_END

%class wxStaticText, wxControl

    wxStaticText()
    wxStaticText(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticText")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticText")

    // wxString GetLabel() const - see wxWindow
    // void SetLabel(const wxString& label) - see wxWindow
    void Wrap(int width)

%endclass

%endif //wxLUA_USE_wxStaticText && wxUSE_STATTEXT

// ---------------------------------------------------------------------------
// wxStaticLine

%if wxLUA_USE_wxStaticLine && wxUSE_STATLINE

%include "wx/statline.h"

%define wxLI_HORIZONTAL
%define wxLI_VERTICAL

%class wxStaticLine, wxControl

    wxStaticLine()
    wxStaticLine(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxLI_HORIZONTAL, const wxString& name = "wxStaticLine")
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticLine")

    bool IsVertical() const
    static int GetDefaultSize()

%endclass

%endif //wxLUA_USE_wxStaticLine && wxUSE_STATLINE

wxwidgets/wxadv_adv.i - Lua table = 'wx'
// ===========================================================================
// Purpose: Various wxAdv library classes
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxAboutDialog

%if %wxchkver_2_8 && wxUSE_ABOUTDLG && wxLUA_USE_wxAboutDialog

%include "wx/aboutdlg.h"

%class %delete %noclassinfo %encapsulate wxAboutDialogInfo

    wxAboutDialogInfo()

    void SetName(const wxString& name)
    wxString GetName() const

    void SetVersion(const wxString& version)
    bool HasVersion() const
    wxString GetVersion() const

    void SetDescription(const wxString& desc)
    bool HasDescription() const
    wxString GetDescription() const

    void SetCopyright(const wxString& copyright)
    bool HasCopyright() const
    wxString GetCopyright() const

    void SetLicence(const wxString& licence)
    void SetLicense(const wxString& licence)
    bool HasLicence() const
    wxString GetLicence() const

    void SetIcon(const wxIcon& icon)
    bool HasIcon() const
    wxIcon GetIcon() const

    void SetWebSite(const wxString& url, const wxString& desc = "")
    bool HasWebSite() const

    wxString GetWebSiteURL() const
    wxString GetWebSiteDescription() const

    void SetDevelopers(const wxArrayString& developers)
    void AddDeveloper(const wxString& developer)
    bool HasDevelopers() const
    const wxArrayString& GetDevelopers() const

    void SetDocWriters(const wxArrayString& docwriters)
    void AddDocWriter(const wxString& docwriter)
    bool HasDocWriters() const
    wxArrayString GetDocWriters() const

    void SetArtists(const wxArrayString& artists)
    void AddArtist(const wxString& artist)
    bool HasArtists() const
    wxArrayString GetArtists() const

    void SetTranslators(const wxArrayString& translators)
    void AddTranslator(const wxString& translator)
    bool HasTranslators() const
    wxArrayString GetTranslators() const

    // implementation only
    // -------------------
    bool IsSimple() const
    wxString GetDescriptionAndCredits() const

%endclass

%function void wxAboutBox(const wxAboutDialogInfo& info)

%endif //%wxchkver_2_8 && wxUSE_ABOUTDLG && wxLUA_USE_wxAboutDialog


// ---------------------------------------------------------------------------
// wxAnimation

%if %wxchkver_2_8 && wxLUA_USE_wxAnimation && wxUSE_ANIMATIONCTRL

%include "wx/animate.h"

%enum wxAnimationType

    wxANIMATION_TYPE_INVALID
    wxANIMATION_TYPE_GIF
    wxANIMATION_TYPE_ANI

    wxANIMATION_TYPE_ANY

%endenum

%class %delete wxAnimation, wxGDIObject // ignore platform independent wxAnimationBase

    wxAnimation()
    wxAnimation(const wxAnimation& anim)
    //wxAnimation(const wxString& name, wxAnimationType type = wxANIMATION_TYPE_ANY) // doesn't exist in 2.8.4

    virtual bool IsOk() const
    virtual int GetDelay(unsigned int frame) const // can be -1
    virtual unsigned int GetFrameCount() const
    virtual wxImage GetFrame(unsigned int frame) const
    virtual wxSize GetSize() const

    virtual bool LoadFile(const wxString& name, wxAnimationType type = wxANIMATION_TYPE_ANY)
    virtual bool Load(wxInputStream& stream, wxAnimationType type = wxANIMATION_TYPE_ANY)

%endclass

// ---------------------------------------------------------------------------
// wxAnimationCtrl

%define wxAC_NO_AUTORESIZE
%define wxAC_DEFAULT_STYLE // = wxNO_BORDER

%class wxAnimationCtrl, wxControl

    wxAnimationCtrl()
    wxAnimationCtrl(wxWindow *parent, wxWindowID id, const wxAnimation& anim, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxAC_DEFAULT_STYLE, const wxString& name = "wxAnimationCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxAnimation& anim, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxAC_DEFAULT_STYLE, const wxString& name = "wxAnimationCtrl")

    // virtual bool LoadFile(const wxString& filename, wxAnimationType type = wxANIMATION_TYPE_ANY) // GloaEdit: Non-virtual variant below.

    wxAnimation GetAnimation() const
    // always return the original bitmap set in this control
    wxBitmap GetInactiveBitmap() const
    virtual bool IsPlaying() const
    bool LoadFile(const wxString& file, wxAnimationType animType = wxANIMATION_TYPE_ANY)
    virtual bool Play()
    virtual void SetAnimation(const wxAnimation &anim)
    virtual void SetInactiveBitmap(const wxBitmap &bmp)
    virtual void Stop()

%endclass

%endif // %wxchkver_2_8 && wxLUA_USE_wxAnimation && wxUSE_ANIMATIONCTRL


// ---------------------------------------------------------------------------
// wxBitmapComboBox

%if wxLUA_USE_wxBitmapComboBox && wxUSE_BITMAPCOMBOBOX

%include "wx/bmpcbox.h"

%class wxBitmapComboBox //, wxControlWithItems

    wxBitmapComboBox()
    //wxBitmapComboBox(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, int n = 0, const wxString choices[] = NULL, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "comboBox")
    wxBitmapComboBox(wxWindow* parent, wxWindowID id, const wxString& value, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxBitmapComboBox")
    //bool Create(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, int n, const wxString choices[], long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxBitmapComboBox")
    bool Create(wxWindow* parent, wxWindowID id, const wxString& value, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, const wxArrayString& choices = wxLuaNullSmartwxArrayString, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxBitmapComboBox")

    int Append(const wxString& item, const wxBitmap& bitmap = wxNullBitmap)
    int Append(const wxString& item, const wxBitmap& bitmap, voidptr_long data ) // C++ is (void *clientData) You can put a number here
    int Append(const wxString& item, const wxBitmap& bitmap, wxClientData *clientData)

    wxSize GetBitmapSize() const
    wxBitmap GetItemBitmap(unsigned int n) const

    int Insert(const wxString& item, const wxBitmap& bitmap, unsigned int pos)
    int Insert(const wxString& item, const wxBitmap& bitmap, unsigned int pos, voidptr_long data ) // C++ is (void *clientData) You can put a number here
    int Insert(const wxString& item, const wxBitmap& bitmap, unsigned int pos, wxClientData *clientData)

    void SetItemBitmap(unsigned int n, const wxBitmap& bitmap)

%endclass

%endif //wxLUA_USE_wxBitmapComboBox && wxUSE_BITMAPCOMBOBOX


// ---------------------------------------------------------------------------
// wxCalendarCtrl

%if wxLUA_USE_wxCalendarCtrl && wxUSE_CALENDARCTRL

%include "wx/calctrl.h"

%enum

    wxCAL_SUNDAY_FIRST
    wxCAL_MONDAY_FIRST
    wxCAL_SHOW_HOLIDAYS
    wxCAL_NO_YEAR_CHANGE
    wxCAL_NO_MONTH_CHANGE
    wxCAL_SHOW_SURROUNDING_WEEKS
    wxCAL_SEQUENTIAL_MONTH_SELECTION

%endenum

%enum wxCalendarHitTestResult

    wxCAL_HITTEST_NOWHERE
    wxCAL_HITTEST_HEADER
    wxCAL_HITTEST_DAY
    wxCAL_HITTEST_INCMONTH
    wxCAL_HITTEST_DECMONTH
    wxCAL_HITTEST_SURROUNDING_WEEK

%endenum

%enum wxCalendarDateBorder

    wxCAL_BORDER_NONE
    wxCAL_BORDER_SQUARE
    wxCAL_BORDER_ROUND

%endenum

%class wxCalendarCtrl, wxControl

    wxCalendarCtrl(wxWindow* parent, wxWindowID id, const wxDateTime& date = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCAL_SHOW_HOLIDAYS, const wxString& name = "wxCalendarCtrl")
    //bool Create(wxWindow* parent, wxWindowID id, const wxDateTime& date = wxDefaultDateTime, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCAL_SHOW_HOLIDAYS, const wxString& name = "wxCalendarCtrl")

    void SetDate(const wxDateTime& date)
    wxDateTime GetDate() const
    void EnableYearChange(bool enable = true)
    void EnableMonthChange(bool enable = true)
    void EnableHolidayDisplay(bool display = true)
    void SetHeaderColours(const wxColour& colFg, const wxColour& colBg)
    wxColour GetHeaderColourFg() const
    wxColour GetHeaderColourBg() const
    void SetHighlightColours(const wxColour& colFg, const wxColour& colBg)
    wxColour GetHighlightColourFg() const
    wxColour GetHighlightColourBg() const
    void SetHolidayColours(const wxColour& colFg, const wxColour& colBg)
    wxColour GetHolidayColourFg() const
    wxColour GetHolidayColourBg() const
    wxCalendarDateAttr* GetAttr(size_t day) const
    void SetAttr(size_t day, %ungc wxCalendarDateAttr* attr) // will delete previously set attr as well
    void SetHoliday(size_t day)
    void ResetAttr(size_t day)

    // %override [wxCalendarHitTestResult, wxDateTime date, wxDateTime::WeekDay wd] wxCalendarCtrl::HitTest(const wxPoint& pos)
    // C++ Func: wxCalendarHitTestResult HitTest(const wxPoint& pos, wxDateTime* date = NULL, wxDateTime::WeekDay* wd = NULL)
    wxCalendarHitTestResult HitTest(const wxPoint& pos)

%endclass

// ---------------------------------------------------------------------------
// wxCalendarDateAttr

%class %delete %noclassinfo %encapsulate wxCalendarDateAttr

    wxCalendarDateAttr()
    wxCalendarDateAttr(const wxColour& colText, const wxColour& colBack = wxNullColour, const wxColour& colBorder = wxNullColour, const wxFont& font = wxNullFont, wxCalendarDateBorder border = wxCAL_BORDER_NONE)
    wxCalendarDateAttr(wxCalendarDateBorder border, const wxColour& colBorder = wxNullColour)

    void SetTextColour(const wxColour& colText)
    void SetBackgroundColour(const wxColour& colBack)
    void SetBorderColour(const wxColour& col)
    void SetFont(const wxFont& font)
    void SetBorder(wxCalendarDateBorder border)
    void SetHoliday(bool holiday)
    bool HasTextColour() const
    bool HasBackgroundColour() const
    bool HasBorderColour() const
    bool HasFont() const
    bool HasBorder() const
    bool IsHoliday() const
    wxColour GetTextColour() const
    wxColour GetBackgroundColour()
    wxColour GetBorderColour() const
    wxFont GetFont() const
    wxCalendarDateBorder GetBorder()

%endclass

// ---------------------------------------------------------------------------
// wxDateEvent

%include "wx/dateevt.h"

%class %delete wxDateEvent, wxCommandEvent

    %define_event wxEVT_DATE_CHANGED // EVT_DATE_CHANGED(id, fn)

    wxDateEvent(wxWindow *win, const wxDateTime& dt, wxEventType type)

    const wxDateTime& GetDate() const
    void SetDate(const wxDateTime &date)

%endclass

// ---------------------------------------------------------------------------
// wxCalendarEvent

%include "wx/event.h"

%class %delete wxCalendarEvent, wxDateEvent

    %define_event wxEVT_CALENDAR_SEL_CHANGED // EVT_CALENDAR_SEL_CHANGED(id, fn)
    %define_event wxEVT_CALENDAR_DAY_CHANGED // EVT_CALENDAR_DAY(id, fn)
    %define_event wxEVT_CALENDAR_MONTH_CHANGED // EVT_CALENDAR_MONTH(id, fn)
    %define_event wxEVT_CALENDAR_YEAR_CHANGED // EVT_CALENDAR_YEAR(id, fn)
    %define_event wxEVT_CALENDAR_DOUBLECLICKED // EVT_CALENDAR(id, fn)
    %define_event wxEVT_CALENDAR_WEEKDAY_CLICKED // EVT_CALENDAR_WEEKDAY_CLICKED(id, fn)

    wxCalendarEvent(wxCalendarCtrl *cal, wxEventType type)

    wxDateTime::WeekDay GetWeekDay() const
    void SetWeekDay(const wxDateTime::WeekDay wd)

%endclass

%endif //wxLUA_USE_wxCalendarCtrl && wxUSE_CALENDARCTRL


// ---------------------------------------------------------------------------
// wxHyperlinkCtrl

%if %wxchkver_2_8 && wxUSE_HYPERLINKCTRL && wxLUA_USE_wxHyperlinkCtrl

%include "wx/hyperlink.h"

%define wxHL_CONTEXTMENU
%define wxHL_ALIGN_LEFT
%define wxHL_ALIGN_RIGHT
%define wxHL_ALIGN_CENTRE
%define wxHL_DEFAULT_STYLE // (wxHL_CONTEXTMENU|wxNO_BORDER|wxHL_ALIGN_CENTRE)

%class wxHyperlinkCtrl, wxControl

    wxHyperlinkCtrl()
    wxHyperlinkCtrl(wxWindow *parent, wxWindowID id, const wxString& label, const wxString& url, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHL_DEFAULT_STYLE, const wxString& name = "wxHyperlinkCtrl")
    bool Create(wxWindow *parent, wxWindowID id, const wxString& label, const wxString& url, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHL_DEFAULT_STYLE, const wxString& name = "wxHyperlinkCtrl");

    wxColour GetHoverColour() const
    wxColour GetNormalColour() const
    wxColour GetVisitedColour() const
    bool GetVisited() const
    wxString GetURL() const

    void SetHoverColour(const wxColour &colour)
    void SetNormalColour(const wxColour &colour);
    void SetVisitedColour(const wxColour &colour);
    void SetVisited(bool visited = true)
    void SetURL (const wxString &url)

%endclass

// ---------------------------------------------------------------------------
// wxHyperlinkEvent

%class %delete wxHyperlinkEvent, wxCommandEvent

    %define_event wxEVT_COMMAND_HYPERLINK // EVT_HYPERLINK(id, fn)

    //wxHyperlinkEvent()
    wxHyperlinkEvent(wxObject *generator, wxWindowID id, const wxString& url)

    wxString GetURL() const
    void SetURL(const wxString &url)

%endclass

%endif // %wxchkver_2_8 && wxUSE_HYPERLINKCTRL && wxLUA_USE_wxHyperlinkCtrl


// ---------------------------------------------------------------------------
// wxSashWindow

%if wxLUA_USE_wxSashWindow && wxUSE_SASH

%include "wx/sashwin.h"

%define wxSW_3D
%define wxSW_3DSASH
%define wxSW_3DBORDER
%define wxSW_BORDER

%enum wxSashEdgePosition

    wxSASH_TOP
    wxSASH_RIGHT
    wxSASH_BOTTOM
    wxSASH_LEFT
    wxSASH_NONE

%endenum

%enum wxSashDragStatus

    wxSASH_STATUS_OK
    wxSASH_STATUS_OUT_OF_RANGE

%endenum

%class wxSashWindow, wxWindow

    wxSashWindow()
    wxSashWindow(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSW_3D|wxCLIP_CHILDREN, const wxString& name = "wxSashWindow")

    bool GetSashVisible(wxSashEdgePosition edge) const
    int GetMaximumSizeX() const
    int GetMaximumSizeY() const
    int GetMinimumSizeX() const
    int GetMinimumSizeY() const

    bool HasBorder(wxSashEdgePosition edge) const
    void SetMaximumSizeX(int min)
    void SetMaximumSizeY(int min)
    void SetMinimumSizeX(int min)
    void SetMinimumSizeY(int min)
    void SetSashVisible(wxSashEdgePosition edge, bool visible)
    void SetSashBorder(wxSashEdgePosition edge, bool hasBorder)

%endclass

// ---------------------------------------------------------------------------
// wxSashLayoutWindow

%include "wx/laywin.h"

%enum wxLayoutAlignment

    wxLAYOUT_NONE
    wxLAYOUT_TOP
    wxLAYOUT_LEFT
    wxLAYOUT_RIGHT
    wxLAYOUT_BOTTOM

%endenum

%enum wxLayoutOrientation

    wxLAYOUT_HORIZONTAL
    wxLAYOUT_VERTICAL

%endenum

%class wxSashLayoutWindow, wxSashWindow

    wxSashLayoutWindow()
    wxSashLayoutWindow(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSW_3D|wxCLIP_CHILDREN, const wxString& name = "wxSashLayoutWindow")
    bool Create(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSW_3D|wxCLIP_CHILDREN, const wxString& name = "wxSashLayoutWindow")

    wxLayoutAlignment GetAlignment() const
    wxLayoutOrientation GetOrientation() const
    //void OnCalculateLayout(wxCalculateLayoutEvent& event)
    //void OnQueryLayoutInfo(wxQueryLayoutInfoEvent& event)
    void SetAlignment(wxLayoutAlignment alignment)
    void SetDefaultSize(const wxSize& size)
    void SetOrientation(wxLayoutOrientation orientation)

%endclass

// ---------------------------------------------------------------------------
// wxLayoutAlgorithm - for wxSashLayoutWindow

%include "wx/laywin.h"

%class %delete %noclassinfo wxLayoutAlgorithm, wxObject

    wxLayoutAlgorithm()

    bool LayoutFrame(wxFrame* frame, wxWindow* mainWindow = NULL) const
    bool LayoutMDIFrame(wxMDIParentFrame* frame, wxRect* rect = NULL)
    bool LayoutWindow(wxWindow* frame, wxWindow* mainWindow = NULL)

%endclass

// ---------------------------------------------------------------------------
// wxQueryLayoutInfoEvent - for wxSashLayoutWindow

%include "wx/laywin.h"

%class %delete wxQueryLayoutInfoEvent, wxEvent

    %define_event wxEVT_QUERY_LAYOUT_INFO // EVT_QUERY_LAYOUT_INFO(func)

    wxQueryLayoutInfoEvent(wxWindowID id = 0)

    wxLayoutAlignment GetAlignment() const
    int GetFlags() const
    wxLayoutOrientation GetOrientation() const
    int GetRequestedLength() const
    wxSize GetSize() const
    void SetAlignment(wxLayoutAlignment alignment)
    void SetFlags(int flags)
    void SetOrientation(wxLayoutOrientation orientation)
    void SetRequestedLength(int length)
    void SetSize(const wxSize& size)

%endclass

// ---------------------------------------------------------------------------
// wxCalculateLayoutEvent - for wxSashLayoutWindow

%include "wx/laywin.h"

%class %delete wxCalculateLayoutEvent, wxEvent

    %define_event wxEVT_CALCULATE_LAYOUT // EVT_CALCULATE_LAYOUT(func)

    wxCalculateLayoutEvent(wxWindowID id = 0)

    int GetFlags() const
    wxRect GetRect() const
    void SetFlags(int flags)
    void SetRect(const wxRect& rect)

%endclass

// ---------------------------------------------------------------------------
// wxSashEvent

%class %delete wxSashEvent, wxCommandEvent

    %define_event wxEVT_SASH_DRAGGED // EVT_SASH_DRAGGED(id, fn) EVT_SASH_DRAGGED_RANGE(id1, id2, fn)

    wxSashEvent(int id = 0, wxSashEdgePosition edge = wxSASH_NONE)

    void SetEdge(wxSashEdgePosition edge)
    int GetEdge()
    void SetDragRect(const wxRect& rect)
    wxRect GetDragRect()
    void SetDragStatus(wxSashDragStatus status)
    int GetDragStatus()

%endclass

%endif //wxLUA_USE_wxSashWindow && wxUSE_SASH


// ---------------------------------------------------------------------------
// wxSplashScreen

%if wxLUA_USE_wxSplashScreen

%include "wx/splash.h"

%define wxSPLASH_CENTRE_ON_PARENT
%define wxSPLASH_CENTRE_ON_SCREEN
%define wxSPLASH_NO_CENTRE
%define wxSPLASH_TIMEOUT
%define wxSPLASH_NO_TIMEOUT

%class wxSplashScreen, wxFrame

    wxSplashScreen(const wxBitmap& bitmap, long splashStyle, int milliseconds, wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSIMPLE_BORDER|wxFRAME_NO_TASKBAR|wxSTAY_ON_TOP)

    long GetSplashStyle() const
    wxSplashScreenWindow* GetSplashWindow() const
    int GetTimeout() const

%endclass

%class wxSplashScreenWindow, wxWindow

    // don't need to create this, just get it from wxSplashScreen

    void SetBitmap(const wxBitmap& bitmap)
    wxBitmap& GetBitmap()

%endclass

%endif //wxLUA_USE_wxSplashScreen


// ---------------------------------------------------------------------------
// wxWizard

%if wxUSE_WIZARDDLG && wxLUA_USE_wxWizard

%include "wx/wizard.h"

%define wxWIZARD_EX_HELPBUTTON

%class wxWizard, wxDialog

    wxWizard()
    wxWizard(wxWindow* parent, int id = -1, const wxString& title = "", const wxBitmap& bitmap = wxNullBitmap, const wxPoint& pos = wxDefaultPosition, long style = wxDEFAULT_DIALOG_STYLE)
    bool Create(wxWindow* parent, int id = -1, const wxString& title = "", const wxBitmap& bitmap = wxNullBitmap, const wxPoint& pos = wxDefaultPosition, long style = wxDEFAULT_DIALOG_STYLE)

    wxWizardPage* GetCurrentPage() const
    virtual wxSizer* GetPageAreaSizer() const
    wxSize GetPageSize() const
    virtual bool HasNextPage(wxWizardPage *page)
    virtual bool HasPrevPage(wxWizardPage *page)
    bool RunWizard(wxWizardPage* firstPage)
    void SetPageSize(const wxSize& sizePage)
    void SetBorder(int border)

%endclass

// ---------------------------------------------------------------------------
// wxWizardPage - this has virtual functions so it can't be used?

%class wxWizardPage, wxPanel

    //wxWizardPage(wxWizard* parent, const wxBitmap& bitmap = wxNullBitmap, const wxChar *resource = NULL)

    //virtual wxWizardPage* GetPrev() const // FIXME not virtual for wxLua
    //virtual wxWizardPage* GetNext() const
    wxBitmap GetBitmap() const

%endclass

// ---------------------------------------------------------------------------
// wxWizardPageSimple - use this

%class wxWizardPageSimple, wxWizardPage

    wxWizardPageSimple(wxWizard* parent = NULL, wxWizardPage* prev = NULL, wxWizardPage* next = NULL, const wxBitmap& bitmap = wxNullBitmap)

    virtual wxWizardPage* GetPrev() const
    virtual wxWizardPage* GetNext() const

    void SetPrev(wxWizardPage* prev)
    void SetNext(wxWizardPage* next)
    static void Chain(wxWizardPageSimple* first, wxWizardPageSimple* second)

%endclass

// ---------------------------------------------------------------------------
// wxWizardEvent

%class %delete wxWizardEvent, wxNotifyEvent

    %define_event wxEVT_WIZARD_CANCEL // EVT_WIZARD_CANCEL(id, fn)
    %define_event wxEVT_WIZARD_PAGE_CHANGED // EVT_WIZARD_PAGE_CHANGED(id, fn)
    %define_event wxEVT_WIZARD_PAGE_CHANGING // EVT_WIZARD_PAGE_CHANGING(id, fn)
    %define_event wxEVT_WIZARD_HELP // EVT_WIZARD_HELP(id, fn)
    %define_event wxEVT_WIZARD_FINISHED // EVT_WIZARD_FINISHED(id, fn)

    wxWizardEvent(wxEventType type = wxEVT_NULL, int id = -1, bool direction = true)

    bool GetDirection() const
    wxWizardPage* GetPage() const

%endclass

%endif //wxUSE_WIZARDDLG && wxLUA_USE_wxWizard


// ---------------------------------------------------------------------------
// wxTaskBarIcon

%if wxLUA_USE_wxTaskBarIcon && defined(wxHAS_TASK_BAR_ICON)

%include "wx/taskbar.h"

%class %delete wxTaskBarIcon, wxEvtHandler

    wxTaskBarIcon()

    // virtual wxMenu* CreatePopupMenu()
    bool IsIconInstalled()
    %wxchkver_2_4 bool IsOk()
    virtual bool PopupMenu(wxMenu* menu)

    // call RemoveIcon() or delete this if you want your program to exit, must have called SetIcon()
    bool RemoveIcon()
    // call SetIcon() to have the taskbar icon displayed
    bool SetIcon(const wxIcon& icon, const wxString& tooltip)

%endclass

// ---------------------------------------------------------------------------
// wxTaskBarIconEvent

%class %delete %noclassinfo wxTaskBarIconEvent, wxEvent

    %define_event wxEVT_TASKBAR_MOVE // EVT_TASKBAR_MOVE(func)
    %define_event wxEVT_TASKBAR_LEFT_DOWN // EVT_TASKBAR_LEFT_DOWN(func)
    %define_event wxEVT_TASKBAR_LEFT_UP // EVT_TASKBAR_LEFT_UP(func)
    %define_event wxEVT_TASKBAR_RIGHT_DOWN // EVT_TASKBAR_RIGHT_DOWN(func)
    %define_event wxEVT_TASKBAR_RIGHT_UP // EVT_TASKBAR_RIGHT_UP(func)
    %define_event wxEVT_TASKBAR_LEFT_DCLICK // EVT_TASKBAR_LEFT_DCLICK(func)
    %define_event wxEVT_TASKBAR_RIGHT_DCLICK // EVT_TASKBAR_RIGHT_DCLICK(func)

    wxTaskBarIconEvent(wxEventType evtType, wxTaskBarIcon *tbIcon)

%endclass

%endif //wxLUA_USE_wxTaskBarIcon && defined(wxHAS_TASK_BAR_ICON)


// ---------------------------------------------------------------------------
// wxJoystick

%if wxLUA_USE_wxJoystick && wxUSE_JOYSTICK

%include "wx/joystick.h"

%enum

    wxJOYSTICK1
    wxJOYSTICK2

%endenum

%enum

    wxJOY_BUTTON_ANY
    wxJOY_BUTTON1
    wxJOY_BUTTON2
    wxJOY_BUTTON3
    wxJOY_BUTTON4

%endenum

%class %delete wxJoystick, wxObject

    wxJoystick(int joystick = wxJOYSTICK1)

    int GetButtonState() const
    int GetManufacturerId() const
    int GetMovementThreshold() const
    int GetNumberAxes() const
    int GetNumberButtons() const
    %wxchkver_2_8 static int GetNumberJoysticks() const
    !%wxchkver_2_8 int GetNumberJoysticks() const
    int GetPollingMax() const
    int GetPollingMin() const
    int GetProductId() const
    wxString GetProductName() const
    wxPoint GetPosition() const
    int GetPOVPosition() const
    int GetPOVCTSPosition() const
    int GetRudderMax() const
    int GetRudderMin() const
    int GetRudderPosition() const
    int GetUMax() const
    int GetUMin() const
    int GetUPosition() const
    int GetVMax() const
    int GetVMin() const
    int GetVPosition() const
    int GetXMax() const
    int GetXMin() const
    int GetYMax() const
    int GetYMin() const
    int GetZMax() const
    int GetZMin() const
    int GetZPosition() const
    bool HasPOV() const
    bool HasPOV4Dir() const
    bool HasPOVCTS() const
    bool HasRudder() const
    bool HasU() const
    bool HasV() const
    bool HasZ() const
    bool IsOk() const
    bool ReleaseCapture()
    bool SetCapture(wxWindow* win, int pollingFreq = 0)
    void SetMovementThreshold(int threshold)

%endclass

// ---------------------------------------------------------------------------
// wxJoystickEvent

%include "wx/event.h"

%class %delete wxJoystickEvent, wxEvent

    %define_event wxEVT_JOY_BUTTON_DOWN // EVT_JOY_BUTTON_DOWN(func)
    %define_event wxEVT_JOY_BUTTON_UP // EVT_JOY_BUTTON_UP(func)
    %define_event wxEVT_JOY_MOVE // EVT_JOY_MOVE(func)
    %define_event wxEVT_JOY_ZMOVE // EVT_JOY_ZMOVE(func)

    wxJoystickEvent(wxEventType eventType = wxEVT_NULL, int state = 0, int joystick = wxJOYSTICK1, int change = 0)

    bool ButtonDown(int button = wxJOY_BUTTON_ANY) const
    bool ButtonIsDown(int button = wxJOY_BUTTON_ANY) const
    bool ButtonUp(int button = wxJOY_BUTTON_ANY) const
    int GetButtonChange() const
    int GetButtonState() const
    int GetJoystick() const
    wxPoint GetPosition() const
    int GetZPosition() const
    bool IsButton() const
    bool IsMove() const
    bool IsZMove() const

%endclass

%endif //wxLUA_USE_wxJoystick && wxUSE_JOYSTICK


// ---------------------------------------------------------------------------
// wxSound

%if wxLUA_USE_wxWave

wxUSE_SOUND|(%msw&wxUSE_WAVE) %define wxSOUND_SYNC
wxUSE_SOUND|(%msw&wxUSE_WAVE) %define wxSOUND_ASYNC
wxUSE_SOUND|(%msw&wxUSE_WAVE) %define wxSOUND_LOOP

%if %wxchkver_2_6 && wxUSE_SOUND

%include "wx/sound.h"

%class %delete %noclassinfo wxSound, wxObject

    wxSound()
    wxSound(const wxString& fileName, bool isResource = false)
    //wxSound(int size, const wxByte* data)
    bool Create(const wxString& fileName, bool isResource = false)
    //bool Create(int size, const wxByte* data)

    bool IsOk() const
    !%win static bool IsPlaying() const
    bool Play(unsigned int flags = wxSOUND_ASYNC) const
    static bool Play(const wxString& filename, unsigned int flags = wxSOUND_ASYNC)
    static void Stop()

%endclass

%endif // %wxchkver_2_6 && wxUSE_SOUND

// ---------------------------------------------------------------------------
// wxWave

%if %msw && !%wxchkver_2_6 && wxUSE_WAVE

%include "wx/wave.h"

%class %delete %noclassinfo wxWave, wxObject

    wxWave()
    wxWave(const wxString& fileName, bool isResource = false)
    bool Create(const wxString& fileName, bool isResource = false)

    bool IsOk() const
    !%wxchkver_2_6 bool Play(bool async = true, bool looped = false) const
    %wxchkver_2_6 bool Play(unsigned int flags = wxSOUND_ASYNC) const

%endclass

%endif // %msw && !%wxchkver_2_6 && wxUSE_WAVE

%endif //wxLUA_USE_wxWave


wxwidgets/wxadv_grid.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxGrid and related classes (Updated using grid.h NOT docs)
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxGrid && wxUSE_GRID

%include "wx/grid.h"
%include "wx/generic/gridctrl.h"

%define WXGRID_DEFAULT_NUMBER_ROWS
%define WXGRID_DEFAULT_NUMBER_COLS
%define WXGRID_DEFAULT_ROW_HEIGHT
%define WXGRID_DEFAULT_COL_WIDTH
%define WXGRID_DEFAULT_COL_LABEL_HEIGHT
%define WXGRID_DEFAULT_ROW_LABEL_WIDTH
%define WXGRID_LABEL_EDGE_ZONE
%define WXGRID_MIN_ROW_HEIGHT
%define WXGRID_MIN_COL_WIDTH
%define WXGRID_DEFAULT_SCROLLBAR_WIDTH

%define_string wxGRID_VALUE_STRING
%define_string wxGRID_VALUE_BOOL
%define_string wxGRID_VALUE_NUMBER
%define_string wxGRID_VALUE_FLOAT
%define_string wxGRID_VALUE_CHOICE
%define_string wxGRID_VALUE_TEXT
%define_string wxGRID_VALUE_LONG

%define_string wxGRID_VALUE_CHOICEINT
%define_string wxGRID_VALUE_DATETIME

%wxchkver_2_8_8 %define wxGRID_AUTOSIZE

// ---------------------------------------------------------------------------
// wxGridCellWorker

%class %delete %noclassinfo %encapsulate wxGridCellWorker, wxClientDataContainer

    // wxGridCellWorker() - base class only

    void IncRef()
    void DecRef()

    int GetRef() const // wxLua added function to help track if it needs to be refed

    virtual void SetParameters(const wxString& params)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellRenderer

%class %delete %noclassinfo %encapsulate wxGridCellRenderer, wxGridCellWorker

    //wxGridCellRenderer() - no constructor abstract class

    //virtual void Draw(wxGrid& grid, wxGridCellAttr& attr, wxDC& dc, const wxRect& rect, int row, int col, bool isSelected)
    virtual wxSize GetBestSize(wxGrid& grid, wxGridCellAttr& attr, wxDC& dc, int row, int col)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellStringRenderer

%class %delete %noclassinfo %encapsulate wxGridCellStringRenderer, wxGridCellRenderer

    wxGridCellStringRenderer()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellNumberRenderer

%class %delete %noclassinfo %encapsulate wxGridCellNumberRenderer, wxGridCellStringRenderer

    wxGridCellNumberRenderer()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellFloatRenderer

%class %delete %noclassinfo %encapsulate wxGridCellFloatRenderer, wxGridCellStringRenderer

    wxGridCellFloatRenderer(int width = -1, int precision = -1)

    int GetWidth() const
    void SetWidth(int width)
    int GetPrecision() const
    void SetPrecision(int precision)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellBoolRenderer

%class %delete %noclassinfo %encapsulate wxGridCellBoolRenderer, wxGridCellRenderer

    wxGridCellBoolRenderer()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellDateTimeRenderer

%class %delete %noclassinfo %encapsulate wxGridCellDateTimeRenderer, wxGridCellStringRenderer

    wxGridCellDateTimeRenderer(const wxString& outformat = wxDefaultDateTimeFormat, const wxString& informat = wxDefaultDateTimeFormat)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellEnumRenderer

%class %delete %noclassinfo %encapsulate wxGridCellEnumRenderer, wxGridCellStringRenderer

    wxGridCellEnumRenderer( const wxString& choices = "" )

%endclass

// ---------------------------------------------------------------------------
// wxGridCellAutoWrapStringRenderer

%class %delete %noclassinfo %encapsulate wxGridCellAutoWrapStringRenderer, wxGridCellStringRenderer

    wxGridCellAutoWrapStringRenderer()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellEditor

%class %delete %noclassinfo %encapsulate wxGridCellEditor, wxGridCellWorker

    // wxGridCellEditor() - no constructor abstract class

    bool IsCreated()
    wxControl* GetControl()
    // wxLua Note: This will delete the control
    void SetControl(%ungc wxControl* control)
    wxGridCellAttr* GetCellAttr()
    // wxLua Note: the attr must exist for the life of this object and it doesn't take ownership
    void SetCellAttr(wxGridCellAttr* attr)

    //virtual void Create(wxWindow* parent, wxWindowID id, wxEvtHandler* evtHandler)
    virtual void BeginEdit(int row, int col, wxGrid* grid)
    virtual bool EndEdit(int row, int col, wxGrid* grid)
    virtual void Reset()
    //virtual wxGridCellEditor *Clone() const
    virtual void SetSize(const wxRect& rect)
    virtual void Show(bool show, wxGridCellAttr *attr = NULL)
    virtual void PaintBackground(const wxRect& rectCell, wxGridCellAttr *attr)
    virtual bool IsAcceptedKey(wxKeyEvent& event)
    virtual void StartingKey(wxKeyEvent& event)
    virtual void StartingClick()
    virtual void HandleReturn(wxKeyEvent& event)
    virtual void Destroy()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellTextEditor

%class %delete %noclassinfo %encapsulate wxGridCellTextEditor, wxGridCellEditor

    wxGridCellTextEditor()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellNumberEditor

%class %delete %noclassinfo %encapsulate wxGridCellNumberEditor, wxGridCellTextEditor

    wxGridCellNumberEditor(int min = -1, int max = -1)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellFloatEditor

%class %delete %noclassinfo %encapsulate wxGridCellFloatEditor, wxGridCellTextEditor

    wxGridCellFloatEditor(int width = -1, int precision = -1)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellBoolEditor

%class %delete %noclassinfo %encapsulate wxGridCellBoolEditor, wxGridCellEditor

    wxGridCellBoolEditor()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellChoiceEditor

%class %delete %noclassinfo %encapsulate wxGridCellChoiceEditor, wxGridCellEditor

    wxGridCellChoiceEditor(const wxArrayString& choices, bool allowOthers = false)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellEnumEditor

%class %delete %noclassinfo %encapsulate wxGridCellEnumEditor, wxGridCellChoiceEditor

    wxGridCellEnumEditor( const wxString& choices = "" )

%endclass

// ---------------------------------------------------------------------------
// wxGridCellAutoWrapStringEditor

%class %delete %noclassinfo %encapsulate wxGridCellAutoWrapStringEditor, wxGridCellTextEditor

    wxGridCellAutoWrapStringEditor()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellAttr

%enum wxGridCellAttr::wxAttrKind

    Any
    Default
    Cell
    Row
    Col
    Merged

%endenum

%class %delete %noclassinfo %encapsulate wxGridCellAttr, wxClientDataContainer

    wxGridCellAttr()
    wxGridCellAttr(const wxColour& colText, const wxColour& colBack, const wxFont& font, int hAlign, int vAlign)

    void MergeWith(wxGridCellAttr *mergefrom)
    void IncRef()
    void DecRef()
    void SetTextColour(const wxColour& colText)
    void SetBackgroundColour(const wxColour& colBack)
    void SetFont(const wxFont& font)
    void SetAlignment(int hAlign, int vAlign)
    void SetSize(int num_rows, int num_cols)
    void SetOverflow(bool allow = true)
    void SetReadOnly(bool isReadOnly = true)
    // wxLua Note: the renderer must exist for the life of this object and it doesn't take ownership, but it does call DecRef()
    void SetRenderer(wxGridCellRenderer *renderer)
    // wxLua Note: the editor must exist for the life of this object and it doesn't take ownership, but it does call DecRef()
    void SetEditor(wxGridCellEditor* editor)
    void SetKind(wxGridCellAttr::wxAttrKind kind)
    bool HasTextColour() const
    bool HasBackgroundColour() const
    bool HasFont() const
    bool HasAlignment() const
    bool HasRenderer() const
    bool HasEditor() const
    bool HasReadWriteMode() const
    bool HasOverflowMode() const
    bool HasSize() const
    wxColour GetTextColour() const
    wxColour GetBackgroundColour() const
    wxFont GetFont() const

    // %override [int horiz, int vert] wxGridCellAttr::GetAlignment() const
    // C++ Func: void GetAlignment(int *horz, int *vert) const
    void GetAlignment() const

    // %override [int num_rows, int num_cols] wxGridCellAttr::GetSize() const
    // C++ Func: void GetSize(int *num_rows, int *num_cols) const
    void GetSize() const

    bool GetOverflow() const
    wxGridCellRenderer *GetRenderer(wxGrid* grid, int row, int col) const
    wxGridCellEditor *GetEditor(wxGrid* grid, int row, int col) const
    bool IsReadOnly() const
    wxGridCellAttr::wxAttrKind GetKind()
    // wxLua Note: the attr must exist for the life of this object and it doesn't take ownership
    void SetDefAttr(wxGridCellAttr* defAttr)

%endclass

// ---------------------------------------------------------------------------
// wxGridCellAttrProvider

%class %delete %noclassinfo %encapsulate wxGridCellAttrProvider, wxClientDataContainer

    wxGridCellAttrProvider()

    // wxLua Note: You must call DecRef() on the returned attr.
    wxGridCellAttr *GetAttr(int row, int col, wxGridCellAttr::wxAttrKind kind) const
    void SetAttr(%ungc wxGridCellAttr *attr, int row, int col)
    void SetRowAttr(%ungc wxGridCellAttr *attr, int row)
    void SetColAttr(%ungc wxGridCellAttr *attr, int col)
    void UpdateAttrRows( size_t pos, int numRows )
    void UpdateAttrCols( size_t pos, int numCols )

%endclass

// ---------------------------------------------------------------------------
// wxGridTableBase

%class wxGridTableBase, wxObject //, wxClientDataContainer

    // no constructor pure virtual base class

    virtual int GetNumberRows()
    virtual int GetNumberCols()
    virtual bool IsEmptyCell( int row, int col )
    virtual wxString GetValue( int row, int col )
    virtual void SetValue( int row, int col, const wxString& value )
    virtual wxString GetTypeName( int row, int col )
    virtual bool CanGetValueAs( int row, int col, const wxString& typeName )
    virtual bool CanSetValueAs( int row, int col, const wxString& typeName )
    virtual bool GetValueAsBool( int row, int col )
    virtual long GetValueAsLong( int row, int col )
    virtual double GetValueAsDouble( int row, int col )
    virtual void SetValueAsBool( int row, int col, bool value )
    virtual void SetValueAsLong( int row, int col, long value )
    virtual void SetValueAsDouble( int row, int col, double value )
    //virtual void* GetValueAsCustom( int row, int col, const wxString& typeName )
    //virtual void SetValueAsCustom( int row, int col, const wxString& typeName, void* value )
    virtual void SetView( wxGrid *grid )
    virtual wxGrid * GetView() const
    virtual void Clear()
    virtual bool InsertRows( size_t pos = 0, size_t numRows = 1 )
    virtual bool AppendRows( size_t numRows = 1 )
    virtual bool DeleteRows( size_t pos = 0, size_t numRows = 1 )
    virtual bool InsertCols( size_t pos = 0, size_t numCols = 1 )
    virtual bool AppendCols( size_t numCols = 1 )
    virtual bool DeleteCols( size_t pos = 0, size_t numCols = 1 )
    virtual wxString GetRowLabelValue( int row )
    virtual wxString GetColLabelValue( int col )
    virtual void SetRowLabelValue( int row, const wxString& value )
    virtual void SetColLabelValue( int col, const wxString& value )

    void SetAttrProvider(wxGridCellAttrProvider *attrProvider)
    wxGridCellAttrProvider *GetAttrProvider() const
    virtual bool CanHaveAttributes()
    virtual wxGridCellAttr* GetAttr( int row, int col, wxGridCellAttr::wxAttrKind kind)

    void SetAttr(%ungc wxGridCellAttr* attr, int row, int col)
    void SetRowAttr(%ungc wxGridCellAttr *attr, int row)
    void SetColAttr(%ungc wxGridCellAttr *attr, int col)

%endclass

// ---------------------------------------------------------------------------
// wxLuaGridTableBase

%include "wxbind/include/wxadv_wxladv.h"

%class %delete wxLuaGridTableBase, wxGridTableBase

    // %override - the C++ function takes the wxLuaState as the first param
    wxLuaGridTableBase()

    // The functions below are all virtual functions that you override in Lua.

    // You must override these functions in a derived table class
    //
    //virtual int GetNumberRows();
    //virtual int GetNumberCols();
    //virtual bool IsEmptyCell( int row, int col );
    //virtual wxString GetValue( int row, int col );
    //virtual void SetValue( int row, int col, const wxString& value );
    //
    // Data type determination and value access
    //virtual wxString GetTypeName( int row, int col );
    //virtual bool CanGetValueAs( int row, int col, const wxString& typeName );
    //virtual bool CanSetValueAs( int row, int col, const wxString& typeName );
    //
    //virtual long GetValueAsLong( int row, int col );
    //virtual double GetValueAsDouble( int row, int col );
    //virtual bool GetValueAsBool( int row, int col );
    //
    //virtual void SetValueAsLong( int row, int col, long value );
    //virtual void SetValueAsDouble( int row, int col, double value );
    //virtual void SetValueAsBool( int row, int col, bool value );
    //
    // For user defined types
    //virtual void* GetValueAsCustom( int row, int col, const wxString& typeName );
    //virtual void SetValueAsCustom( int row, int col, const wxString& typeName, void* value );
    //
    // Overriding these is optional
    //
    //virtual void SetView( wxGrid *grid ) { m_view = grid; }
    //virtual wxGrid * GetView() const { return m_view; }
    //
    //virtual void Clear() {}
    //virtual bool InsertRows( size_t pos = 0, size_t numRows = 1 );
    //virtual bool AppendRows( size_t numRows = 1 );
    //virtual bool DeleteRows( size_t pos = 0, size_t numRows = 1 );
    //virtual bool InsertCols( size_t pos = 0, size_t numCols = 1 );
    //virtual bool AppendCols( size_t numCols = 1 );
    //virtual bool DeleteCols( size_t pos = 0, size_t numCols = 1 );
    //
    //virtual wxString GetRowLabelValue( int row );
    //virtual wxString GetColLabelValue( int col );
    //virtual void SetRowLabelValue( int WXUNUSED(row), const wxString& ) {}
    //virtual void SetColLabelValue( int WXUNUSED(col), const wxString& ) {}
    //
    // Attribute handling
    //
    // give us the attr provider to use - we take ownership of the pointer
    //void SetAttrProvider(wxGridCellAttrProvider *attrProvider);
    //
    // get the currently used attr provider (may be NULL)
    //wxGridCellAttrProvider *GetAttrProvider() const { return m_attrProvider; }
    //
    // Does this table allow attributes? Default implementation creates
    // a wxGridCellAttrProvider if necessary.
    //virtual bool CanHaveAttributes();
    //
    // by default forwarded to wxGridCellAttrProvider if any. May be
    // overridden to handle attributes directly in the table.
    //virtual wxGridCellAttr *GetAttr( int row, int col,
    // wxGridCellAttr::wxAttrKind kind );
    //
    // these functions take ownership of the pointer
    //virtual void SetAttr(wxGridCellAttr* attr, int row, int col);
    //virtual void SetRowAttr(wxGridCellAttr *attr, int row);
    //virtual void SetColAttr(wxGridCellAttr *attr, int col);

%endclass

// ---------------------------------------------------------------------------
// wxGridStringTable

%class %delete wxGridStringTable, wxGridTableBase

    wxGridStringTable( int numRows=0, int numCols=0 )

%endclass

// ---------------------------------------------------------------------------
// wxGridTableMessage

%enum wxGridTableRequest

    wxGRIDTABLE_REQUEST_VIEW_GET_VALUES
    wxGRIDTABLE_REQUEST_VIEW_SEND_VALUES
    wxGRIDTABLE_NOTIFY_ROWS_INSERTED
    wxGRIDTABLE_NOTIFY_ROWS_APPENDED
    wxGRIDTABLE_NOTIFY_ROWS_DELETED
    wxGRIDTABLE_NOTIFY_COLS_INSERTED
    wxGRIDTABLE_NOTIFY_COLS_APPENDED
    wxGRIDTABLE_NOTIFY_COLS_DELETED

%endenum


%class %delete %noclassinfo %encapsulate wxGridTableMessage

    wxGridTableMessage( wxGridTableBase *table, int id, int comInt1 = -1, int comInt2 = -1 )

    void SetTableObject( wxGridTableBase *table )
    wxGridTableBase * GetTableObject() const
    void SetId( int id )
    int GetId()
    void SetCommandInt( int comInt1 )
    int GetCommandInt()
    void SetCommandInt2( int comInt2 )
    int GetCommandInt2()

%endclass

// ---------------------------------------------------------------------------
// wxGridCellCoords

%class %delete %noclassinfo %encapsulate wxGridCellCoords

    %define_object wxGridNoCellCoords

    wxGridCellCoords( int r = -1, int c = -1 )

    int GetRow() const
    void SetRow( int n )
    int GetCol() const
    void SetCol( int n )
    void Set(int row, int col)

    %operator wxGridCellCoords& operator=( const wxGridCellCoords& other )
    %operator bool operator==( const wxGridCellCoords& other ) const
    %operator bool operator!() const

%endclass

// ---------------------------------------------------------------------------
// wxGridCellCoordsArray

%include "wx/dynarray.h"

%class %delete %noclassinfo %encapsulate wxGridCellCoordsArray

    wxGridCellCoordsArray()
    wxGridCellCoordsArray(const wxGridCellCoordsArray& array)

    void Add( const wxGridCellCoords& c )
    void Alloc(size_t count)
    void Clear()
    int GetCount() const
    bool IsEmpty() const
    void Insert( const wxGridCellCoords& c, int n, int copies = 1 )
    wxGridCellCoords Item( int n )
    void RemoveAt(size_t index)
    void Shrink()

    %operator wxGridCellCoords operator[](size_t nIndex)

%endclass

// ---------------------------------------------------------------------------
// wxGrid

%enum wxGrid::wxGridSelectionModes

    wxGridSelectCells
    wxGridSelectRows
    wxGridSelectColumns

%endenum

%class wxGrid, wxScrolledWindow

    wxGrid( wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxWANTS_CHARS, const wxString &name = "wxGrid" )

    bool CreateGrid( int numRows, int numCols, wxGrid::wxGridSelectionModes selmode = wxGrid::wxGridSelectCells )

    void SetSelectionMode(wxGrid::wxGridSelectionModes selmode)
    wxGrid::wxGridSelectionModes GetSelectionMode() const
    int GetNumberRows()
    int GetNumberCols()

    //wxArrayInt CalcRowLabelsExposed( const wxRegion& reg )
    //wxArrayInt CalcColLabelsExposed( const wxRegion& reg )
    //wxGridCellCoordsArray CalcCellsExposed( const wxRegion& reg )
    //void ProcessRowLabelMouseEvent( wxMouseEvent& event );
    //void ProcessColLabelMouseEvent( wxMouseEvent& event );
    //void ProcessCornerLabelMouseEvent( wxMouseEvent& event );
    //void ProcessGridCellMouseEvent( wxMouseEvent& event );
    bool ProcessTableMessage( wxGridTableMessage& msg )
    //void DoEndDragResizeRow();
    //void DoEndDragResizeCol();

    wxGridTableBase * GetTable() const

    // %override - so that takeOwnership releases the table from garbage collection by Lua
    bool SetTable( wxGridTableBase * table, bool takeOwnership = false, wxGrid::wxGridSelectionModes selmode = wxGrid::wxGridSelectCells )

    void ClearGrid()
    bool InsertRows( int pos = 0, int numRows = 1, bool updateLabels=true )
    bool AppendRows( int numRows = 1, bool updateLabels=true )
    bool DeleteRows( int pos = 0, int numRows = 1, bool updateLabels=true )
    bool InsertCols( int pos = 0, int numCols = 1, bool updateLabels=true )
    bool AppendCols( int numCols = 1, bool updateLabels=true )
    bool DeleteCols( int pos = 0, int numCols = 1, bool updateLabels=true )

    //void DrawGridCellArea( wxDC& dc , const wxGridCellCoordsArray& cells );
    //void DrawGridSpace( wxDC& dc );
    //void DrawCellBorder( wxDC& dc, const wxGridCellCoords& );
    //void DrawAllGridLines( wxDC& dc, const wxRegion& reg );
    //void DrawCell( wxDC& dc, const wxGridCellCoords& );
    //void DrawHighlight(wxDC& dc, const wxGridCellCoordsArray& cells);
    //virtual void DrawCellHighlight( wxDC& dc, const wxGridCellAttr *attr );
    //virtual void DrawRowLabels( wxDC& dc, const wxArrayInt& rows );
    //virtual void DrawRowLabel( wxDC& dc, int row );
    //virtual void DrawColLabels( wxDC& dc, const wxArrayInt& cols );
    //virtual void DrawColLabel( wxDC& dc, int col );
    void DrawTextRectangle( wxDC& dc, const wxString& text, const wxRect& rect, int horizontalAlignment = wxALIGN_LEFT, int verticalAlignment = wxALIGN_TOP, int textOrientation = wxHORIZONTAL )
    //void DrawTextRectangle( wxDC& dc, const wxArrayString& lines, const wxRect&, int horizontalAlignment = wxALIGN_LEFT, int verticalAlignment = wxALIGN_TOP, int textOrientation = wxHORIZONTAL )
    void StringToLines( const wxString& value, wxArrayString& lines )

    // %override [long width, long height] wxGrid::GetTextBoxSize(wxDC& dc, const wxArrayString& lines)
    // C++ Func: void GetTextBoxSize( wxDC& dc, const wxArrayString& lines, long *width, long *height )
    void GetTextBoxSize( wxDC& dc, const wxArrayString& lines )

    void BeginBatch()
    void EndBatch()
    int GetBatchCount()
    void ForceRefresh()

    bool IsEditable()
    void EnableEditing( bool edit )
    void EnableCellEditControl( bool enable = true )
    void DisableCellEditControl()
    bool CanEnableCellControl() const
    bool IsCellEditControlEnabled() const
    bool IsCellEditControlShown() const
    bool IsCurrentCellReadOnly() const
    void ShowCellEditControl()
    void HideCellEditControl()
    void SaveEditControlValue()

    void XYToCell( int x, int y, wxGridCellCoords& coords)
    int XToCol( int x )
    int YToRow( int y )
    int XToEdgeOfCol( int x )
    int YToEdgeOfRow( int y )
    wxRect CellToRect( int row, int col )
    //wxRect CellToRect( const wxGridCellCoords& coords )
    int GetGridCursorRow()
    int GetGridCursorCol()
    bool IsVisible( int row, int col, bool wholeCellVisible = true )
    //bool IsVisible( const wxGridCellCoords& coords, bool wholeCellVisible = true )
    void MakeCellVisible( int row, int col )
    //void MakeCellVisible( const wxGridCellCoords& coords )

    void SetGridCursor( int row, int col )
    bool MoveCursorUp( bool expandSelection )
    bool MoveCursorDown( bool expandSelection )
    bool MoveCursorLeft( bool expandSelection )
    bool MoveCursorRight( bool expandSelection )
    bool MovePageDown()
    bool MovePageUp()
    bool MoveCursorUpBlock( bool expandSelection )
    bool MoveCursorDownBlock( bool expandSelection )
    bool MoveCursorLeftBlock( bool expandSelection )
    bool MoveCursorRightBlock( bool expandSelection )

    int GetDefaultRowLabelSize()
    int GetRowLabelSize()
    int GetDefaultColLabelSize()
    int GetColLabelSize()
    wxColour GetLabelBackgroundColour()
    wxColour GetLabelTextColour()
    wxFont GetLabelFont()

    // %override [int horiz, int vert] wxGrid::GetRowLabelAlignment()
    // C++ Func: void GetRowLabelAlignment( int *horiz, int *vert )
    void GetRowLabelAlignment( int *horz, int *vert )
    // %override [int horiz, int vert] wxGrid::GetColLabelAlignment()
    // C++ Func: void GetColLabelAlignment( int *horiz, int *vert )
    void GetColLabelAlignment( int *horz, int *vert )

    int GetColLabelTextOrientation()
    wxString GetRowLabelValue( int row )
    wxString GetColLabelValue( int col )
    wxColour GetGridLineColour()
    wxColour GetCellHighlightColour()
    int GetCellHighlightPenWidth()
    int GetCellHighlightROPenWidth()
    void SetRowLabelSize( int width )
    void SetColLabelSize( int height )
    void SetLabelBackgroundColour( const wxColour& backColour )
    void SetLabelTextColour( const wxColour& textColour)
    void SetLabelFont( const wxFont& labelFont)
    void SetRowLabelAlignment( int horiz, int vert )
    void SetColLabelAlignment( int horiz, int vert )
    void SetRowLabelValue( int row, const wxString& value )
    void SetColLabelValue( int col, const wxString& value)
    void SetGridLineColour( const wxColour& lineColour)
    void SetCellHighlightColour( const wxColour& highlightColour)
    void SetCellHighlightPenWidth(int width)
    void SetCellHighlightROPenWidth(int width)

    void EnableDragRowSize( bool enable = true )
    void DisableDragRowSize()
    bool CanDragRowSize()
    void EnableDragColSize( bool enable = true )
    void DisableDragColSize()
    bool CanDragColSize()
    void EnableDragGridSize(bool enable = true)
    void DisableDragGridSize()
    bool CanDragGridSize()
    void EnableDragCell( bool enable = true )
    void DisableDragCell()
    bool CanDragCell()

    void SetAttr(int row, int col, %ungc wxGridCellAttr *attr)
    void SetRowAttr(int row, %ungc wxGridCellAttr *attr)
    void SetColAttr(int col, %ungc wxGridCellAttr *attr)
    wxGridCellAttr *GetOrCreateCellAttr(int row, int col) const

    void SetColFormatBool(int col)
    void SetColFormatNumber(int col)
    void SetColFormatFloat(int col, int width = -1, int precision = -1)
    void SetColFormatCustom(int col, const wxString& typeName)

    void EnableGridLines( bool enable = true )
    bool GridLinesEnabled()

    int GetDefaultRowSize()
    int GetRowSize( int row )
    int GetDefaultColSize()
    int GetColSize( int col )
    wxColour GetDefaultCellBackgroundColour()
    wxColour GetCellBackgroundColour( int row, int col )
    wxColour GetDefaultCellTextColour()
    wxColour GetCellTextColour( int row, int col )
    wxFont GetDefaultCellFont()
    wxFont GetCellFont( int row, int col )
    void GetDefaultCellAlignment( int *horiz, int *vert )

    // %override [int horiz, int vert] wxGrid::GetCellAlignment( int row, int col )
    // C++ Func: void GetCellAlignment( int row, int col, int *horiz, int *vert )
    void GetCellAlignment( int row, int col )

    bool GetDefaultCellOverflow()
    bool GetCellOverflow( int row, int col )

    // %override [int num_rows, int num_cols] wxGrid::GetCellSize( int row, int col )
    // C++ Func: void GetCellSize( int row, int col, int *num_rows, int *num_cols )
    void GetCellSize( int row, int col )

    void SetDefaultRowSize( int height, bool resizeExistingRows = false )
    void SetRowSize( int row, int height )
    void SetDefaultColSize( int width, bool resizeExistingCols = false )
    void SetColSize( int col, int width )
    void AutoSize()
    void AutoSizeRow( int row, bool setAsMin = true )
    void AutoSizeColumn( int col, bool setAsMin = true )
    void AutoSizeRows( bool setAsMin = true )
    void AutoSizeColumns( bool setAsMin = true )
    void AutoSizeRowLabelSize( int row )
    void AutoSizeColLabelSize( int col )

    void SetColMinimalWidth( int col, int width )
    void SetRowMinimalHeight( int row, int width )
    void SetColMinimalAcceptableWidth( int width )
    void SetRowMinimalAcceptableHeight( int width )
    int GetColMinimalAcceptableWidth() const
    int GetRowMinimalAcceptableHeight() const

    void SetDefaultCellBackgroundColour( const wxColour& backColour)
    void SetCellBackgroundColour( int row, int col, const wxColour& backColour)
    void SetDefaultCellTextColour( const wxColour& textColour)
    void SetCellTextColour( int row, int col, const wxColour& textColour)
    void SetDefaultCellFont( const wxFont& cellFont)
    void SetCellFont( int row, int col, const wxFont& cellFont)
    void SetDefaultCellAlignment( int horiz, int vert )
    void SetCellAlignment( int row, int col, int horiz, int vert )
    void SetDefaultCellOverflow( bool allow )
    void SetCellOverflow( int row, int col, bool allow )
    void SetCellSize( int row, int col, int num_rows, int num_cols )

    void SetDefaultRenderer(%ungc wxGridCellRenderer *renderer)
    void SetCellRenderer(int row, int col, wxGridCellRenderer *renderer)
    wxGridCellRenderer* GetDefaultRenderer() const
    wxGridCellRenderer* GetCellRenderer(int row, int col)

    void SetDefaultEditor(%ungc wxGridCellEditor *editor)
    void SetCellEditor(int row, int col, wxGridCellEditor *editor)
    wxGridCellEditor* GetDefaultEditor() const
    wxGridCellEditor* GetCellEditor(int row, int col)

    wxString GetCellValue( int row, int col )
    // wxString GetCellValue( const wxGridCellCoords& coords )
    void SetCellValue( int row, int col, const wxString& s )
    // void SetCellValue( const wxGridCellCoords& coords, const wxString& s )

    bool IsReadOnly(int row, int col) const
    void SetReadOnly(int row, int col, bool isReadOnly = true)

    void SelectRow( int row, bool addToSelected = false )
    void SelectCol( int col, bool addToSelected = false )
    void SelectBlock( int topRow, int leftCol, int bottomRow, int rightCol, bool addToSelected = false )
    // void SelectBlock( const wxGridCellCoords& topLeft, const wxGridCellCoords& bottomRight)
    void SelectAll()
    bool IsSelection()
    void DeselectRow( int row )
    void DeselectCol( int col )
    void DeselectCell( int row, int col )
    void ClearSelection()
    bool IsInSelection( int row, int col )
    // bool IsInSelection( const wxGridCellCoords& coords )

    wxGridCellCoordsArray GetSelectedCells() const
    wxGridCellCoordsArray GetSelectionBlockTopLeft() const
    wxGridCellCoordsArray GetSelectionBlockBottomRight() const
    wxArrayInt GetSelectedRows() const
    wxArrayInt GetSelectedCols() const

    wxRect BlockToDeviceRect( const wxGridCellCoords& topLeft, const wxGridCellCoords& bottomRight )

    wxColour GetSelectionBackground() const
    wxColour GetSelectionForeground() const
    void SetSelectionBackground(const wxColour& c)
    void SetSelectionForeground(const wxColour& c)

    void RegisterDataType(const wxString& typeName, wxGridCellRenderer* renderer, wxGridCellEditor* editor)
    wxGridCellEditor* GetDefaultEditorForCell(int row, int col) const
    //wxGridCellEditor* GetDefaultEditorForCell(const wxGridCellCoords& coords) const
    wxGridCellRenderer* GetDefaultRendererForCell(int row, int col) const
    wxGridCellEditor* GetDefaultEditorForType(const wxString& typeName) const
    wxGridCellRenderer* GetDefaultRendererForType(const wxString& typeName) const
    void SetMargins(int extraWidth, int extraHeight)

    wxWindow* GetGridWindow()
    wxWindow* GetGridRowLabelWindow()
    wxWindow* GetGridColLabelWindow()
    wxWindow* GetGridCornerLabelWindow()

    //void SetScrollLineX(int x)
    //void SetScrollLineY(int y)
    //int GetScrollLineX() const
    //int GetScrollLineY() const
    //int GetScrollX(int x) const
    //int GetScrollY(int y) const

%endclass

// ---------------------------------------------------------------------------
// wxGridEvent

%class %delete wxGridEvent, wxNotifyEvent

    %define_event wxEVT_GRID_CELL_LEFT_CLICK // EVT_GRID_CELL_LEFT_CLICK(fn) // FIXME! wxEVT_CMD_GRID_XXX in > 2.6
    %define_event wxEVT_GRID_CELL_RIGHT_CLICK // EVT_GRID_CELL_RIGHT_CLICK(fn)
    %define_event wxEVT_GRID_CELL_LEFT_DCLICK // EVT_GRID_CELL_LEFT_DCLICK(fn)
    %define_event wxEVT_GRID_CELL_RIGHT_DCLICK // EVT_GRID_CELL_RIGHT_DCLICK(fn)
    %define_event wxEVT_GRID_LABEL_LEFT_CLICK // EVT_GRID_LABEL_LEFT_CLICK(fn)
    %define_event wxEVT_GRID_LABEL_RIGHT_CLICK // EVT_GRID_LABEL_RIGHT_CLICK(fn)
    %define_event wxEVT_GRID_LABEL_LEFT_DCLICK // EVT_GRID_LABEL_LEFT_DCLICK(fn)
    %define_event wxEVT_GRID_LABEL_RIGHT_DCLICK // EVT_GRID_LABEL_RIGHT_DCLICK(fn)
    %define_event wxEVT_GRID_CELL_CHANGE // EVT_GRID_CELL_CHANGE(fn)
    %define_event wxEVT_GRID_SELECT_CELL // EVT_GRID_SELECT_CELL(fn)
    %define_event wxEVT_GRID_EDITOR_SHOWN // EVT_GRID_EDITOR_SHOWN(fn)
    %define_event wxEVT_GRID_EDITOR_HIDDEN // EVT_GRID_EDITOR_HIDDEN(fn)
    %define_event wxEVT_GRID_CELL_BEGIN_DRAG // EVT_GRID_CELL_BEGIN_DRAG(fn)

    wxGridEvent(int id, wxEventType type, wxObject* obj, int row = -1, int col = -1, int x = -1, int y = -1, bool sel = true, bool control = false, bool shift = false, bool alt = false, bool meta = false)

    virtual int GetRow()
    virtual int GetCol()
    wxPoint GetPosition()
    bool Selecting()
    bool ControlDown()
    bool MetaDown()
    bool ShiftDown()
    bool AltDown()

%endclass

// ---------------------------------------------------------------------------
// wxGridSizeEvent

%class %delete wxGridSizeEvent, wxNotifyEvent

    %define_event wxEVT_GRID_ROW_SIZE // EVT_GRID_CMD_ROW_SIZE(id, fn)
    %define_event wxEVT_GRID_COL_SIZE // EVT_GRID_CMD_COL_SIZE(id, fn)

    wxGridSizeEvent(int id, wxEventType type, wxObject* obj, int rowOrCol = -1, int x = -1, int y = -1, bool control = false, bool shift = false, bool alt = false, bool meta = false)

    int GetRowOrCol()
    wxPoint GetPosition()
    bool ShiftDown()
    bool ControlDown()
    bool AltDown()
    bool MetaDown()

%endclass

// ---------------------------------------------------------------------------
// wxGridRangeSelectEvent

%class %delete wxGridRangeSelectEvent, wxNotifyEvent

    %define_event wxEVT_GRID_RANGE_SELECT // EVT_GRID_CMD_RANGE_SELECT(id, fn)

    wxGridRangeSelectEvent(int id, wxEventType type, wxObject* obj, const wxGridCellCoords& topLeft, const wxGridCellCoords& bottomRight, bool sel = true, bool control = false, bool shift = false, bool alt = false, bool meta = false)

    wxGridCellCoords GetTopLeftCoords()
    wxGridCellCoords GetBottomRightCoords()
    int GetTopRow()
    int GetBottomRow()
    int GetLeftCol()
    int GetRightCol()
    bool Selecting()
    bool ControlDown()
    bool ShiftDown()
    bool MetaDown()
    bool AltDown()

%endclass

// ---------------------------------------------------------------------------
// wxGridEditorCreatedEvent

%class %delete wxGridEditorCreatedEvent, wxCommandEvent

    %define_event wxEVT_GRID_EDITOR_CREATED // EVT_GRID_EDITOR_CREATED(fn)

    wxGridEditorCreatedEvent(int id, wxEventType type, wxObject* obj, int row, int col, wxControl* ctrl)

    int GetRow()
    int GetCol()
    wxControl* GetControl()
    void SetRow(int row)
    void SetCol(int col)
    void SetControl(wxControl * ctrl)

%endclass

%endif //wxLUA_USE_wxGrid && wxUSE_GRID

wxwidgets/wxnet_net.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxNet library
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxSocket && wxUSE_SOCKETS

// ---------------------------------------------------------------------------
// wxSocketBase

%include "wx/socket.h"

%enum wxSocketError

    wxSOCKET_NOERROR
    wxSOCKET_INVOP
    wxSOCKET_IOERR
    wxSOCKET_INVADDR
    wxSOCKET_INVSOCK
    wxSOCKET_NOHOST
    wxSOCKET_INVPORT
    wxSOCKET_WOULDBLOCK
    wxSOCKET_TIMEDOUT
    wxSOCKET_MEMERR

%endenum

%enum wxSocketFlags // actually typedef int wxSocketFlags

    wxSOCKET_NONE
    wxSOCKET_NOWAIT
    wxSOCKET_WAITALL
    wxSOCKET_BLOCK
    wxSOCKET_REUSEADDR

%endenum

%enum wxSocketNotify

    wxSOCKET_INPUT
    wxSOCKET_OUTPUT
    wxSOCKET_CONNECTION
    wxSOCKET_LOST

%endenum

%enum wxSocketEventFlags

    wxSOCKET_INPUT_FLAG
    wxSOCKET_OUTPUT_FLAG
    wxSOCKET_CONNECTION_FLAG
    wxSOCKET_LOST_FLAG

%endenum

%enum wxSocketType

    wxSOCKET_UNINIT
    wxSOCKET_CLIENT
    wxSOCKET_SERVER
    wxSOCKET_BASE
    wxSOCKET_DATAGRAM

%endenum

%class wxSocketBase, wxObject

    // wxSocketBase() - No constructor, base class

    void Close()
    bool Destroy()
    void Discard()
    bool Error() const
    voidptr_long GetClientData() const // C++ returns (void *) You get a number here
    bool GetLocal(wxSockAddress& addr) const
    wxSocketFlags GetFlags() const
    bool GetPeer(wxSockAddress& addr) const
    void InterruptWait()
    bool IsConnected() const
    bool IsData() const
    bool IsDisconnected() const
    unsigned long LastCount() const
    wxSocketError LastError() const // %gtk|%mac causes link error with Borland C++ w/DLL not exported?
    void Notify(bool notify)
    bool Ok() const
    void RestoreState()
    void SaveState()
    void SetClientData(voidptr_long number) // C++ is (void *clientData) You can put a number here
    void SetEventHandler(wxEvtHandler& handler, int id = -1)
    void SetFlags(wxSocketFlags flags)
    void SetNotify(wxSocketEventFlags flags)
    void SetTimeout(int seconds)

    // %override [Lua string] wxSocketBase::Peek(unsigned long nbytes)
    // C++ Func: void Peek(void * buffer, unsigned long nbytes)
    void Peek(unsigned long nbytes)

    // %override [Lua string] wxSocketBase::Read(unsigned long nbytes)
    // C++ Func: void Read(unsigned long nbytes)
    void Read(void * buffer, unsigned long nbytes)

    // %override [Lua string] wxSocketBase::ReadMsg(unsigned long nbytes)
    // C++ Func: void ReadMsg(void * buffer, unsigned long nbytes)
    void ReadMsg(unsigned long nbytes)

    // %override void wxSocketBase::Unread(Lua string)
    // %override void wxSocketBase::Unread(Lua string, unsigned long nbytes)
    // C++ Func: void Unread(const void * buffer, unsigned long nbytes)
    void Unread(const char* buffer, unsigned long nbytes)

    bool Wait(long seconds = -1, long millisecond = 0)
    bool WaitForLost(long seconds = -1, long millisecond = 0)
    bool WaitForRead(long seconds = -1, long millisecond = 0)
    bool WaitForWrite(long seconds = -1, long millisecond = 0)

    // %override void wxSocketBase::Write(Lua string)
    // %override void wxSocketBase::Write(Lua string, unsigned long nbytes)
    // C++ Func: void Write(const void * buffer, unsigned long nbytes)
    void Write(const char* buffer, unsigned long nbytes)

    // %override void wxSocketBase::WriteMsg(Lua string)
    // %override void wxSocketBase::WriteMsg(Lua string, unsigned long nbytes)
    // C++ Func: void WriteMsg(const void * buffer, wxUint32 nbytes)
    void WriteMsg(const char* buffer, wxUint32 nbytes)

%endclass

// ---------------------------------------------------------------------------
// wxSocketClient

%class %delete wxSocketClient, wxSocketBase

    wxSocketClient(wxSocketFlags flags = wxSOCKET_NONE)

    bool Connect(wxSockAddress& address, bool wait = true)
    bool WaitOnConnect(long seconds = -1, long milliseconds = 0)

%endclass

// ---------------------------------------------------------------------------
// wxSocketServer

%class %delete wxSocketServer, wxSocketBase

    wxSocketServer(wxSockAddress& address, wxSocketFlags flags = wxSOCKET_NONE)

    wxSocketBase* Accept(bool wait = true)
    bool AcceptWith(wxSocketBase& socket, bool wait = true)
    bool WaitForAccept(long seconds = -1, long millisecond = 0)

%endclass

// ---------------------------------------------------------------------------
// wxSocketEvent

%class %delete wxSocketEvent, wxEvent

    %define_event wxEVT_SOCKET // EVT_SOCKET(id, func)

    wxSocketEvent(int id = 0)

    voidptr_long GetClientData() // C++ returns (void *) You get a number here
    wxSocketBase * GetSocket() const
    wxSocketNotify GetSocketEvent() const

%endclass

// ---------------------------------------------------------------------------
// wxSockAddress

%class wxSockAddress, wxObject

    // wxSockAddress() virtual base class

    void Clear()
    //int SockAddrLen() // Does not exist

%endclass

// ---------------------------------------------------------------------------
// wxIPAddress

%class %delete wxIPaddress, wxSockAddress

    //wxIPaddress() virtual base class

    bool Hostname(const wxString& hostname)
    //bool Hostname(unsigned long addr) // pure virtual, fun in derived classes
    wxString Hostname()
    wxString IPAddress()
    bool Service(const wxString& service)
    bool Service(unsigned short service)
    unsigned short Service()
    bool AnyAddress()
    bool LocalHost()
    virtual bool IsLocalHost()

%endclass

// ---------------------------------------------------------------------------
// wxIPV4address

%class %delete wxIPV4address, wxIPaddress

    wxIPV4address()
    wxIPV4address(const wxIPV4address& other);

    //bool Hostname(const wxString& hostname)
    bool Hostname(unsigned long addr)
    //wxString Hostname()
    //wxString IPAddress()
    //bool Service(const wxString& service)
    //bool Service(unsigned short service)
    //unsigned short Service()
    //bool AnyAddress()
    //bool LocalHost()

%endclass

// ---------------------------------------------------------------------------
// wxProtocol

%if wxUSE_PROTOCOL

%include "wx/protocol/protocol.h"

%enum wxProtocolError

    wxPROTO_NOERR
    wxPROTO_NETERR
    wxPROTO_PROTERR
    wxPROTO_CONNERR
    wxPROTO_INVVAL
    wxPROTO_NOHNDLR
    wxPROTO_NOFILE
    wxPROTO_ABRT
    wxPROTO_RCNCT
    wxPROTO_STREAMING

%endenum

%class %delete wxProtocol, wxSocketClient

    //wxProtocol() virtual base class

    bool Reconnect()
    wxInputStream *GetInputStream(const wxString& path)
    bool Abort()
    wxProtocolError GetError()
    wxString GetContentType()
    void SetUser(const wxString& user)
    void SetPassword(const wxString& user)

%endclass

%endif //wxUSE_PROTOCOL

// ---------------------------------------------------------------------------
// wxHTTP

%if wxUSE_PROTOCOL_HTTP

%include "wx/protocol/http.h"

%class %delete wxHTTP, wxProtocol

    wxHTTP()

    int GetResponse() const
    // wxInputStream *GetInputStream(const wxString& path) - see wxProtocol
    void SetHeader(const wxString& header, const wxString& h_data)
    wxString GetHeader(const wxString& header)

%endclass

%endif //wxUSE_PROTOCOL_HTTP

// ---------------------------------------------------------------------------
// wxFTP

%if wxUSE_PROTOCOL_FTP

%include "wx/protocol/ftp.h"

%enum wxFTP::TransferMode

    NONE
    ASCII
    BINARY

%endenum

%class %delete wxFTP, wxProtocol

    wxFTP()

    //bool Abort()
    bool CheckCommand(const wxString& command, char ret)
    char SendCommand(const wxString& command)
    wxString GetLastResult()
    bool ChDir(const wxString& dir)
    bool MkDir(const wxString& dir)
    bool RmDir(const wxString& dir)
    wxString Pwd()
    bool Rename(const wxString& src, const wxString& dst)
    bool RmFile(const wxString& path)
    bool SetAscii()
    bool SetBinary()
    void SetPassive(bool pasv)
    bool SetTransferMode(wxFTP::TransferMode mode)
    // void SetUser(const wxString& user) - see wxProtocol
    // void SetPassword(const wxString& passwd) - see wxProtocol
    bool FileExists(const wxString& filename)
    int GetFileSize(const wxString& filename)
    bool GetDirList(wxArrayString& files, const wxString& wildcard = "")
    bool GetFilesList(wxArrayString& files, const wxString& wildcard = "")
    wxOutputStream * GetOutputStream(const wxString& file)
    // wxInputStream * GetInputStream(const wxString& path) - see wxProtocol

%endclass

%endif //wxUSE_PROTOCOL_FTP

// ---------------------------------------------------------------------------
// wxURI

%include "wx/uri.h"

%enum wxURIHostType

    wxURI_REGNAME
    wxURI_IPV4ADDRESS
    wxURI_IPV6ADDRESS
    wxURI_IPVFUTURE

%endenum

%enum wxURIFieldType

    wxURI_SCHEME
    wxURI_USERINFO
    wxURI_SERVER
    wxURI_PORT
    wxURI_PATH
    wxURI_QUERY
    wxURI_FRAGMENT

%endenum

%enum wxURIFlags

    wxURI_STRICT

%endenum

%class %delete wxURI, wxObject

    wxURI()
    wxURI(const wxString& uri)
    wxURI(const wxURI& uri)

    wxString Create(const wxString& uri)
    bool HasScheme() const
    bool HasUserInfo() const
    bool HasServer() const
    bool HasPort() const
    bool HasPath() const
    bool HasQuery() const
    bool HasFragment() const
    wxString GetScheme() const
    wxString GetPath() const
    wxString GetQuery() const
    wxString GetFragment() const
    wxString GetPort() const
    wxString GetUserInfo() const
    wxString GetServer() const
    wxURIHostType GetHostType() const
    wxString GetUser() const
    wxString GetPassword() const
    wxString BuildURI() const
    wxString BuildUnescapedURI() const
    void Resolve(const wxURI& base, int flags = wxURI_STRICT)
    bool IsReference() const
    static wxString Unescape (const wxString& szEscapedURI)

    %operator wxURI& operator = (const wxURI& uri);
    //wxURI& operator = (const wxString& string);
    %operator bool operator == (const wxURI& uri) const

%endclass

// ---------------------------------------------------------------------------
// wxURL

%if wxUSE_URL

%include "wx/url.h"

%enum wxURLError

    wxURL_NOERR
    wxURL_SNTXERR
    wxURL_NOPROTO
    wxURL_NOHOST
    wxURL_NOPATH
    wxURL_CONNERR
    wxURL_PROTOERR

%endenum

%class %delete wxURL, wxURI

    wxURL(const wxString& sUrl)
    wxURL(const wxURI& url)

    wxProtocol& GetProtocol()
    wxURLError GetError() const
    wxString GetURL() const

    wxInputStream *GetInputStream()

    %if wxUSE_PROTOCOL_HTTP
    static void SetDefaultProxy(const wxString& url_proxy)
    void SetProxy(const wxString& url_proxy)
    %endif // wxUSE_PROTOCOL_HTTP

    //wxURL& operator = (const wxString& url);
    //wxURL& operator = (const wxURI& url);

%endclass

%endif //wxUSE_URL

// ---------------------------------------------------------------------------
//// wxConnectionBase
//
//%include "wx/ipcbase.h"
//
//%enum wxIPCFormat
// wxIPC_INVALID
// wxIPC_TEXT
// wxIPC_BITMAP
// wxIPC_METAFILE
// wxIPC_SYLK
// wxIPC_DIF
// wxIPC_TIFF
// wxIPC_OEMTEXT
// wxIPC_DIB
// wxIPC_PALETTE
// wxIPC_PENDATA
// wxIPC_RIFF
// wxIPC_WAVE
// wxIPC_UNICODETEXT
// wxIPC_ENHMETAFILE
// wxIPC_FILENAME
// wxIPC_LOCALE
// wxIPC_PRIVATE
//%endenum
//
//%class wxConnectionBase, wxObject
// // no constructor virtual base class
//
// bool Advise(const wxString& item, char* data, int size = -1, wxIPCFormat format = wxCF_TEXT)
//
//%endclass
//
// ---------------------------------------------------------------------------
//// wxConnection
//
//%class wxConnection, wxConnectionBase
// wxConnection()
//%endclass
//
// ---------------------------------------------------------------------------
//// wxClient
//
//%class wxClient, wxObject
// wxClient()
// wxConnectionBase * MakeConnection(const wxString& host, const wxString& service, const wxString& topic)
//
// //virtual wxConnectionBase * OnMakeConnection()
// bool ValidHost(const wxString& host)
//
//%endclass
//

%endif //wxLUA_USE_wxSocket && wxUSE_SOCKETS

wxwidgets/wxmedia_media.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxMedia library
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxMediaCtrl

%if wxLUA_USE_wxMediaCtrl && wxUSE_MEDIACTRL

%include "wx/mediactrl.h"

%enum wxMediaState

    wxMEDIASTATE_STOPPED
    wxMEDIASTATE_PAUSED
    wxMEDIASTATE_PLAYING

%endenum

%enum wxMediaCtrlPlayerControls

    wxMEDIACTRLPLAYERCONTROLS_NONE
    wxMEDIACTRLPLAYERCONTROLS_STEP
    wxMEDIACTRLPLAYERCONTROLS_VOLUME
    wxMEDIACTRLPLAYERCONTROLS_DEFAULT

%endenum

%define_string wxMEDIABACKEND_DIRECTSHOW //wxT("wxAMMediaBackend")
%define_string wxMEDIABACKEND_MCI //wxT("wxMCIMediaBackend")
%define_string wxMEDIABACKEND_QUICKTIME //wxT("wxQTMediaBackend")
%define_string wxMEDIABACKEND_GSTREAMER //wxT("wxGStreamerMediaBackend")
%wxchkver_2_8 %define_string wxMEDIABACKEND_REALPLAYER //wxT("wxRealPlayerMediaBackend")
%wxchkver_2_8 %define_string wxMEDIABACKEND_WMP10 //wxT("wxWMP10MediaBackend")

%class wxMediaCtrl, wxControl

    wxMediaCtrl()
    wxMediaCtrl( wxWindow* parent, wxWindowID winid, const wxString& fileName = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& szBackend = "", const wxValidator& val = wxDefaultValidator, const wxString& name = "wxMediaCtrl" )
    bool Create( wxWindow* parent, wxWindowID winid, const wxString& fileName = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& szBackend = "", const wxValidator& val = wxDefaultValidator, const wxString& name = "wxMediaCtrl" )

    wxFileOffset GetDownloadProgress() // DirectShow only
    wxFileOffset GetDownloadTotal() // DirectShow only
    wxMediaState GetState()
    double GetVolume()
    wxFileOffset Length()
    bool Load(const wxString& fileName)
    bool Load(const wxURI& location)
    bool Load(const wxURI& location, const wxURI& proxy)
    bool LoadURI(const wxString& fileName) // { return Load(wxURI(fileName)); }
    bool LoadURIWithProxy(const wxString& fileName, const wxString& proxy) // { return Load(wxURI(fileName), wxURI(proxy)); }
    bool Pause()
    bool Play()
    wxFileOffset Seek(wxFileOffset where, wxSeekMode mode = wxFromStart)
    bool Stop()
    bool SetVolume(double dVolume)
    bool ShowPlayerControls(wxMediaCtrlPlayerControls flags = wxMEDIACTRLPLAYERCONTROLS_DEFAULT)
    wxFileOffset Tell();


%endclass

// ---------------------------------------------------------------------------
// wxMediaEvent

%define wxMEDIA_FINISHED_ID
%define wxMEDIA_STOP_ID
%define wxMEDIA_LOADED_ID
%wxchkver_2_6_4 %define wxMEDIA_STATECHANGED_ID
%wxchkver_2_6_4 %define wxMEDIA_PLAY_ID
%wxchkver_2_6_4 %define wxMEDIA_PAUSE_ID

%class %delete wxMediaEvent, wxNotifyEvent

    %define_event wxEVT_MEDIA_FINISHED // EVT_MEDIA_FINISHED(winid, fn)
    %define_event wxEVT_MEDIA_STOP // EVT_MEDIA_STOP(winid, fn)
    %define_event wxEVT_MEDIA_LOADED // EVT_MEDIA_LOADED(winid, fn)
    %wxchkver_2_6_4 %define_event wxEVT_MEDIA_STATECHANGED // EVT_MEDIA_STATECHANGED(winid, fn)
    %wxchkver_2_6_4 %define_event wxEVT_MEDIA_PLAY // EVT_MEDIA_PLAY(winid, fn)
    %wxchkver_2_6_4 %define_event wxEVT_MEDIA_PAUSE // EVT_MEDIA_PAUSE(winid, fn)

    wxMediaEvent(wxEventType commandType = wxEVT_NULL, int winid = 0)

%endclass

%endif //wxLUA_USE_wxMediaCtrl && wxUSE_MEDIACTRL

wxwidgets/wxgl_gl.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxGL library
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

//%if wxUSE_OPENGL // FIXME ? Is it probably enough to test for wxUSE_GLCANVAS

// ---------------------------------------------------------------------------
// wxGLCanvas

%if wxLUA_USE_wxGLCanvas && wxUSE_GLCANVAS

// FIXME : Need to wrap wxGLApp?

%include "wx/glcanvas.h"

%enum

    WX_GL_RGBA
    WX_GL_BUFFER_SIZE
    WX_GL_LEVEL
    WX_GL_DOUBLEBUFFER
    WX_GL_STEREO
    WX_GL_AUX_BUFFERS
    WX_GL_MIN_RED
    WX_GL_MIN_GREEN
    WX_GL_MIN_BLUE
    WX_GL_MIN_ALPHA
    WX_GL_DEPTH_SIZE
    WX_GL_STENCIL_SIZE
    WX_GL_MIN_ACCUM_RED
    WX_GL_MIN_ACCUM_GREEN
    WX_GL_MIN_ACCUM_BLUE
    WX_GL_MIN_ACCUM_ALPHA

%endenum

%class wxGLCanvas, wxWindow

    wxGLCanvas(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=0, const wxString& name="GLCanvas", int attribList[] = 0, const wxPalette& palette = wxNullPalette)
    wxGLCanvas(wxWindow* parent, wxGLContext* sharedContext, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=0, const wxString& name="GLCanvas", int attribList[] = 0, const wxPalette& palette = wxNullPalette)
    wxGLCanvas(wxWindow* parent, wxGLCanvas* sharedCanvas, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=0, const wxString& name="GLCanvas", int attribList[] = 0, const wxPalette& palette = wxNullPalette)
    // !%mac wxGLCanvas(wxWindow* parent, wxWindowID id = wxID_ANY, int attribList[] = 0, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=0, const wxString& name="GLCanvas", const wxPalette& palette = wxNullPalette) -- GloaEdit: Same as the first overload, just with rearranged arguments.

    wxGLContext* GetContext() const
    %mac void SetCurrent()
    %wxchkver_2_8&!%mac void SetCurrent(const wxGLContext& RC) const
    void SetColour(const wxString& colour)
    void SwapBuffers()

%endclass

// ---------------------------------------------------------------------------
// wxGLContext

%class wxGLContext, wxObject


    %if %wxchkver_2_8
    !%mac wxGLContext(wxGLCanvas *win, const wxGLContext* other = NULL ) // FIXME

    !%mac void SetCurrent(const wxGLCanvas& win) const
    %mac void SetCurrent() const
    %endif // %wxchkver_2_8

    %if !%wxchkver_2_8
    wxGLContext(bool isRGB, wxGLCanvas* win, const wxPalette& palette = wxNullPalette)
    wxGLContext(bool isRGB, wxGLCanvas* win, const wxPalette& palette = wxNullPalette, const wxGLContext* other = NULL)

    const wxWindow* GetWindow()
    void SetCurrent()
    void SetColour(const wxString& colour)
    void SwapBuffers()
    %endif // !%wxchkver_2_8

%endclass

%endif //wxLUA_USE_wxGLCanvas && wxUSE_GLCANVAS

//%endif wxUSE_OPENGL

wxwidgets/wxxml_xml.i - Lua table = 'wx'
// ===========================================================================
// Purpose: wxXML library
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxXML && wxUSE_XML

%wxchkver_2_6 %include "wx/xml/xml.h"

%enum wxXmlNodeType

    wxXML_ELEMENT_NODE
    wxXML_ATTRIBUTE_NODE
    wxXML_TEXT_NODE
    wxXML_CDATA_SECTION_NODE
    wxXML_ENTITY_REF_NODE
    wxXML_ENTITY_NODE
    wxXML_PI_NODE
    wxXML_COMMENT_NODE
    wxXML_DOCUMENT_NODE
    wxXML_DOCUMENT_TYPE_NODE
    wxXML_DOCUMENT_FRAG_NODE
    wxXML_NOTATION_NODE
    wxXML_HTML_DOCUMENT_NODE

%endenum

// ---------------------------------------------------------------------------
// wxXmlNode

%class %delete %noclassinfo %encapsulate wxXmlNode

    wxXmlNode()
    wxXmlNode(wxXmlNodeType type, const wxString& name, const wxString& content = "")

    // %override wxXmlNode::wxXmlNode(wxXmlNode *parent, wxXmlNodeType type, const wxString& name, const wxString& content, wxXmlProperty *props, wxXmlNode *next)
    // C++ Func: No change: if parent is not NULL, created node is not garbage collected.
    wxXmlNode(wxXmlNode *parent, wxXmlNodeType type, const wxString& name, const wxString& content, wxXmlProperty *props, wxXmlNode *next)

    void AddChild(%ungc wxXmlNode *child)
    void InsertChild(%ungc wxXmlNode *child, wxXmlNode *before_node)

    // %override bool wxXmlNode::RemoveChild(%gc wxXmlNode *child)
    // C++ Func: No change: only if child is removed will we garbage collect it
    bool RemoveChild(%gc wxXmlNode *child)

    void AddProperty(const wxString& name, const wxString& value)
    bool DeleteProperty(const wxString& name)
    wxXmlNodeType GetType() const
    wxString GetName() const
    wxString GetContent() const
    wxXmlNode *GetParent() const
    wxXmlNode *GetNext() const
    wxXmlNode *GetChildren() const
    wxXmlProperty *GetProperties() const

    // %override [bool, string] wxXmlNode::GetPropValPtr(const wxString& propName) const
    // C++ Func: bool GetPropVal(const wxString& propName, wxString *value) const
    %override_name wxLua_wxXmlNode_GetPropValPtr bool GetPropVal(const wxString& propName) const

    wxString GetPropVal(const wxString& propName, const wxString& defaultVal) const
    bool HasProp(const wxString& propName) const
    void SetType(wxXmlNodeType type)
    void SetName(const wxString& name)
    void SetContent(const wxString& con)
    void SetParent(wxXmlNode *parent)
    void SetNext(wxXmlNode *next)
    void SetChildren(%ungc wxXmlNode *child)
    void SetProperties(%ungc wxXmlProperty *prop)
    void AddProperty(%ungc wxXmlProperty *prop)

%endclass

// ---------------------------------------------------------------------------
// wxXmlProperty

%class %delete %noclassinfo %encapsulate wxXmlProperty

    wxXmlProperty()
    wxXmlProperty(const wxString& name, const wxString& value, wxXmlProperty *next)

    wxString GetName()
    wxString GetValue()
    wxXmlProperty *GetNext()
    void SetName(const wxString& name)
    void SetValue(const wxString& value)
    void SetNext(wxXmlProperty *next)

%endclass

// ---------------------------------------------------------------------------
// wxXmlDocument

%class %delete wxXmlDocument, wxObject

    wxXmlDocument();
    wxXmlDocument(const wxString& filename, const wxString& encoding = "UTF-8");
    //wxXmlDocument(wxInputStream& stream, const wxString& encoding = "UTF-8");

    bool Load(const wxString& filename, const wxString& encoding = "UTF-8");
    //bool Load(wxInputStream& stream, const wxString& encoding = "UTF-8");
    bool Save(const wxString& filename) const;
    //bool Save(wxOutputStream& stream) const;
    bool IsOk() const;
    wxXmlNode *GetRoot() const;

    wxString GetVersion() const;
    wxString GetFileEncoding() const;
    void SetRoot(%ungc wxXmlNode *node);
    void SetVersion(const wxString& version);
    void SetFileEncoding(const wxString& encoding);

    // These two are not for unicode
    //wxString GetEncoding() const;
    //void SetEncoding(const wxString& enc);

%endclass

%endif //wxLUA_USE_wxXML && wxUSE_XML

wxwidgets/wxxrc_xrc.i - Lua table = 'wx'
// ===========================================================================
// Purpose: XRC Resource system
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxXRC && wxUSE_XRC

%include "wx/xrc/xmlres.h"

// ---------------------------------------------------------------------------
// wxXmlResourceHandler - wxLua shouldn't need this

//%class %noclassinfo wxXmlResourceHandler, wxObject
//%endclass

%enum wxXmlResourceFlags

    wxXRC_USE_LOCALE
    wxXRC_NO_SUBCLASSING
    wxXRC_NO_RELOADING

%endenum

// ---------------------------------------------------------------------------
// wxXmlResource

%class %delete %noclassinfo wxXmlResource, wxObject

    //wxXmlResource();
    wxXmlResource(int flags = wxXRC_USE_LOCALE, const wxString& domain = "");
    wxXmlResource(const wxString& filemask, int flags = wxXRC_USE_LOCALE, const wxString& domain = "");

    //void AddHandler(wxXmlResourceHandler* handler);
    bool AttachUnknownControl(const wxString& name, wxWindow* control, wxWindow* parent = NULL);
    void ClearHandlers();
    int CompareVersion(int major, int minor, int release, int revision) const;
    static wxXmlResource* Get();
    int GetFlags()
    long GetVersion() const;
    static int GetXRCID(const wxString &stringID, int value_if_not_found = wxID_NONE);
    void InitAllHandlers();

    bool Load(const wxString& filemask);
    wxBitmap LoadBitmap(const wxString& name);
    wxDialog* LoadDialog(wxWindow* parent, const wxString& name);
    bool LoadDialog(wxDialog* dlg, wxWindow *parent, const wxString &name);
    bool LoadFrame(wxFrame* frame, wxWindow* parent, const wxString& name);
    wxIcon LoadIcon(const wxString& name);
    wxMenu* LoadMenu(const wxString& name);
    wxMenuBar* LoadMenuBar(wxWindow* parent, const wxString& name);
    wxMenuBar* LoadMenuBar(const wxString& name);
    wxPanel* LoadPanel(wxWindow* parent, const wxString &name);
    bool LoadPanel(wxPanel *panel, wxWindow *parent, const wxString &name);
    wxToolBar* LoadToolBar(wxWindow *parent, const wxString& name);

    static %gc wxXmlResource* Set(%ungc wxXmlResource *res);
    void SetDomain(const wxString& domain)
    void SetFlags(int flags);
    bool Unload(const wxString& filename)

%endclass

%endif //wxLUA_USE_wxXRC && wxUSE_XRC

wxwidgets/wxaui_aui.i - Lua table = 'wxaui'
// ===========================================================================
// Purpose: wxAUI library
// Author: John Labenski
// Created: 07/03/2007
// Copyright: (c) 2007 John Labenski. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.6
// ===========================================================================

// NOTE: This file is mostly copied from wxWidget's include/aui/*.h headers
// to make updating it easier.

%if wxLUA_USE_wxAUI && %wxchkver_2_8 && wxUSE_AUI

%include "wx/aui/aui.h"


// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

//%include "wx/aui/auibook.h" // already included by aui.h

%enum wxAuiNotebookOption

    wxAUI_NB_TOP
    wxAUI_NB_LEFT // not implemented yet
    wxAUI_NB_RIGHT // not implemented yet
    wxAUI_NB_BOTTOM // not implemented yet
    wxAUI_NB_TAB_SPLIT
    wxAUI_NB_TAB_MOVE
    wxAUI_NB_TAB_EXTERNAL_MOVE
    wxAUI_NB_TAB_FIXED_WIDTH
    wxAUI_NB_SCROLL_BUTTONS
    wxAUI_NB_WINDOWLIST_BUTTON
    wxAUI_NB_CLOSE_BUTTON
    wxAUI_NB_CLOSE_ON_ACTIVE_TAB
    wxAUI_NB_CLOSE_ON_ALL_TABS
    %wxchkver_2_8_6 wxAUI_NB_MIDDLE_CLICK_CLOSE

    wxAUI_NB_DEFAULT_STYLE //= wxAUI_NB_TOP|wxAUI_NB_TAB_SPLIT|wxAUI_NB_TAB_MOVE|wxAUI_NB_SCROLL_BUTTONS|wxAUI_NB_CLOSE_ON_ACTIVE_TAB|wxAUI_NB_MIDDLE_CLICK_CLOSE

%endenum


// ---------------------------------------------------------------------------
// wxAuiNotebookEvent

%class %delete wxAuiNotebookEvent, wxNotifyEvent

    %define_event wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSE // EVT_AUINOTEBOOK_PAGE_CLOSE(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGED // EVT_AUINOTEBOOK_PAGE_CHANGED(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_PAGE_CHANGING // EVT_AUINOTEBOOK_PAGE_CHANGING(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_BUTTON // EVT_AUINOTEBOOK_BUTTON(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_BEGIN_DRAG // EVT_AUINOTEBOOK_BEGIN_DRAG(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_END_DRAG // EVT_AUINOTEBOOK_END_DRAG(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_DRAG_MOTION // EVT_AUINOTEBOOK_DRAG_MOTION(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_ALLOW_DND // EVT_AUINOTEBOOK_ALLOW_DND(winid, fn)

    %if %wxchkver_2_8_5
    %define_event wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_DOWN // EVT_AUINOTEBOOK_TAB_MIDDLE_DOWN(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_TAB_MIDDLE_UP // EVT_AUINOTEBOOK_TAB_MIDDLE_UP(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_DOWN // EVT_AUINOTEBOOK_TAB_RIGHT_DOWN(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_TAB_RIGHT_UP // EVT_AUINOTEBOOK_TAB_RIGHT_UP(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_PAGE_CLOSED //
    %define_event wxEVT_COMMAND_AUINOTEBOOK_DRAG_DONE // EVT_AUINOTEBOOK_DRAG_DONE(winid, fn)
    %define_event wxEVT_COMMAND_AUINOTEBOOK_BG_DCLICK // EVT_AUINOTEBOOK_BG_DCLICK(winid, fn)
    %endif //%wxchkver_2_8_5


    wxAuiNotebookEvent(wxEventType command_type = wxEVT_NULL, int win_id = 0)
    wxAuiNotebookEvent(const wxAuiNotebookEvent& c)

    void SetSelection(int s)
    int GetSelection() const

    void SetOldSelection(int s)
    int GetOldSelection() const

    void SetDragSource(wxAuiNotebook* s)
    wxAuiNotebook* GetDragSource() const

%endclass


// ---------------------------------------------------------------------------
// wxAuiNotebookPage

%class %delete %noclassinfo %encapsulate wxAuiNotebookPage

    %member wxWindow* window; // page's associated window
    %member wxString caption; // caption displayed on the tab
    %member wxBitmap bitmap; // tab's bitmap
    %member wxRect rect; // tab's hit rectangle
    %member bool active; // true if the page is currently active

%endclass


// ---------------------------------------------------------------------------
// wxAuiNotebookPageArray

%class %delete %noclassinfo %encapsulate wxAuiNotebookPageArray

    wxAuiNotebookPageArray()
    wxAuiNotebookPageArray(const wxAuiNotebookPageArray& array)

    void Add(wxAuiNotebookPage* page)
    void Clear()
    int GetCount() const
    void Insert(wxAuiNotebookPage* page, int nIndex)
    bool IsEmpty()
    wxAuiNotebookPage Item(size_t nIndex) const
    void RemoveAt(size_t nIndex)

%endclass


// ---------------------------------------------------------------------------
// wxAuiTabContainerButton

%class %delete %noclassinfo %encapsulate wxAuiTabContainerButton

    %member int id; // button's id
    %member int cur_state; // current state (normal, hover, pressed, etc.)
    %member int location; // buttons location (wxLEFT, wxRIGHT, or wxCENTER)
    %member wxBitmap bitmap; // button's hover bitmap
    %member wxBitmap dis_bitmap; // button's disabled bitmap
    %member wxRect rect; // button's hit rectangle

%endclass

//WX_DECLARE_USER_EXPORTED_OBJARRAY(wxAuiTabContainerButton, wxAuiTabContainerButtonArray, WXDLLIMPEXP_AUI);


// ---------------------------------------------------------------------------
// wxAuiTabArt

%class %delete %noclassinfo %encapsulate wxAuiTabArt

    // wxAuiTabArt() No constructor - base class

    %gc virtual wxAuiTabArt* Clone() //= 0;
    virtual void SetFlags(unsigned int flags) //= 0;
    virtual void SetSizingInfo(const wxSize& tab_ctrl_size, size_t tab_count) //= 0;
    virtual void SetNormalFont(const wxFont& font) //= 0;
    virtual void SetSelectedFont(const wxFont& font) //= 0;
    virtual void SetMeasuringFont(const wxFont& font) //= 0;

    virtual void DrawBackground( wxDC& dc, wxWindow* wnd, const wxRect& rect) //= 0;
    virtual void DrawTab(wxDC& dc, wxWindow* wnd, const wxAuiNotebookPage& pane, const wxRect& in_rect, int close_button_state, wxRect* out_tab_rect, wxRect* out_button_rect, int* x_extent) //= 0;
    virtual void DrawButton( wxDC& dc, wxWindow* wnd, const wxRect& in_rect, int bitmap_id, int button_state, int orientation, wxRect* out_rect) //= 0;
    virtual wxSize GetTabSize( wxDC& dc, wxWindow* wnd, const wxString& caption, const wxBitmap& bitmap, bool active, int close_button_state, int* x_extent) //= 0;
    virtual int ShowDropDown( wxWindow* wnd, const wxAuiNotebookPageArray& items, int active_idx) //= 0;
    virtual int GetIndentSize() //= 0;
    virtual int GetBestTabCtrlSize( wxWindow* wnd, const wxAuiNotebookPageArray& pages, const wxSize& required_bmp_size) //= 0;

%endclass


// ---------------------------------------------------------------------------
// wxAuiDefaultTabArt

%class %delete %noclassinfo %encapsulate wxAuiDefaultTabArt, wxAuiTabArt

    wxAuiDefaultTabArt();

%endclass


// ---------------------------------------------------------------------------
// wxAuiSimpleTabArt

%class %delete %noclassinfo %encapsulate wxAuiSimpleTabArt, wxAuiTabArt

    wxAuiSimpleTabArt();

%endclass

// ---------------------------------------------------------------------------
// wxAuiTabContainer

//%class %delete %noclassinfo %encapsulate wxAuiTabContainer
// wxAuiTabContainer();
//
// All methods put into wxAuiTabCtrl since this isn't the base class of anything else
//
//%endclass


// ---------------------------------------------------------------------------
// wxAuiTabCtrl

%class wxAuiTabCtrl, wxControl //, wxAuiTabContainer


    wxAuiTabCtrl(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0);

    void SetArtProvider(wxAuiTabArt* art);
    wxAuiTabArt* GetArtProvider() const;

    void SetFlags(unsigned int flags);
    unsigned int GetFlags() const;

    bool AddPage(wxWindow* page, const wxAuiNotebookPage& info);
    bool InsertPage(wxWindow* page, const wxAuiNotebookPage& info, size_t idx);
    bool MovePage(wxWindow* page, size_t new_idx);
    bool RemovePage(wxWindow* page);
    bool SetActivePage(wxWindow* page);
    bool SetActivePage(size_t page);
    void SetNoneActive();
    int GetActivePage() const;
    bool TabHitTest(int x, int y, wxWindow** hit) const;
    bool ButtonHitTest(int x, int y, wxAuiTabContainerButton** hit) const;
    wxWindow* GetWindowFromIdx(size_t idx) const;
    int GetIdxFromWindow(wxWindow* page) const;
    size_t GetPageCount() const;
    wxAuiNotebookPage& GetPage(size_t idx);
    // const wxAuiNotebookPage& GetPage(size_t idx) const; // GloaEdit: Effectively the same as the above.
    wxAuiNotebookPageArray& GetPages();
    void SetNormalFont(const wxFont& normal_font);
    void SetSelectedFont(const wxFont& selected_font);
    void SetMeasuringFont(const wxFont& measuring_font);
    void DoShowHide();
    void SetRect(const wxRect& rect);

    void RemoveButton(int id);
    void AddButton(int id, int location, const wxBitmap& normal_bitmap = wxNullBitmap, const wxBitmap& disabled_bitmap = wxNullBitmap);

    size_t GetTabOffset() const;
    void SetTabOffset(size_t offset);

    %wxchkver_2_8_6 bool IsTabVisible(int tabPage, int tabOffset, wxDC* dc, wxWindow* wnd);
    %wxchkver_2_8_6 void MakeTabVisible(int tabPage, wxWindow* win);

    %wxchkver_2_8_5 bool IsDragging() const

%endclass


// ---------------------------------------------------------------------------
// wxAuiNotebook

%class wxAuiNotebook, wxControl

    wxAuiNotebook();
    wxAuiNotebook(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxAUI_NB_DEFAULT_STYLE);
    bool Create(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0);

    void SetWindowStyleFlag(long style);
    void SetArtProvider(wxAuiTabArt* art);
    wxAuiTabArt* GetArtProvider() const;

    virtual void SetUniformBitmapSize(const wxSize& size);
    virtual void SetTabCtrlHeight(int height);

    bool AddPage(wxWindow* page, const wxString& caption, bool select = false, const wxBitmap& bitmap = wxNullBitmap);

    bool InsertPage(size_t page_idx, wxWindow* page, const wxString& caption, bool select = false, const wxBitmap& bitmap = wxNullBitmap);

    bool DeletePage(size_t page);
    bool RemovePage(size_t page);

    size_t GetPageCount() const;
    wxWindow* GetPage(size_t page_idx) const;
    int GetPageIndex(wxWindow* page_wnd) const;

    bool SetPageText(size_t page, const wxString& text);
    wxString GetPageText(size_t page_idx) const;

    bool SetPageBitmap(size_t page, const wxBitmap& bitmap);
    wxBitmap GetPageBitmap(size_t page_idx) const;

    size_t SetSelection(size_t new_page);
    int GetSelection() const;

    virtual void Split(size_t page, int direction);

    %if %wxchkver_2_8_1 // (wxABI_VERSION >= 20801)
    const wxAuiManager& GetAuiManager() const
    %endif

    %if %wxchkver_2_8_5 //(wxABI_VERSION >= 20805)
    // Sets the normal font
    void SetNormalFont(const wxFont& font);

    // Sets the selected tab font
    void SetSelectedFont(const wxFont& font);

    // Sets the measuring font
    void SetMeasuringFont(const wxFont& font);

    // Sets the tab font
    virtual bool SetFont(const wxFont& font);

    // Gets the tab control height
    int GetTabCtrlHeight() const;

    // Gets the height of the notebook for a given page height
    int GetHeightForPageHeight(int pageHeight);

    // Advances the selection, generation page selection events
    void AdvanceSelection(bool forward = true);

    // Shows the window menu
    bool ShowWindowMenu();
    %endif

%endclass


// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

//%include "wx/aui/dockart.h"

// ---------------------------------------------------------------------------
// wxAuiDockArt

%class %delete %encapsulate %noclassinfo wxAuiDockArt

    // wxAuiDockArt() - No constructor - base class

    virtual int GetMetric(int id) //= 0;
    virtual void SetMetric(int id, int new_val) //= 0;
    virtual void SetFont(int id, const wxFont& font) //= 0;
    virtual wxFont GetFont(int id) //= 0;
    virtual wxColour GetColour(int id) //= 0;
    virtual void SetColour(int id, const wxColour& colour) //= 0;
    wxColour GetColor(int id)
    void SetColor(int id, const wxColour& color)

    virtual void DrawSash(wxDC& dc, wxWindow* window, int orientation, const wxRect& rect) //= 0;
    virtual void DrawBackground(wxDC& dc, wxWindow* window, int orientation, const wxRect& rect) //= 0;
    virtual void DrawCaption(wxDC& dc, wxWindow* window, const wxString& text, const wxRect& rect, wxAuiPaneInfo& pane) //= 0;
    virtual void DrawGripper(wxDC& dc, wxWindow* window, const wxRect& rect, wxAuiPaneInfo& pane) //= 0;
    virtual void DrawBorder(wxDC& dc, wxWindow* window, const wxRect& rect, wxAuiPaneInfo& pane) //= 0;
    virtual void DrawPaneButton(wxDC& dc, wxWindow* window, int button, int button_state, const wxRect& rect, wxAuiPaneInfo& pane) //= 0;

%endclass


// ---------------------------------------------------------------------------
// wxAuiDefaultDockArt

%class %delete %noclassinfo %encapsulate wxAuiDefaultDockArt, wxAuiDockArt

    wxAuiDefaultDockArt();

%endclass


// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

//%include "wx/aui/floatpane.h"

// ---------------------------------------------------------------------------
// wxAuiFloatingFrame

%class wxAuiFloatingFrame, wxFrame // wxAuiFloatingFrameBaseClass

    wxAuiFloatingFrame(wxWindow* parent, wxAuiManager* owner_mgr, const wxAuiPaneInfo& pane, wxWindowID id = wxID_ANY, long style = wxRESIZE_BORDER|wxSYSTEM_MENU|wxCAPTION|wxFRAME_NO_TASKBAR | wxFRAME_FLOAT_ON_PARENT|wxCLIP_CHILDREN);

    void SetPaneWindow(const wxAuiPaneInfo& pane);
    wxAuiManager* GetOwnerManager() const;

%endclass


// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

//%include "wx/aui/framemanager.h"

%enum wxAuiManagerDock

    wxAUI_DOCK_NONE
    wxAUI_DOCK_TOP
    wxAUI_DOCK_RIGHT
    wxAUI_DOCK_BOTTOM
    wxAUI_DOCK_LEFT
    wxAUI_DOCK_CENTER
    wxAUI_DOCK_CENTRE //= wxAUI_DOCK_CENTER

%endenum

%enum wxAuiManagerOption

    wxAUI_MGR_ALLOW_FLOATING
    wxAUI_MGR_ALLOW_ACTIVE_PANE
    wxAUI_MGR_TRANSPARENT_DRAG
    wxAUI_MGR_TRANSPARENT_HINT
    wxAUI_MGR_VENETIAN_BLINDS_HINT
    wxAUI_MGR_RECTANGLE_HINT
    wxAUI_MGR_HINT_FADE
    wxAUI_MGR_NO_VENETIAN_BLINDS_FADE

    wxAUI_MGR_DEFAULT //= wxAUI_MGR_ALLOW_FLOATING | wxAUI_MGR_TRANSPARENT_HINT | wxAUI_MGR_HINT_FADE | wxAUI_MGR_NO_VENETIAN_BLINDS_FADE

%endenum

%enum wxAuiPaneDockArtSetting

    wxAUI_DOCKART_SASH_SIZE
    wxAUI_DOCKART_CAPTION_SIZE
    wxAUI_DOCKART_GRIPPER_SIZE
    wxAUI_DOCKART_PANE_BORDER_SIZE
    wxAUI_DOCKART_PANE_BUTTON_SIZE
    wxAUI_DOCKART_BACKGROUND_COLOUR
    wxAUI_DOCKART_SASH_COLOUR
    wxAUI_DOCKART_ACTIVE_CAPTION_COLOUR
    wxAUI_DOCKART_ACTIVE_CAPTION_GRADIENT_COLOUR
    wxAUI_DOCKART_INACTIVE_CAPTION_COLOUR
    wxAUI_DOCKART_INACTIVE_CAPTION_GRADIENT_COLOUR
    wxAUI_DOCKART_ACTIVE_CAPTION_TEXT_COLOUR
    wxAUI_DOCKART_INACTIVE_CAPTION_TEXT_COLOUR
    wxAUI_DOCKART_BORDER_COLOUR
    wxAUI_DOCKART_GRIPPER_COLOUR
    wxAUI_DOCKART_CAPTION_FONT
    wxAUI_DOCKART_GRADIENT_TYPE

%endenum

%enum wxAuiPaneDockArtGradients

    wxAUI_GRADIENT_NONE
    wxAUI_GRADIENT_VERTICAL
    wxAUI_GRADIENT_HORIZONTAL

%endenum

%enum wxAuiPaneButtonState

    wxAUI_BUTTON_STATE_NORMAL
    wxAUI_BUTTON_STATE_HOVER
    wxAUI_BUTTON_STATE_PRESSED
    wxAUI_BUTTON_STATE_DISABLED
    wxAUI_BUTTON_STATE_HIDDEN
    wxAUI_BUTTON_STATE_CHECKED

%endenum

%enum wxAuiButtonId

    wxAUI_BUTTON_CLOSE
    wxAUI_BUTTON_MAXIMIZE_RESTORE
    wxAUI_BUTTON_MINIMIZE
    wxAUI_BUTTON_PIN
    wxAUI_BUTTON_OPTIONS
    wxAUI_BUTTON_WINDOWLIST
    wxAUI_BUTTON_LEFT
    wxAUI_BUTTON_RIGHT
    wxAUI_BUTTON_UP
    wxAUI_BUTTON_DOWN
    wxAUI_BUTTON_CUSTOM1
    wxAUI_BUTTON_CUSTOM2
    wxAUI_BUTTON_CUSTOM3

%endenum

%enum wxAuiPaneInsertLevel

    wxAUI_INSERT_PANE
    wxAUI_INSERT_ROW
    wxAUI_INSERT_DOCK

%endenum


//WX_DECLARE_USER_EXPORTED_OBJARRAY(wxAuiDockInfo, wxAuiDockInfoArray, WXDLLIMPEXP_AUI);
//WX_DECLARE_USER_EXPORTED_OBJARRAY(wxAuiDockUIPart, wxAuiDockUIPartArray, WXDLLIMPEXP_AUI);
//WX_DECLARE_USER_EXPORTED_OBJARRAY(wxAuiPaneButton, wxAuiPaneButtonArray, WXDLLIMPEXP_AUI);
//WX_DECLARE_USER_EXPORTED_OBJARRAY(wxAuiPaneInfo, wxAuiPaneInfoArray, WXDLLIMPEXP_AUI);
//WX_DEFINE_USER_EXPORTED_ARRAY_PTR(wxAuiPaneInfo*, wxAuiPaneInfoPtrArray, class WXDLLIMPEXP_AUI);
//WX_DEFINE_USER_EXPORTED_ARRAY_PTR(wxAuiDockInfo*, wxAuiDockInfoPtrArray, class WXDLLIMPEXP_AUI);

// ---------------------------------------------------------------------------
// wxAuiPaneInfo

// NOTE: You can add and subtract flags from this list,
// but do not change the values of the flags, because
// they are stored in a binary integer format in the
// perspective string. If you really need to change the
// values around, you'll have to ensure backwards-compatibility
// in the perspective loading code.
%enum wxAuiPaneInfo::wxAuiPaneState

    optionFloating
    optionHidden
    optionLeftDockable
    optionRightDockable
    optionTopDockable
    optionBottomDockable
    optionFloatable
    optionMovable
    optionResizable
    optionPaneBorder
    optionCaption
    optionGripper
    optionDestroyOnClose
    optionToolbar
    optionActive
    optionGripperTop
    optionMaximized

    buttonClose
    buttonMaximize
    buttonMinimize
    buttonPin

    buttonCustom1
    buttonCustom2
    buttonCustom3

    savedHiddenState // used internally
    actionPane // used internally

%endenum


%class %delete %noclassinfo %encapsulate wxAuiPaneInfo

    %define_object wxAuiNullPaneInfo

    wxAuiPaneInfo()
    wxAuiPaneInfo(const wxAuiPaneInfo& c)

    %operator wxAuiPaneInfo& operator=(const wxAuiPaneInfo& c)

    // Write the safe parts of a newly loaded PaneInfo structure "source" into "this"
    // used on loading perspectives etc.
    void SafeSet(wxAuiPaneInfo source)

    bool IsOk() const
    bool IsFixed() const
    bool IsResizable() const
    bool IsShown() const
    bool IsFloating() const
    bool IsDocked() const
    bool IsToolbar() const
    bool IsTopDockable() const
    bool IsBottomDockable() const
    bool IsLeftDockable() const
    bool IsRightDockable() const
    bool IsFloatable() const
    bool IsMovable() const
    bool IsDestroyOnClose() const
    bool IsMaximized() const
    bool HasCaption() const
    bool HasGripper() const
    bool HasBorder() const
    bool HasCloseButton() const
    bool HasMaximizeButton() const
    bool HasMinimizeButton() const
    bool HasPinButton() const
    bool HasGripperTop() const

    wxAuiPaneInfo& Window(wxWindow* w)
    wxAuiPaneInfo& Name(const wxString& n)
    wxAuiPaneInfo& Caption(const wxString& c)
    wxAuiPaneInfo& Left()
    wxAuiPaneInfo& Right()
    wxAuiPaneInfo& Top()
    wxAuiPaneInfo& Bottom()
    wxAuiPaneInfo& Center()
    wxAuiPaneInfo& Centre()
    wxAuiPaneInfo& Direction(int direction)
    wxAuiPaneInfo& Layer(int layer)
    wxAuiPaneInfo& Row(int row)
    wxAuiPaneInfo& Position(int pos)
    wxAuiPaneInfo& BestSize(const wxSize& size)
    wxAuiPaneInfo& MinSize(const wxSize& size)
    wxAuiPaneInfo& MaxSize(const wxSize& size)
    wxAuiPaneInfo& BestSize(int x, int y)
    wxAuiPaneInfo& MinSize(int x, int y)
    wxAuiPaneInfo& MaxSize(int x, int y)
    wxAuiPaneInfo& FloatingPosition(const wxPoint& pos)
    wxAuiPaneInfo& FloatingPosition(int x, int y)
    wxAuiPaneInfo& FloatingSize(const wxSize& size)
    wxAuiPaneInfo& FloatingSize(int x, int y)
    wxAuiPaneInfo& Fixed()
    wxAuiPaneInfo& Resizable(bool resizable = true)
    wxAuiPaneInfo& Dock()
    wxAuiPaneInfo& Float()
    wxAuiPaneInfo& Hide()
    wxAuiPaneInfo& Show(bool show = true)
    wxAuiPaneInfo& CaptionVisible(bool visible = true)
    wxAuiPaneInfo& Maximize()
    wxAuiPaneInfo& Restore()
    wxAuiPaneInfo& PaneBorder(bool visible = true)
    wxAuiPaneInfo& Gripper(bool visible = true)
    wxAuiPaneInfo& GripperTop(bool attop = true)
    wxAuiPaneInfo& CloseButton(bool visible = true)
    wxAuiPaneInfo& MaximizeButton(bool visible = true)
    wxAuiPaneInfo& MinimizeButton(bool visible = true)
    wxAuiPaneInfo& PinButton(bool visible = true)
    wxAuiPaneInfo& DestroyOnClose(bool b = true)
    wxAuiPaneInfo& TopDockable(bool b = true)
    wxAuiPaneInfo& BottomDockable(bool b = true)
    wxAuiPaneInfo& LeftDockable(bool b = true)
    wxAuiPaneInfo& RightDockable(bool b = true)
    wxAuiPaneInfo& Floatable(bool b = true)
    wxAuiPaneInfo& Movable(bool b = true)

    wxAuiPaneInfo& Dockable(bool b = true)
    wxAuiPaneInfo& DefaultPane()

    wxAuiPaneInfo& CentrePane()
    wxAuiPaneInfo& CenterPane()

    wxAuiPaneInfo& ToolbarPane()
    wxAuiPaneInfo& SetFlag(unsigned int flag, bool option_state)
    bool HasFlag(unsigned int flag) const


    %member wxString name; // name of the pane
    %member wxString caption; // caption displayed on the window

    %member wxWindow* window; // window that is in this pane
    %member wxFrame* frame; // floating frame window that holds the pane
    %member unsigned int state; // a combination of wxPaneState values

    %member int dock_direction; // dock direction (top, bottom, left, right, center)
    %member int dock_layer; // layer number (0 = innermost layer)
    %member int dock_row; // row number on the docking bar (0 = first row)
    %member int dock_pos; // position inside the row (0 = first position)

    %member wxSize best_size; // size that the layout engine will prefer
    %member wxSize min_size; // minimum size the pane window can tolerate
    %member wxSize max_size; // maximum size the pane window can tolerate

    %member wxPoint floating_pos; // position while floating
    %member wxSize floating_size; // size while floating
    %member int dock_proportion; // proportion while docked

    //%member wxAuiPaneButtonArray buttons; // buttons on the pane

    %member wxRect rect; // current rectangle (populated by wxAUI)

%endclass


// ---------------------------------------------------------------------------
// wxAuiPaneInfoArray

%class %delete %noclassinfo %encapsulate wxAuiPaneInfoArray

    wxAuiPaneInfoArray()
    wxAuiPaneInfoArray(const wxAuiPaneInfoArray& array)

    void Add(wxAuiPaneInfo pi)
    void Clear()
    int GetCount() const
    //int Index(wxAuiPaneInfo* page)
    void Insert(wxAuiPaneInfo pi, int nIndex)
    bool IsEmpty()
    wxAuiPaneInfo Item(size_t nIndex) const
    void RemoveAt(size_t nIndex)

%endclass


// ---------------------------------------------------------------------------
// wxAuiManager

%class wxAuiManager, wxEvtHandler


    wxAuiManager(wxWindow* managed_wnd = NULL, unsigned int flags = wxAUI_MGR_DEFAULT);

    void UnInit();

    void SetFlags(unsigned int flags);
    unsigned int GetFlags() const;

    void SetManagedWindow(wxWindow* managed_wnd);
    wxWindow* GetManagedWindow() const;

    static wxAuiManager* GetManager(wxWindow* window);

    void SetArtProvider(%ungc wxAuiDockArt* art_provider);
    wxAuiDockArt* GetArtProvider() const;

    wxAuiPaneInfo& GetPane(wxWindow* window);
    wxAuiPaneInfo& GetPane(const wxString& name);
    wxAuiPaneInfoArray& GetAllPanes();

    bool AddPane(wxWindow* window, const wxAuiPaneInfo& pane_info);
    bool AddPane(wxWindow* window, const wxAuiPaneInfo& pane_info, const wxPoint& drop_pos);
    bool AddPane(wxWindow* window, int direction = wxLEFT, const wxString& caption = wxEmptyString);
    bool InsertPane(wxWindow* window, const wxAuiPaneInfo& insert_location, int insert_level = wxAUI_INSERT_PANE);
    bool DetachPane(wxWindow* window);

    void Update();

    wxString SavePaneInfo(wxAuiPaneInfo& pane);
    void LoadPaneInfo(wxString pane_part, wxAuiPaneInfo &pane);
    wxString SavePerspective();
    bool LoadPerspective(const wxString& perspective, bool update = true);

    void SetDockSizeConstraint(double width_pct, double height_pct);
    void GetDockSizeConstraint(double* width_pct, double* height_pct) const;

    void ClosePane(wxAuiPaneInfo& pane_info);
    void MaximizePane(wxAuiPaneInfo& pane_info);
    void RestorePane(wxAuiPaneInfo& pane_info);
    void RestoreMaximizedPane();

    virtual wxAuiFloatingFrame* CreateFloatingFrame(wxWindow* parent, const wxAuiPaneInfo& p);
    void StartPaneDrag( wxWindow* pane_window, const wxPoint& offset);
    wxRect CalculateHintRect( wxWindow* pane_window, const wxPoint& pt, const wxPoint& offset);
    void DrawHintRect( wxWindow* pane_window, const wxPoint& pt, const wxPoint& offset);

    virtual void ShowHint(const wxRect& rect);
    virtual void HideHint();

    // public events (which can be invoked externally)
    void OnRender(wxAuiManagerEvent& evt);
    void OnPaneButton(wxAuiManagerEvent& evt);

%endclass


// ---------------------------------------------------------------------------
// wxAuiManagerEvent

%class %delete wxAuiManagerEvent, wxEvent

    %define_event wxEVT_AUI_PANE_BUTTON // EVT_AUI_PANE_BUTTON(func)
    %define_event wxEVT_AUI_PANE_CLOSE // EVT_AUI_PANE_CLOSE(func)
    %define_event wxEVT_AUI_PANE_MAXIMIZE // EVT_AUI_PANE_MAXIMIZE(func)
    %define_event wxEVT_AUI_PANE_RESTORE // EVT_AUI_PANE_RESTORE(func)
    %define_event wxEVT_AUI_RENDER // EVT_AUI_RENDER(func)
    %define_event wxEVT_AUI_FIND_MANAGER // EVT_AUI_FIND_MANAGER(func)

    wxAuiManagerEvent(wxEventType type=wxEVT_NULL)
    wxAuiManagerEvent(const wxAuiManagerEvent& c)


    void SetManager(wxAuiManager* mgr)
    void SetPane(wxAuiPaneInfo* p)
    void SetButton(int b)
    void SetDC(wxDC* pdc)

    wxAuiManager* GetManager() const
    wxAuiPaneInfo* GetPane() const
    int GetButton() const
    wxDC* GetDC() const

    void Veto(bool veto = true)
    bool GetVeto() const
    void SetCanVeto(bool can_veto)
    bool CanVeto() const

%endclass


// ---------------------------------------------------------------------------
// wxAuiDockInfo

%class %delete %noclassinfo %encapsulate wxAuiDockInfo

    %define_object wxAuiNullDockInfo

    wxAuiDockInfo()
    wxAuiDockInfo(const wxAuiDockInfo& c)

    %operator wxAuiDockInfo& operator=(const wxAuiDockInfo& c)

    bool IsOk() const
    bool IsHorizontal() const
    bool IsVertical() const


    //%member wxAuiPaneInfoPtrArray panes; // array of panes - FIXME
    %member wxRect rect; // current rectangle
    %member int dock_direction; // dock direction (top, bottom, left, right, center)
    %member int dock_layer; // layer number (0 = innermost layer)
    %member int dock_row; // row number on the docking bar (0 = first row)
    %member int size; // size of the dock
    %member int min_size; // minimum size of a dock (0 if there is no min)
    %member bool resizable; // flag indicating whether the dock is resizable
    %member bool toolbar; // flag indicating dock contains only toolbars
    %member bool fixed; // flag indicating that the dock operates on
    // absolute coordinates as opposed to proportional
    %member bool reserved1;

%endclass


// ---------------------------------------------------------------------------
// wxAuiDockUIPart

%enum wxAuiDockUIPart::dummy

    typeCaption,
    typeGripper,
    typeDock,
    typeDockSizer,
    typePane,
    typePaneSizer,
    typeBackground,
    typePaneBorder,
    typePaneButton

%endenum

%class %delete %noclassinfo %encapsulate wxAuiDockUIPart


    %member int type; // ui part type (see enum above)
    %member int orientation; // orientation (either wxHORIZONTAL or wxVERTICAL)
    %member wxAuiDockInfo* dock; // which dock the item is associated with
    %member wxAuiPaneInfo* pane; // which pane the item is associated with
    %member wxAuiPaneButton* button; // which pane button the item is associated with
    %member wxSizer* cont_sizer; // the part's containing sizer
    %member wxSizerItem* sizer_item; // the sizer item of the part
    %member wxRect rect; // client coord rectangle of the part itself

%endclass


// ---------------------------------------------------------------------------
// wxAuiPaneButton

%class %delete %noclassinfo %encapsulate wxAuiPaneButton

    %member int button_id; // id of the button (e.g. buttonClose)

%endclass


// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------

//%include "wx/aui/tabmdi.h"

//-----------------------------------------------------------------------------
// wxAuiMDIParentFrame
//-----------------------------------------------------------------------------

%class wxAuiMDIParentFrame, wxFrame

    wxAuiMDIParentFrame()
    wxAuiMDIParentFrame(wxWindow *parent, wxWindowID winid, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL, const wxString& name = "wxAuiMDIParentFrame")

    bool Create(wxWindow *parent, wxWindowID winid, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL,const wxString& name = "wxAuiMDIParentFrame" )

    void SetArtProvider(%ungc wxAuiTabArt* provider);
    wxAuiTabArt* GetArtProvider();
    wxAuiNotebook* GetNotebook() const;

    wxMenu* GetWindowMenu() const
    void SetWindowMenu(wxMenu* pMenu);

    virtual void SetMenuBar(wxMenuBar *pMenuBar);

    void SetChildMenuBar(wxAuiMDIChildFrame *pChild);

    virtual bool ProcessEvent(wxEvent& event);

    wxAuiMDIChildFrame *GetActiveChild() const;
    void SetActiveChild(wxAuiMDIChildFrame* pChildFrame);

    wxAuiMDIClientWindow *GetClientWindow() const;
    virtual wxAuiMDIClientWindow *OnCreateClient();

    virtual void Cascade() //{ /* Has no effect */ }
    virtual void Tile(wxOrientation orient = wxHORIZONTAL);
    virtual void ArrangeIcons() //{ /* Has no effect */ }
    virtual void ActivateNext();
    virtual void ActivatePrevious();

%endclass

//-----------------------------------------------------------------------------
// wxAuiMDIChildFrame
//-----------------------------------------------------------------------------

%class wxAuiMDIChildFrame, wxPanel

    wxAuiMDIChildFrame()
    wxAuiMDIChildFrame(wxAuiMDIParentFrame *parent, wxWindowID winid, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxAuiMDIChildFrame");

    bool Create(wxAuiMDIParentFrame *parent, wxWindowID winid, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxAuiMDIChildFrame");

    virtual void SetMenuBar(wxMenuBar *menu_bar);
    virtual wxMenuBar *GetMenuBar() const;

    virtual void SetTitle(const wxString& title);
    virtual wxString GetTitle() const;

    virtual void SetIcons(const wxIconBundle& icons);
    virtual const wxIconBundle& GetIcons() const;

    virtual void SetIcon(const wxIcon& icon);
    virtual const wxIcon& GetIcon() const;

    virtual void Activate();
    virtual bool Destroy();

    %if wxUSE_STATUSBAR
    // no status bars
    //virtual wxStatusBar* CreateStatusBar(int number = 1, long style = 1, wxWindowID winid = 1, const wxString& name = "") //{ return (wxStatusBar*)NULL; } - FIXME

    //virtual wxStatusBar *GetStatusBar() const { return (wxStatusBar*)NULL; }
    //virtual void SetStatusText( const wxString &WXUNUSED(text), int WXUNUSED(number)=0 ) {}
    //virtual void SetStatusWidths( int WXUNUSED(n), const int WXUNUSED(widths_field)[] ) {}
    %endif //wxUSE_STATUSBAR

    // no size hints
    //virtual void DoSetSizeHints(int WXUNUSED(minW), int WXUNUSED(minH), int WXUNUSED(maxW) = wxDefaultCoord, int WXUNUSED(maxH) = wxDefaultCoord, int WXUNUSED(incW) = wxDefaultCoord, int WXUNUSED(incH) = wxDefaultCoord) {} - FIXME
    %if wxUSE_TOOLBAR
    // no toolbar bars
    //virtual wxToolBar* CreateToolBar(long WXUNUSED(style), wxWindowID WXUNUSED(winid), const wxString& WXUNUSED(name)) { return (wxToolBar*)NULL; }
    //virtual wxToolBar *GetToolBar() const { return (wxToolBar*)NULL; }
    %endif //wxUSE_TOOLBAR


    // no maximize etc
    //virtual void Maximize(bool WXUNUSED(maximize) = true) { /* Has no effect */ }
    //virtual void Restore() { /* Has no effect */ }
    //virtual void Iconize(bool WXUNUSED(iconize) = true) { /* Has no effect */ }
    //virtual bool IsMaximized() const { return true; }
    //virtual bool IsIconized() const { return false; }
    //virtual bool ShowFullScreen(bool WXUNUSED(show), long WXUNUSED(style)) { return false; }
    //virtual bool IsFullScreen() const { return false; }

    //virtual bool IsTopLevel() const { return false; }

    //void OnMenuHighlight(wxMenuEvent& evt);
    //void OnActivate(wxActivateEvent& evt);
    //void OnCloseWindow(wxCloseEvent& evt);

    void SetMDIParentFrame(wxAuiMDIParentFrame* parent);
    wxAuiMDIParentFrame* GetMDIParentFrame() const;

    // This function needs to be called when a size change is confirmed,
    // we needed this function to prevent anybody from the outside
    // changing the panel... it messes the UI layout when we would allow it.
    void ApplyMDIChildFrameRect();
    void DoShow(bool show);

%endclass

//-----------------------------------------------------------------------------
// wxAuiMDIClientWindow
//-----------------------------------------------------------------------------

%class wxAuiMDIClientWindow, wxAuiNotebook

    wxAuiMDIClientWindow();
    wxAuiMDIClientWindow(wxAuiMDIParentFrame *parent, long style = 0);

    virtual bool CreateClient(wxAuiMDIParentFrame *parent, long style = wxVSCROLL | wxHSCROLL);

    virtual int SetSelection(size_t page);

%endclass

%endif // wxLUA_USE_wxAUI && %wxchkver_2_8 && wxUSE_AUI

wxwidgets/wxhtml_html.i - Lua table = 'wxhtml'
// ===========================================================================
// Purpose: wxHtml library
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%if wxLUA_USE_wxHTML && wxUSE_HTML

// ---------------------------------------------------------------------------
// wxHtmlCell

%include "wx/html/htmlcell.h"

%define wxHTML_COND_ISANCHOR
%define wxHTML_COND_ISIMAGEMAP
%define wxHTML_COND_USER

%class %delete wxHtmlCell, wxObject

    wxHtmlCell()

    // // %override [bool, int pagebreak] wxHtmlCell::AdjustPagebreak(int pagebreak)

    // %override bool AdjustPagebreak(int pagebreak) // int* known_pagebreaks, int number_of_pages)
    // C++ Func: bool AdjustPagebreak(int pagebreak, int* known_pagebreaks, int number_of_pages)
    %not_overload !%wxchkver_2_8 virtual bool AdjustPagebreak(int pagebreak) // int* known_pagebreaks, int number_of_pages)

    // %override bool AdjustPagebreak(int pagebreak, wxArrayInt& known_pagebreaks)
    // C++ Func: bool AdjustPagebreak(int pagebreak, wxArrayInt& known_pagebreaks)
    %not_overload %wxchkver_2_8 virtual bool AdjustPagebreak(int pagebreak, wxArrayInt& known_pagebreaks)

    //virtual void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo& info)
    //virtual void DrawInvisible(wxDC& dc, int x, int y, wxHtmlRenderingInfo& info)

    // %override wxHtmlCell* wxHtmlCell::Find(int condition)
    // %override wxHtmlCell* wxHtmlCell::Find(int condition, string param)
    // %override wxHtmlCell* wxHtmlCell::Find(int condition, int    param)
    // C++ Func: virtual const wxHtmlCell* Find(int condition, void *param = 0)
    virtual const wxHtmlCell* Find(int condition, void *param = 0)

    int GetDescent() const
    wxHtmlCell* GetFirstChild()
    int GetHeight() const
    virtual wxString GetId() const
    virtual wxHtmlLinkInfo* GetLink(int x = 0, int y = 0) const
    wxHtmlCell* GetNext() const
    wxHtmlContainerCell* GetParent() const
    int GetPosX() const
    int GetPosY() const
    int GetWidth() const
    virtual void Layout(int w)
    //virtual void OnMouseClick(wxWindow* parent, int x, int y, const wxMouseEvent& event)
    void SetId(const wxString& id)
    void SetLink(const wxHtmlLinkInfo& link)
    void SetNext(wxHtmlCell *cell)
    void SetParent(wxHtmlContainerCell *p)
    void SetPos(int x, int y)

%endclass

// ---------------------------------------------------------------------------
// wxHtmlWidgetCell

%include "wx/html/htmlcell.h"

%class wxHtmlWidgetCell, wxHtmlCell

    wxHtmlWidgetCell(wxWindow* wnd, int w = 0)

%endclass


// ---------------------------------------------------------------------------
// wxHtmlContainerCell

%include "wx/html/htmlcell.h"

%define wxHTML_UNITS_PIXELS
%define wxHTML_UNITS_PERCENT
%define wxHTML_INDENT_TOP
%define wxHTML_INDENT_BOTTOM
%define wxHTML_INDENT_LEFT
%define wxHTML_INDENT_RIGHT
%define wxHTML_INDENT_HORIZONTAL
%define wxHTML_INDENT_VERTICAL
%define wxHTML_INDENT_ALL
%define wxHTML_ALIGN_LEFT
%define wxHTML_ALIGN_JUSTIFY
%define wxHTML_ALIGN_CENTER
%define wxHTML_ALIGN_RIGHT
%define wxHTML_ALIGN_BOTTOM
%define wxHTML_ALIGN_TOP

%class wxHtmlContainerCell, wxHtmlCell

    wxHtmlContainerCell(wxHtmlContainerCell *parent)

    int GetAlignHor() const
    int GetAlignVer() const
    wxColour GetBackgroundColour()
    int GetIndent(int ind) const
    int GetIndentUnits(int ind) const
    void InsertCell(wxHtmlCell *cell)
    void SetAlign(const wxHtmlTag& tag)
    void SetAlignHor(int al)
    void SetAlignVer(int al)
    void SetBackgroundColour(const wxColour& clr)
    void SetBorder(const wxColour& clr1, const wxColour& clr2)
    void SetIndent(int i, int what, int units = wxHTML_UNITS_PIXELS)
    void SetMinHeight(int h, int align = wxHTML_ALIGN_TOP)
    void SetWidthFloat(int w, int units)
    void SetWidthFloat(const wxHtmlTag& tag, double pixel_scale = 1.0)

    // %wxchkver_2_6 wxHtmlCell* GetFirstChild() see wxHtmlCell
    // !%wxchkver_2_6 wxHtmlCell* GetFirstCell() - nobody probably uses this

%endclass

// ---------------------------------------------------------------------------
// wxHtmlColourCell

%if %wxchkver_2_8

%include "wx/html/htmlcell.h"

%class wxHtmlColourCell, wxHtmlCell

    wxHtmlColourCell(const wxColour& clr, int flags = wxHTML_CLR_FOREGROUND)

    //virtual void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo& info);
    //virtual void DrawInvisible(wxDC& dc, int x, int y, wxHtmlRenderingInfo& info);

%endclass

%endif // %wxchkver_2_8

// ---------------------------------------------------------------------------
// wxHtmlFontCell

%if %wxchkver_2_8

%include "wx/html/htmlcell.h"

%class wxHtmlFontCell, wxHtmlCell

    wxHtmlFontCell(wxFont *font)

    //virtual void Draw(wxDC& dc, int x, int y, int view_y1, int view_y2, wxHtmlRenderingInfo& info);
    //virtual void DrawInvisible(wxDC& dc, int x, int y, wxHtmlRenderingInfo& info);

%endclass

%endif // %wxchkver_2_8

// ---------------------------------------------------------------------------
// wxHtmlCellEvent

%if %wxchkver_2_8

%include "wx/html/htmlwin.h"

%class %delete wxHtmlCellEvent, wxCommandEvent

    wxHtmlCellEvent()
    wxHtmlCellEvent(wxEventType commandType, int id, wxHtmlCell *cell, const wxPoint &pt, const wxMouseEvent &ev)

    wxHtmlCell* GetCell() const
    wxPoint GetPoint() const
    wxMouseEvent GetMouseEvent() const

    void SetLinkClicked(bool linkclicked)
    bool GetLinkClicked() const

%endclass

%endif // %wxchkver_2_8


// ---------------------------------------------------------------------------
// wxHtmlLinkInfo

%include "wx/html/htmlcell.h"

%class %delete %noclassinfo wxHtmlLinkInfo

    wxHtmlLinkInfo(const wxString& href, const wxString& target = "")

    const wxMouseEvent * GetEvent()
    const wxHtmlCell * GetHtmlCell()
    wxString GetHref()
    wxString GetTarget()

%endclass

// ---------------------------------------------------------------------------
// wxHtmlTag

%include "wx/html/htmltag.h"

%class wxHtmlTag, wxObject

    //wxHtmlTag(const wxString& source, int pos, int end_pos, wxHtmlTagsCache* cache)

    const wxString GetAllParams() const
    int GetBeginPos() const
    int GetEndPos1() const
    int GetEndPos2() const
    wxString GetName() const
    wxString GetParam(const wxString& par, bool with_commas = false) const

    // %override [bool, wxColour] wxHtmlTag::GetParamAsColour(const wxString& par) const
    // C++ Func: bool GetParamAsColour(const wxString& par, wxColour *clr) const
    bool GetParamAsColour(const wxString& par) const

    // %override [bool, int value] wxHtmlTag::GetParamAsInt(const wxString& par) const
    // C++ Func: bool GetParamAsInt(const wxString& par, int *value) const
    bool GetParamAsInt(const wxString& par) const

    bool HasEnding() const
    bool HasParam(const wxString& par) const
    //bool IsEnding() const
    //wxString ScanParam(const wxString& par, const wxString &format, void *value) const

%endclass

// ---------------------------------------------------------------------------
// wxHtmlWindow

%include "wx/wxhtml.h"

%define wxHW_SCROLLBAR_NEVER
%define wxHW_SCROLLBAR_AUTO

%class wxHtmlWindow, wxScrolledWindow

    wxHtmlWindow(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHW_SCROLLBAR_AUTO, const wxString& name = "wxHtmlWindow")

    //static void AddFilter(wxHtmlFilter *filter)
    bool AppendToPage(const wxString& source)
    wxHtmlContainerCell* GetInternalRepresentation() const
    wxString GetOpenedAnchor()
    wxString GetOpenedPage()
    wxString GetOpenedPageTitle()
    wxFrame* GetRelatedFrame() const
    bool HistoryBack()
    bool HistoryCanBack()
    bool HistoryCanForward()
    void HistoryClear()
    bool HistoryForward()
    virtual bool LoadFile(const wxFileName& filename)
    bool LoadPage(const wxString& location)
    void ReadCustomization(wxConfigBase *cfg, wxString path = wxEmptyString)
    void SelectAll()
    wxString SelectionToText()
    void SelectLine(const wxPoint& pos)
    void SelectWord(const wxPoint& pos)
    void SetBorders(int b)

    // %override void wxHtmlWindow::SetFonts(wxString normal_face, wxString fixed_face, Lua int table)
    // C++ Func: void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes)
    void SetFonts(wxString normal_face, wxString fixed_face, LuaTable intTable)

    bool SetPage(const wxString& source)
    void SetRelatedFrame(wxFrame* frame, const wxString& format)
    void SetRelatedStatusBar(int bar)
    wxString ToText()
    void WriteCustomization(wxConfigBase *cfg, wxString path = wxEmptyString)

%endclass


// ---------------------------------------------------------------------------
// wxLuaHtmlWindow

%if wxLUA_USE_wxLuaHtmlWindow

%include "wxbind/include/wxhtml_wxlhtml.h"

%class wxLuaHtmlWindow, wxHtmlWindow

    wxLuaHtmlWindow(wxWindow *parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHW_SCROLLBAR_AUTO, const wxString& name = "wxLuaHtmlWindow")

    // The functions below are all virtual functions that you can override in Lua.
    // See the html sample and wxHtmlWindow for proper parameters and usage.
    //bool OnCellClicked(wxHtmlCell *cell, wxCoord x, wxCoord y, const wxMouseEvent& event)
    //void OnCellMouseHover(wxHtmlCell *cell, wxCoord x, wxCoord y)
    //void OnLinkClicked(const wxHtmlLinkInfo& link)
    //void OnSetTitle(const wxString& title)

%endclass

// ---------------------------------------------------------------------------
// wxLuaHtmlWinTagEvent

%class %delete wxLuaHtmlWinTagEvent, wxEvent

    %define_event wxEVT_HTML_TAG_HANDLER // EVT_HTML_TAG_HANDLER(id, fn)

    const wxHtmlTag *GetHtmlTag() const
    wxHtmlWinParser *GetHtmlParser() const
    void SetParseInnerCalled(bool fParseInnerCalled = true)
    bool GetParseInnerCalled() const

%endclass

%endif //wxLUA_USE_wxLuaHtmlWindow


// ---------------------------------------------------------------------------
// wxHtmlParser

//%enum wxHtmlURLType
// wxHTML_URL_PAGE
// wxHTML_URL_IMAGE
// wxHTML_URL_OTHER
//%endenum

%class wxHtmlParser, wxObject

    //wxHtmlParser()

    //void AddTag(const wxHtmlTag& tag)
    //void AddTagHandler(wxHtmlTagHandler *handler)
    //void AddWord(const wxString &txt) - not in 2.6?
    void DoParsing(int begin_pos, int end_pos)
    void DoParsing()
    virtual void DoneParser()
    //virtual wxObject* GetProduct()
    //wxString* GetSource()
    void InitParser(const wxString& source)
    //virtual wxFSFile* OpenURL(wxHtmlURLType type, const wxString& url)
    //wxObject* Parse(const wxString& source)
    //void PushTagHandler(wxHtmlTagHandler* handler, wxString tags)
    //void PopTagHandler()
    //void SetFS(wxFileSystem *fs)
    //void StopParsing()

%endclass

// ---------------------------------------------------------------------------
// wxHtmlWinParser

%class wxHtmlWinParser, wxHtmlParser

    wxHtmlWinParser(wxHtmlWindow *wnd)

    wxHtmlContainerCell* CloseContainer()
    wxFont* CreateCurrentFont()
    wxColour GetActualColor() const
    int GetAlign() const
    int GetCharHeight() const
    int GetCharWidth() const
    wxHtmlContainerCell* GetContainer() const
    wxDC* GetDC()
    //wxEncodingConverter * GetEncodingConverter() const
    int GetFontBold() const
    wxString GetFontFace() const
    int GetFontFixed() const
    int GetFontItalic() const
    int GetFontSize() const
    int GetFontUnderlined() const
    //wxFontEncoding GetInputEncoding() const
    const wxHtmlLinkInfo& GetLink() const
    wxColour GetLinkColor() const
    //wxFontEncoding GetOutputEncoding() const
    %wxchkver_2_8 wxHtmlWindowInterface *GetWindowInterface()
    !%wxchkver_2_8 wxWindow* GetWindow()
    wxHtmlContainerCell* OpenContainer()
    void SetActualColor(const wxColour& clr)
    void SetAlign(int a)
    wxHtmlContainerCell* SetContainer(wxHtmlContainerCell *c)
    void SetDC(wxDC *dc, double pixel_scale = 1.0)
    void SetFontBold(int x)
    void SetFontFace(const wxString& face)
    void SetFontFixed(int x)
    void SetFontItalic(int x)
    void SetFontSize(int s)
    void SetFontUnderlined(int x)

    // %override void wxHtmlWinParser::SetFonts(wxString normal_face, wxString fixed_face, Lua int table)
    // C++ Func: void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes)
    void SetFonts(wxString normal_face, wxString fixed_face, LuaTable intTable)

    void SetLink(const wxHtmlLinkInfo& link)
    void SetLinkColor(const wxColour& clr)

%endclass

// ---------------------------------------------------------------------------
// wxHtmlWindowInterface

%if %wxchkver_2_8

%enum wxHtmlWindowInterface::HTMLCursor

    HTMLCursor_Default
    HTMLCursor_Link
    HTMLCursor_Text

%endenum

%class %noclassinfo wxHtmlWindowInterface


    virtual void SetHTMLWindowTitle(const wxString& title)
    virtual void OnHTMLLinkClicked(const wxHtmlLinkInfo& link)
    //virtual wxHtmlOpeningStatus OnHTMLOpeningURL(wxHtmlURLType type, const wxString& url, wxString *redirect) const
    virtual wxPoint HTMLCoordsToWindow(wxHtmlCell *cell, const wxPoint& pos) const
    virtual wxWindow* GetHTMLWindow()
    virtual wxColour GetHTMLBackgroundColour() const
    virtual void SetHTMLBackgroundColour(const wxColour& clr)
    virtual void SetHTMLBackgroundImage(const wxBitmap& bmpBg)
    virtual void SetHTMLStatusText(const wxString& text)
    virtual wxCursor GetHTMLCursor(wxHtmlWindowInterface::HTMLCursor type) const

%endclass

// ----------------------------------------------------------------------------
// wxSimpleHtmlListBox - Use this instead of having to override virtual functions in wxHtmlListBox

%include "wx/htmllbox.h"

%define wxHLB_DEFAULT_STYLE
%define wxHLB_MULTIPLE

%class wxSimpleHtmlListBox, wxHtmlWindowInterface //: public wxHtmlListBox, public wxItemContainer

    wxSimpleHtmlListBox()
    wxSimpleHtmlListBox(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, const wxArrayString& choices, long style = wxHLB_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxSimpleHtmlListBox")
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos, const wxSize& size, const wxArrayString& choices, long style = wxHLB_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxSimpleHtmlListBox")

    void SetSelection(int n)
    int GetSelection() const
    virtual unsigned int GetCount() const
    virtual wxString GetString(unsigned int n) const
    wxArrayString GetStrings() const
    virtual void SetString(unsigned int n, const wxString& s)
    virtual void Clear()
    virtual void Delete(unsigned int n)
    void Append(const wxArrayString& strings)
    int Append(const wxString& item)
    int Append(const wxString& item, voidptr_long number) // C++ is (void *clientData) You can put a number here
    int Append(const wxString& item, wxClientData *clientData)

%endclass

%endif //%wxchkver_2_8

// ---------------------------------------------------------------------------
// wxHtmlDCRenderer

%include "wx/html/htmprint.h"

%class %delete %noclassinfo wxHtmlDCRenderer, wxObject

    wxHtmlDCRenderer()

    void SetDC(wxDC* dc, double pixel_scale = 1.0)
    //void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes = NULL)
    void SetSize(int width, int height)
    void SetHtmlText(const wxString& html, const wxString& basepath = "", bool isdir = true)
    !%wxchkver_2_8 int Render(int x, int y, int from = 0, bool dont_render = false) //, int *known_pagebreaks = NULL, int number_of_pages = 0)
    %wxchkver_2_8 int Render(int x, int y, wxArrayInt& known_pagebreaks, int from = 0, bool dont_render = false, int to = INT_MAX);
    int GetTotalHeight()

%endclass

// ---------------------------------------------------------------------------
// wxHtmlEasyPrinting

%include "wx/html/htmprint.h"

%class %delete %noclassinfo wxHtmlEasyPrinting, wxObject

    wxHtmlEasyPrinting(const wxString& name = "Printing", wxFrame* parent_frame = NULL)

    bool PreviewFile(const wxString& htmlfile)
    bool PreviewText(const wxString& htmltext, const wxString& basepath = "")
    bool PrintFile(const wxString& htmlfile)
    bool PrintText(const wxString& htmltext, const wxString& basepath = "")
    %wxchkver_2_4&!%wxchkver_2_6 void PrinterSetup()
    void PageSetup()
    //void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes = NULL)
    void SetHeader(const wxString& header, int pg = wxPAGE_ALL)
    void SetFooter(const wxString& footer, int pg = wxPAGE_ALL)
    wxPrintData* GetPrintData()
    wxPageSetupDialogData* GetPageSetupData()

%endclass

// ---------------------------------------------------------------------------
// wxHtmlPrintout

%include "wx/html/htmprint.h"

%class %delete %noclassinfo wxHtmlPrintout, wxPrintout

    wxHtmlPrintout(const wxString& title = "Printout")

    //void SetFonts(wxString normal_face, wxString fixed_face, const int *sizes = NULL)
    void SetFooter(const wxString& footer, int pg = wxPAGE_ALL)
    void SetHeader(const wxString& header, int pg = wxPAGE_ALL)
    void SetHtmlFile(const wxString& htmlfile)
    void SetHtmlText(const wxString& html, const wxString& basepath = "", bool isdir = true)
    void SetMargins(float top = 25.2, float bottom = 25.2, float left = 25.2, float right = 25.2, float spaces = 5)

%endclass

// ---------------------------------------------------------------------------
// wxHtmlHelpData

%if wxLUA_USE_wxHtmlHelpController && wxUSE_WXHTML_HELP

//%if !%wxchkver_2_6|%wxcompat_2_4
//%struct %noclassinfo wxHtmlContentsItem
// // needs access functions
//%endstruct
//%endif

%include "wx/html/helpdata.h"

//%class %delete %encapsulate %noclassinfo wxHtmlBookRecord
// wxHtmlBookRecord(const wxString& bookfile, const wxString& basepath, const wxString& title, const wxString& start)
//
// wxString GetBookFile() const
// wxString GetTitle() const
// wxString GetStart() const
// wxString GetBasePath() const
// void SetContentsRange(int start, int end)
// int GetContentsStart() const
// int GetContentsEnd() const
//
// void SetTitle(const wxString& title)
// void SetBasePath(const wxString& path)
// void SetStart(const wxString& start)
// wxString GetFullPath(const wxString &page) const;
//%endclass
//
//%class %delete %encapsulate %noclassinfo wxHtmlBookRecArray
// wxHtmlBookRecArray()
//
// size_t Add(const wxHtmlBookRecord& book, size_t copies = 1)
// void Clear()
// int GetCount() const
// void Insert(const wxHtmlBookRecord& book, int nIndex, size_t copies = 1)
// wxHtmlBookRecord Item(size_t nIndex) const
// void Remove(const wxString &sz)
// void RemoveAt(size_t nIndex, size_t count = 1)
//%endclass

%class %delete wxHtmlHelpData, wxObject

    wxHtmlHelpData()

    bool AddBook(const wxString& book)
    wxString FindPageById(int id)
    wxString FindPageByName(const wxString& page)
    //wxHtmlBookRecArray GetBookRecArray()
    //wxHtmlHelpDataItems GetContentsArray()
    //wxHtmlHelpDataItems GetIndexArray()
    void SetTempDir(const wxString& path)

    // rem these out to get rid of deprecated warnings
    //!%wxchkver_2_6|%wxcompat_2_4 wxHtmlContentsItem* GetContents()
    //!%wxchkver_2_6|%wxcompat_2_4 int GetContentsCnt()
    //!%wxchkver_2_6|%wxcompat_2_4 wxHtmlContentsItem* GetIndex()
    //!%wxchkver_2_6|%wxcompat_2_4 int GetIndexCnt()

%endclass

// ---------------------------------------------------------------------------
// wxHtmlHelpController

%include "wx/html/helpctrl.h"

%define wxHF_TOOLBAR
%define wxHF_FLAT_TOOLBAR
%define wxHF_CONTENTS
%define wxHF_INDEX
%define wxHF_SEARCH
%define wxHF_BOOKMARKS
%define wxHF_OPEN_FILES
%define wxHF_PRINT
%define wxHF_MERGE_BOOKS
%define wxHF_ICONS_BOOK
%define wxHF_ICONS_FOLDER
%define wxHF_ICONS_BOOK_CHAPTER
%define wxHF_DEFAULT_STYLE

%class %delete wxHtmlHelpController, wxHelpControllerBase

    wxHtmlHelpController(int style = wxHF_DEFAULT_STYLE)

    bool AddBook(const wxString& book, bool show_wait_msg)
    bool AddBook(const wxFileName& book_file, bool show_wait_msg)
    //virtual wxHtmlHelpFrame* CreateHelpFrame(wxHtmlHelpData * data)
    void Display(const wxString& x)
    void Display(const int id)
    //void DisplayContents() - see wxHelpControllerBase
    void DisplayIndex()
    // bool KeywordSearch(const wxString& keyword, wxHelpSearchMode mode = wxHELP_SEARCH_ALL) // see base
    void ReadCustomization(wxConfigBase* cfg, wxString path = "")
    void SetTempDir(const wxString& path)
    void SetTitleFormat(const wxString& format)
    void UseConfig(wxConfigBase* config, const wxString& rootpath = "")
    void WriteCustomization(wxConfigBase* cfg, wxString path = "")

%endclass

%endif //wxLUA_USE_wxHtmlHelpController && wxUSE_WXHTML_HELP

%endif //wxLUA_USE_wxHTML && wxUSE_HTML

wxwidgets/wxstc_stc.i - Lua table = 'wxstc'
// ===========================================================================
// Purpose: wxStyledTextCtrl library
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================


// NOTE: This file is mostly copied from wxWidget's stc.h header
// to make updating it easier, the comments help diff follow along better.

%include "wx/stc/stc.h"

%define wxSTC_INVALID_POSITION

// Define start of Scintilla messages to be greater than all Windows edit (EM_*) messages
// as many EM_ messages can be used although that use is deprecated.
%define wxSTC_START
%define wxSTC_OPTIONAL_START
%define wxSTC_LEXER_START
%define wxSTC_WS_INVISIBLE
%define wxSTC_WS_VISIBLEALWAYS
%define wxSTC_WS_VISIBLEAFTERINDENT
%define wxSTC_EOL_CRLF
%define wxSTC_EOL_CR
%define wxSTC_EOL_LF

// The SC_CP_UTF8 value can be used to enter Unicode mode.
// This is the same value as CP_UTF8 in Windows
%define wxSTC_CP_UTF8

// The SC_CP_DBCS value can be used to indicate a DBCS mode for GTK+.
%define wxSTC_CP_DBCS
%define wxSTC_MARKER_MAX
%define wxSTC_MARK_CIRCLE
%define wxSTC_MARK_ROUNDRECT
%define wxSTC_MARK_ARROW
%define wxSTC_MARK_SMALLRECT
%define wxSTC_MARK_SHORTARROW
%define wxSTC_MARK_EMPTY
%define wxSTC_MARK_ARROWDOWN
%define wxSTC_MARK_MINUS
%define wxSTC_MARK_PLUS

// Shapes used for outlining column.
%define wxSTC_MARK_VLINE
%define wxSTC_MARK_LCORNER
%define wxSTC_MARK_TCORNER
%define wxSTC_MARK_BOXPLUS
%define wxSTC_MARK_BOXPLUSCONNECTED
%define wxSTC_MARK_BOXMINUS
%define wxSTC_MARK_BOXMINUSCONNECTED
%define wxSTC_MARK_LCORNERCURVE
%define wxSTC_MARK_TCORNERCURVE
%define wxSTC_MARK_CIRCLEPLUS
%define wxSTC_MARK_CIRCLEPLUSCONNECTED
%define wxSTC_MARK_CIRCLEMINUS
%define wxSTC_MARK_CIRCLEMINUSCONNECTED

// Invisible mark that only sets the line background color.
%define wxSTC_MARK_BACKGROUND
%define wxSTC_MARK_DOTDOTDOT
%define wxSTC_MARK_ARROWS
%define wxSTC_MARK_PIXMAP
%define wxSTC_MARK_FULLRECT
%define wxSTC_MARK_CHARACTER

// Markers used for outlining column.
%define wxSTC_MARKNUM_FOLDEREND
%define wxSTC_MARKNUM_FOLDEROPENMID
%define wxSTC_MARKNUM_FOLDERMIDTAIL
%define wxSTC_MARKNUM_FOLDERTAIL
%define wxSTC_MARKNUM_FOLDERSUB
%define wxSTC_MARKNUM_FOLDER
%define wxSTC_MARKNUM_FOLDEROPEN
%define wxSTC_MASK_FOLDERS
%define wxSTC_MARGIN_SYMBOL
%define wxSTC_MARGIN_NUMBER

// Styles in range 32..37 are predefined for parts of the UI and are not used as normal styles.
// Styles 38 and 39 are for future use.
%define wxSTC_STYLE_DEFAULT
%define wxSTC_STYLE_LINENUMBER
%define wxSTC_STYLE_BRACELIGHT
%define wxSTC_STYLE_BRACEBAD
%define wxSTC_STYLE_CONTROLCHAR
%define wxSTC_STYLE_INDENTGUIDE
%define wxSTC_STYLE_LASTPREDEFINED
%define wxSTC_STYLE_MAX

// Character set identifiers are used in StyleSetCharacterSet.
// The values are the same as the Windows *_CHARSET values.
%define wxSTC_CHARSET_ANSI
%define wxSTC_CHARSET_DEFAULT
%define wxSTC_CHARSET_BALTIC
%define wxSTC_CHARSET_CHINESEBIG5
%define wxSTC_CHARSET_EASTEUROPE
%define wxSTC_CHARSET_GB2312
%define wxSTC_CHARSET_GREEK
%define wxSTC_CHARSET_HANGUL
%define wxSTC_CHARSET_MAC
%define wxSTC_CHARSET_OEM
%define wxSTC_CHARSET_RUSSIAN
%define wxSTC_CHARSET_CYRILLIC
%define wxSTC_CHARSET_SHIFTJIS
%define wxSTC_CHARSET_SYMBOL
%define wxSTC_CHARSET_TURKISH
%define wxSTC_CHARSET_JOHAB
%define wxSTC_CHARSET_HEBREW
%define wxSTC_CHARSET_ARABIC
%define wxSTC_CHARSET_VIETNAMESE
%define wxSTC_CHARSET_THAI
%define wxSTC_CHARSET_8859_15
%define wxSTC_CASE_MIXED
%define wxSTC_CASE_UPPER
%define wxSTC_CASE_LOWER
%define wxSTC_INDIC_MAX
%define wxSTC_INDIC_PLAIN
%define wxSTC_INDIC_SQUIGGLE
%define wxSTC_INDIC_TT
%define wxSTC_INDIC_DIAGONAL
%define wxSTC_INDIC_STRIKE
%define wxSTC_INDIC_HIDDEN
%define wxSTC_INDIC_BOX
%define wxSTC_INDIC0_MASK
%define wxSTC_INDIC1_MASK
%define wxSTC_INDIC2_MASK
%define wxSTC_INDICS_MASK

// PrintColourMode - use same colours as screen.
%define wxSTC_PRINT_NORMAL

// PrintColourMode - invert the light value of each style for printing.
%define wxSTC_PRINT_INVERTLIGHT

// PrintColourMode - force black text on white background for printing.
%define wxSTC_PRINT_BLACKONWHITE

// PrintColourMode - text stays coloured, but all background is forced to be white for printing.
%define wxSTC_PRINT_COLOURONWHITE

// PrintColourMode - only the default-background is forced to be white for printing.
%define wxSTC_PRINT_COLOURONWHITEDEFAULTBG
%define wxSTC_FIND_WHOLEWORD
%define wxSTC_FIND_MATCHCASE
%define wxSTC_FIND_WORDSTART
%define wxSTC_FIND_REGEXP
%define wxSTC_FIND_POSIX
%define wxSTC_FOLDLEVELBASE
%define wxSTC_FOLDLEVELWHITEFLAG
%define wxSTC_FOLDLEVELHEADERFLAG
%define wxSTC_FOLDLEVELBOXHEADERFLAG
%define wxSTC_FOLDLEVELBOXFOOTERFLAG
%define wxSTC_FOLDLEVELCONTRACTED
%define wxSTC_FOLDLEVELUNINDENT
%define wxSTC_FOLDLEVELNUMBERMASK
%define wxSTC_FOLDFLAG_LINEBEFORE_EXPANDED
%define wxSTC_FOLDFLAG_LINEBEFORE_CONTRACTED
%define wxSTC_FOLDFLAG_LINEAFTER_EXPANDED
%define wxSTC_FOLDFLAG_LINEAFTER_CONTRACTED
%define wxSTC_FOLDFLAG_LEVELNUMBERS
%define wxSTC_FOLDFLAG_BOX
%define wxSTC_TIME_FOREVER
%define wxSTC_WRAP_NONE
%define wxSTC_WRAP_WORD
%define wxSTC_WRAP_CHAR
%define wxSTC_WRAPVISUALFLAG_NONE
%define wxSTC_WRAPVISUALFLAG_END
%define wxSTC_WRAPVISUALFLAG_START
%define wxSTC_WRAPVISUALFLAGLOC_DEFAULT
%define wxSTC_WRAPVISUALFLAGLOC_END_BY_TEXT
%define wxSTC_WRAPVISUALFLAGLOC_START_BY_TEXT
%define wxSTC_CACHE_NONE
%define wxSTC_CACHE_CARET
%define wxSTC_CACHE_PAGE
%define wxSTC_CACHE_DOCUMENT
%define wxSTC_EDGE_NONE
%define wxSTC_EDGE_LINE
%define wxSTC_EDGE_BACKGROUND
%define wxSTC_CURSORNORMAL
%define wxSTC_CURSORWAIT

// Constants for use with SetVisiblePolicy, similar to SetCaretPolicy.
%define wxSTC_VISIBLE_SLOP
%define wxSTC_VISIBLE_STRICT

// Caret policy, used by SetXCaretPolicy and SetYCaretPolicy.
// If CARET_SLOP is set, we can define a slop value: caretSlop.
// This value defines an unwanted zone (UZ) where the caret is... unwanted.
// This zone is defined as a number of pixels near the vertical margins,
// and as a number of lines near the horizontal margins.
// By keeping the caret away from the edges, it is seen within its context,
// so it is likely that the identifier that the caret is on can be completely seen,
// and that the current line is seen with some of the lines following it which are
// often dependent on that line.
%define wxSTC_CARET_SLOP

// If CARET_STRICT is set, the policy is enforced... strictly.
// The caret is centred on the display if slop is not set,
// and cannot go in the UZ if slop is set.
%define wxSTC_CARET_STRICT

// If CARET_JUMPS is set, the display is moved more energetically
// so the caret can move in the same direction longer before the policy is applied again.
%define wxSTC_CARET_JUMPS

// If CARET_EVEN is not set, instead of having symmetrical UZs,
// the left and bottom UZs are extended up to right and top UZs respectively.
// This way, we favour the displaying of useful information: the begining of lines,
// where most code reside, and the lines after the caret, eg. the body of a function.
%define wxSTC_CARET_EVEN

// Selection modes
%define wxSTC_SEL_STREAM
%define wxSTC_SEL_RECTANGLE
%define wxSTC_SEL_LINES

// Maximum value of keywordSet parameter of SetKeyWords.
%define wxSTC_KEYWORDSET_MAX

// Notifications
// Type of modification and the action which caused the modification.
// These are defined as a bit mask to make it easy to specify which notifications are wanted.
// One bit is set from each of SC_MOD_* and SC_PERFORMED_*.
%define wxSTC_MOD_INSERTTEXT
%define wxSTC_MOD_DELETETEXT
%define wxSTC_MOD_CHANGESTYLE
%define wxSTC_MOD_CHANGEFOLD
%define wxSTC_PERFORMED_USER
%define wxSTC_PERFORMED_UNDO
%define wxSTC_PERFORMED_REDO
%define wxSTC_MULTISTEPUNDOREDO
%define wxSTC_LASTSTEPINUNDOREDO
%define wxSTC_MOD_CHANGEMARKER
%define wxSTC_MOD_BEFOREINSERT
%define wxSTC_MOD_BEFOREDELETE
%define wxSTC_MULTILINEUNDOREDO
%define wxSTC_MODEVENTMASKALL

// Symbolic key codes and modifier flags.
// ASCII and other printable characters below 256.
// Extended keys above 300.
%define wxSTC_KEY_DOWN
%define wxSTC_KEY_UP
%define wxSTC_KEY_LEFT
%define wxSTC_KEY_RIGHT
%define wxSTC_KEY_HOME
%define wxSTC_KEY_END
%define wxSTC_KEY_PRIOR
%define wxSTC_KEY_NEXT
%define wxSTC_KEY_DELETE
%define wxSTC_KEY_INSERT
%define wxSTC_KEY_ESCAPE
%define wxSTC_KEY_BACK
%define wxSTC_KEY_TAB
%define wxSTC_KEY_RETURN
%define wxSTC_KEY_ADD
%define wxSTC_KEY_SUBTRACT
%define wxSTC_KEY_DIVIDE
%define wxSTC_SCMOD_NORM
%define wxSTC_SCMOD_SHIFT
%define wxSTC_SCMOD_CTRL
%define wxSTC_SCMOD_ALT

// For SciLexer.h
%define wxSTC_LEX_CONTAINER
%define wxSTC_LEX_NULL
%define wxSTC_LEX_PYTHON
%define wxSTC_LEX_CPP
%define wxSTC_LEX_HTML
%define wxSTC_LEX_XML
%define wxSTC_LEX_PERL
%define wxSTC_LEX_SQL
%define wxSTC_LEX_VB
%define wxSTC_LEX_PROPERTIES
%define wxSTC_LEX_ERRORLIST
%define wxSTC_LEX_MAKEFILE
%define wxSTC_LEX_BATCH
%define wxSTC_LEX_XCODE
%define wxSTC_LEX_LATEX
%define wxSTC_LEX_LUA
%define wxSTC_LEX_DIFF
%define wxSTC_LEX_CONF
%define wxSTC_LEX_PASCAL
%define wxSTC_LEX_AVE
%define wxSTC_LEX_ADA
%define wxSTC_LEX_LISP
%define wxSTC_LEX_RUBY
%define wxSTC_LEX_EIFFEL
%define wxSTC_LEX_EIFFELKW
%define wxSTC_LEX_TCL
%define wxSTC_LEX_NNCRONTAB
%define wxSTC_LEX_BULLANT
%define wxSTC_LEX_VBSCRIPT
%define wxSTC_LEX_BAAN
%define wxSTC_LEX_MATLAB
%define wxSTC_LEX_SCRIPTOL
%define wxSTC_LEX_ASM
%define wxSTC_LEX_CPPNOCASE
%define wxSTC_LEX_FORTRAN
%define wxSTC_LEX_F77
%define wxSTC_LEX_CSS
%define wxSTC_LEX_POV
%define wxSTC_LEX_LOUT
%define wxSTC_LEX_ESCRIPT
%define wxSTC_LEX_PS
%define wxSTC_LEX_NSIS
%define wxSTC_LEX_MMIXAL
%define wxSTC_LEX_CLW
%define wxSTC_LEX_CLWNOCASE
%define wxSTC_LEX_LOT
%define wxSTC_LEX_YAML
%define wxSTC_LEX_TEX
%define wxSTC_LEX_METAPOST
%define wxSTC_LEX_POWERBASIC
%define wxSTC_LEX_FORTH
%define wxSTC_LEX_ERLANG
%define wxSTC_LEX_OCTAVE
%define wxSTC_LEX_MSSQL
%define wxSTC_LEX_VERILOG
%define wxSTC_LEX_KIX
%define wxSTC_LEX_GUI4CLI
%define wxSTC_LEX_SPECMAN
%define wxSTC_LEX_AU3
%define wxSTC_LEX_APDL
%define wxSTC_LEX_BASH
%define wxSTC_LEX_ASN1
%define wxSTC_LEX_VHDL
%define wxSTC_LEX_CAML
%define wxSTC_LEX_BLITZBASIC
%define wxSTC_LEX_PUREBASIC
%define wxSTC_LEX_HASKELL
%define wxSTC_LEX_PHPSCRIPT
%define wxSTC_LEX_TADS3
%define wxSTC_LEX_REBOL
%define wxSTC_LEX_SMALLTALK
%define wxSTC_LEX_FLAGSHIP
%define wxSTC_LEX_CSOUND
%define wxSTC_LEX_FREEBASIC

// These are deprecated, STC_LEX_HTML should be used instead.
!%wxchkver_2_8 %define wxSTC_LEX_ASP
!%wxchkver_2_8 %define wxSTC_LEX_PHP

// When a lexer specifies its language as SCLEX_AUTOMATIC it receives a
// value assigned in sequence from SCLEX_AUTOMATIC+1.
%define wxSTC_LEX_AUTOMATIC

// Lexical states for SCLEX_PYTHON
%define wxSTC_P_DEFAULT
%define wxSTC_P_COMMENTLINE
%define wxSTC_P_NUMBER
%define wxSTC_P_STRING
%define wxSTC_P_CHARACTER
%define wxSTC_P_WORD
%define wxSTC_P_TRIPLE
%define wxSTC_P_TRIPLEDOUBLE
%define wxSTC_P_CLASSNAME
%define wxSTC_P_DEFNAME
%define wxSTC_P_OPERATOR
%define wxSTC_P_IDENTIFIER
%define wxSTC_P_COMMENTBLOCK
%define wxSTC_P_STRINGEOL
%define wxSTC_P_WORD2
%define wxSTC_P_DECORATOR

// Lexical states for SCLEX_CPP
%define wxSTC_C_DEFAULT
%define wxSTC_C_COMMENT
%define wxSTC_C_COMMENTLINE
%define wxSTC_C_COMMENTDOC
%define wxSTC_C_NUMBER
%define wxSTC_C_WORD
%define wxSTC_C_STRING
%define wxSTC_C_CHARACTER
%define wxSTC_C_UUID
%define wxSTC_C_PREPROCESSOR
%define wxSTC_C_OPERATOR
%define wxSTC_C_IDENTIFIER
%define wxSTC_C_STRINGEOL
%define wxSTC_C_VERBATIM
%define wxSTC_C_REGEX
%define wxSTC_C_COMMENTLINEDOC
%define wxSTC_C_WORD2
%define wxSTC_C_COMMENTDOCKEYWORD
%define wxSTC_C_COMMENTDOCKEYWORDERROR
%define wxSTC_C_GLOBALCLASS

// Lexical states for SCLEX_HTML, SCLEX_XML
%define wxSTC_H_DEFAULT
%define wxSTC_H_TAG
%define wxSTC_H_TAGUNKNOWN
%define wxSTC_H_ATTRIBUTE
%define wxSTC_H_ATTRIBUTEUNKNOWN
%define wxSTC_H_NUMBER
%define wxSTC_H_DOUBLESTRING
%define wxSTC_H_SINGLESTRING
%define wxSTC_H_OTHER
%define wxSTC_H_COMMENT
%define wxSTC_H_ENTITY

// XML and ASP
%define wxSTC_H_TAGEND
%define wxSTC_H_XMLSTART
%define wxSTC_H_XMLEND
%define wxSTC_H_SCRIPT
%define wxSTC_H_ASP
%define wxSTC_H_ASPAT
%define wxSTC_H_CDATA
%define wxSTC_H_QUESTION

// More HTML
%define wxSTC_H_VALUE

// X-Code
%define wxSTC_H_XCCOMMENT

// SGML
%define wxSTC_H_SGML_DEFAULT
%define wxSTC_H_SGML_COMMAND
%define wxSTC_H_SGML_1ST_PARAM
%define wxSTC_H_SGML_DOUBLESTRING
%define wxSTC_H_SGML_SIMPLESTRING
%define wxSTC_H_SGML_ERROR
%define wxSTC_H_SGML_SPECIAL
%define wxSTC_H_SGML_ENTITY
%define wxSTC_H_SGML_COMMENT
%define wxSTC_H_SGML_1ST_PARAM_COMMENT
%define wxSTC_H_SGML_BLOCK_DEFAULT

// Embedded Javascript
%define wxSTC_HJ_START
%define wxSTC_HJ_DEFAULT
%define wxSTC_HJ_COMMENT
%define wxSTC_HJ_COMMENTLINE
%define wxSTC_HJ_COMMENTDOC
%define wxSTC_HJ_NUMBER
%define wxSTC_HJ_WORD
%define wxSTC_HJ_KEYWORD
%define wxSTC_HJ_DOUBLESTRING
%define wxSTC_HJ_SINGLESTRING
%define wxSTC_HJ_SYMBOLS
%define wxSTC_HJ_STRINGEOL
%define wxSTC_HJ_REGEX

// ASP Javascript
%define wxSTC_HJA_START
%define wxSTC_HJA_DEFAULT
%define wxSTC_HJA_COMMENT
%define wxSTC_HJA_COMMENTLINE
%define wxSTC_HJA_COMMENTDOC
%define wxSTC_HJA_NUMBER
%define wxSTC_HJA_WORD
%define wxSTC_HJA_KEYWORD
%define wxSTC_HJA_DOUBLESTRING
%define wxSTC_HJA_SINGLESTRING
%define wxSTC_HJA_SYMBOLS
%define wxSTC_HJA_STRINGEOL
%define wxSTC_HJA_REGEX

// Embedded VBScript
%define wxSTC_HB_START
%define wxSTC_HB_DEFAULT
%define wxSTC_HB_COMMENTLINE
%define wxSTC_HB_NUMBER
%define wxSTC_HB_WORD
%define wxSTC_HB_STRING
%define wxSTC_HB_IDENTIFIER
%define wxSTC_HB_STRINGEOL

// ASP VBScript
%define wxSTC_HBA_START
%define wxSTC_HBA_DEFAULT
%define wxSTC_HBA_COMMENTLINE
%define wxSTC_HBA_NUMBER
%define wxSTC_HBA_WORD
%define wxSTC_HBA_STRING
%define wxSTC_HBA_IDENTIFIER
%define wxSTC_HBA_STRINGEOL

// Embedded Python
%define wxSTC_HP_START
%define wxSTC_HP_DEFAULT
%define wxSTC_HP_COMMENTLINE
%define wxSTC_HP_NUMBER
%define wxSTC_HP_STRING
%define wxSTC_HP_CHARACTER
%define wxSTC_HP_WORD
%define wxSTC_HP_TRIPLE
%define wxSTC_HP_TRIPLEDOUBLE
%define wxSTC_HP_CLASSNAME
%define wxSTC_HP_DEFNAME
%define wxSTC_HP_OPERATOR
%define wxSTC_HP_IDENTIFIER

// PHP
%define wxSTC_HPHP_COMPLEX_VARIABLE

// ASP Python
%define wxSTC_HPA_START
%define wxSTC_HPA_DEFAULT
%define wxSTC_HPA_COMMENTLINE
%define wxSTC_HPA_NUMBER
%define wxSTC_HPA_STRING
%define wxSTC_HPA_CHARACTER
%define wxSTC_HPA_WORD
%define wxSTC_HPA_TRIPLE
%define wxSTC_HPA_TRIPLEDOUBLE
%define wxSTC_HPA_CLASSNAME
%define wxSTC_HPA_DEFNAME
%define wxSTC_HPA_OPERATOR
%define wxSTC_HPA_IDENTIFIER

// PHP
%define wxSTC_HPHP_DEFAULT
%define wxSTC_HPHP_HSTRING
%define wxSTC_HPHP_SIMPLESTRING
%define wxSTC_HPHP_WORD
%define wxSTC_HPHP_NUMBER
%define wxSTC_HPHP_VARIABLE
%define wxSTC_HPHP_COMMENT
%define wxSTC_HPHP_COMMENTLINE
%define wxSTC_HPHP_HSTRING_VARIABLE
%define wxSTC_HPHP_OPERATOR

// Lexical states for SCLEX_PERL
%define wxSTC_PL_DEFAULT
%define wxSTC_PL_ERROR
%define wxSTC_PL_COMMENTLINE
%define wxSTC_PL_POD
%define wxSTC_PL_NUMBER
%define wxSTC_PL_WORD
%define wxSTC_PL_STRING
%define wxSTC_PL_CHARACTER
%define wxSTC_PL_PUNCTUATION
%define wxSTC_PL_PREPROCESSOR
%define wxSTC_PL_OPERATOR
%define wxSTC_PL_IDENTIFIER
%define wxSTC_PL_SCALAR
%define wxSTC_PL_ARRAY
%define wxSTC_PL_HASH
%define wxSTC_PL_SYMBOLTABLE
%define wxSTC_PL_VARIABLE_INDEXER
%define wxSTC_PL_REGEX
%define wxSTC_PL_REGSUBST
%define wxSTC_PL_LONGQUOTE
%define wxSTC_PL_BACKTICKS
%define wxSTC_PL_DATASECTION
%define wxSTC_PL_HERE_DELIM
%define wxSTC_PL_HERE_Q
%define wxSTC_PL_HERE_QQ
%define wxSTC_PL_HERE_QX
%define wxSTC_PL_STRING_Q
%define wxSTC_PL_STRING_QQ
%define wxSTC_PL_STRING_QX
%define wxSTC_PL_STRING_QR
%define wxSTC_PL_STRING_QW
%define wxSTC_PL_POD_VERB

// Lexical states for SCLEX_RUBY
%define wxSTC_RB_DEFAULT
%define wxSTC_RB_ERROR
%define wxSTC_RB_COMMENTLINE
%define wxSTC_RB_POD
%define wxSTC_RB_NUMBER
%define wxSTC_RB_WORD
%define wxSTC_RB_STRING
%define wxSTC_RB_CHARACTER
%define wxSTC_RB_CLASSNAME
%define wxSTC_RB_DEFNAME
%define wxSTC_RB_OPERATOR
%define wxSTC_RB_IDENTIFIER
%define wxSTC_RB_REGEX
%define wxSTC_RB_GLOBAL
%define wxSTC_RB_SYMBOL
%define wxSTC_RB_MODULE_NAME
%define wxSTC_RB_INSTANCE_VAR
%define wxSTC_RB_CLASS_VAR
%define wxSTC_RB_BACKTICKS
%define wxSTC_RB_DATASECTION
%define wxSTC_RB_HERE_DELIM
%define wxSTC_RB_HERE_Q
%define wxSTC_RB_HERE_QQ
%define wxSTC_RB_HERE_QX
%define wxSTC_RB_STRING_Q
%define wxSTC_RB_STRING_QQ
%define wxSTC_RB_STRING_QX
%define wxSTC_RB_STRING_QR
%define wxSTC_RB_STRING_QW
%define wxSTC_RB_WORD_DEMOTED
%define wxSTC_RB_STDIN
%define wxSTC_RB_STDOUT
%define wxSTC_RB_STDERR
%define wxSTC_RB_UPPER_BOUND

// Lexical states for SCLEX_VB, SCLEX_VBSCRIPT, SCLEX_POWERBASIC
%define wxSTC_B_DEFAULT
%define wxSTC_B_COMMENT
%define wxSTC_B_NUMBER
%define wxSTC_B_KEYWORD
%define wxSTC_B_STRING
%define wxSTC_B_PREPROCESSOR
%define wxSTC_B_OPERATOR
%define wxSTC_B_IDENTIFIER
%define wxSTC_B_DATE
%define wxSTC_B_STRINGEOL
%define wxSTC_B_KEYWORD2
%define wxSTC_B_KEYWORD3
%define wxSTC_B_KEYWORD4
%define wxSTC_B_CONSTANT
%define wxSTC_B_ASM
%define wxSTC_B_LABEL
%define wxSTC_B_ERROR
%define wxSTC_B_HEXNUMBER
%define wxSTC_B_BINNUMBER

// Lexical states for SCLEX_PROPERTIES
%define wxSTC_PROPS_DEFAULT
%define wxSTC_PROPS_COMMENT
%define wxSTC_PROPS_SECTION
%define wxSTC_PROPS_ASSIGNMENT
%define wxSTC_PROPS_DEFVAL

// Lexical states for SCLEX_LATEX
%define wxSTC_L_DEFAULT
%define wxSTC_L_COMMAND
%define wxSTC_L_TAG
%define wxSTC_L_MATH
%define wxSTC_L_COMMENT

// Lexical states for SCLEX_LUA
%define wxSTC_LUA_DEFAULT
%define wxSTC_LUA_COMMENT
%define wxSTC_LUA_COMMENTLINE
%define wxSTC_LUA_COMMENTDOC
%define wxSTC_LUA_NUMBER
%define wxSTC_LUA_WORD
%define wxSTC_LUA_STRING
%define wxSTC_LUA_CHARACTER
%define wxSTC_LUA_LITERALSTRING
%define wxSTC_LUA_PREPROCESSOR
%define wxSTC_LUA_OPERATOR
%define wxSTC_LUA_IDENTIFIER
%define wxSTC_LUA_STRINGEOL
%define wxSTC_LUA_WORD2
%define wxSTC_LUA_WORD3
%define wxSTC_LUA_WORD4
%define wxSTC_LUA_WORD5
%define wxSTC_LUA_WORD6
%define wxSTC_LUA_WORD7
%define wxSTC_LUA_WORD8

// Lexical states for SCLEX_ERRORLIST
%define wxSTC_ERR_DEFAULT
%define wxSTC_ERR_PYTHON
%define wxSTC_ERR_GCC
%define wxSTC_ERR_MS
%define wxSTC_ERR_CMD
%define wxSTC_ERR_BORLAND
%define wxSTC_ERR_PERL
%define wxSTC_ERR_NET
%define wxSTC_ERR_LUA
%define wxSTC_ERR_CTAG
%define wxSTC_ERR_DIFF_CHANGED
%define wxSTC_ERR_DIFF_ADDITION
%define wxSTC_ERR_DIFF_DELETION
%define wxSTC_ERR_DIFF_MESSAGE
%define wxSTC_ERR_PHP
%define wxSTC_ERR_ELF
%define wxSTC_ERR_IFC
%define wxSTC_ERR_IFORT
%define wxSTC_ERR_ABSF
%define wxSTC_ERR_TIDY
%define wxSTC_ERR_JAVA_STACK

// Lexical states for SCLEX_BATCH
%define wxSTC_BAT_DEFAULT
%define wxSTC_BAT_COMMENT
%define wxSTC_BAT_WORD
%define wxSTC_BAT_LABEL
%define wxSTC_BAT_HIDE
%define wxSTC_BAT_COMMAND
%define wxSTC_BAT_IDENTIFIER
%define wxSTC_BAT_OPERATOR

// Lexical states for SCLEX_MAKEFILE
%define wxSTC_MAKE_DEFAULT
%define wxSTC_MAKE_COMMENT
%define wxSTC_MAKE_PREPROCESSOR
%define wxSTC_MAKE_IDENTIFIER
%define wxSTC_MAKE_OPERATOR
%define wxSTC_MAKE_TARGET
%define wxSTC_MAKE_IDEOL

// Lexical states for SCLEX_DIFF
%define wxSTC_DIFF_DEFAULT
%define wxSTC_DIFF_COMMENT
%define wxSTC_DIFF_COMMAND
%define wxSTC_DIFF_HEADER
%define wxSTC_DIFF_POSITION
%define wxSTC_DIFF_DELETED
%define wxSTC_DIFF_ADDED

// Lexical states for SCLEX_CONF (Apache Configuration Files Lexer)
%define wxSTC_CONF_DEFAULT
%define wxSTC_CONF_COMMENT
%define wxSTC_CONF_NUMBER
%define wxSTC_CONF_IDENTIFIER
%define wxSTC_CONF_EXTENSION
%define wxSTC_CONF_PARAMETER
%define wxSTC_CONF_STRING
%define wxSTC_CONF_OPERATOR
%define wxSTC_CONF_IP
%define wxSTC_CONF_DIRECTIVE

// Lexical states for SCLEX_AVE, Avenue
%define wxSTC_AVE_DEFAULT
%define wxSTC_AVE_COMMENT
%define wxSTC_AVE_NUMBER
%define wxSTC_AVE_WORD
%define wxSTC_AVE_STRING
%define wxSTC_AVE_ENUM
%define wxSTC_AVE_STRINGEOL
%define wxSTC_AVE_IDENTIFIER
%define wxSTC_AVE_OPERATOR
%define wxSTC_AVE_WORD1
%define wxSTC_AVE_WORD2
%define wxSTC_AVE_WORD3
%define wxSTC_AVE_WORD4
%define wxSTC_AVE_WORD5
%define wxSTC_AVE_WORD6

// Lexical states for SCLEX_ADA
%define wxSTC_ADA_DEFAULT
%define wxSTC_ADA_WORD
%define wxSTC_ADA_IDENTIFIER
%define wxSTC_ADA_NUMBER
%define wxSTC_ADA_DELIMITER
%define wxSTC_ADA_CHARACTER
%define wxSTC_ADA_CHARACTEREOL
%define wxSTC_ADA_STRING
%define wxSTC_ADA_STRINGEOL
%define wxSTC_ADA_LABEL
%define wxSTC_ADA_COMMENTLINE
%define wxSTC_ADA_ILLEGAL

// Lexical states for SCLEX_BAAN
%define wxSTC_BAAN_DEFAULT
%define wxSTC_BAAN_COMMENT
%define wxSTC_BAAN_COMMENTDOC
%define wxSTC_BAAN_NUMBER
%define wxSTC_BAAN_WORD
%define wxSTC_BAAN_STRING
%define wxSTC_BAAN_PREPROCESSOR
%define wxSTC_BAAN_OPERATOR
%define wxSTC_BAAN_IDENTIFIER
%define wxSTC_BAAN_STRINGEOL
%define wxSTC_BAAN_WORD2

// Lexical states for SCLEX_LISP
%define wxSTC_LISP_DEFAULT
%define wxSTC_LISP_COMMENT
%define wxSTC_LISP_NUMBER
%define wxSTC_LISP_KEYWORD
%define wxSTC_LISP_KEYWORD_KW
%define wxSTC_LISP_SYMBOL
%define wxSTC_LISP_STRING
%define wxSTC_LISP_STRINGEOL
%define wxSTC_LISP_IDENTIFIER
%define wxSTC_LISP_OPERATOR
%define wxSTC_LISP_SPECIAL
%define wxSTC_LISP_MULTI_COMMENT

// Lexical states for SCLEX_EIFFEL and SCLEX_EIFFELKW
%define wxSTC_EIFFEL_DEFAULT
%define wxSTC_EIFFEL_COMMENTLINE
%define wxSTC_EIFFEL_NUMBER
%define wxSTC_EIFFEL_WORD
%define wxSTC_EIFFEL_STRING
%define wxSTC_EIFFEL_CHARACTER
%define wxSTC_EIFFEL_OPERATOR
%define wxSTC_EIFFEL_IDENTIFIER
%define wxSTC_EIFFEL_STRINGEOL

// Lexical states for SCLEX_NNCRONTAB (nnCron crontab Lexer)
%define wxSTC_NNCRONTAB_DEFAULT
%define wxSTC_NNCRONTAB_COMMENT
%define wxSTC_NNCRONTAB_TASK
%define wxSTC_NNCRONTAB_SECTION
%define wxSTC_NNCRONTAB_KEYWORD
%define wxSTC_NNCRONTAB_MODIFIER
%define wxSTC_NNCRONTAB_ASTERISK
%define wxSTC_NNCRONTAB_NUMBER
%define wxSTC_NNCRONTAB_STRING
%define wxSTC_NNCRONTAB_ENVIRONMENT
%define wxSTC_NNCRONTAB_IDENTIFIER

// Lexical states for SCLEX_FORTH (Forth Lexer)
%define wxSTC_FORTH_DEFAULT
%define wxSTC_FORTH_COMMENT
%define wxSTC_FORTH_COMMENT_ML
%define wxSTC_FORTH_IDENTIFIER
%define wxSTC_FORTH_CONTROL
%define wxSTC_FORTH_KEYWORD
%define wxSTC_FORTH_DEFWORD
%define wxSTC_FORTH_PREWORD1
%define wxSTC_FORTH_PREWORD2
%define wxSTC_FORTH_NUMBER
%define wxSTC_FORTH_STRING
%define wxSTC_FORTH_LOCALE

// Lexical states for SCLEX_MATLAB
%define wxSTC_MATLAB_DEFAULT
%define wxSTC_MATLAB_COMMENT
%define wxSTC_MATLAB_COMMAND
%define wxSTC_MATLAB_NUMBER
%define wxSTC_MATLAB_KEYWORD

// single quoted string
%define wxSTC_MATLAB_STRING
%define wxSTC_MATLAB_OPERATOR
%define wxSTC_MATLAB_IDENTIFIER
%define wxSTC_MATLAB_DOUBLEQUOTESTRING

// Lexical states for SCLEX_SCRIPTOL
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_DEFAULT
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENT
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTLINE
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTDOC
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_NUMBER
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_WORD
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_STRING
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_CHARACTER
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_UUID
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_PREPROCESSOR
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_OPERATOR
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_IDENTIFIER
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_STRINGEOL
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_VERBATIM
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_REGEX
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTLINEDOC
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_WORD2
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTDOCKEYWORD
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTDOCKEYWORDERROR
!%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTBASIC

%wxchkver_2_6 %define wxSTC_SCRIPTOL_DEFAULT
%wxchkver_2_6 %define wxSTC_SCRIPTOL_WHITE
%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTLINE
%wxchkver_2_6 %define wxSTC_SCRIPTOL_PERSISTENT
%wxchkver_2_6 %define wxSTC_SCRIPTOL_CSTYLE
%wxchkver_2_6 %define wxSTC_SCRIPTOL_COMMENTBLOCK
%wxchkver_2_6 %define wxSTC_SCRIPTOL_NUMBER
%wxchkver_2_6 %define wxSTC_SCRIPTOL_STRING
%wxchkver_2_6 %define wxSTC_SCRIPTOL_CHARACTER
%wxchkver_2_6 %define wxSTC_SCRIPTOL_STRINGEOL
%wxchkver_2_6 %define wxSTC_SCRIPTOL_KEYWORD
%wxchkver_2_6 %define wxSTC_SCRIPTOL_OPERATOR
%wxchkver_2_6 %define wxSTC_SCRIPTOL_IDENTIFIER
%wxchkver_2_6 %define wxSTC_SCRIPTOL_TRIPLE
%wxchkver_2_6 %define wxSTC_SCRIPTOL_CLASSNAME
%wxchkver_2_6 %define wxSTC_SCRIPTOL_PREPROCESSOR

// Lexical states for SCLEX_ASM
%define wxSTC_ASM_DEFAULT
%define wxSTC_ASM_COMMENT
%define wxSTC_ASM_NUMBER
%define wxSTC_ASM_STRING
%define wxSTC_ASM_OPERATOR
%define wxSTC_ASM_IDENTIFIER
%define wxSTC_ASM_CPUINSTRUCTION
%define wxSTC_ASM_MATHINSTRUCTION
%define wxSTC_ASM_REGISTER
%define wxSTC_ASM_DIRECTIVE
%define wxSTC_ASM_DIRECTIVEOPERAND
%define wxSTC_ASM_COMMENTBLOCK
%define wxSTC_ASM_CHARACTER
%define wxSTC_ASM_STRINGEOL
%define wxSTC_ASM_EXTINSTRUCTION

// Lexical states for SCLEX_FORTRAN
%define wxSTC_F_DEFAULT
%define wxSTC_F_COMMENT
%define wxSTC_F_NUMBER
%define wxSTC_F_STRING1
%define wxSTC_F_STRING2
%define wxSTC_F_STRINGEOL
%define wxSTC_F_OPERATOR
%define wxSTC_F_IDENTIFIER
%define wxSTC_F_WORD
%define wxSTC_F_WORD2
%define wxSTC_F_WORD3
%define wxSTC_F_PREPROCESSOR
%define wxSTC_F_OPERATOR2
%define wxSTC_F_LABEL
%define wxSTC_F_CONTINUATION

// Lexical states for SCLEX_CSS
%define wxSTC_CSS_DEFAULT
%define wxSTC_CSS_TAG
%define wxSTC_CSS_CLASS
%define wxSTC_CSS_PSEUDOCLASS
%define wxSTC_CSS_UNKNOWN_PSEUDOCLASS
%define wxSTC_CSS_OPERATOR
%define wxSTC_CSS_IDENTIFIER
%define wxSTC_CSS_UNKNOWN_IDENTIFIER
%define wxSTC_CSS_VALUE
%define wxSTC_CSS_COMMENT
%define wxSTC_CSS_ID
%define wxSTC_CSS_IMPORTANT
%define wxSTC_CSS_DIRECTIVE
%define wxSTC_CSS_DOUBLESTRING
%define wxSTC_CSS_SINGLESTRING
%define wxSTC_CSS_IDENTIFIER2
%define wxSTC_CSS_ATTRIBUTE

// Lexical states for SCLEX_POV
%define wxSTC_POV_DEFAULT
%define wxSTC_POV_COMMENT
%define wxSTC_POV_COMMENTLINE
%define wxSTC_POV_NUMBER
%define wxSTC_POV_OPERATOR
%define wxSTC_POV_IDENTIFIER
%define wxSTC_POV_STRING
%define wxSTC_POV_STRINGEOL
%define wxSTC_POV_DIRECTIVE
%define wxSTC_POV_BADDIRECTIVE
%define wxSTC_POV_WORD2
%define wxSTC_POV_WORD3
%define wxSTC_POV_WORD4
%define wxSTC_POV_WORD5
%define wxSTC_POV_WORD6
%define wxSTC_POV_WORD7
%define wxSTC_POV_WORD8

// Lexical states for SCLEX_LOUT
%define wxSTC_LOUT_DEFAULT
%define wxSTC_LOUT_COMMENT
%define wxSTC_LOUT_NUMBER
%define wxSTC_LOUT_WORD
%define wxSTC_LOUT_WORD2
%define wxSTC_LOUT_WORD3
%define wxSTC_LOUT_WORD4
%define wxSTC_LOUT_STRING
%define wxSTC_LOUT_OPERATOR
%define wxSTC_LOUT_IDENTIFIER
%define wxSTC_LOUT_STRINGEOL

// Lexical states for SCLEX_ESCRIPT
%define wxSTC_ESCRIPT_DEFAULT
%define wxSTC_ESCRIPT_COMMENT
%define wxSTC_ESCRIPT_COMMENTLINE
%define wxSTC_ESCRIPT_COMMENTDOC
%define wxSTC_ESCRIPT_NUMBER
%define wxSTC_ESCRIPT_WORD
%define wxSTC_ESCRIPT_STRING
%define wxSTC_ESCRIPT_OPERATOR
%define wxSTC_ESCRIPT_IDENTIFIER
%define wxSTC_ESCRIPT_BRACE
%define wxSTC_ESCRIPT_WORD2
%define wxSTC_ESCRIPT_WORD3

// Lexical states for SCLEX_PS
%define wxSTC_PS_DEFAULT
%define wxSTC_PS_COMMENT
%define wxSTC_PS_DSC_COMMENT
%define wxSTC_PS_DSC_VALUE
%define wxSTC_PS_NUMBER
%define wxSTC_PS_NAME
%define wxSTC_PS_KEYWORD
%define wxSTC_PS_LITERAL
%define wxSTC_PS_IMMEVAL
%define wxSTC_PS_PAREN_ARRAY
%define wxSTC_PS_PAREN_DICT
%define wxSTC_PS_PAREN_PROC
%define wxSTC_PS_TEXT
%define wxSTC_PS_HEXSTRING
%define wxSTC_PS_BASE85STRING
%define wxSTC_PS_BADSTRINGCHAR

// Lexical states for SCLEX_NSIS
%define wxSTC_NSIS_DEFAULT
%define wxSTC_NSIS_COMMENT
%define wxSTC_NSIS_STRINGDQ
%define wxSTC_NSIS_STRINGLQ
%define wxSTC_NSIS_STRINGRQ
%define wxSTC_NSIS_FUNCTION
%define wxSTC_NSIS_VARIABLE
%define wxSTC_NSIS_LABEL
%define wxSTC_NSIS_USERDEFINED
%define wxSTC_NSIS_SECTIONDEF
%define wxSTC_NSIS_SUBSECTIONDEF
%define wxSTC_NSIS_IFDEFINEDEF
%define wxSTC_NSIS_MACRODEF
%define wxSTC_NSIS_STRINGVAR
%define wxSTC_NSIS_NUMBER
%define wxSTC_NSIS_SECTIONGROUP
%define wxSTC_NSIS_PAGEEX
%define wxSTC_NSIS_FUNCTIONDEF
%define wxSTC_NSIS_COMMENTBOX

// Lexical states for SCLEX_MMIXAL
%define wxSTC_MMIXAL_LEADWS
%define wxSTC_MMIXAL_COMMENT
%define wxSTC_MMIXAL_LABEL
%define wxSTC_MMIXAL_OPCODE
%define wxSTC_MMIXAL_OPCODE_PRE
%define wxSTC_MMIXAL_OPCODE_VALID
%define wxSTC_MMIXAL_OPCODE_UNKNOWN
%define wxSTC_MMIXAL_OPCODE_POST
%define wxSTC_MMIXAL_OPERANDS
%define wxSTC_MMIXAL_NUMBER
%define wxSTC_MMIXAL_REF
%define wxSTC_MMIXAL_CHAR
%define wxSTC_MMIXAL_STRING
%define wxSTC_MMIXAL_REGISTER
%define wxSTC_MMIXAL_HEX
%define wxSTC_MMIXAL_OPERATOR
%define wxSTC_MMIXAL_SYMBOL
%define wxSTC_MMIXAL_INCLUDE

// Lexical states for SCLEX_CLW
%define wxSTC_CLW_DEFAULT
%define wxSTC_CLW_LABEL
%define wxSTC_CLW_COMMENT
%define wxSTC_CLW_STRING
%define wxSTC_CLW_USER_IDENTIFIER
%define wxSTC_CLW_INTEGER_CONSTANT
%define wxSTC_CLW_REAL_CONSTANT
%define wxSTC_CLW_PICTURE_STRING
%define wxSTC_CLW_KEYWORD
%define wxSTC_CLW_COMPILER_DIRECTIVE
%define wxSTC_CLW_RUNTIME_EXPRESSIONS
%define wxSTC_CLW_BUILTIN_PROCEDURES_FUNCTION
%define wxSTC_CLW_STRUCTURE_DATA_TYPE
%define wxSTC_CLW_ATTRIBUTE
%define wxSTC_CLW_STANDARD_EQUATE
%define wxSTC_CLW_ERROR
%define wxSTC_CLW_DEPRECATED

// Lexical states for SCLEX_LOT
%define wxSTC_LOT_DEFAULT
%define wxSTC_LOT_HEADER
%define wxSTC_LOT_BREAK
%define wxSTC_LOT_SET
%define wxSTC_LOT_PASS
%define wxSTC_LOT_FAIL
%define wxSTC_LOT_ABORT

// Lexical states for SCLEX_YAML
%define wxSTC_YAML_DEFAULT
%define wxSTC_YAML_COMMENT
%define wxSTC_YAML_IDENTIFIER
%define wxSTC_YAML_KEYWORD
%define wxSTC_YAML_NUMBER
%define wxSTC_YAML_REFERENCE
%define wxSTC_YAML_DOCUMENT
%define wxSTC_YAML_TEXT
%define wxSTC_YAML_ERROR

// Lexical states for SCLEX_TEX
%define wxSTC_TEX_DEFAULT
%define wxSTC_TEX_SPECIAL
%define wxSTC_TEX_GROUP
%define wxSTC_TEX_SYMBOL
%define wxSTC_TEX_COMMAND
%define wxSTC_TEX_TEXT
%define wxSTC_METAPOST_DEFAULT
%define wxSTC_METAPOST_SPECIAL
%define wxSTC_METAPOST_GROUP
%define wxSTC_METAPOST_SYMBOL
%define wxSTC_METAPOST_COMMAND
%define wxSTC_METAPOST_TEXT
%define wxSTC_METAPOST_EXTRA

// Lexical states for SCLEX_ERLANG
%define wxSTC_ERLANG_DEFAULT
%define wxSTC_ERLANG_COMMENT
%define wxSTC_ERLANG_VARIABLE
%define wxSTC_ERLANG_NUMBER
%define wxSTC_ERLANG_KEYWORD
%define wxSTC_ERLANG_STRING
%define wxSTC_ERLANG_OPERATOR
%define wxSTC_ERLANG_ATOM
%define wxSTC_ERLANG_FUNCTION_NAME
%define wxSTC_ERLANG_CHARACTER
%define wxSTC_ERLANG_MACRO
%define wxSTC_ERLANG_RECORD
%define wxSTC_ERLANG_SEPARATOR
%define wxSTC_ERLANG_NODE_NAME
%define wxSTC_ERLANG_UNKNOWN

// Lexical states for SCLEX_OCTAVE are identical to MatLab
// Lexical states for SCLEX_MSSQL
%define wxSTC_MSSQL_DEFAULT
%define wxSTC_MSSQL_COMMENT
%define wxSTC_MSSQL_LINE_COMMENT
%define wxSTC_MSSQL_NUMBER
%define wxSTC_MSSQL_STRING
%define wxSTC_MSSQL_OPERATOR
%define wxSTC_MSSQL_IDENTIFIER
%define wxSTC_MSSQL_VARIABLE
%define wxSTC_MSSQL_COLUMN_NAME
%define wxSTC_MSSQL_STATEMENT
%define wxSTC_MSSQL_DATATYPE
%define wxSTC_MSSQL_SYSTABLE
%define wxSTC_MSSQL_GLOBAL_VARIABLE
%define wxSTC_MSSQL_FUNCTION
%define wxSTC_MSSQL_STORED_PROCEDURE
%define wxSTC_MSSQL_DEFAULT_PREF_DATATYPE
%define wxSTC_MSSQL_COLUMN_NAME_2

// Lexical states for SCLEX_VERILOG
%define wxSTC_V_DEFAULT
%define wxSTC_V_COMMENT
%define wxSTC_V_COMMENTLINE
%define wxSTC_V_COMMENTLINEBANG
%define wxSTC_V_NUMBER
%define wxSTC_V_WORD
%define wxSTC_V_STRING
%define wxSTC_V_WORD2
%define wxSTC_V_WORD3
%define wxSTC_V_PREPROCESSOR
%define wxSTC_V_OPERATOR
%define wxSTC_V_IDENTIFIER
%define wxSTC_V_STRINGEOL
%define wxSTC_V_USER

// Lexical states for SCLEX_KIX
%define wxSTC_KIX_DEFAULT
%define wxSTC_KIX_COMMENT
%define wxSTC_KIX_STRING1
%define wxSTC_KIX_STRING2
%define wxSTC_KIX_NUMBER
%define wxSTC_KIX_VAR
%define wxSTC_KIX_MACRO
%define wxSTC_KIX_KEYWORD
%define wxSTC_KIX_FUNCTIONS
%define wxSTC_KIX_OPERATOR
%define wxSTC_KIX_IDENTIFIER

// Lexical states for SCLEX_GUI4CLI
%define wxSTC_GC_DEFAULT
%define wxSTC_GC_COMMENTLINE
%define wxSTC_GC_COMMENTBLOCK
%define wxSTC_GC_GLOBAL
%define wxSTC_GC_EVENT
%define wxSTC_GC_ATTRIBUTE
%define wxSTC_GC_CONTROL
%define wxSTC_GC_COMMAND
%define wxSTC_GC_STRING
%define wxSTC_GC_OPERATOR

// Lexical states for SCLEX_SPECMAN
%define wxSTC_SN_DEFAULT
%define wxSTC_SN_CODE
%define wxSTC_SN_COMMENTLINE
%define wxSTC_SN_COMMENTLINEBANG
%define wxSTC_SN_NUMBER
%define wxSTC_SN_WORD
%define wxSTC_SN_STRING
%define wxSTC_SN_WORD2
%define wxSTC_SN_WORD3
%define wxSTC_SN_PREPROCESSOR
%define wxSTC_SN_OPERATOR
%define wxSTC_SN_IDENTIFIER
%define wxSTC_SN_STRINGEOL
%define wxSTC_SN_REGEXTAG
%define wxSTC_SN_SIGNAL
%define wxSTC_SN_USER

// Lexical states for SCLEX_AU3
%define wxSTC_AU3_DEFAULT
%define wxSTC_AU3_COMMENT
%define wxSTC_AU3_COMMENTBLOCK
%define wxSTC_AU3_NUMBER
%define wxSTC_AU3_FUNCTION
%define wxSTC_AU3_KEYWORD
%define wxSTC_AU3_MACRO
%define wxSTC_AU3_STRING
%define wxSTC_AU3_OPERATOR
%define wxSTC_AU3_VARIABLE
%define wxSTC_AU3_SENT
%define wxSTC_AU3_PREPROCESSOR
%define wxSTC_AU3_SPECIAL
%define wxSTC_AU3_EXPAND
%define wxSTC_AU3_COMOBJ

// Lexical states for SCLEX_APDL
%define wxSTC_APDL_DEFAULT
%define wxSTC_APDL_COMMENT
%define wxSTC_APDL_COMMENTBLOCK
%define wxSTC_APDL_NUMBER
%define wxSTC_APDL_STRING
%define wxSTC_APDL_OPERATOR
%define wxSTC_APDL_WORD
%define wxSTC_APDL_PROCESSOR
%define wxSTC_APDL_COMMAND
%define wxSTC_APDL_SLASHCOMMAND
%define wxSTC_APDL_STARCOMMAND
%define wxSTC_APDL_ARGUMENT
%define wxSTC_APDL_FUNCTION

// Lexical states for SCLEX_BASH
%define wxSTC_SH_DEFAULT
%define wxSTC_SH_ERROR
%define wxSTC_SH_COMMENTLINE
%define wxSTC_SH_NUMBER
%define wxSTC_SH_WORD
%define wxSTC_SH_STRING
%define wxSTC_SH_CHARACTER
%define wxSTC_SH_OPERATOR
%define wxSTC_SH_IDENTIFIER
%define wxSTC_SH_SCALAR
%define wxSTC_SH_PARAM
%define wxSTC_SH_BACKTICKS
%define wxSTC_SH_HERE_DELIM
%define wxSTC_SH_HERE_Q

// Lexical states for SCLEX_ASN1
%define wxSTC_ASN1_DEFAULT
%define wxSTC_ASN1_COMMENT
%define wxSTC_ASN1_IDENTIFIER
%define wxSTC_ASN1_STRING
%define wxSTC_ASN1_OID
%define wxSTC_ASN1_SCALAR
%define wxSTC_ASN1_KEYWORD
%define wxSTC_ASN1_ATTRIBUTE
%define wxSTC_ASN1_DESCRIPTOR
%define wxSTC_ASN1_TYPE
%define wxSTC_ASN1_OPERATOR

// Lexical states for SCLEX_VHDL
%define wxSTC_VHDL_DEFAULT
%define wxSTC_VHDL_COMMENT
%define wxSTC_VHDL_COMMENTLINEBANG
%define wxSTC_VHDL_NUMBER
%define wxSTC_VHDL_STRING
%define wxSTC_VHDL_OPERATOR
%define wxSTC_VHDL_IDENTIFIER
%define wxSTC_VHDL_STRINGEOL
%define wxSTC_VHDL_KEYWORD
%define wxSTC_VHDL_STDOPERATOR
%define wxSTC_VHDL_ATTRIBUTE
%define wxSTC_VHDL_STDFUNCTION
%define wxSTC_VHDL_STDPACKAGE
%define wxSTC_VHDL_STDTYPE
%define wxSTC_VHDL_USERWORD

// Lexical states for SCLEX_CAML
%define wxSTC_CAML_DEFAULT
%define wxSTC_CAML_IDENTIFIER
%define wxSTC_CAML_TAGNAME
%define wxSTC_CAML_KEYWORD
%define wxSTC_CAML_KEYWORD2
%define wxSTC_CAML_KEYWORD3
%define wxSTC_CAML_LINENUM
%define wxSTC_CAML_OPERATOR
%define wxSTC_CAML_NUMBER
%define wxSTC_CAML_CHAR
%define wxSTC_CAML_STRING
%define wxSTC_CAML_COMMENT
%define wxSTC_CAML_COMMENT1
%define wxSTC_CAML_COMMENT2
%define wxSTC_CAML_COMMENT3

// Lexical states for SCLEX_HASKELL
%define wxSTC_HA_DEFAULT
%define wxSTC_HA_IDENTIFIER
%define wxSTC_HA_KEYWORD
%define wxSTC_HA_NUMBER
%define wxSTC_HA_STRING
%define wxSTC_HA_CHARACTER
%define wxSTC_HA_CLASS
%define wxSTC_HA_MODULE
%define wxSTC_HA_CAPITAL
%define wxSTC_HA_DATA
%define wxSTC_HA_IMPORT
%define wxSTC_HA_OPERATOR
%define wxSTC_HA_INSTANCE
%define wxSTC_HA_COMMENTLINE
%define wxSTC_HA_COMMENTBLOCK
%define wxSTC_HA_COMMENTBLOCK2
%define wxSTC_HA_COMMENTBLOCK3

// Lexical states of SCLEX_TADS3
%define wxSTC_T3_DEFAULT
%define wxSTC_T3_X_DEFAULT
%define wxSTC_T3_PREPROCESSOR
%define wxSTC_T3_BLOCK_COMMENT
%define wxSTC_T3_LINE_COMMENT
%define wxSTC_T3_OPERATOR
%define wxSTC_T3_KEYWORD
%define wxSTC_T3_NUMBER
%define wxSTC_T3_IDENTIFIER
%define wxSTC_T3_S_STRING
%define wxSTC_T3_D_STRING
%define wxSTC_T3_X_STRING
%define wxSTC_T3_LIB_DIRECTIVE
%define wxSTC_T3_MSG_PARAM
%define wxSTC_T3_HTML_TAG
%define wxSTC_T3_HTML_DEFAULT
%define wxSTC_T3_HTML_STRING
%define wxSTC_T3_USER1
%define wxSTC_T3_USER2
%define wxSTC_T3_USER3

// Lexical states for SCLEX_REBOL
%define wxSTC_REBOL_DEFAULT
%define wxSTC_REBOL_COMMENTLINE
%define wxSTC_REBOL_COMMENTBLOCK
%define wxSTC_REBOL_PREFACE
%define wxSTC_REBOL_OPERATOR
%define wxSTC_REBOL_CHARACTER
%define wxSTC_REBOL_QUOTEDSTRING
%define wxSTC_REBOL_BRACEDSTRING
%define wxSTC_REBOL_NUMBER
%define wxSTC_REBOL_PAIR
%define wxSTC_REBOL_TUPLE
%define wxSTC_REBOL_BINARY
%define wxSTC_REBOL_MONEY
%define wxSTC_REBOL_ISSUE
%define wxSTC_REBOL_TAG
%define wxSTC_REBOL_FILE
%define wxSTC_REBOL_EMAIL
%define wxSTC_REBOL_URL
%define wxSTC_REBOL_DATE
%define wxSTC_REBOL_TIME
%define wxSTC_REBOL_IDENTIFIER
%define wxSTC_REBOL_WORD
%define wxSTC_REBOL_WORD2
%define wxSTC_REBOL_WORD3
%define wxSTC_REBOL_WORD4
%define wxSTC_REBOL_WORD5
%define wxSTC_REBOL_WORD6
%define wxSTC_REBOL_WORD7
%define wxSTC_REBOL_WORD8

// Lexical states for SCLEX_SQL
%define wxSTC_SQL_DEFAULT
%define wxSTC_SQL_COMMENT
%define wxSTC_SQL_COMMENTLINE
%define wxSTC_SQL_COMMENTDOC
%define wxSTC_SQL_NUMBER
%define wxSTC_SQL_WORD
%define wxSTC_SQL_STRING
%define wxSTC_SQL_CHARACTER
%define wxSTC_SQL_SQLPLUS
%define wxSTC_SQL_SQLPLUS_PROMPT
%define wxSTC_SQL_OPERATOR
%define wxSTC_SQL_IDENTIFIER
%define wxSTC_SQL_SQLPLUS_COMMENT
%define wxSTC_SQL_COMMENTLINEDOC
%define wxSTC_SQL_WORD2
%define wxSTC_SQL_COMMENTDOCKEYWORD
%define wxSTC_SQL_COMMENTDOCKEYWORDERROR
%define wxSTC_SQL_USER1
%define wxSTC_SQL_USER2
%define wxSTC_SQL_USER3
%define wxSTC_SQL_USER4
%define wxSTC_SQL_QUOTEDIDENTIFIER

// Lexical states for SCLEX_SMALLTALK
%define wxSTC_ST_DEFAULT
%define wxSTC_ST_STRING
%define wxSTC_ST_NUMBER
%define wxSTC_ST_COMMENT
%define wxSTC_ST_SYMBOL
%define wxSTC_ST_BINARY
%define wxSTC_ST_BOOL
%define wxSTC_ST_SELF
%define wxSTC_ST_SUPER
%define wxSTC_ST_NIL
%define wxSTC_ST_GLOBAL
%define wxSTC_ST_RETURN
%define wxSTC_ST_SPECIAL
%define wxSTC_ST_KWSEND
%define wxSTC_ST_ASSIGN
%define wxSTC_ST_CHARACTER
%define wxSTC_ST_SPEC_SEL

// Lexical states for SCLEX_FLAGSHIP (clipper)
%define wxSTC_FS_DEFAULT
%define wxSTC_FS_COMMENT
%define wxSTC_FS_COMMENTLINE
%define wxSTC_FS_COMMENTDOC
%define wxSTC_FS_COMMENTLINEDOC
%define wxSTC_FS_COMMENTDOCKEYWORD
%define wxSTC_FS_COMMENTDOCKEYWORDERROR
%define wxSTC_FS_KEYWORD
%define wxSTC_FS_KEYWORD2
%define wxSTC_FS_KEYWORD3
%define wxSTC_FS_KEYWORD4
%define wxSTC_FS_NUMBER
%define wxSTC_FS_STRING
%define wxSTC_FS_PREPROCESSOR
%define wxSTC_FS_OPERATOR
%define wxSTC_FS_IDENTIFIER
%define wxSTC_FS_DATE
%define wxSTC_FS_STRINGEOL
%define wxSTC_FS_CONSTANT
%define wxSTC_FS_ASM
%define wxSTC_FS_LABEL
%define wxSTC_FS_ERROR
%define wxSTC_FS_HEXNUMBER
%define wxSTC_FS_BINNUMBER

// Lexical states for SCLEX_CSOUND
%define wxSTC_CSOUND_DEFAULT
%define wxSTC_CSOUND_COMMENT
%define wxSTC_CSOUND_NUMBER
%define wxSTC_CSOUND_OPERATOR
%define wxSTC_CSOUND_INSTR
%define wxSTC_CSOUND_IDENTIFIER
%define wxSTC_CSOUND_OPCODE
%define wxSTC_CSOUND_HEADERSTMT
%define wxSTC_CSOUND_USERKEYWORD
%define wxSTC_CSOUND_COMMENTBLOCK
%define wxSTC_CSOUND_PARAM
%define wxSTC_CSOUND_ARATE_VAR
%define wxSTC_CSOUND_KRATE_VAR
%define wxSTC_CSOUND_IRATE_VAR
%define wxSTC_CSOUND_GLOBAL_VAR
%define wxSTC_CSOUND_STRINGEOL


//-----------------------------------------
// Commands that can be bound to keystrokes


// Redoes the next action on the undo history.
%define wxSTC_CMD_REDO

// Select all the text in the document.
%define wxSTC_CMD_SELECTALL

// Undo one action in the undo history.
%define wxSTC_CMD_UNDO

// Cut the selection to the clipboard.
%define wxSTC_CMD_CUT

// Copy the selection to the clipboard.
%define wxSTC_CMD_COPY

// Paste the contents of the clipboard into the document replacing the selection.
%define wxSTC_CMD_PASTE

// Clear the selection.
%define wxSTC_CMD_CLEAR

// Move caret down one line.
%define wxSTC_CMD_LINEDOWN

// Move caret down one line extending selection to new caret position.
%define wxSTC_CMD_LINEDOWNEXTEND

// Move caret up one line.
%define wxSTC_CMD_LINEUP

// Move caret up one line extending selection to new caret position.
%define wxSTC_CMD_LINEUPEXTEND

// Move caret left one character.
%define wxSTC_CMD_CHARLEFT

// Move caret left one character extending selection to new caret position.
%define wxSTC_CMD_CHARLEFTEXTEND

// Move caret right one character.
%define wxSTC_CMD_CHARRIGHT

// Move caret right one character extending selection to new caret position.
%define wxSTC_CMD_CHARRIGHTEXTEND

// Move caret left one word.
%define wxSTC_CMD_WORDLEFT

// Move caret left one word extending selection to new caret position.
%define wxSTC_CMD_WORDLEFTEXTEND

// Move caret right one word.
%define wxSTC_CMD_WORDRIGHT

// Move caret right one word extending selection to new caret position.
%define wxSTC_CMD_WORDRIGHTEXTEND

// Move caret to first position on line.
%define wxSTC_CMD_HOME

// Move caret to first position on line extending selection to new caret position.
%define wxSTC_CMD_HOMEEXTEND

// Move caret to last position on line.
%define wxSTC_CMD_LINEEND

// Move caret to last position on line extending selection to new caret position.
%define wxSTC_CMD_LINEENDEXTEND

// Move caret to first position in document.
%define wxSTC_CMD_DOCUMENTSTART

// Move caret to first position in document extending selection to new caret position.
%define wxSTC_CMD_DOCUMENTSTARTEXTEND

// Move caret to last position in document.
%define wxSTC_CMD_DOCUMENTEND

// Move caret to last position in document extending selection to new caret position.
%define wxSTC_CMD_DOCUMENTENDEXTEND

// Move caret one page up.
%define wxSTC_CMD_PAGEUP

// Move caret one page up extending selection to new caret position.
%define wxSTC_CMD_PAGEUPEXTEND

// Move caret one page down.
%define wxSTC_CMD_PAGEDOWN

// Move caret one page down extending selection to new caret position.
%define wxSTC_CMD_PAGEDOWNEXTEND

// Switch from insert to overtype mode or the reverse.
%define wxSTC_CMD_EDITTOGGLEOVERTYPE

// Cancel any modes such as call tip or auto-completion list display.
%define wxSTC_CMD_CANCEL

// Delete the selection or if no selection, the character before the caret.
%define wxSTC_CMD_DELETEBACK

// If selection is empty or all on one line replace the selection with a tab character.
// If more than one line selected, indent the lines.
%define wxSTC_CMD_TAB

// Dedent the selected lines.
%define wxSTC_CMD_BACKTAB

// Insert a new line, may use a CRLF, CR or LF depending on EOL mode.
%define wxSTC_CMD_NEWLINE

// Insert a Form Feed character.
%define wxSTC_CMD_FORMFEED

// Move caret to before first visible character on line.
// If already there move to first character on line.
%define wxSTC_CMD_VCHOME

// Like VCHome but extending selection to new caret position.
%define wxSTC_CMD_VCHOMEEXTEND

// Magnify the displayed text by increasing the sizes by 1 point.
%define wxSTC_CMD_ZOOMIN

// Make the displayed text smaller by decreasing the sizes by 1 point.
%define wxSTC_CMD_ZOOMOUT

// Delete the word to the left of the caret.
%define wxSTC_CMD_DELWORDLEFT

// Delete the word to the right of the caret.
%define wxSTC_CMD_DELWORDRIGHT

// Cut the line containing the caret.
%define wxSTC_CMD_LINECUT

// Delete the line containing the caret.
%define wxSTC_CMD_LINEDELETE

// Switch the current line with the previous.
%define wxSTC_CMD_LINETRANSPOSE

// Duplicate the current line.
%define wxSTC_CMD_LINEDUPLICATE

// Transform the selection to lower case.
%define wxSTC_CMD_LOWERCASE

// Transform the selection to upper case.
%define wxSTC_CMD_UPPERCASE

// Scroll the document down, keeping the caret visible.
%define wxSTC_CMD_LINESCROLLDOWN

// Scroll the document up, keeping the caret visible.
%define wxSTC_CMD_LINESCROLLUP

// Delete the selection or if no selection, the character before the caret.
// Will not delete the character before at the start of a line.
%define wxSTC_CMD_DELETEBACKNOTLINE

// Move caret to first position on display line.
%define wxSTC_CMD_HOMEDISPLAY

// Move caret to first position on display line extending selection to
// new caret position.
%define wxSTC_CMD_HOMEDISPLAYEXTEND

// Move caret to last position on display line.
%define wxSTC_CMD_LINEENDDISPLAY

// Move caret to last position on display line extending selection to new
// caret position.
%define wxSTC_CMD_LINEENDDISPLAYEXTEND

// These are like their namesakes Home(Extend)?, LineEnd(Extend)?, VCHome(Extend)?
// except they behave differently when word-wrap is enabled:
// They go first to the start / end of the display line, like (Home|LineEnd)Display
// The difference is that, the cursor is already at the point, it goes on to the start
// or end of the document line, as appropriate for (Home|LineEnd|VCHome)(Extend)?.
%define wxSTC_CMD_HOMEWRAP
%define wxSTC_CMD_HOMEWRAPEXTEND
%define wxSTC_CMD_LINEENDWRAP
%define wxSTC_CMD_LINEENDWRAPEXTEND
%define wxSTC_CMD_VCHOMEWRAP
%define wxSTC_CMD_VCHOMEWRAPEXTEND

// Copy the line containing the caret.
%define wxSTC_CMD_LINECOPY

// Move to the previous change in capitalisation.
%define wxSTC_CMD_WORDPARTLEFT

// Move to the previous change in capitalisation extending selection
// to new caret position.
%define wxSTC_CMD_WORDPARTLEFTEXTEND

// Move to the change next in capitalisation.
%define wxSTC_CMD_WORDPARTRIGHT

// Move to the next change in capitalisation extending selection
// to new caret position.
%define wxSTC_CMD_WORDPARTRIGHTEXTEND

// Delete back from the current position to the start of the line.
%define wxSTC_CMD_DELLINELEFT

// Delete forwards from the current position to the end of the line.
%define wxSTC_CMD_DELLINERIGHT

// Move caret between paragraphs (delimited by empty lines).
%define wxSTC_CMD_PARADOWN
%define wxSTC_CMD_PARADOWNEXTEND
%define wxSTC_CMD_PARAUP
%define wxSTC_CMD_PARAUPEXTEND

// Move caret down one line, extending rectangular selection to new caret position.
%define wxSTC_CMD_LINEDOWNRECTEXTEND

// Move caret up one line, extending rectangular selection to new caret position.
%define wxSTC_CMD_LINEUPRECTEXTEND

// Move caret left one character, extending rectangular selection to new caret position.
%define wxSTC_CMD_CHARLEFTRECTEXTEND

// Move caret right one character, extending rectangular selection to new caret position.
%define wxSTC_CMD_CHARRIGHTRECTEXTEND

// Move caret to first position on line, extending rectangular selection to new caret position.
%define wxSTC_CMD_HOMERECTEXTEND

// Move caret to before first visible character on line.
// If already there move to first character on line.
// In either case, extend rectangular selection to new caret position.
%define wxSTC_CMD_VCHOMERECTEXTEND

// Move caret to last position on line, extending rectangular selection to new caret position.
%define wxSTC_CMD_LINEENDRECTEXTEND

// Move caret one page up, extending rectangular selection to new caret position.
%define wxSTC_CMD_PAGEUPRECTEXTEND

// Move caret one page down, extending rectangular selection to new caret position.
%define wxSTC_CMD_PAGEDOWNRECTEXTEND

// Move caret to top of page, or one page up if already at top of page.
%define wxSTC_CMD_STUTTEREDPAGEUP

// Move caret to top of page, or one page up if already at top of page, extending selection to new caret position.
%define wxSTC_CMD_STUTTEREDPAGEUPEXTEND

// Move caret to bottom of page, or one page down if already at bottom of page.
%define wxSTC_CMD_STUTTEREDPAGEDOWN

// Move caret to bottom of page, or one page down if already at bottom of page, extending selection to new caret position.
%define wxSTC_CMD_STUTTEREDPAGEDOWNEXTEND

// Move caret left one word, position cursor at end of word.
%define wxSTC_CMD_WORDLEFTEND

// Move caret left one word, position cursor at end of word, extending selection to new caret position.
%define wxSTC_CMD_WORDLEFTENDEXTEND

// Move caret right one word, position cursor at end of word.
%define wxSTC_CMD_WORDRIGHTEND

// Move caret right one word, position cursor at end of word, extending selection to new caret position.
%define wxSTC_CMD_WORDRIGHTENDEXTEND

///////////////////////////////////////////////////////////////////////////////
// wxStyledTextCtrl

%class wxStyledTextCtrl, wxControl

    wxStyledTextCtrl(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString &name = "wxStyledTextCtrl")

    //----------------------------------------------------------------------
    // BEGIN generated section. The following code is automatically generated
    // by gen_iface.py. Do not edit this file. Edit stc.h.in instead
    // and regenerate

    // Add text to the document at current position.
    void AddText(const wxString& text);

    // Add array of cells to document.
    //void AddStyledText(const wxMemoryBuffer& data);

    // Insert string at a position.
    void InsertText(int pos, const wxString& text);

    // Delete all text in the document.
    void ClearAll();

    // Set all style bytes to 0, remove all folding information.
    void ClearDocumentStyle();

    // Returns the number of characters in the document.
    int GetLength();

    // Returns the character byte at the position.
    int GetCharAt(int pos);

    // Returns the position of the caret.
    int GetCurrentPos();

    // Returns the position of the opposite end of the selection to the caret.
    int GetAnchor();

    // Returns the style byte at the position.
    int GetStyleAt(int pos);

    // Redoes the next action on the undo history.
    void Redo();

    // Choose between collecting actions into the undo
    // history and discarding them.
    void SetUndoCollection(bool collectUndo);

    // Select all the text in the document.
    void SelectAll();

    // Remember the current position in the undo history as the position
    // at which the document was saved.
    void SetSavePoint();

    // Retrieve a buffer of cells.
    //wxMemoryBuffer GetStyledText(int startPos, int endPos);

    // Are there any redoable actions in the undo history?
    bool CanRedo();

    // Retrieve the line number at which a particular marker is located.
    int MarkerLineFromHandle(int handle);

    // Delete a marker.
    void MarkerDeleteHandle(int handle);

    // Is undo history being collected?
    bool GetUndoCollection();

    // Are white space characters currently visible?
    // Returns one of SCWS_* constants.
    int GetViewWhiteSpace();

    // Make white space characters invisible, always visible or visible outside indentation.
    void SetViewWhiteSpace(int viewWS);

    // Find the position from a point within the window.
    int PositionFromPoint(const wxPoint& pt);

    // Find the position from a point within the window but return
    // INVALID_POSITION if not close to text.
    int PositionFromPointClose(int x, int y);

    // Set caret to start of a line and ensure it is visible.
    void GotoLine(int line);

    // Set caret to a position and ensure it is visible.
    void GotoPos(int pos);

    // Set the selection anchor to a position. The anchor is the opposite
    // end of the selection from the caret.
    void SetAnchor(int posAnchor);

    // Retrieve the text of the line containing the caret.
    // Returns the index of the caret on the line.
    //#ifdef SWIG
    // wxString GetCurLine(int* OUTPUT);
    //#else
    // %override [int linePos] wxStyledTextCtrl::GetCurLine()
    // C++ Func: wxString GetCurLine(int* linePos=NULL);
    wxString GetCurLine();
    //#endif

    // Retrieve the position of the last correctly styled character.
    int GetEndStyled();

    // Convert all line endings in the document to one mode.
    void ConvertEOLs(int eolMode);

    // Retrieve the current end of line mode - one of CRLF, CR, or LF.
    int GetEOLMode();

    // Set the current end of line mode.
    void SetEOLMode(int eolMode);

    // Set the current styling position to pos and the styling mask to mask.
    // The styling mask can be used to protect some bits in each styling byte from modification.
    void StartStyling(int pos, unsigned int mask);

    // Change style from current styling position for length characters to a style
    // and move the current styling position to after this newly styled segment.
    void SetStyling(int length, int style);

    // Is drawing done first into a buffer or direct to the screen?
    bool GetBufferedDraw();

    // If drawing is buffered then each line of text is drawn into a bitmap buffer
    // before drawing it to the screen to avoid flicker.
    void SetBufferedDraw(bool buffered);

    // Change the visible size of a tab to be a multiple of the width of a space character.
    void SetTabWidth(int tabWidth);

    // Retrieve the visible size of a tab.
    int GetTabWidth();

    // Set the code page used to interpret the bytes of the document as characters.
    void SetCodePage(int codePage);

    // Set the symbol used for a particular marker number,
    // and optionally the fore and background colours.
    void MarkerDefine(int markerNumber, int markerSymbol, const wxColour& foreground = wxNullColour, const wxColour& background = wxNullColour);

    // Set the foreground colour used for a particular marker number.
    void MarkerSetForeground(int markerNumber, const wxColour& fore);

    // Set the background colour used for a particular marker number.
    void MarkerSetBackground(int markerNumber, const wxColour& back);

    // Add a marker to a line, returning an ID which can be used to find or delete the marker.
    int MarkerAdd(int line, int markerNumber);

    // Delete a marker from a line.
    void MarkerDelete(int line, int markerNumber);

    // Delete all markers with a particular number from all lines.
    void MarkerDeleteAll(int markerNumber);

    // Get a bit mask of all the markers set on a line.
    unsigned int MarkerGet(int line);

    // Find the next line after lineStart that includes a marker in mask.
    int MarkerNext(int lineStart, unsigned int markerMask);

    // Find the previous line before lineStart that includes a marker in mask.
    int MarkerPrevious(int lineStart, unsigned int markerMask);

    // Define a marker from a bitmap
    void MarkerDefineBitmap(int markerNumber, const wxBitmap& bmp);

    // Add a set of markers to a line.
    void MarkerAddSet(int line, int set);

    // Set a margin to be either numeric or symbolic.
    void SetMarginType(int margin, int marginType);

    // Retrieve the type of a margin.
    int GetMarginType(int margin);

    // Set the width of a margin to a width expressed in pixels.
    void SetMarginWidth(int margin, int pixelWidth);

    // Retrieve the width of a margin in pixels.
    int GetMarginWidth(int margin);

    // Set a mask that determines which markers are displayed in a margin.
    void SetMarginMask(int margin, unsigned int mask); // NOTE: wxSTC has "int mask", but we need all the bits so we force uint

    // Retrieve the marker mask of a margin.
    unsigned int GetMarginMask(int margin);

    // Make a margin sensitive or insensitive to mouse clicks.
    void SetMarginSensitive(int margin, bool sensitive);

    // Retrieve the mouse click sensitivity of a margin.
    bool GetMarginSensitive(int margin);

    // Clear all the styles and make equivalent to the global default style.
    void StyleClearAll();

    // Set the foreground colour of a style.
    void StyleSetForeground(int style, const wxColour& fore);

    // Set the background colour of a style.
    void StyleSetBackground(int style, const wxColour& back);

    // Set a style to be bold or not.
    void StyleSetBold(int style, bool bold);

    // Set a style to be italic or not.
    void StyleSetItalic(int style, bool italic);

    // Set the size of characters of a style.
    void StyleSetSize(int style, int sizePoints);

    // Set the font of a style.
    void StyleSetFaceName(int style, const wxString& fontName);

    // Set a style to have its end of line filled or not.
    void StyleSetEOLFilled(int style, bool filled);

    // Reset the default style to its state at startup
    void StyleResetDefault();

    // Set a style to be underlined or not.
    void StyleSetUnderline(int style, bool underline);

    // Set a style to be mixed case, or to force upper or lower case.
    void StyleSetCase(int style, int caseForce);

    // Set a style to be a hotspot or not.
    void StyleSetHotSpot(int style, bool hotspot);

    // Set the foreground colour of the selection and whether to use this setting.
    void SetSelForeground(bool useSetting, const wxColour& fore);

    // Set the background colour of the selection and whether to use this setting.
    void SetSelBackground(bool useSetting, const wxColour& back);

    // Set the foreground colour of the caret.
    void SetCaretForeground(const wxColour& fore);

    // When key+modifier combination km is pressed perform msg.
    void CmdKeyAssign(int key, int modifiers, int cmd);

    // When key+modifier combination km is pressed do nothing.
    void CmdKeyClear(int key, int modifiers);

    // Drop all key mappings.
    void CmdKeyClearAll();

    // Set the styles for a segment of the document.

    // %override [Lua string styleBytes] wxStyledTextCtrl::SetStyleBytes(int length, Lua string styleBytes)
    // C++ Func: void SetStyleBytes(int length, char* styleBytes);
    void SetStyleBytes(int length, char* styleBytes);

    // Set a style to be visible or not.
    void StyleSetVisible(int style, bool visible);

    // Get the time in milliseconds that the caret is on and off.
    int GetCaretPeriod();

    // Get the time in milliseconds that the caret is on and off. 0 = steady on.
    void SetCaretPeriod(int periodMilliseconds);

    // Set the set of characters making up words for when moving or selecting by word.
    // First sets deaults like SetCharsDefault.
    void SetWordChars(const wxString& characters);

    // Start a sequence of actions that is undone and redone as a unit.
    // May be nested.
    void BeginUndoAction();

    // End a sequence of actions that is undone and redone as a unit.
    void EndUndoAction();

    // Set an indicator to plain, squiggle or TT.
    void IndicatorSetStyle(int indic, int style);

    // Retrieve the style of an indicator.
    int IndicatorGetStyle(int indic);

    // Set the foreground colour of an indicator.
    void IndicatorSetForeground(int indic, const wxColour& fore);

    // Retrieve the foreground colour of an indicator.
    wxColour IndicatorGetForeground(int indic);

    // Set the foreground colour of all whitespace and whether to use this setting.
    void SetWhitespaceForeground(bool useSetting, const wxColour& fore);

    // Set the background colour of all whitespace and whether to use this setting.
    void SetWhitespaceBackground(bool useSetting, const wxColour& back);

    // Divide each styling byte into lexical class bits (default: 5) and indicator
    // bits (default: 3). If a lexer requires more than 32 lexical states, then this
    // is used to expand the possible states.
    void SetStyleBits(int bits);

    // Retrieve number of bits in style bytes used to hold the lexical state.
    int GetStyleBits();

    // Used to hold extra styling information for each line.
    void SetLineState(int line, int state);

    // Retrieve the extra styling information for a line.
    int GetLineState(int line);

    // Retrieve the last line number that has line state.
    int GetMaxLineState();

    // Is the background of the line containing the caret in a different colour?
    bool GetCaretLineVisible();

    // Display the background of the line containing the caret in a different colour.
    void SetCaretLineVisible(bool show);

    // Get the colour of the background of the line containing the caret.
    !%wxchkver_2_8 wxColour GetCaretLineBack();
    %wxchkver_2_8 wxColour GetCaretLineBackground();

    // Set the colour of the background of the line containing the caret.
    !%wxchkver_2_8 void SetCaretLineBack(const wxColour& back);
    %wxchkver_2_8 void SetCaretLineBackground(const wxColour& back);

    // Set a style to be changeable or not (read only).
    // Experimental feature, currently buggy.
    void StyleSetChangeable(int style, bool changeable);

    // Display a auto-completion list.
    // The lenEntered parameter indicates how many characters before
    // the caret should be used to provide context.
    void AutoCompShow(int lenEntered, const wxString& itemList);

    // Remove the auto-completion list from the screen.
    void AutoCompCancel();

    // Is there an auto-completion list visible?
    bool AutoCompActive();

    // Retrieve the position of the caret when the auto-completion list was displayed.
    int AutoCompPosStart();

    // User has selected an item so remove the list and insert the selection.
    void AutoCompComplete();

    // Define a set of character that when typed cancel the auto-completion list.
    void AutoCompStops(const wxString& characterSet);

    // Change the separator character in the string setting up an auto-completion list.
    // Default is space but can be changed if items contain space.
    void AutoCompSetSeparator(int separatorCharacter);

    // Retrieve the auto-completion list separator character.
    int AutoCompGetSeparator();

    // Select the item in the auto-completion list that starts with a string.
    void AutoCompSelect(const wxString& text);

    // Should the auto-completion list be cancelled if the user backspaces to a
    // position before where the box was created.
    void AutoCompSetCancelAtStart(bool cancel);

    // Retrieve whether auto-completion cancelled by backspacing before start.
    bool AutoCompGetCancelAtStart();

    // Define a set of characters that when typed will cause the autocompletion to
    // choose the selected item.
    void AutoCompSetFillUps(const wxString& characterSet);

    // Should a single item auto-completion list automatically choose the item.
    void AutoCompSetChooseSingle(bool chooseSingle);

    // Retrieve whether a single item auto-completion list automatically choose the item.
    bool AutoCompGetChooseSingle();

    // Set whether case is significant when performing auto-completion searches.
    void AutoCompSetIgnoreCase(bool ignoreCase);

    // Retrieve state of ignore case flag.
    bool AutoCompGetIgnoreCase();

    // Display a list of strings and send notification when user chooses one.
    void UserListShow(int listType, const wxString& itemList);

    // Set whether or not autocompletion is hidden automatically when nothing matches.
    void AutoCompSetAutoHide(bool autoHide);

    // Retrieve whether or not autocompletion is hidden automatically when nothing matches.
    bool AutoCompGetAutoHide();

    // Set whether or not autocompletion deletes any word characters
    // after the inserted text upon completion.
    void AutoCompSetDropRestOfWord(bool dropRestOfWord);

    // Retrieve whether or not autocompletion deletes any word characters
    // after the inserted text upon completion.
    bool AutoCompGetDropRestOfWord();

    // Register an image for use in autocompletion lists.
    void RegisterImage(int type, const wxBitmap& bmp);

    // Clear all the registered images.
    void ClearRegisteredImages();

    // Retrieve the auto-completion list type-separator character.
    int AutoCompGetTypeSeparator();

    // Change the type-separator character in the string setting up an auto-completion list.
    // Default is '?' but can be changed if items contain '?'.
    void AutoCompSetTypeSeparator(int separatorCharacter);

    // Set the maximum width, in characters, of auto-completion and user lists.
    // Set to 0 to autosize to fit longest item, which is the default.
    void AutoCompSetMaxWidth(int characterCount);

    // Get the maximum width, in characters, of auto-completion and user lists.
    int AutoCompGetMaxWidth();

    // Set the maximum height, in rows, of auto-completion and user lists.
    // The default is 5 rows.
    void AutoCompSetMaxHeight(int rowCount);

    // Set the maximum height, in rows, of auto-completion and user lists.
    int AutoCompGetMaxHeight();

    // Set the number of spaces used for one level of indentation.
    void SetIndent(int indentSize);

    // Retrieve indentation size.
    int GetIndent();

    // Indentation will only use space characters if useTabs is false, otherwise
    // it will use a combination of tabs and spaces.
    void SetUseTabs(bool useTabs);

    // Retrieve whether tabs will be used in indentation.
    bool GetUseTabs();

    // Change the indentation of a line to a number of columns.
    void SetLineIndentation(int line, int indentSize);

    // Retrieve the number of columns that a line is indented.
    int GetLineIndentation(int line);

    // Retrieve the position before the first non indentation character on a line.
    int GetLineIndentPosition(int line);

    // Retrieve the column number of a position, taking tab width into account.
    int GetColumn(int pos);

    // Show or hide the horizontal scroll bar.
    void SetUseHorizontalScrollBar(bool show);

    // Is the horizontal scroll bar visible?
    bool GetUseHorizontalScrollBar();

    // Show or hide indentation guides.
    void SetIndentationGuides(bool show);

    // Are the indentation guides visible?
    bool GetIndentationGuides();

    // Set the highlighted indentation guide column.
    // 0 = no highlighted guide.
    void SetHighlightGuide(int column);

    // Get the highlighted indentation guide column.
    int GetHighlightGuide();

    // Get the position after the last visible characters on a line.
    int GetLineEndPosition(int line);

    // Get the code page used to interpret the bytes of the document as characters.
    int GetCodePage();

    // Get the foreground colour of the caret.
    wxColour GetCaretForeground();

    // In read-only mode?
    bool GetReadOnly();

    // Sets the position of the caret.
    void SetCurrentPos(int pos);

    // Sets the position that starts the selection - this becomes the anchor.
    void SetSelectionStart(int pos);

    // Returns the position at the start of the selection.
    int GetSelectionStart();

    // Sets the position that ends the selection - this becomes the currentPosition.
    void SetSelectionEnd(int pos);

    // Returns the position at the end of the selection.
    int GetSelectionEnd();

    // Sets the print magnification added to the point size of each style for printing.
    void SetPrintMagnification(int magnification);

    // Returns the print magnification.
    int GetPrintMagnification();

    // Modify colours when printing for clearer printed text.
    void SetPrintColourMode(int mode);

    // Returns the print colour mode.
    int GetPrintColourMode();

    // Find some text in the document.
    int FindText(int minPos, int maxPos, const wxString& text, int flags=0);

    // On Windows, will draw the document into a display context such as a printer.
    int FormatRange(bool doDraw, int startPos, int endPos, wxDC* draw, wxDC* target, const wxRect& renderRect, const wxRect& pageRect);

    // Retrieve the display line at the top of the display.
    int GetFirstVisibleLine();

    // Retrieve the contents of a line.
    wxString GetLine(int line);

    // Returns the number of lines in the document. There is always at least one.
    int GetLineCount();

    // Sets the size in pixels of the left margin.
    void SetMarginLeft(int pixelWidth);

    // Returns the size in pixels of the left margin.
    int GetMarginLeft();

    // Sets the size in pixels of the right margin.
    void SetMarginRight(int pixelWidth);

    // Returns the size in pixels of the right margin.
    int GetMarginRight();

    // Is the document different from when it was last saved?
    bool GetModify();

    // Select a range of text.
    void SetSelection(int start, int end);

    // Retrieve the selected text.
    wxString GetSelectedText();

    // Retrieve a range of text.
    wxString GetTextRange(int startPos, int endPos);

    // Draw the selection in normal style or with selection highlighted.
    void HideSelection(bool normal);

    // Retrieve the line containing a position.
    int LineFromPosition(int pos);

    // Retrieve the position at the start of a line.
    int PositionFromLine(int line);

    // Scroll horizontally and vertically.
    void LineScroll(int columns, int lines);

    // Ensure the caret is visible.
    void EnsureCaretVisible();

    // Replace the selected text with the argument text.
    void ReplaceSelection(const wxString& text);

    // Set to read only or read write.
    void SetReadOnly(bool readOnly);

    // Will a paste succeed?
    bool CanPaste();

    // Are there any undoable actions in the undo history?
    bool CanUndo();

    // Delete the undo history.
    void EmptyUndoBuffer();

    // Undo one action in the undo history.
    void Undo();

    // Cut the selection to the clipboard.
    void Cut();

    // Copy the selection to the clipboard.
    void Copy();

    // Paste the contents of the clipboard into the document replacing the selection.
    void Paste();

    // Clear the selection.
    void Clear();

    // Replace the contents of the document with the argument text.
    void SetText(const wxString& text);

    // Retrieve all the text in the document.
    wxString GetText();

    // Retrieve the number of characters in the document.
    int GetTextLength();

    // Set to overtype (true) or insert mode.
    void SetOvertype(bool overtype);

    // Returns true if overtype mode is active otherwise false is returned.
    bool GetOvertype();

    // Set the width of the insert mode caret.
    void SetCaretWidth(int pixelWidth);

    // Returns the width of the insert mode caret.
    int GetCaretWidth();

    // Sets the position that starts the target which is used for updating the
    // document without affecting the scroll position.
    void SetTargetStart(int pos);

    // Get the position that starts the target.
    int GetTargetStart();

    // Sets the position that ends the target which is used for updating the
    // document without affecting the scroll position.
    void SetTargetEnd(int pos);

    // Get the position that ends the target.
    int GetTargetEnd();

    // Replace the target text with the argument text.
    // Text is counted so it can contain NULs.
    // Returns the length of the replacement text.
    int ReplaceTarget(const wxString& text);

    // Replace the target text with the argument text after \d processing.
    // Text is counted so it can contain NULs.
    // Looks for \d where d is between 1 and 9 and replaces these with the strings
    // matched in the last search operation which were surrounded by \( and \).
    // Returns the length of the replacement text including any change
    // caused by processing the \d patterns.
    int ReplaceTargetRE(const wxString& text);

    // Search for a counted string in the target and set the target to the found
    // range. Text is counted so it can contain NULs.
    // Returns length of range or -1 for failure in which case target is not moved.
    int SearchInTarget(const wxString& text);

    // Set the search flags used by SearchInTarget.
    void SetSearchFlags(int flags);

    // Get the search flags used by SearchInTarget.
    int GetSearchFlags();

    // Show a call tip containing a definition near position pos.
    void CallTipShow(int pos, const wxString& definition);

    // Remove the call tip from the screen.
    void CallTipCancel();

    // Is there an active call tip?
    bool CallTipActive();

    // Retrieve the position where the caret was before displaying the call tip.
    int CallTipPosAtStart();

    // Highlight a segment of the definition.
    void CallTipSetHighlight(int start, int end);

    // Set the background colour for the call tip.
    void CallTipSetBackground(const wxColour& back);

    // Set the foreground colour for the call tip.
    void CallTipSetForeground(const wxColour& fore);

    // Set the foreground colour for the highlighted part of the call tip.
    void CallTipSetForegroundHighlight(const wxColour& fore);

    // Find the display line of a document line taking hidden lines into account.
    int VisibleFromDocLine(int line);

    // Find the document line of a display line taking hidden lines into account.
    int DocLineFromVisible(int lineDisplay);

    // The number of display lines needed to wrap a document line
    int WrapCount(int line);

    // Set the fold level of a line.
    // This encodes an integer level along with flags indicating whether the
    // line is a header and whether it is effectively white space.
    void SetFoldLevel(int line, int level);

    // Retrieve the fold level of a line.
    int GetFoldLevel(int line);

    // Find the last child line of a header line.
    int GetLastChild(int line, int level);

    // Find the parent line of a child line.
    int GetFoldParent(int line);

    // Make a range of lines visible.
    void ShowLines(int lineStart, int lineEnd);

    // Make a range of lines invisible.
    void HideLines(int lineStart, int lineEnd);

    // Is a line visible?
    bool GetLineVisible(int line);

    // Show the children of a header line.
    void SetFoldExpanded(int line, bool expanded);

    // Is a header line expanded?
    bool GetFoldExpanded(int line);

    // Switch a header line between expanded and contracted.
    void ToggleFold(int line);

    // Ensure a particular line is visible by expanding any header line hiding it.
    void EnsureVisible(int line);

    // Set some style options for folding.
    void SetFoldFlags(int flags);

    // Ensure a particular line is visible by expanding any header line hiding it.
    // Use the currently set visibility policy to determine which range to display.
    void EnsureVisibleEnforcePolicy(int line);

    // Sets whether a tab pressed when caret is within indentation indents.
    void SetTabIndents(bool tabIndents);

    // Does a tab pressed when caret is within indentation indent?
    bool GetTabIndents();

    // Sets whether a backspace pressed when caret is within indentation unindents.
    void SetBackSpaceUnIndents(bool bsUnIndents);

    // Does a backspace pressed when caret is within indentation unindent?
    bool GetBackSpaceUnIndents();

    // Sets the time the mouse must sit still to generate a mouse dwell event.
    void SetMouseDwellTime(int periodMilliseconds);

    // Retrieve the time the mouse must sit still to generate a mouse dwell event.
    int GetMouseDwellTime();

    // Get position of start of word.
    int WordStartPosition(int pos, bool onlyWordCharacters);

    // Get position of end of word.
    int WordEndPosition(int pos, bool onlyWordCharacters);

    // Sets whether text is word wrapped.
    void SetWrapMode(int mode);

    // Retrieve whether text is word wrapped.
    int GetWrapMode();

    // Set the display mode of visual flags for wrapped lines.
    void SetWrapVisualFlags(int wrapVisualFlags);

    // Retrive the display mode of visual flags for wrapped lines.
    int GetWrapVisualFlags();

    // Set the location of visual flags for wrapped lines.
    void SetWrapVisualFlagsLocation(int wrapVisualFlagsLocation);

    // Retrive the location of visual flags for wrapped lines.
    int GetWrapVisualFlagsLocation();

    // Set the start indent for wrapped lines.
    void SetWrapStartIndent(int indent);

    // Retrive the start indent for wrapped lines.
    int GetWrapStartIndent();

    // Sets the degree of caching of layout information.
    void SetLayoutCache(int mode);

    // Retrieve the degree of caching of layout information.
    int GetLayoutCache();

    // Sets the document width assumed for scrolling.
    void SetScrollWidth(int pixelWidth);

    // Retrieve the document width assumed for scrolling.
    int GetScrollWidth();

    // Measure the pixel width of some text in a particular style.
    // NUL terminated text argument.
    // Does not handle tab or control characters.
    int TextWidth(int style, const wxString& text);

    // Sets the scroll range so that maximum scroll position has
    // the last line at the bottom of the view (default).
    // Setting this to false allows scrolling one page below the last line.
    void SetEndAtLastLine(bool endAtLastLine);

    // Retrieve whether the maximum scroll position has the last
    // line at the bottom of the view.
    bool GetEndAtLastLine();

    // Retrieve the height of a particular line of text in pixels.
    int TextHeight(int line);

    // Show or hide the vertical scroll bar.
    void SetUseVerticalScrollBar(bool show);

    // Is the vertical scroll bar visible?
    bool GetUseVerticalScrollBar();

    // Append a string to the end of the document without changing the selection.
    void AppendText(const wxString& text);

    // Is drawing done in two phases with backgrounds drawn before foregrounds?
    bool GetTwoPhaseDraw();

    // In twoPhaseDraw mode, drawing is performed in two phases, first the background
    // and then the foreground. This avoids chopping off characters that overlap the next run.
    void SetTwoPhaseDraw(bool twoPhase);

    // Make the target range start and end be the same as the selection range start and end.
    void TargetFromSelection();

    // Join the lines in the target.
    void LinesJoin();

    // Split the lines in the target into lines that are less wide than pixelWidth
    // where possible.
    void LinesSplit(int pixelWidth);

    // Set the colours used as a chequerboard pattern in the fold margin
    void SetFoldMarginColour(bool useSetting, const wxColour& back);
    void SetFoldMarginHiColour(bool useSetting, const wxColour& fore);

    // Move caret down one line.
    void LineDown();

    // Move caret down one line extending selection to new caret position.
    void LineDownExtend();

    // Move caret up one line.
    void LineUp();

    // Move caret up one line extending selection to new caret position.
    void LineUpExtend();

    // Move caret left one character.
    void CharLeft();

    // Move caret left one character extending selection to new caret position.
    void CharLeftExtend();

    // Move caret right one character.
    void CharRight();

    // Move caret right one character extending selection to new caret position.
    void CharRightExtend();

    // Move caret left one word.
    void WordLeft();

    // Move caret left one word extending selection to new caret position.
    void WordLeftExtend();

    // Move caret right one word.
    void WordRight();

    // Move caret right one word extending selection to new caret position.
    void WordRightExtend();

    // Move caret to first position on line.
    void Home();

    // Move caret to first position on line extending selection to new caret position.
    void HomeExtend();

    // Move caret to last position on line.
    void LineEnd();

    // Move caret to last position on line extending selection to new caret position.
    void LineEndExtend();

    // Move caret to first position in document.
    void DocumentStart();

    // Move caret to first position in document extending selection to new caret position.
    void DocumentStartExtend();

    // Move caret to last position in document.
    void DocumentEnd();

    // Move caret to last position in document extending selection to new caret position.
    void DocumentEndExtend();

    // Move caret one page up.
    void PageUp();

    // Move caret one page up extending selection to new caret position.
    void PageUpExtend();

    // Move caret one page down.
    void PageDown();

    // Move caret one page down extending selection to new caret position.
    void PageDownExtend();

    // Switch from insert to overtype mode or the reverse.
    void EditToggleOvertype();

    // Cancel any modes such as call tip or auto-completion list display.
    void Cancel();

    // Delete the selection or if no selection, the character before the caret.
    void DeleteBack();

    // If selection is empty or all on one line replace the selection with a tab character.
    // If more than one line selected, indent the lines.
    void Tab();

    // Dedent the selected lines.
    void BackTab();

    // Insert a new line, may use a CRLF, CR or LF depending on EOL mode.
    void NewLine();

    // Insert a Form Feed character.
    void FormFeed();

    // Move caret to before first visible character on line.
    // If already there move to first character on line.
    void VCHome();

    // Like VCHome but extending selection to new caret position.
    void VCHomeExtend();

    // Magnify the displayed text by increasing the sizes by 1 point.
    void ZoomIn();

    // Make the displayed text smaller by decreasing the sizes by 1 point.
    void ZoomOut();

    // Delete the word to the left of the caret.
    void DelWordLeft();

    // Delete the word to the right of the caret.
    void DelWordRight();

    // Cut the line containing the caret.
    void LineCut();

    // Delete the line containing the caret.
    void LineDelete();

    // Switch the current line with the previous.
    void LineTranspose();

    // Duplicate the current line.
    void LineDuplicate();

    // Transform the selection to lower case.
    void LowerCase();

    // Transform the selection to upper case.
    void UpperCase();

    // Scroll the document down, keeping the caret visible.
    void LineScrollDown();

    // Scroll the document up, keeping the caret visible.
    void LineScrollUp();

    // Delete the selection or if no selection, the character before the caret.
    // Will not delete the character before at the start of a line.
    void DeleteBackNotLine();

    // Move caret to first position on display line.
    void HomeDisplay();

    // Move caret to first position on display line extending selection to
    // new caret position.
    void HomeDisplayExtend();

    // Move caret to last position on display line.
    void LineEndDisplay();

    // Move caret to last position on display line extending selection to new
    // caret position.
    void LineEndDisplayExtend();

    // These are like their namesakes Home(Extend)?, LineEnd(Extend)?, VCHome(Extend)?
    // except they behave differently when word-wrap is enabled:
    // They go first to the start / end of the display line, like (Home|LineEnd)Display
    // The difference is that, the cursor is already at the point, it goes on to the start
    // or end of the document line, as appropriate for (Home|LineEnd|VCHome)(Extend)?.
    void HomeWrap();
    void HomeWrapExtend();
    void LineEndWrap();
    void LineEndWrapExtend();
    void VCHomeWrap();
    void VCHomeWrapExtend();

    // Copy the line containing the caret.
    void LineCopy();

    // Move the caret inside current view if it's not there already.
    void MoveCaretInsideView();

    // How many characters are on a line, not including end of line characters?
    int LineLength(int line);

    // Highlight the characters at two positions.
    void BraceHighlight(int pos1, int pos2);

    // Highlight the character at a position indicating there is no matching brace.
    void BraceBadLight(int pos);

    // Find the position of a matching brace or INVALID_POSITION if no match.
    int BraceMatch(int pos);

    // Are the end of line characters visible?
    bool GetViewEOL();

    // Make the end of line characters visible or invisible.
    void SetViewEOL(bool visible);

    // Retrieve a pointer to the document object.
    void* GetDocPointer();

    // Change the document object used.
    void SetDocPointer(void* docPointer);

    // Set which document modification events are sent to the container.
    void SetModEventMask(int mask);

    // Retrieve the column number which text should be kept within.
    int GetEdgeColumn();

    // Set the column number of the edge.
    // If text goes past the edge then it is highlighted.
    void SetEdgeColumn(int column);

    // Retrieve the edge highlight mode.
    int GetEdgeMode();

    // The edge may be displayed by a line (EDGE_LINE) or by highlighting text that
    // goes beyond it (EDGE_BACKGROUND) or not displayed at all (EDGE_NONE).
    void SetEdgeMode(int mode);

    // Retrieve the colour used in edge indication.
    wxColour GetEdgeColour();

    // Change the colour used in edge indication.
    void SetEdgeColour(const wxColour& edgeColour);

    // Sets the current caret position to be the search anchor.
    void SearchAnchor();

    // Find some text starting at the search anchor.
    // Does not ensure the selection is visible.
    int SearchNext(int flags, const wxString& text);

    // Find some text starting at the search anchor and moving backwards.
    // Does not ensure the selection is visible.
    int SearchPrev(int flags, const wxString& text);

    // Retrieves the number of lines completely visible.
    int LinesOnScreen();

    // Set whether a pop up menu is displayed automatically when the user presses
    // the wrong mouse button.
    void UsePopUp(bool allowPopUp);

    // Is the selection rectangular? The alternative is the more common stream selection.
    bool SelectionIsRectangle();

    // Set the zoom level. This number of points is added to the size of all fonts.
    // It may be positive to magnify or negative to reduce.
    void SetZoom(int zoom);

    // Retrieve the zoom level.
    int GetZoom();

    // Create a new document object.
    // Starts with reference count of 1 and not selected into editor.
    void* CreateDocument();

    // Extend life of document.
    void AddRefDocument(void* docPointer);

    // Release a reference to the document, deleting document if it fades to black.
    void ReleaseDocument(void* docPointer);

    // Get which document modification events are sent to the container.
    int GetModEventMask();

    // Change internal focus flag.
    void SetSTCFocus(bool focus);

    // Get internal focus flag.
    bool GetSTCFocus();

    // Change error status - 0 = OK.
    void SetStatus(int statusCode);

    // Get error status.
    int GetStatus();

    // Set whether the mouse is captured when its button is pressed.
    void SetMouseDownCaptures(bool captures);

    // Get whether mouse gets captured.
    bool GetMouseDownCaptures();

    // Sets the cursor to one of the SC_CURSOR* values.
    void SetSTCCursor(int cursorType);

    // Get cursor type.
    int GetSTCCursor();

    // Change the way control characters are displayed:
    // If symbol is < 32, keep the drawn way, else, use the given character.
    void SetControlCharSymbol(int symbol);

    // Get the way control characters are displayed.
    int GetControlCharSymbol();

    // Move to the previous change in capitalisation.
    void WordPartLeft();

    // Move to the previous change in capitalisation extending selection
    // to new caret position.
    void WordPartLeftExtend();

    // Move to the change next in capitalisation.
    void WordPartRight();

    // Move to the next change in capitalisation extending selection
    // to new caret position.
    void WordPartRightExtend();

    // Set the way the display area is determined when a particular line
    // is to be moved to by Find, FindNext, GotoLine, etc.
    void SetVisiblePolicy(int visiblePolicy, int visibleSlop);

    // Delete back from the current position to the start of the line.
    void DelLineLeft();

    // Delete forwards from the current position to the end of the line.
    void DelLineRight();

    // Get and Set the xOffset (ie, horizonal scroll position).
    void SetXOffset(int newOffset);
    int GetXOffset();

    // Set the last x chosen value to be the caret x position.
    void ChooseCaretX();

    // Set the way the caret is kept visible when going sideway.
    // The exclusion zone is given in pixels.
    void SetXCaretPolicy(int caretPolicy, int caretSlop);

    // Set the way the line the caret is on is kept visible.
    // The exclusion zone is given in lines.
    void SetYCaretPolicy(int caretPolicy, int caretSlop);

    // Set printing to line wrapped (SC_WRAP_WORD) or not line wrapped (SC_WRAP_NONE).
    void SetPrintWrapMode(int mode);

    // Is printing line wrapped?
    int GetPrintWrapMode();

    // Set a fore colour for active hotspots.
    void SetHotspotActiveForeground(bool useSetting, const wxColour& fore);

    // Set a back colour for active hotspots.
    void SetHotspotActiveBackground(bool useSetting, const wxColour& back);

    // Enable / Disable underlining active hotspots.
    void SetHotspotActiveUnderline(bool underline);

    // Limit hotspots to single line so hotspots on two lines don't merge.
    void SetHotspotSingleLine(bool singleLine);

    // Move caret between paragraphs (delimited by empty lines).
    void ParaDown();
    void ParaDownExtend();
    void ParaUp();
    void ParaUpExtend();

    // Given a valid document position, return the previous position taking code
    // page into account. Returns 0 if passed 0.
    int PositionBefore(int pos);

    // Given a valid document position, return the next position taking code
    // page into account. Maximum value returned is the last position in the document.
    int PositionAfter(int pos);

    // Copy a range of text to the clipboard. Positions are clipped into the document.
    void CopyRange(int start, int end);

    // Copy argument text to the clipboard.
    void CopyText(int length, const wxString& text);

    // Set the selection mode to stream (SC_SEL_STREAM) or rectangular (SC_SEL_RECTANGLE) or
    // by lines (SC_SEL_LINES).
    void SetSelectionMode(int mode);

    // Get the mode of the current selection.
    int GetSelectionMode();

    // Retrieve the position of the start of the selection at the given line (INVALID_POSITION if no selection on this line).
    int GetLineSelStartPosition(int line);

    // Retrieve the position of the end of the selection at the given line (INVALID_POSITION if no selection on this line).
    int GetLineSelEndPosition(int line);

    // Move caret down one line, extending rectangular selection to new caret position.
    void LineDownRectExtend();

    // Move caret up one line, extending rectangular selection to new caret position.
    void LineUpRectExtend();

    // Move caret left one character, extending rectangular selection to new caret position.
    void CharLeftRectExtend();

    // Move caret right one character, extending rectangular selection to new caret position.
    void CharRightRectExtend();

    // Move caret to first position on line, extending rectangular selection to new caret position.
    void HomeRectExtend();

    // Move caret to before first visible character on line.
    // If already there move to first character on line.
    // In either case, extend rectangular selection to new caret position.
    void VCHomeRectExtend();

    // Move caret to last position on line, extending rectangular selection to new caret position.
    void LineEndRectExtend();

    // Move caret one page up, extending rectangular selection to new caret position.
    void PageUpRectExtend();

    // Move caret one page down, extending rectangular selection to new caret position.
    void PageDownRectExtend();

    // Move caret to top of page, or one page up if already at top of page.
    void StutteredPageUp();

    // Move caret to top of page, or one page up if already at top of page, extending selection to new caret position.
    void StutteredPageUpExtend();

    // Move caret to bottom of page, or one page down if already at bottom of page.
    void StutteredPageDown();

    // Move caret to bottom of page, or one page down if already at bottom of page, extending selection to new caret position.
    void StutteredPageDownExtend();

    // Move caret left one word, position cursor at end of word.
    void WordLeftEnd();

    // Move caret left one word, position cursor at end of word, extending selection to new caret position.
    void WordLeftEndExtend();

    // Move caret right one word, position cursor at end of word.
    void WordRightEnd();

    // Move caret right one word, position cursor at end of word, extending selection to new caret position.
    void WordRightEndExtend();

    // Set the set of characters making up whitespace for when moving or selecting by word.
    // Should be called after SetWordChars.
    void SetWhitespaceChars(const wxString& characters);

    // Reset the set of characters for whitespace and word characters to the defaults.
    void SetCharsDefault();

    // Get currently selected item position in the auto-completion list
    int AutoCompGetCurrent();

    // Enlarge the document to a particular size of text bytes.
    void Allocate(int bytes);

    // Find the position of a column on a line taking into account tabs and
    // multi-byte characters. If beyond end of line, return line end position.
    int FindColumn(int line, int column);

    // Can the caret preferred x position only be changed by explicit movement commands?
    bool GetCaretSticky();

    // Stop the caret preferred x position changing when the user types.
    void SetCaretSticky(bool useCaretStickyBehaviour);

    // Switch between sticky and non-sticky: meant to be bound to a key.
    void ToggleCaretSticky();

    // Enable/Disable convert-on-paste for line endings
    void SetPasteConvertEndings(bool convert);

    // Get convert-on-paste setting
    bool GetPasteConvertEndings();

    // Duplicate the selection. If selection empty duplicate the line containing the caret.
    void SelectionDuplicate();

    // Start notifying the container of all key presses and commands.
    void StartRecord();

    // Stop notifying the container of all key presses and commands.
    void StopRecord();

    // Set the lexing language of the document.
    void SetLexer(int lexer);

    // Retrieve the lexing language of the document.
    int GetLexer();

    // Colourise a segment of the document using the current lexing language.
    void Colourise(int start, int end);

    // Set up a value that may be used by a lexer for some optional feature.
    void SetProperty(const wxString& key, const wxString& value);

    // Set up the key words used by the lexer.
    void SetKeyWords(int keywordSet, const wxString& keyWords);

    // Set the lexing language of the document based on string name.
    void SetLexerLanguage(const wxString& language);

    // Retrieve a 'property' value previously set with SetProperty.
    wxString GetProperty(const wxString& key);

    // Retrieve a 'property' value previously set with SetProperty,
    // with '$()' variable replacement on returned buffer.
    wxString GetPropertyExpanded(const wxString& key);

    // Retrieve a 'property' value previously set with SetProperty,
    // interpreted as an int AFTER any '$()' variable replacement.
    int GetPropertyInt(const wxString& key);

    // Retrieve the number of bits the current lexer needs for styling.
    int GetStyleBitsNeeded();


    // END of generated section
    //----------------------------------------------------------------------
    // Others...


    // Returns the line number of the line with the caret.
    int GetCurrentLine();

    // Extract style settings from a spec-string which is composed of one or
    // more of the following comma separated elements:
    //
    // bold turns on bold
    // italic turns on italics
    // fore:[name or #RRGGBB] sets the foreground colour
    // back:[name or #RRGGBB] sets the background colour
    // face:[facename] sets the font face name to use
    // size:[num] sets the font size in points
    // eol turns on eol filling
    // underline turns on underlining
    //
    void StyleSetSpec(int styleNum, const wxString& spec);



    // Set style size, face, bold, italic, and underline attributes from
    // a wxFont's attributes.
    void StyleSetFont(int styleNum, wxFont& font);



    // Set all font style attributes at once.
    void StyleSetFontAttr(int styleNum, int size, const wxString& faceName, bool bold, bool italic, bool underline, wxFontEncoding encoding=wxFONTENCODING_DEFAULT);


    // Set the character set of the font in a style. Converts the Scintilla
    // character set values to a wxFontEncoding.
    void StyleSetCharacterSet(int style, int characterSet);

    // Set the font encoding to be used by a style.
    void StyleSetFontEncoding(int style, wxFontEncoding encoding);


    // Perform one of the operations defined by the wxSTC_CMD_* constants.
    void CmdKeyExecute(int cmd);


    // Set the left and right margin in the edit area, measured in pixels.
    void SetMargins(int left, int right);


    // Retrieve the start and end positions of the current selection.
    //#ifdef SWIG
    // void GetSelection(int* OUTPUT, int* OUTPUT);
    //#else
    // %override [int startPos, int endPos] wxStyledTextCtrl::GetSelection()
    // C++ Func: void GetSelection(int* startPos, int* endPos);
    void GetSelection();
    //#endif

    // Retrieve the point in the window where a position is displayed.
    wxPoint PointFromPosition(int pos);


    // Scroll enough to make the given line visible
    void ScrollToLine(int line);


    // Scroll enough to make the given column visible
    void ScrollToColumn(int column);


    // Send a message to Scintilla
    long SendMsg(int msg, long wp=0, long lp=0);


    // Set the vertical scrollbar to use instead of the ont that's built-in.
    void SetVScrollBar(wxScrollBar* bar);


    // Set the horizontal scrollbar to use instead of the ont that's built-in.
    void SetHScrollBar(wxScrollBar* bar);

    // Can be used to prevent the EVT_CHAR handler from adding the char
    bool GetLastKeydownProcessed()
    void SetLastKeydownProcessed(bool val)

    // Write the contents of the editor to filename
    bool SaveFile(const wxString& filename);

    // Load the contents of filename into the editor
    bool LoadFile(const wxString& filename);

    //#ifdef STC_USE_DND
    // Allow for simulating a DnD DragOver
    // wxDragResult DoDragOver(wxCoord x, wxCoord y, wxDragResult def);

    // Allow for simulating a DnD DropText
    // bool DoDropText(long x, long y, const wxString& data);
    //#endif

    // Specify whether anti-aliased fonts should be used. Will have no effect
    // on some platforms, but on some (wxMac for example) can greatly improve
    // performance.
    void SetUseAntiAliasing(bool useAA);

    // Returns the current UseAntiAliasing setting.
    bool GetUseAntiAliasing();



    // The following methods are nearly equivallent to their similarly named
    // cousins above. The difference is that these methods bypass wxString
    // and always use a char* even if used in a unicode build of wxWidgets.
    // In that case the character data will be utf-8 encoded since that is
    // what is used internally by Scintilla in unicode builds.

    // Add text to the document at current position.
    void AddTextRaw(const char* text);

    // Insert string at a position.
    void InsertTextRaw(int pos, const char* text);

    // Retrieve the text of the line containing the caret.
    // Returns the index of the caret on the line.
    //#ifdef SWIG
    // wxCharBuffer GetCurLineRaw(int* OUTPUT);
    //#else
    // wxCharBuffer GetCurLineRaw(int* linePos=NULL);
    //#endif

    // Retrieve the contents of a line.
    // wxCharBuffer GetLineRaw(int line);

    // Retrieve the selected text.
    // wxCharBuffer GetSelectedTextRaw();

    // Retrieve a range of text.
    // wxCharBuffer GetTextRangeRaw(int startPos, int endPos);

    // Replace the contents of the document with the argument text.
    // void SetTextRaw(const char* text);

    // Retrieve all the text in the document.
    // wxCharBuffer GetTextRaw();

    // Append a string to the end of the document without changing the selection.
    // void AppendTextRaw(const char* text);

%endclass

///////////////////////////////////////////////////////////////////////////////
// wxStyledTextEvent

//----------------------------------------------------------------------

%class %delete wxStyledTextEvent, wxCommandEvent

    %define_event wxEVT_STC_CHANGE // EVT_STC_CHANGE(id, fn)
    %define_event wxEVT_STC_STYLENEEDED // EVT_STC_STYLENEEDED(id, fn)
    %define_event wxEVT_STC_CHARADDED // EVT_STC_CHARADDED(id, fn)
    %define_event wxEVT_STC_SAVEPOINTREACHED // EVT_STC_SAVEPOINTREACHED(id, fn)
    %define_event wxEVT_STC_SAVEPOINTLEFT // EVT_STC_SAVEPOINTLEFT(id, fn)
    %define_event wxEVT_STC_ROMODIFYATTEMPT // EVT_STC_ROMODIFYATTEMPT(id, fn)
    %define_event wxEVT_STC_KEY // EVT_STC_KEY(id, fn)
    %define_event wxEVT_STC_DOUBLECLICK // EVT_STC_DOUBLECLICK(id, fn)
    %define_event wxEVT_STC_UPDATEUI // EVT_STC_UPDATEUI(id, fn)
    %define_event wxEVT_STC_MODIFIED // EVT_STC_MODIFIED(id, fn)
    %define_event wxEVT_STC_MACRORECORD // EVT_STC_MACRORECORD(id, fn)
    %define_event wxEVT_STC_MARGINCLICK // EVT_STC_MARGINCLICK(id, fn)
    %define_event wxEVT_STC_NEEDSHOWN // EVT_STC_NEEDSHOWN(id, fn)
    !%wxchkver_2_6 %define_event wxEVT_STC_POSCHANGED // ??
    %define_event wxEVT_STC_PAINTED // EVT_STC_PAINTED(id, fn)
    %define_event wxEVT_STC_USERLISTSELECTION // EVT_STC_USERLISTSELECTION(id, fn)
    %define_event wxEVT_STC_URIDROPPED // EVT_STC_URIDROPPED(id, fn)
    %define_event wxEVT_STC_DWELLSTART // EVT_STC_DWELLSTART(id, fn)
    %define_event wxEVT_STC_DWELLEND // EVT_STC_DWELLEND(id, fn)
    %define_event wxEVT_STC_START_DRAG // EVT_STC_START_DRAG(id, fn)
    %define_event wxEVT_STC_DRAG_OVER // EVT_STC_DRAG_OVER(id, fn)
    %define_event wxEVT_STC_DO_DROP // EVT_STC_DO_DROP(id, fn)
    %define_event wxEVT_STC_ZOOM // EVT_STC_ZOOM(id, fn)
    %define_event wxEVT_STC_HOTSPOT_CLICK // EVT_STC_HOTSPOT_CLICK(id, fn)
    %define_event wxEVT_STC_HOTSPOT_DCLICK // EVT_STC_HOTSPOT_DCLICK(id, fn)
    %define_event wxEVT_STC_CALLTIP_CLICK // EVT_STC_CALLTIP_CLICK(id, fn)
    %define_event wxEVT_STC_AUTOCOMP_SELECTION // EVT_STC_AUTOCOMP_SELECTION(id, fn)

    wxStyledTextEvent(wxEventType commandType = 0, int id = 0)
    void SetPosition(int pos)
    void SetKey(int k)
    void SetModifiers(int m)
    void SetModificationType(int t)
    void SetText(const wxString& t)
    void SetLength(int len)
    void SetLinesAdded(int num)
    void SetLine(int val)
    void SetFoldLevelNow(int val)
    void SetFoldLevelPrev(int val)
    void SetMargin(int val)
    void SetMessage(int val)
    void SetWParam(int val)
    void SetLParam(int val)
    void SetListType(int val)
    void SetX(int val)
    void SetY(int val)
    void SetDragText(const wxString& val)
    void SetDragAllowMove(bool val)
    void SetDragResult(wxDragResult val)

    int GetPosition() const
    int GetKey() const
    int GetModifiers() const
    int GetModificationType() const
    wxString GetText() const
    int GetLength() const
    int GetLinesAdded() const
    int GetLine() const
    int GetFoldLevelNow() const
    int GetFoldLevelPrev() const
    int GetMargin() const
    int GetMessage() const
    int GetWParam() const
    int GetLParam() const
    int GetListType() const
    int GetX() const
    int GetY() const
    wxString GetDragText()
    bool GetDragAllowMove()
    wxDragResult GetDragResult()
    bool GetShift() const
    bool GetControl() const
    bool GetAlt() const

%endclass


wxlua/wxlua.i - Lua table = 'wxlua'
// ===========================================================================
// Purpose: wxLua specific wrappers
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxLua version defines

%define wxLUA_MAJOR_VERSION
%define wxLUA_MINOR_VERSION
%define wxLUA_RELEASE_NUMBER
%define wxLUA_SUBRELEASE_NUMBER
%define_string wxLUA_VERSION_STRING

%function bool wxLUA_CHECK_VERSION(int major, int minor, int release) // actually a define
%function bool wxLUA_CHECK_VERSION_FULL(int major, int minor, int release, int subrel) // actually a define

// ---------------------------------------------------------------------------
// Compile the luaScript of the given name and return the lua error code, a message
// and the line number (or -1) of the error.
// %override [int return, lua_string err_msg, int line_number] CompileLuaScript(const wxString& luaScript, const wxString& fileName)
%function int CompileLuaScript(const wxString& luaScript, const wxString& fileName)

// ---------------------------------------------------------------------------
// Get information about the status of wxLua.

// Get a table or string of all tracked top level windows that wxLua will
// Destroy() when lua is closed.
// Example output : { "ClassName(&win id=wxWindowID)", ...}
%function LuaTable GetTrackedWindowInfo(bool as_string = false)

// Get a table or string of all tracked userdata wxLua will delete when lua
// is closed or lua will eventually garbage collect.
// Example output : { "ClassName(&obj)", ... }
%function LuaTable GetGCUserdataInfo(bool as_string = false)

// Get a table or string of all tracked userdata wxLua has pushed.
// A single object may have multiple types if it has been casted.
// Example output : { "&obj wxLuaTypeName(type#), ...", ... }
%function LuaTable GetTrackedObjectInfo(bool as_string = false)

// Get a table or string of all tracked wxEvent callbacks that have been
// installed using wxEvtHandler::Connect(...)
// "wxEVT_XXX(evt#) -> wxLuaEventCallback(&callback, ids %d %d)|wxEvtHandler(&evthandler) -> wxEvtHandlerClassName"
%function LuaTable GetTrackedEventCallbackInfo(bool as_string = false)

// Get a table or string of all wxWindow derived classes that have been created in wxLua.
// "wxWindowClassName(&win, id=%d)|wxLuaDestroyCallback(&callback)"
%function LuaTable GetTrackedWinDestroyCallbackInfo(bool as_string = false)

// Is the wxLua userdata object on the list to be garbage collected by Lua?
%function bool isgcobject(void* object)

// Is the wxLua userdata object on the list of tracked objects?
%function bool istrackedobject(void* object)

// Is the wxLua object refed by wxLua
%function bool isrefed(void* object)

// ---------------------------------------------------------------------------
// Force the Lua garbage collector to act or ignore object *DANGEROUS*
//
// These are *only* meant for very special cases and should NOT be used unless
// you have an initmate knowledge about the object and how it will be treated
// by wxWidgets, wxLua, and Lua.

// Add the userdata object to the list of objects that will be deleted when
// it goes out of scope and the Lua garbage collector runs.
// %function bool gcobject(void* object)

// Remove the userdata object from the list of objects that will be deleted when
// it goes out of scope and the Lua garbage collector runs.
%function bool ungcobject(void* object)

// ---------------------------------------------------------------------------
// Type information about the bindings or current userdata

%enum wxLuaMethod_Type // The type of a Lua method

    WXLUAMETHOD_CONSTRUCTOR // constructor
    WXLUAMETHOD_METHOD // class member function
    WXLUAMETHOD_CFUNCTION // global C function (not part of a class)
    WXLUAMETHOD_GETPROP // Get %property funcName, read
    WXLUAMETHOD_SETPROP // Set %property funcName, write

    WXLUAMETHOD_STATIC // Class member function is static

    WXLUAMETHOD_DELETE // This is the delete function that wxLua has generated
    // to delete this class and is not part of the
    // original class.

    WXLUAMETHOD_CHECKED_OVERLOAD // Class method has been checked to see if it is
    // overloaded from the base class.
    // Check WXLUAMETHOD::basemethod and if !NULL
    // this method is an overload from the base class

%endenum

%define WXLUA_TNONE
%define WXLUA_TNIL
%define WXLUA_TBOOLEAN
%define WXLUA_TLIGHTUSERDATA
%define WXLUA_TNUMBER
%define WXLUA_TSTRING
%define WXLUA_TTABLE
%define WXLUA_TFUNCTION
%define WXLUA_TUSERDATA
%define WXLUA_TTHREAD
%define WXLUA_TINTEGER
%define WXLUA_TCFUNCTION

%define WXLUA_T_MAX

%define LUA_TNONE // (-1)
%define LUA_TNIL // 0
%define LUA_TBOOLEAN // 1
%define LUA_TLIGHTUSERDATA // 2
%define LUA_TNUMBER // 3
%define LUA_TSTRING // 4
%define LUA_TTABLE // 5
%define LUA_TFUNCTION // 6
%define LUA_TUSERDATA // 7
%define LUA_TTHREAD // 8

// Is this lua_type() (or in lua the type() function) considered equivalent
%rename iswxluatype %function int wxlua_iswxluatype(int luatype, int wxluaarg_tag)

// %override [string wxlua_typename, int wxlua_typenum, string lua_typename, int lua_typenum] type(any object)
// Given any type of object, returns four values:
// wxlua name of the type - wxluaT_gettypename(L, stack_idx)
// wxlua number of the type - wxluaT_type(L, stack_idx)
// lua name of the type - lua_typename(L, lua_type(L, stack_idx))
// lua number of the type - lua_type(L, stack_idx)
%function wxString type(void* object)

// %override wxString typename(int wxluaarg_tag)
// Returns the wxLua name binding wxLua class type numbers.
%function wxString typename(int wxluaarg_tag)

// ---------------------------------------------------------------------------
// wxLuaBinding - These are not wrapped in the standard way, but coded by hand
// for size.

// These items follow the structure below and ALL items are called as if they
// were table members.
// Example : print(wxlua.GetBindings()[1].GetClassCount)
// Example : print(wxlua.GetBindings()[1].GetClassArray[1].methods[1].name)
// Note: Use only '.' and NO () to make it a function call, also check to see
// if the item exists first (unlike the example above)!
// Also, you probably want to store the returned tables and get the values from
// them instead of getting the whole table every time from wxlua.GetBindings()...
// Please see the bindings.wx.lua sample program for usage.

// Entry point to get the objects below.
// returns a table array of each installed binding { wxLuaBinding* }
%function LuaTable GetBindings()

/*

%class wxLuaBinding

    // No constructor as this is read only

    wxString GetBindingName
    wxString GetLuaNamespace

    int GetClassCount
    int GetNumberCount
    int GetStringCount
    int GetEventCount
    int GetObjectCount
    int GetFunctionCount

    {wxLuaBindClass*} GetClassArray
    {wxLuaBindMethod*} GetFunctionArray
    {name, value} GetNumberArray
    {name, value} GetStringArray
    {name, eventType, wxluatype, wxLuaBindClass} GetEventArray
    {name, object, wxluatype, wxLuaBindClass} GetObjectArray

%endclass

%struct wxLuaBindClass

    // No constructor as this is read only

    wxString name
    {wxLuaBindMethod*} wxluamethods
    int wxluamethods_n
    wxClassInfo* classInfo
    int wxluatype
    {wxString} baseclassNames
    {wxLuaBindClass*} baseBindClasses
    {name, value} enums
    int enums_n

%endstruct

%struct wxLuaBindMethod

    // No constructor as this is read only

    wxString name
    int method_type
    {wxLuaBindCFunc*} wxluacfuncs
    int wxluacfuncs_n
    wxLuaBindMethod* basemethod

    wxLuaBindClass* class // class this is part of (not in struct)
    wxString class_name // class name this is part of (not in struct)

%endstruct

%struct wxLuaBindCFunc

    // No constructor as this is read only

    cfunction lua_cfunc
    int method_type
    int minargs
    int maxargs
    {int} argtypes

    wxString class_name // added, not in struct

%endstruct

*/


// ---------------------------------------------------------------------------
// wxLuaState

%include "wxlua/include/wxlstate.h"

%class %delete wxLuaState, wxObject

    /*
    wxLuaState(bool create = false)
    wxLuaState(wxEvtHandler *handler, wxWindowID id = wxID_ANY)

    bool Ok() const
    void Destroy()
    bool CloseLuaState(bool force)
    bool IsClosing() const
    wxEventType GetInEventType() const
    void SetEventHandler(wxEvtHandler *evtHandler)
    wxEvtHandler *GetEventHandler() const
    void SetId(wxWindowID id)
    wxWindowID GetId() const
    void SendEvent( wxLuaEvent &event ) const

    int RunFile(const wxString &fileName)
    int RunString(const wxString &script, const wxString& name = "")
    bool IsRunning() const
    */

%endclass

// ---------------------------------------------------------------------------
// wxLuaObject - Allows Lua data items to be used for wxClientData.

%enum wxLuaObject_Type

    wxLUAOBJECT_NONE
    wxLUAOBJECT_BOOL
    wxLUAOBJECT_INT
    wxLUAOBJECT_STRING
    wxLUAOBJECT_ARRAYINT

%endenum

%class %delete wxLuaObject, wxObject // ALSO! wxClientData use it anywhere that takes that

    // %override wxLuaObject(any value type)
    // C++ Func: wxLuaObject(const wxLuaState& wxlState, int stack_idx = 1)
    // Wrap the single value passed in with a wxLuaObject
    wxLuaObject()

    // %override void wxLuaObject::SetObject(any value type)
    // C++ Func: void SetObject(int stack_idx = 1)
    // Discard the old reference and create a new one for the item passed in
    void SetObject()

    // %override [any value type] wxLuaObject::GetObject()
    // C++ Func: bool GetObject()
    // get the object, note C++ returns bool, in lua it "returns" the referenced object
    void GetObject() const

    // These are not useful in lua
    //bool *GetBoolPtr();
    //int *GetIntPtr();
    //wxString *GetStringPtr();
    //wxArrayInt *GetArrayPtr();

    int GetAllocationFlag() const

%endclass

wxluasocket/wxluasocket.i - Lua table = 'wxlua'
// ===========================================================================
// Purpose: wxLuaSocket specific wrappers
// Author: J Winwood, John Labenski
// Created: 14/11/2001
// Copyright: (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence: wxWidgets licence
// wxWidgets: Updated to 2.8.4
// ===========================================================================

%include "wx/defs.h"
%include "wx/object.h"

%include "wxlua/include/wxlstate.h"
%include "wxlua/include/wxlbind.h"


// Show a dialog of the current stack and all of the global data in a wxListCtrl
// This also shows information about the number and kind of userdata items that
// wxLua is tracking and will delete.
// %override void StackDialog()
%function void LuaStackDialog()

// ---------------------------------------------------------------------------
// wxLuaDebugServer

%include "wxluasocket/include/wxldserv.h"

%class %delete wxLuaDebuggerServer, wxEvtHandler

    wxLuaDebuggerServer(int portNumber)

    bool StartServer()
    bool StopServer()
    long StartClient()

    bool AddBreakPoint(const wxString &fileName, int lineNumber)
    bool RemoveBreakPoint(const wxString &fileName, int lineNumber)
    bool ClearAllBreakPoints()
    bool Run(const wxString &fileName, const wxString &buffer)
    bool Step()
    bool StepOver()
    bool StepOut()
    bool Continue()
    bool Break()
    bool Reset()
    bool EvaluateExpr(int exprRef, const wxString &expr)

    void DisplayStackDialog(wxWindow *pParent, wxWindowID id = wxID_ANY)

    long GetDebuggeeProcessId() const
    bool KillDebuggee()

    static wxString GetProgramName()
    static wxString GetNetworkName()

%endclass

// ---------------------------------------------------------------------------
// wxLuaDebugData

//%class %noclassinfo wxLuaDebugData
//%endclass

// ---------------------------------------------------------------------------
// wxLuaDebuggerEvent

%class %delete wxLuaDebuggerEvent, wxEvent

    %define_event wxEVT_WXLUA_DEBUGGER_DEBUGGEE_CONNECTED // EVT_WXLUA_DEBUGGER_DEBUGGEE_CONNECTED(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_DEBUGGEE_DISCONNECTED // EVT_WXLUA_DEBUGGER_DEBUGGEE_DISCONNECTED(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_BREAK // EVT_WXLUA_DEBUGGER_BREAK(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_PRINT // EVT_WXLUA_DEBUGGER_PRINT(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_ERROR // EVT_WXLUA_DEBUGGER_ERROR(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_EXIT // EVT_WXLUA_DEBUGGER_EXIT(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_STACK_ENUM // EVT_WXLUA_DEBUGGER_STACK_ENUM(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_STACK_ENTRY_ENUM // EVT_WXLUA_DEBUGGER_STACK_ENTRY_ENUM(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_TABLE_ENUM // EVT_WXLUA_DEBUGGER_TABLE_ENUM(id, fn)
    %define_event wxEVT_WXLUA_DEBUGGER_EVALUATE_EXPR // EVT_WXLUA_DEBUGGER_EVALUATE_EXPR(id, fn)

    int GetLineNumber() const
    int GetReference() const
    wxString GetFileName() const
    wxString GetMessage() const
    //const wxLuaDebugData GetDebugData() const

%endclass
