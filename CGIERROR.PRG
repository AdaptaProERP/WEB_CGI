// Error handler system adapted to FiveWin
// ErrSysW.prg

#include "error.ch"
#include "FiveWin.ch"

MEMVAR oDp

external _fwGenError   // Link FiveWin generic Error Objects Generator

#define NTRIM(n)    ( LTrim( Str( n ) ) )

#ifdef __CLIPPER__
   #define DLG_TITLE "FiveWin: The CA-Clipper for Windows Library"
#else
   #ifdef __HARBOUR__
      #define DLG_TITLE "FiveWin for Harbour"
   #else
      #define DLG_TITLE "FiveWin for Xbase++"
   #endif
#endif

/*************
*	ErrorSys()
*
*	Note:  automatically executes at startup
*/
proc ErrorSys()
    ErrorBlock( { | e| ErrorDialog( e ) } )
return

proc ErrorLink()
return


/*************
*   ErrorDialog()
*/
function ErrorDialog( e ) // -> logical or quits App.

   local oDlg, oLbx, oFont
   local lRet    // if lRet == nil -> default action: QUIT
   local n, j, cMessage, aStack := {}
   local oSay, hLogo
   local nButtons  := 1
   local cErrorLog := ""
   local aVersions := GetVersion()
   local aTasks
   local aRDDs, nTarget, uValue
   local oOldError
   local cRelation
   local lIsWinNT := IsWinNT()
   local cMsg:="" // Mensaje que se mostrara al usuario, JN

   // by default, division by zero yields zero
   if ( e:genCode == EG_ZERODIV )
      return 0
   end

   // for network open error, set NETERR() and subsystem default
   if ( e:genCode == EG_OPEN .and. ;
      ( e:osCode == 32 .or. e:osCode == 5 ) .and. ;
        e:canDefault )
      NetErr( .t. )
      return .f.       // Warning: Exiting!
   end

   // for lock error during APPEND BLANK, set NETERR() and subsystem default
   if ( e:genCode == EG_APPENDLOCK .and. e:canDefault )
      NetErr( .t. )
      return .f.       // OJO SALIDA
   endif

//   if ProcName( 7 ) == "ERRORDIALO"   // recursive error !!!
//      SET RESOURCES TO
//      ErrorLevel( 1 )
//      QUIT
//   endif

   IF TYPE("oDp")="O" .AND. oDp:lCgi
      HrbLoad("DPCGI.HRB")
      RETURN ErrorCgi(e,oDp:oCgi)
   ENDIF
return lRet

//----------------------------------------------------------------------------//

static function DoBreak()

   BREAK

return nil

//----------------------------------------------------------------------------//

static func ErrorMessage( e )

	// start error message
    local cMessage := if( empty( e:OsCode ), ;
                          if( e:severity > ES_WARNING, "Error ", "Warning " ),;
                          "(DOS Error " + NTRIM(e:osCode) + ") " )

	// add subsystem name if available
    cMessage += if( ValType( e:SubSystem ) == "C",;
                    e:SubSystem()                ,;
                    "???" )

	// add subsystem's error code if available
    cMessage += if( ValType( e:SubCode ) == "N",;
                    "/" + NTRIM( e:SubCode )   ,;
                    "/???" )
	// add error description if available
  if ( ValType( e:Description ) == "C" )
        cMessage += "  " + e:Description
	end

	// add either filename or operation
    cMessage += if( ! Empty( e:FileName ),;
                    ": " + e:FileName   ,;
                    if( !Empty( e:Operation ),;
                        ": " + e:Operation   ,;
                        "" ) )
return cMessage

//----------------------------------------------------------------------------//
// returns extended info for a certain variable type

static function cGetInfo( uVal )

   local cType := ValType( uVal )

   do case
      case cType == "C"
           return '"' + cValToChar( uVal ) + '"'

      case cType == "O"
           return "Class: " + uVal:ClassName()

      case cType == "A"
           return "Len: " + Str( Len( uVal ), 4 )

      otherwise
           return cValToChar( uVal )
   endcase

return nil

//----------------------------------------------------------------------------//


//----------------------------------------------------------------------------//
/*
// Control de Errores para el CGI
*/
FUNCTION ErrorCgi(e,oCgi,cDescri)

   Local nTipo:=1,cPrompt:="Regresar",cScript:="CGIPRESENTA",cErrorLog:="",n,j

   IF Empty(cDescri)

     if ( e:genCode == EG_ZERODIV )
        return 0
     end

     cDescri:=ErrorMessage(e)

     n := 2    // we don't disscard any info again !
     while ( n < 74 )

       if ! Empty( ProcName( n ) )
          cErrorLog += "   " + Trim( ProcName( n ) ) + CRLF
          for j = 1 to ParamCount( n )
             cErrorLog += "     Param " + Str( j, 3 ) + ":    " + ;
                          ValType( GetParam( n, j ) ) + ;
                          "    " + cGetInfo( GetParam( n, j ) ) + CRLF
          next
            for j = 1 to LocalCount( n )
               cErrorLog += "     Local " + Str( j, 3 ) + ":    " + ;
                           ValType( GetLocal( n, j ) ) + ;
                           "    " + cGetInfo( GetLocal( n, j ) ) + CRLF
            next
         endif

         n++
      end

   ENDIF

   IF ValType(oCgi)="O"
     oCgi:SayHtml([<TABLE ALIGN="CENTER" WIDTH=60% HEIGHT=20% /*CELLPADDING=0 CELLSPACING=0*/ ></CENTER>])
     oCgi:SayHtml([<TR><B><TD BGCOLOR="#000060"><FONT FACE="ARIAL" SIZE="2" COLOR="#FFFFFF">])
     oCgi:SayHtml(cDescri)
     oCgi:SayHtml([</TD></B></TR>])
     oCgi:SayHtml([<TR><TD  BGCOLOR="#CCCCCC">])
     oCgi:SayHtml([<FONT FACE="ARIAL" SIZE="2">])
     oCgi:SayHtml(cErrorLog)
     oCgi:SayHtml([<BR></TD>])
     oCgi:SayHtml([<TR><TD  BGCOLOR="#CCCCCC"></TD></TR>])
     oCgi:SayHtml([</TABLE></TR>])
     oCgi:SayHtml([<center>])
     oCgi:SayHtml("<INPUT TYPE='"+IIF(nTipo=1,"SUBMIT' ","RESET' ")+"VALUE='"+cPrompt+"'>")
     oCgi:SayHtml([<B><FORM  NAME="Simple" ACTION="/cgi-win/DPWIN32.EXE" METHOD=GET>])
     oCgi:SayHtml([<INPUT NAME="func" TYPE=Hidden VALUE="]+cScript+["><TD>])


//     oCgi:SayHtml([<B><FORM  NAME="Simple" ACTION="/cgi-win/dpwin32.exe" METHOD=GET>])
//     oCgi:SayHtml([<INPUT NAME="CGIPRESENTA" TYPE=Hidden VALUE= cFunc >])
      // ? "Poner Boton"
      // oCgi:BUTTON(1,"Atrás","CGIPRESENTA")
      oCgi:SayHtml([</CENTER>])
      oCgi:SayHtml([</FORM>])
      oCgi:End()
   ELSE
     ? cDescri
   ENDIF


RETURN NIL























































































