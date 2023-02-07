   /*
// Ejecutor del Aplicaciones de Tipo CGI
// Juan Navas 15/05/2003
*/
#include "FiveWin.ch"
#include "Error.ch"
#include "FWerror.ch"

MEMVAR oDp,oCgi

FUNCTION CGIINI(cIniFile)
   local cVarValue,X,I

   PRIVATE oCgi

   oDp:lTracerSql:=.F.  // Monitore los Comandos Actualizar de SQL

   ErrorBlock( { | e | ErrorCgi( e , oCgi ) } ) // Esta en ERRSYSW

//   VP("SCRIPTPATH"   ,GETINI(CURDRIVE()+":\"+CURDIR()+"\DP\DATAPRO.INI","SCRIPTPATH"   )) // ubicación de los scripts
//   VP("SCRIPTINCLUDE",GETINI(CURDRIVE()+":\"+CURDIR()+"\DP\DATAPRO.INI","SCRIPTINCLUDE")) // Carpeta de Archivos include
//   VP("SCRIPTPATH"   ,GETINI(oDp:cPathExe+"DATAPRO.INI","SCRIPTPATH"   )) // ubicación de los scripts

   VP("SCRIPTINCLUDE",GETINI(oDp:cPathExe+"DATAPRO.INI","SCRIPTINCLUDE")) // Carpeta de Archivos include

   oDp:cDsnData  :=GETINI(oDp:cPathExe+"DATAPRO.INI","DSNNAME" )    // DSN de la Empresa Principal
   oDp:cDsnConfig:=GETINI(oDp:cPathExe+"DATAPRO.INI","CDSNNAME")    // DSN de Configuración
   oDp:cFileOdbc :=oDp:cPathExe+"DP\ODBC.INI"

   // ? oDp:cDsnData,oDp:cDsnConfig,oDp:cFileOdbc
   //
   // LOADTABLAS()

   oCgi:=TWCgi():New(cIniFile)

   oDp:oCgi:=oCgi // Necesaria para el Control de Errores

   IF empty(oCgi:aVars)
      oCgi:SayHtml("Error CGI, Faltan Variables ")
      oCgi:End()
      return nil
   ELSE
//      FOR I := 1 TO LEN(oCgi:aVars)
//         ? I,oCgi:aVars[I,1],oCgi:aVars[I,2]
//      NEXT
   ENDIF

   cVarValue := oCgi:aVars[ASCAN(oCgi:aVars,{|x| x[1]== "func"}),2]

   oCgi:SayHtml("<html>")

   // Iniciacion y Preparacion del Objeto
   Ejecutar("CGIINI" , oCgi) // Extiende la Clase CGI
   // Ejecución Exclusisa en Cada Formulario
   // MSGALERT(cVarValue)
   Ejecutar(cVarValue , oCgi) // Script de Ejecución
   // Finalización General
   Ejecutar("CGIFIN"  , oCgi)
   oCgi:End()

   RELEASE oCGI

RETURN (.T.)
*/

