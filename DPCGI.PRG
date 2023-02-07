//
// DPCGI.PRG
// Exclusivo Ejecución CGI
//
#INCLUDE "\DPWIN32\INCLUDE\DPXBASE.CH"
//#INCLUDE "ADS.CH"

REQUEST __RUN
//REQUEST GETHOSTBYNAME,GETHOSTNAME,SHELLEXECUTE
REQUEST lMkDir,nRANDOM,MOD,GETWHERE,ADIR
REQUEST __COPYFILE

MEMVAR oDp

PROCEDURE MAIN(cPar1)

  Public oDp

  oDp             :=TPublic():New( .T. )
  oDp:lCgi        :=.f.
  oDp:cFileOdbc   :="DP\ODBC.INI"
  oDp:cPathExe    :=GETINI("DATAPRO.INI","EXEPATH" ) // Ruta del Ejecutable
  oDp:cPathScr    :=GETINI("DATAPRO.INI","SCRPATH" ) // Ruta del Ejecutable
  oDp:cPathBmp    :=GETINI("DATAPRO.INI","BMPPATH" ) // Ruta de BitMaps
  oDp:cPathDxb    :=GETINI("DATAPRO.INI","DXBPATH" ) // Ruta de DpXbase

  oDp:cPathExe    :=IIF( EMPTY(oDp:cPathExe),CURDRIVE()+":\"+CURDIR()+"\", oDp:cPathExe )
  oDP:cPathScr    :=IIF( EMPTY(oDp:cPathScr),CURDRIVE()+":\"+CURDIR()+"\SCRIPT\" , oDp:cPathScr )
  oDP:cPathBmp    :=IIF( EMPTY(oDp:cPathBmp),CURDRIVE()+":\"+CURDIR()+"\BITMAPS\", oDp:cPathBmp )
  oDP:cPathDxb    :=IIF( EMPTY(oDp:cPathDxb),CURDRIVE()+":\"+CURDIR()+"\DPXBASE\", oDp:cPathDxb )

  oDp:cScrFunction:=NIL // Programa de Funciones

  SET MULTIPLE ON
  SET DATE FREN

  oDp:lCgi:=.t. // Indica que trabaja como CGI, los errores deben ser escritos en el explorador
  CGIINI(cPar1)

RETURN

PROCEDURE DBFNTX
PROCEDURE GETCONTROL
PROCEDURE __PP_INIT
PROCEDURE __PPADDRULE
PROCEDURE __PREPROCESS
PROCEDURE __PP_FREE
PROCEDURE TWINDOW
PROCEDURE BROWSE
PROCEDURE TCONTROL
PROCEDURE TWBrowse
PROCEDURE TCBROWSE
PROCEDURE TDIALOG
PROCEDURE TMDICHILD
PROCEDURE TMDIFRAME
PROCEDURE TMDICLIENT
PROCEDURE TMENU
PROCEDURE TInternet
PROCEDURE TPrinter
PROCEDURE RPreview
PROCEDURE TMETER
PROCEDURE TBITMAP
PROCEDURE TGET
PROCEDURE TMULTIGET
PROCEDURE TCOMBOBOX
PROCEDURE TRADIO
PROCEDURE TSAY
PROCEDURE TPAGE
PROCEDURE TSCROLLBAR
PROCEDURE TBAR
PROCEDURE TTABS
PROCEDURE TVBX
PROCEDURE TMSGBAR
PROCEDURE TCHECKBOX
PROCEDURE XPADR
PROCEDURE XPADC
PROCEDURE XPADL
PROCEDURE MSGRUN
PROCEDURE MSGWAIT
PROCEDURE MSGINFO
PROCEDURE WAITSECONDS
PROCEDURE STOPUNTIL
PROCEDURE MSGLIST
PROCEDURE TCCOLUMN
// PROCEDURE TCLIPBOARD
PROCEDURE TCOMPONENT
PROCEDURE TDATABASE
PROCEDURE TDBM
PROCEDURE TDDE
PROCEDURE TLISTBOX
// PROCEDURE TINDEX
PROCEDURE TIMAGE
PROCEDURE TMENUITEM
PROCEDURE TMETAFILE
PROCEDURE TOUTLOOK
PROCEDURE TWEBSERVER
PROCEDURE DPLBX
PROCEDURE MSGMETER
PROCEDURE MSGDATE
PROCEDURE MAKEWIND
PROCEDURE TESTTHIS
PROCEDURE IsGTF
PROCEDURE IsRTF
PROCEDURE GTFToRTF
PROCEDURE RTFToGTF
PROCEDURE GetRValue
PROCEDURE GetGValue
PROCEDURE nHiByte
PROCEDURE GetBValue
PROCEDURE nLoByte
PROCEDURE TDBODBC

/*
proce InitClsRules
proce InitClsResults
proce InitFWRules()
proce InitFWResults()
proce InitMiniGUIRules()
proce InitMiniGUIResults()

proce PROCFILE()
*/
proce BIN2W
proce BIN2I
proce BIN2L
proce I2BIN
proce L2BIN
/*
//proce OUTSTD
proce OUTERR
//proce QQOUT
//proce QOUT
proce DISPOUT
proce DISPOUTAT
proce __EJECT
proce SETPRC
proce DISPBOX
proce DISPBEGIN
proce DISPEND
proce DISPCOUNT
proce ISCOLOR
proce NOSNOW
proce DBGSHADOW
proce SAVESCREEN
proce RESTSCREEN
proce SETCURSOR
proce SETBLINK
proce SETMODE
proce __ACCEPT
proce __ACCEPTSTR

proce __COPYFILE
proce DESCEND
proce DIRECTORY
proce VERSION
proce GETENV //,__RUN
proce ERRORNEW
function DOSERROR
return 0
// proce FERASE
proce FRENAME
// proce FILE,FREADSTR,CURDIR
proce DISKSPACE
proce __KEYBOARD
proce NEXTKEY
proce LASTKEY
proce FKLABEL
proce FKMAX
proce ISPRINTER

// proce MEMOTRAN

proce NETNAME
proce __BOX
proce __BOXD
proce __BOXS
proce AMPM
proce DAYS
proce ELAPTIME
proce LENNUM
// proce SECS
proce TSTRING

proce SETCANCEL
// proce __SETCENTURY
proce DEFPATH
proce __DEFPATH
proce SETCOLOR
proce COLORSELECT
proce SOUNDEX

//   EXTERNAL ISALPHA,ISDIGIT,ISUPPER,ISLOWER,ALLTRIM,PADR,PAD,PADL,PADC, ;
//            STUFF,STRZERO

proce TONE

//   EXTERNAL TRANSFORM

proce DEVOUTPICT
*/
proce __DIR
proce  DBCLEARREL
proce MEMOEDIT
proce __XHELP
proce ACHOICE
proce __NONOALERT
proce TBROWSEDB
proce DBEDIT
proce MEMOLINE
proce MLCOUNT
proce MLPOS


/* ,MLCTOPOS,MPOSTOLC,__DBAPP,__DBCOPY, ;
            __DBDELIM,__DBJOIN,__DBLIST,__DBSDF,__DBSORT,__DBTOTAL,__DBUPDATE,__DBARRANGE,__DBFLIST, ;
            __DBOPENSDF,__DBTRANS,__DBTRANSREC
*/
// proce __dbsort
// proce __dbtotal
proce __dbelist
proce FIELDBLOCK
proce FIELDWBLOCK
proce __INPUT
proce MEMVARBLOCK
proce __ATPROMPT
proce __MENUTO
proce READKEY
proce SETKEY
proce SETTYPEAHEAD
proce TBCOLUMNNEW
proce TBROWSENEW
proce __TEXTSAVE
proce __TEXTRESTORE
proce __GET
proce __GETA
proce __LABELFORM
proce __REPORTFORM
proce __TYPEFILE
proce __WAIT
proce __XSAVESCREEN
proce __XRESTSCREEN


























































PROCEDURE TIndex
PROCEDURE TClipBoard



PROCEDURE dbSelectArea
PROCEDURE dbUseArea
PROCEDURE dbCloseArea
PROCEDURE dbSetIndex
PROCEDURE dbAppend
PROCEDURE __dbPack
PROCEDURE __dbZap
PROCEDURE dbunlock
PROCEDURE dbunlockall
PROCEDURE dbcommitAll
PROCEDURE dbGoto
PROCEDURE dbGotop
PROCEDURE dbGoBottom
PROCEDURE dbSkip
PROCEDURE dbSeek
PROCEDURE __dbContinue
PROCEDURE __dbLocate
PROCEDURE dbClearFilter
PROCEDURE dbSetFilter
PROCEDURE dbDelete
PROCEDURE dbRecall
PROCEDURE __dbCreate
PROCEDURE __dbCopyXStruct
PROCEDURE __dbCopyStruct
PROCEDURE __dbDelim
PROCEDURE __dbSDF
PROCEDURE __dbCopy
PROCEDURE __dbApp
PROCEDURE __dbSort
PROCEDURE __dbTotal
PROCEDURE __dbUpdate
PROCEDURE __dbJoin
PROCEDURE DbEval
PROCEDURE __dblist
PROCEDURE dbCloseAll
PROCEDURE dbClearIndex
PROCEDURE ordCondset
PROCEDURE ordcreate
PROCEDURE dbCreateIndex
PROCEDURE ordDestroy
PROCEDURE ordlistrebuild
PROCEDURE ordlistclear
PROCEDURE ordlistadd
PROCEDURE ordsetfocus
PROCEDURE fieldput
PROCEDURE fieldget
// PROCEDURE __SetCentury
PROCEDURE Alert
PROCEDURE Lfn2Sfn
PROCEDURE Sfn2Lfn
PROCEDURE tbrowse


proce rddFieldPut
proce rddSelectWorkAreaSymbol
proce rddSelectWorkAreaAlias
proce rddGetFieldValue
proce rddFieldGet
proce rddGetCurrentWorkAreaNumber
proce rddSelectWorkAreaNumber
proce rddPutFieldValue
proce NETERR
proce ORDNAME
proce DBRSELECT
proce DBRELATION
proce RDDSETDEFAULT
proce DBCREATE
proce ALIAS
proce FIELDPOS
proce DBCOMMIT
proce RDDLIST
proce RDDNAME
// proce _SELECT
proce rddShutDown
// proce rddFieldPut
//proce rddSelectWorkAreaSymbol
//proce rddSelectWorkAreaAlias
//proce rddGetFieldValue
//proce rddGetCurrentWorkAreaNumber
//proce rddSelectWorkAreaNumber
proce _rddPutFieldValue

PROCE _SELECT
PROCE _RECNO
//PROCE EOF
//PROCE BOF
#pragma BEGINDUMP
void hb_rddFieldPut()
{
int x;
}
/*
void hb_rddPutFieldValue()

{
  int  nPar1;
}
void hb_rddFieldPut()
{
 int x;
}
void hb_rddSelectWorkAreaSymbol()
{
int x;
}
void hb_rddSelectWorkAreaAlias()
{
int x;
}
void hb_rddFieldGet()
{
int x;
}
void rddGetCurrentWorkAreaNumber()
{
int x;
}
void hb_rddSelectWorkAreaNumber()
{
int x;
}
void hb_rddPutFieldValue()
{
int x
}
*/
void hb_rddShutDown()
{
 int x;
}
void hb_rddFieldGet()
{
 int x;
}
void hb_rddPutFieldValue()
{
int x;
}
void hb_rddGetFieldValue()
{
int x;
}
void hb_rddSelectWorkAreaNumber()
{
int x;
}
void hb_rddGetCurrentWorkAreaNumber()
{
int x;
}
void hb_rddSelectWorkAreaAlias()
{
int x;
}
void hb_rddSelectWorkAreaSymbol()
{
int x;
}
#pragma ENDDUMP

PROCE DLGBOX
PROCE QSORT
PROCE TBROWSEBD
PROCE TBRUSH
PROCE TCOMPONET
PROCE THROW
PROCE TICON
PROCE TRACKPOPUP
PROCE WINDOWFROMPOINT
PROCE WINDOWSFIX
PROCE WINEXEC
PROCE WINHELP
PROCE WININSPECT
PROCE WNDADJBOTTOM
PROCE WNDADJCLIENT
PROCE WNDADJLEFT
PROCE WNDADJRIGHT
//PROCE WNDADJBOTTOM
//PROCE WNDADJCLIENT
//PROCE WNDADJLEFT
//PROCE WNDADJRIGHT
PROCE MOVETO()

PROCE LogFile
PROCE MaskRegion
PROCE MsgStr
PROCE MsgToNum
PROCE OpenWinPrinter
PROCE PalBmpFree
PROCE PalBmpNew
PROCE PalBmpRealize
PROCE WindowBox
PROCE WindowBoxBlack
PROCE WindowBoxIn
PROCE WindowBoxInBlack
PROCE WindowInset
PROCE WindowRaised
PROCE WintoDosError
PROCE WndDrawBox
PROCE WriteStringtoPrint
PROCE ATOM
PROCE BARTOOLS
PROCE BMPDRAW
PROCE BMPREAD
PROCE BRUSHES
PROCE CALLDLL
PROCE CALDLL32
PROCE CHANGEPR
PROCE CLRCHOOS


PROCE CLT2SCR
PROCE COLOR
PROCE COLORTON
PROCE CREATEPA
PROCE CREATESO
PROCE CREATWND
PROCE CTLHDLEH
PROCE CURSORS
PROCE DC
PROCE DDEXC
PROCE DELOBJEC
PROCE DEVICE
PROCE DESKTOP
PROCE DIB
PROCE DIBBMP
PROCE DLL
PROCE DRAWING
PROCE DROPFILE
PROCE FONTS











PROCE FTEXT
PROCE FWARRAY
PROCE FWBMP
PROCE FWPALCTL
PROCE FFWNDRUN
PROCE GETDLGIT
PROCE GETPROCA
PROCE GETSTKOB
PROCE GETTEXT
PROCE GETTEXTW
PROCE HANDLIST
PROCE HARBOURC
PROCE HELP
PROCE HILOWORD
PROCE ICONS
PROCE INSTANCE
PROCE KEYBRD
PROCE LOADBMP
PROCE MAKELONG
// PROCE MEM ACBP=A9
PROCE MENUS
PROCE SYSREFRESH()
PROCE TEXT
PROCE TIMERS
PROCE PRINTER()
PROCE CONSOLE()
PROCE MEMOFILE()
PROCE PHILES()
//PROCE SETCOLOR()
//PROCE TPRINT()
// PROCE TPRINTER()
//PROCE TRACE()
PROCE DEBUG()
PROCE PRINTERSETUP

PROCE TDDEMLServer
PROCE cFileNoExt
PROCE GetModuleFileName
PROCE GetInstance()
/*PROCE DdeCreateStringHandle()
PROCE DdeNameService()
PROCE DdeCmpStringHandles()
PROCE TDDEMLClient() */

PROCE LoadString()
PROCE GetResources()
PROCE MessageBeep()
//PROCE GetStockObject()
//PROCE GetFontInfo()

