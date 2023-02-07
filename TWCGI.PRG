#INCLUDE "OBJECTS.CH"
#INCLUDE "FIVEWIN.CH"

MEMVAR oCgi

CLASS TWCGI
   DATA cIniFile
   DATA oIni
   DATA oTDPrn // EXPORT
   DATA nLineCont AS NUMERIC INIT 0
   DATA cURLEnc
   DATA aVars AS ARRAY

   DATA Request_Protocol
   DATA Request_Method
   DATA Request_Keep_Alive
   DATA Document_Root
   DATA Executable_Path
   DATA Query_String
   DATA Server_Software
   DATA Server_Name
   DATA Server_Port
   DATA Server_Admin
   DATA CGI_Version
   DATA Remote_Address
   DATA Referer
   DATA User_Agent
   DATA Content_Type
   DATA Content_Length
   DATA GMT_Offset
   DATA Debug_Mode
   DATA Output_File
   DATA Content_File
   DATA image_gif
   DATA image_x_xbitmap
   DATA image_jpeg
   DATA image_pjpeg
   DATA image_png
   DATA Host
   DATA Accept_Encoding
   DATA Accept_Language
   DATA Accept_Charset


   // Implantación Script
   DATA oScript      // Programa DpXbase que se Ejecuta con la Clase
   DATA cScript      // Nombre del programa Script
   DATA aVars,nPos,cName,lAutomatic  // Modo de Asignación de Valores
   DATA cLog,nEvent  // Contiene Achivo HTM generado por la clase

   // Para CGIINI.SCR
   DATA lCenter,cFont,cColor,aPublics,lIniForm,lPutScript,lTable,lTableLine,lTableCol
   DATA lTableColH,nTableCol,aTablePane,aTableText,nTableLine

   METHOD New(cIniFile,cFrame,cOutPut) CONSTRUCTOR

   METHOD Anchor(nTipo,cLink,cTitle,cTarget)
   METHOD Big(xVar) INLINE "<BIG>"+::xType2Char(xVar)+"</BIG>" //grande
// METHOD Body(oIniRef,cSection)
   METHOD Bold(xVar) INLINE "<B>"+::XType2Char(xVar)+"</B>" //negritas
//   METHOD Button(ntipo,cPrompt)
   METHOD CaracEspec(cHtmLine)
   METHOD Char2XType(xCampo,cVar) HIDDEN
   METHOD Get(cVar,cValue)
   METHOD GetVars(cURLEncoded)
//  METHOD Header(cTitle,cBase)
   METHOD Hn(nHead,cVar,nAlign)
   METHOD Image(cImgName,cAlt)
   METHOD Italic(xVar) INLINE "<I>"+::xType2Char(xVar)+"</I>" //cursivas
   METHOD List(aDatos,lOrder)
   METHOD ListBox(aItems,cVar,nSize) //seleccion multiple
   METHOD SayHtml(cHtmLine) INLINE ::oTDPrn:Say(::CaracEspec(cHtmLine))
   METHOD SaveVars(cAlias)
// METHOD SepLine(nAlign,Width,nSize,lShade)
   METHOD Small(xVar) INLINE "<SMALL>"+::xType2Char(xVar)+"</SMALL>" //pequeña
   METHOD SubIndex(xVar) INLINE "<SUB>"+::xType2Char(xVar)+"</SUB>" //subindice
   METHOD SuperIndex(xVar) INLINE "<SUP>"+::xType2Char(xVar)+"</SUP>" //superindice
   METHOD TeleType(xVar) INLINE "<TT>"+::xType2Char(xVar)+"</TT>" //teletipo
   METHOD Underline(xVar) INLINE "<U>"+::xType2Char(xVar)+"</U>" //subrayado
   METHOD VarOculta(cVarName,cValor)
   METHOD XType2Char(xCampo)
   METHOD Webrowse(cAlias,aCampos)
   METHOD GetVal(cVarName)
   METHOD PutVars(cLista)
   METHOD IniTR(cTexto,cTitle)
   METHOD FinTR(cTexto1,cTexto2)
   METHOD Public(cVarName,uValue) // JN
   METHOD NewLine(nLines)

//   METHOD PutFrame(cFileTxt) INLINE ::SayHtml:=MEMOREAD(cFileTxt)

   // Metodos para Script
   METHOD Add( cName, xValue )
   METHOD Del( cName )
   METHOD read( cName )
   METHOD Set( cName, xValue )
   METHOD GetPos( cName )
   METHOD IsDef( cName ) INLINE (::GetPos(cName)>0)

   METHOD SetScript() INLINE (::oScript:=GetScript(),;
                              ::cScript:=VP("SCRPROGRAM"))

   ERROR HANDLER OnError( cMsg,nPar1,nPar2,nPar3,nPar4,nPar5,nPar6,nPar7,nPar8,nPar9,nPar10,nPar11,nPar12,nError )

   METHOD End()
ENDCLASS

METHOD New(cIniFile,cFrame,cOutPut) CLASS TWCgi
   ::cIniFile := cIniFile
   ::oIni := TIni():New(cIniFile)
   ::Request_Protocol   := ::oIni:Get("CGI","Request Protocol")
   ::Request_Method     := ::oIni:Get("CGI","Request Method")
   ::Request_Keep_Alive := ::oIni:Get("CGI","Request Keep-Alive")
   ::Document_Root      := ::oIni:Get("CGI","Document Root")
   ::Query_String       := ::oIni:Get("CGI","Query String","")
   ::Executable_Path    := ::oIni:Get("CGI","Executable Path")
   ::Server_Software    := ::oIni:Get("CGI","Server Software")
   ::Server_Name        := ::oIni:Get("CGI","Server Name")
   ::Server_Port        := ::oIni:Get("CGI","Server Port")
   ::Server_Admin       := ::oIni:Get("CGI","Server Admin")
   ::CGI_Version        := ::oIni:Get("CGI","CGI Version")
   ::Remote_Address     := ::oIni:Get("CGI","Remote Address")
   ::Referer            := ::oIni:Get("CGI","Referer")
   ::User_Agent         := ::oIni:Get("CGI","User Agent")
   ::Content_Type       := ::oIni:Get("CGI","Content Type")
   ::Content_Length     := ::oIni:Get("CGI","Content Length")
   ::GMT_Offset         := ::oIni:Get("System","GMT Offset")
   ::Debug_Mode         := ::oIni:Get("System","Debug Mode")
   ::Output_File        := ::oIni:Get("System","Output File")
   ::Content_File       := ::oIni:Get("System","Content File")
   ::image_gif          := ::oIni:Get("Accept","image/gif")
   ::image_x_xbitmap    := ::oIni:Get("Accept","image/x-xbitmap")
   ::image_jpeg         := ::oIni:Get("Accept","image/jpeg")
   ::image_pjpeg        := ::oIni:Get("Accept","image/pjpeg")
   ::image_png          := ::oIni:Get("Accept","image/png")
   ::Host               := ::oIni:Get("Extra Headers","Host")
   ::Accept_Encoding    := ::oIni:Get("Extra Headers","Accept-Encoding")
   ::Accept_Language    := ::oIni:Get("Extra Headers","Accept-Language")
   ::Accept_Charset     := ::oIni:Get("Extra Headers","Accept-Charset")

   /* Objeto TDosPrn para la salida de informacion */

   // ? ::Output_File

   IF !EMPTY(cOutPut) // Utiliza el Archivo enviado por Parámetro
      ::Output_file:=cOutPut
   ENDIF
   ::oTDPrn := TWebPrn():New(::Output_file)

   /* Lineas forzosas para salida CGI*/
   ::SayHtml("Content-type: text/html")
   ::SayHtml("")

   ::aVars:={}
   ::nPos :=0
   ::cName:=""
   ::lAutomatic:=.T.  // Modo de Asignación de Valores

   IF !EMPTY(cFrame)
      ::PUTFRAME(cFrame)
   ENDIF

   ::nEvent:=0

   /*Determinamos como vienen las variables */
   IF "POST"$::Request_Method // == "POST"
      ::cURLEnc := MEMOREAD(::Content_File)
   ELSE
      ::cURLEnc := ::Query_String
   ENDIF

   // ? "method",::Request_Method,::Content_File,"aqui estan las variables"
   // ? ::cURLEnc,cIniFile,"VARIABLES"

   /* Obtenemos las variables */
   IF LEN(::cUrlEnc) > 0
      ::aVars := ::GetVars(::cURLEnc)
   ENDIF
RETURN(self)


/* linea separadora HTML Etiqueta <HR>
   <nAlign> alineacion (1) izquierda, (2) centro, (3) derecha
   <Width> ancho de la linea en porcentaje (string) o pixeles (numerico)
   <nSize> espesor de la linea en pixeles
   <lShade> indica si lleva o no sombra
   Todos los parametros son opcionales*/
/*
METHOD SepLine(nAlign,Width,nSize,lShade) CLASS TWCgi
   LOCAL cSep := "<HR"
   DEFAULT lShade := .T.
   IF nAlign <> NIL
      cSep += " ALIGN="
      DO CASE
         CASE nAlign == 1
            cSep += "'LEFT'"
         CASE nAlign == 2
            cSep += "'CENTER'"
         CASE nAlign == 3
            cSep += "'RIGHT'"
      ENDCASE
   ENDIF
   IF Width <> NIL
      cSep += " WIDTH='"+::xType2Char(Width)+"'"
   ENDIF
   IF nSize <> NIL
      cSep += " SIZE='"+::xType2Char(nSize)+"'"
   ENDIF
   IF !lShade
      cSep += " NOSHADE"
   ENDIF
   cSep+=">"
   ::SayHtml(cSep)
RETURN NIL
*/
METHOD List(aDatos,lOrder) CLASS TWCgi
   LOCAL nCiclo
   DEFAULT lOrder := .F.
   IF lOrder
      ::SayHtml("<OL>")
   ELSE
      ::SayHtml("<UL>")
   ENDIF
   FOR nCiclo := 1 TO LEN(aDatos)
      ::SayHtml(::XType2Char(aDatos[nCiclo]))
   NEXT
   IF lOrder
      ::SayHtml("</OL>")
   ELSE
      ::SayHtml("</UL>")
   ENDIF
RETURN NIL

METHOD Image(cImgName,cAlt,nBorder) CLASS TWCgi
   LOCAL cVret := "<IMG SRC='"+ALLTRIM(cImgName)+"'" + IIF( nBorder<>NIL,[ BORDER="]+ALLTRIM(STR(nBorder))+["] , "" )
   IF cAlt <> NIL
      cVret += " ALT='"+ALLTRIM(cAlt)+"'"
   ENDIF
   cVret+=">"
RETURN(cVret)

METHOD Get(cVar,cValue,nLen,lPass) CLASS TWCGI
    LOCAL cType,oCGI:=SELF

    DEFAULT cValue := ""

    DEFAULT nLen   := LEN(cValue)

    DEFAULT lPass  :=.F.

    cType:=IIF(lPass,"PASSWORD","TEXT")

    IIF(oCgi:lTable,oCgi:SayHtml([<TD>]),NIL)

    oCgi:SayHtml([<INPUT TYPE=]+cType+[ NAME="]+cVar+["]+ [ VALUE="]+ALLTRIM(cValue)+["]+;
                 [ MAXLENGTH="]+LTRIM(STR(nLen))+["]+;
                 [ SIZE="]+LTRIM(STR(nLen))+["]+[>])

    IIF(oCgi:lTable,oCgi:SayHtml([</TD>]),NIL)

RETURN NIL


/*
METHOD Header(cTitle,cBase,cMeta,nSeconds) CLASS TWCgi
   DEFAULT nSeconds := 1
   ::SayHtml("<HTML>")
   ::SayHtml("<HEAD>")
   ::SayHtml("   <TITLE>"+cTitle+"</TITLE>")
   IF cBase <> NIL
      ::SayHtml("   <BASE HREF='"+cBase+"'>")
   ENDIF
   IF cMeta <> NIL
      ::SayHtml("    <META http-equiv='refresh' content='"+LTRIM(STR(nSeconds))+";url=http://"+cMeta+"'")
   ENDIF
   ::SayHtml("</HEAD>")
RETURN NIL

METHOD Body(oIniRef,cSection) CLASS TWCgi
   LOCAL cBody := "<BODY"
   LOCAL cVarTmp := ""
   cVarTmp := oIniRef:Get(cSection,"BACKGROUND")
   IF !EMPTY(cVarTmp)
      cBody += " BACKGROUND="+cVarTmp
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"BGCOLOR")
   IF !EMPTY(cVarTmp)
      cBody += " BGCOLOR="+cVarTmp
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"TEXT")
   IF !EMPTY(cVarTmp)
      cBody += " TEXT="+cVarTmp
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"LINK")
   IF !EMPTY(cVarTmp)
      cBody += " LINK="+cVarTmp
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"VLINK")
   IF !EMPTY(cVarTmp)
      cBody += " VLINK="+cVarTmp
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"ALINK")
   IF !EMPTY(cVarTmp)
      cBody += " ALINK="+cVarTmp
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"LEFTMARGIN")
   IF !EMPTY(cVarTmp)
      cBody += " LEFTMARGIN='"+cVarTmp+"'"
      cVarTmp := ""
   ENDIF
   cVarTmp := oIniRef:Get(cSection,"TOPMARGIN")
   IF !EMPTY(cVarTmp)
      cBody += " TOPMARGIN='"+cVarTmp+"'"
      cVarTmp := ""
   ENDIF
   ::SayHtml(cBody+">")
RETURN NIL
*/
METHOD End() CLASS TWcgi
   local cFile:=::Output_file
   local cLog :=::cLog
   ::SayHtml("</BODY>")
   ::SayHtml("</HTML>")
   ::oTDPrn:End()
   IF !empty(cLog)
      memowrit(cLog,memoread(cFile))
   ENDIF
RETURN NIL





/* Decodifica la cadena URL Encoded y pone las variables en un arreglo */
METHOD GetVars(cInpVars) CLASS TWCGI
   LOCAL aVRet := {}, aVnom := {}, aVvar := {}
   LOCAL nCiclo
   LOCAL cVarNom := "", cVal := ""

   /* Comas (,) */
   cInpVars := STRTRAN(cInpVars,"%2C",",")

   /* CR+LF para campos memo*/
   cInpVars := STRTRAN(cInpVars,"%0D",CHR(13))
   cInpVars := STRTRAN(cInpVars,"%0A",CHR(10))

   /* espacios en blanco */
   cInpVars := STRTRAN(cInpVars,"+"," ")

   /* acentos minúsculas*/
   cInpVars := STRTRAN(cInpVars,"%E1",CHR(160))
   cInpVars := STRTRAN(cInpVars,"%E9",CHR(130))
   cInpVars := STRTRAN(cInpVars,"%ED",CHR(161))
   cInpVars := STRTRAN(cInpVars,"%F3",chr(162))
   cInpVars := STRTRAN(cInpVars,"%FA",CHR(163))

   /*eñes mayusculas y minúsculas*/
   cInpVars := STRTRAN(cInpVars,"%F1",chr(164))
   cInpVars := STRTRAN(cInpVars,"%D1",CHR(165))

   /*diagonales*/
   cInpVars := STRTRAN(cInpVars,"%2F","/")

   /* diagonales invertidas (back slash) */
   cInpVars := STRTRAN(cInpVars,"%5C","\")

   /* parentesis */
   cInpVars := STRTRAN(cInpVars,"%28","(")
   cInpVars := STRTRAN(cInpVars,"%29",")")

   /* tilde */
   cInpVars := STRTRAN(cInpVars,"%7E","~")

   /* signos de "+", hay que reemplazarlos DESPUES de reemplazar los "+" por espacios */
   cInpVars := STRTRAN(cInpVars,"%2B","+")

   /* espacios en blanco HTML, estos son sumamente importantes de quitar, ya que si no
   se hace, se pueden tener problemas al decodificar la cadena de entrada porque contienen
   un & que confunde a la rutina de extraccion */
   cInpVars := STRTRAN(cInpVars,"&nbsp;"," ")

   /* arrobas ( @ )*/
   cInpVars := STRTRAN(cInpVars,"%40","@")

   /* dos puntos ( : )*/
   cInpVars := STRTRAN(cInpVars,"%3A",":")

   /* comillas dobles ( " )*/
   cInpVars := STRTRAN(cInpVars,"%22",'"')

   //? cInpVars,"cInpVars"

   FOR nCiclo := 1 TO LEN(cInpVars)
      DO CASE
         CASE SUBSTR(cInpVars,nCiclo,1) == "="
            AADD(aVnom,cVarNom)
            cVarNom := ""
         CASE SUBSTR(cInpVars,nCiclo,1) == "&"
            AADD(aVvar,cVarNom)
            cVarNom := ""
          OTHERWISE
         cVarNom += SUBSTR(cInpVars,nCiclo,1)
      ENDCASE
   NEXT
   AADD(aVvar,cVarNom)

   FOR nCiclo := 1 TO LEN(aVnom)
       AADD(aVret,{aVnom[nCiclo],aVvar[nCiclo]})
   NEXT

   AEVAL(aVret,{|a,i|IIF( a[2]=NIL,aVret[I,2]:="" , NIL )}) // Verifica que no esta Vacio

RETURN (aVret)

/* Convierte los caracteres especiales a su codigo HTML */
METHOD CaracEspec(cParam) CLASS TWCGI
   LOCAL cVret
   /* vocales con acento */
   cVret := STRTRAN(cParam,CHR(160),"&aacute;")
   cVret := STRTRAN(cVret,CHR(130),"&eacute;")
   cVret := STRTRAN(cVret,CHR(161),"&iacute;")
   cVret := STRTRAN(cVret,CHR(162),"&oacute;")
   cVret := STRTRAN(cVret,CHR(163),"&uacute;")
   /* Eñes mayúsculas y Minúsculas */
   cVret := STRTRAN(cVret,CHR(164),"&ntilde;")
   cVret := STRTRAN(cVret,CHR(165),"&Ntilde;")
   /* otros caracteres especiales */
   cVret := STRTRAN(cVret,CHR(60)+" ","&lt; ") //menor que (<)
   cVret := STRTRAN(cVret,CHR(62)+" ","&gt; ") //mayor que (>)
*   cVret := STRTRAN(cVret,CHR(38),"&amp;") // ampersand (&)
   cVret := STRTRAN(cVret,CHR(168),"&iquest;") // signo de interrogacion abierto (¿)
   cVret := STRTRAN(cVret,CHR(173),"&iexcl;") // signo de admiracion abierto (¡)
RETURN (OEMTOANSI(cVret))
/*fin CaracExpec */

METHOD SaveVars(cAlias) CLASS TWCgi
   LOCAL x
   FOR x := 1 TO LEN(::aVars)
      IF (cAlias)->(FieldPos(::aVars[x,1])) > 0 // checamos que la variable del arreglo sea un campo

            /* No podemos hacer un replace directamente por lo mismo utilizamos las funciones
               FIELDPUT() y como no sabemos la posicion del campo entonces utilizamos FIELDPOS()
               Por otro lado hasta este punto todas la varibles son cadenas de caracteres y para
               reemplazarlas debemos de convertirlas a su valor apropiado, esto lo hacemos con
               la funcion Char2xType() */

            (cAlias)->(FIELDPUT(FIELDPOS(::aVars[x,1]),::Char2xType(FIELDGET(FIELDPOS(::aVars[x,1])),ALLTRIM(::aVars[x,2]))))
         ENDIF
      NEXT

      /* liberamos la base de datos */
      (cAlias)->(DBCOMMIT())
      *UNLOCK
RETURN NIL

METHOD Char2XType(xCampo,cVar) CLASS TWCgi
   LOCAL xValue // para el valor de retorno
   DO CASE
      CASE VALTYPE(xCampo) == "D" // fecha
         xValue := CTOD(cVar)
      CASE VALTYPE(xCampo) == "L" // lógico
         xValue := IIF( !EMPTY(cVar),.T.,.F.)
      CASE VALTYPE(xCampo) == "N" // numérico
         xValue := VAL(cVar)
      OTHERWISE
         xValue := OEMTOANSI(cVar) // caracter o memo (por omision)
   ENDCASE
RETURN (xValue)


/* establece enlaces, etiqueta html: <A>...</A>
   <nTipo> : tipo de enlace (omitible), posibles valores:
            ( 0 ) no hay servicio referencia automatica a la direccion definda en <BASE> en el Header
            ( 1 ) servicio http (web normal)
            ( 2 ) servicio https (Secure Server)
            ( 3 ) servicio ftp (transferencia de archivos)
            ( 4 ) servicio news (servidores de noticias)
            ( 5 ) servicio files (referencia a un archivo dentro del mismo disco duro)
            ( 6 ) NAME, indica liga dentro de la misma pagina
   <cLink> : pagina u anclaje al que vamos a hacer referencia, si es dentro de la misma pagina deber ir
             ancedido por "#"
   <cTitle>: nombre con el que debe aparecer el anclaje (omitible)
   <xTarget>: indica donde debe desplegarse la pagina referenciada (omitible), este valor puede ser
              cadena de caracteres para hacer referencia a otra pagina o a un frame o bien un valor
              numerico con estos posibles valores:
              (1) Abre la liga en una pagina en blanco
              (2) Abre la liga en la misma pagina (default)
              (3) Abre la liga en la pagina padre de la que estamos
              (4) Abre la liga en la pagina principal */

METHOD Anchor(nTipo,cLink,cTitle,xTarget) CLASS TWCGI
   LOCAL cTarget, cTempLink := "<A ",cVret:=""
   DEFAULT nTipo := 0
   DEFAULT cTitle := cLink
   DO CASE
      CASE nTipo == 0
         cTempLink += "HREF='"+cLink+"'"
      CASE nTipo == 1 .OR. nTipo == NIL
         cTempLink += "HREF='http://"+cLink+"'"
      CASE nTipo == 2
         cTempLink += "HREF='https://"+cLink+"'"
      CASE nTipo == 3
         cTempLink += "HREF='ftp://"+cLink+"'"
      CASE nTipo == 4
         cTempLink += "HREF='news://"+cLink+"'"
      CASE nTipo == 5
         cTempLink += "HREF='file://"+cLink+"'"
      CASE nTipo == 6
         cTempLink += " NAME='"+cLink+"'"
   ENDCASE
   IF VALTYPE(xTarget) == "C"
      cTarget := xTarget
   ELSE
      DO CASE
         CASE xTarget = 1
            cTarget := "_BLANK"
         CASE xTarget == 2 .OR. xTarget = NIL
            cTarget := "_SELF"
         CASE xTarget = 3
            cTarget := "_PARENT"
         CASE xTarget == 4
            cTarget := "_TOP"
         OTHERWISE
            cTarget := NIL
      ENDCASE
   ENDIF
   IF cTarget <> NIL
      cVret += "TARGET='"+cTarget+"' "
   ENDIF
   cVret +=">"+ALLTRIM(cTitle)+"</A>"
RETURN (cVret)
/* fin Anchor*/

/* Headers*/
METHOD Hn(nHead,cVar,nAlign) CLASS TWCgi
   LOCAL cVret
   DEFAULT nAlign := 1
   DEFAULT nHead := 1
   cVret := "<H"+LTRIM(STR(nHead))+" ALIGN="
   DO CASE
      CASE nAlign == 1
         cVret +="LEFT>"
      CASE nAlign == 2
         cVret +="CENTER>"
      CASE nAlign == 3
         cVret +="RIGHT>"
   ENDCASE
   cVret+=ALLTRIM(cVar)+"</H"+LTRIM(STR(nHead))+">"
RETURN (cVret)

METHOD Webrowse(oWebBrowse) CLASS TWCGI //cAlias,aCampos) CLASS TWCGI
   LOCAL aStruct, nReng
   LOCAL cHtml := "<TABLE"
   oWebBrowse:Activate()
   *cHtml += " WIDTH="+oWebBrowse:Width

   *cHtml +=">"
   *::SayHtml(cHtml)

   /*IF UPPER(oWebBrowse:cAlias) == "ARRAY"
      FOR nReng := 1 TO LEN(oWebBrowse:aArray)
         ::SayHtml("<TR>")
         FOR nCol := 1 TO LEN(oWebBrowse:aWebCols)
            ::SayHtml("<TD>")
            ::SayHtml(::xType2Char(EVAL(oWebBrowse:aWebCols[nCol]:bBlock)))
            ::SayHtml("</TD>")
         NEXT
         ::SayHtml("</TR>")
      NEXT
   ELSE
      (oWebBrowse:cAlias)->(DBGOTOP())
      DO WHILE !(oWebBrowse:cAlias)->(EOF())
         ::SayHtml("<TR>")
         FOR nCol := 1 TO LEN(oWebBrowse:aWebCols)
            ::SayHtml("<TD>")
            ::SayHtml(::xType2Char(EVAL(oWebBrowse:aWebCols[nCol]:bBlock)))
            ::SayHtml("</TD>")
         NEXT

         (oWebBrowse:cAlias)->(DBSKIP())
         ::SayHtml("</TR>")
      ENDDO
   ENDIF

   ::SayHtml("</TABLE>")*/

   /* Webrowse viejo
   IF aCampos == NIL
      aCampos := {}
      aStruct := (cAlias)->(DBSTRUCT())
      FOR x := 1 TO LEN (aStruct)
         AADD(aCampos,aStruct[x,1])
      NEXT
   ENDIF
   ::SayHtml("<TABLE WIDTH = 100% border='1' VALIGN=TOP cellpadding='0' cellspacing='0'>")
   (cAlias)->(DBGOTOP())
   DO WHILE !(cAlias)->(EOF())
      ::SayHtml("<TR>")
      FOR x := 1 TO LEN(aCampos)
         ::SayHtml("<TD VALIGN=TOP>"+::xType2Char((cAlias)->(FIELDGET((cAlias)->(FIELDPOS(aCampos[x])))))+"</TD>")
      NEXT
      ::SayHtml("</TR>")
      (cAlias)->(DBSKIP())
   ENDDO
   ::SayHtml("</TABLE>")
   Fin Webrowse viejo */
RETURN nil

/* convierte de cualquier tipo de dato a cadenar de caracteres */
METHOD XType2Char(xCampo) CLASS TWCgi
   LOCAL cVret,xValTmp
   /* si es un bloque de codigo */
   IF VALTYPE(xCampo) = "B"
      xCampo := EVAL(xCampo)
   ENDIF
   /* hacemos la conversion */
   DO CASE
      CASE VALTYPE(xCampo) == "D" //fecha
         cVret := DTOC(xCampo)
      CASE VALTYPE(xCampo) == "N" //numerico
         cVret := STR(xCampo)
      CASE VALTYPE(xCampo) == "L" // logico
         cVret := IIF(xCampo,".T.",".F.")
      CASE VALTYPE(xCampo) == "A" // Arreglo
         cVret := "Array..."
      OTHERWISE
         cVret := xCampo // cadena de caracteres (default)
   ENDCASE
RETURN(ALLTRIM(cVret))
/* fin XType2Char()*/

/* Formas*/
/* Get */
//METHOD Get(cVar,cValue) CLASS TWCgi
//   DEFAULT cValue := ""
//   ::SayHtml("<INPUT TYPE='TEXT' NAME='"+cVar+"' VALUE='"+cValue+"' SIZE ="+LTRIM(STR(LEN(cValue)))+">")
//RETURN(NIL)

/*
METHOD Button(ntipo,cPrompt) CLASS TWCgi
   DEFAULT nTipo := 1
   IF cPrompt == NIL
      DO CASE
         CASE nTipo == 1
            cPrompt := "Submit"
         CASE nTipo == 2
            cPrompt := "Reset"
      ENDCASE
   ENDIF
   ::SayHtml("<INPUT TYPE='"+IIF(nTipo=1,"SUBMIT' ","RESET' ")+"VALUE='"+cPrompt+"'>")
RETURN(NIL)
*/
/*
METHOD Listbox(aItems,cVar,nSize) CLASS TWCgi
   LOCAL nCiclo
   DEFAULT nSize := 0
   ::SayHtml("<SELECT NAME="+cVar+IIF(nSize >0,"SIZE="+LTRIM(STR(nSize)),"")+">")
   FOR nCiclo := 1 TO LEN(aItems)
      ::SayHtml("<OPTION>"+aItems[nCiclo])
   NEXT
   ::SayHtml("</SELECT>")
RETURN (Nil)
*/
METHOD VarOculta(cVarName,cValor) CLASS TWCgi
   ::SayHtml("<INPUT TYPE='HIDDEN' NAME='"+cVarName+"' VALUE='"+cValor+"'>")
RETURN (NIL)

METHOD GetVal(cVarName,lView) CLASS TWCGI
 // LOCAL uValue:= ::aVars[ASCAN(::aVars,{|x| UPPE(x[1]) == UPPE(cVarName)}),2]
 LOCAL uValue,I,nAT,cLista:=""
 DEFAULT lView:=.F.
 FOR i := 1 TO IIF( lView,len(::aVars),0)
    cLista:=cLista+::aVars[i,1]+::aVars[i,2]+CRLF
 NEXT
 IF lView
    ALERT(cLista)
 ENDIF
 nAt:= ASCAN(::aVars,{|x| UPPE(x[1]) == UPPE(cVarName)})
 IF nAt>0
    uValue:= ::aVars[nAt,2]
 ELSE
    uValue:=cVarname+" NO EXISTE"
    // MENSAJE
 ENDIF
 // uValue:= ::aVars[ASCAN(::aVars,{|x| UPPE(x[1]) == UPPE(cVarName)}),2]
RETURN uValue

/*
// Coloca nuevamente las variables en el formulario para que viajen hacia otra peticion
*/
METHOD PutVars(cLista) CLASS TWCGI
 local aVars:=_vector(cLista),i,uValue
 FOR i := 1 TO len(aVars)
    uValue:=::GETVAL(aVars[i])
    // ? uValue,aVars[i],"putvars method"
    ::SayHtml([<INPUT NAME="]+aVars[i]+[" TYPE=Hidden VALUE="]+uValue+[">])
 NEXT I
RETURN NIL

METHOD IniTR(cTexto,cTitle) CLASS TWCGI
    ::SayHtml('<TR><TD>')
    IIF( ValType(cTexto)="C",::SayHtml(cTexto),NIL)
    IIF( ValType(cTitle)="C",::SayHtml(cTitle),NIL)
RETURN .T.

METHOD FinTR(cTexto1,cTexto2) CLASS TWCGI
    IIF( ValType(cTexto1)="C",::SayHtml(cTexto1),NIL)
    IIF( ValType(cTexto2)="C",::SayHtml(cTexto2),NIL)
    //::SayHtml('</TR></TD>')
    ::SayHtml('</TD></TR>')

RETURN .T.

/*
METHOD PUTFRAME(cFileTxt) CLASS TWCGI
   LOCAL cMemo,aLista,I
   IF !FILE(cFileTxt)
     ::SayHtml('Archivo de Frame '+cFileTxt+" no Existe")
     RETURN NIL
   ENDIF
   ::SayHtml:=MEMOREAD(cFileTxt)
   // cMemo :=STRTRAN(MEMOREAD(cFileTxt),CHR(13),"")
   // aLista:=VECTOR(cMemo,CHR(10))
   // AEVAL(aLista,{|a,i|::SayHtml(a)})
RETURN NIL
*/

/*
 *  DPEDIT:Add()
 */
METHOD Add( cName, xValue ) CLASS TWCGI // [ER]

   if cName != NIL

      if (::nPos := aScan( ::aVars, { |e,n| UPPE(ALLTRIM(e[1])) == AllTrim(Upper(cName)) } )) != 0
         ::aVars[::nPos,2] := xValue
      else
         aAdd( ::aVars, { AllTrim(Upper(cName)), xValue } )
         ::nPos := Len(::aVars)
      endif
      ::cName  := cName

   endif

RETURN Self


/*
 *  TWCGI:Del()
 */

METHOD Del( cName ) CLASS TWCGI
   local nPos

   if cName != NIL
      if (nPos := aScan( ::aVars, { |e,n| ALLTRIM(UPPE(e[1])) == AllTrim(Upper(cName)) } )) != 0
         aDel( ::aVars, nPos )
         ::aVars := aSize( ::aVars, Len(::aVars) - 1 )

         ::nPos   := 0
         ::cName  := ""
      endif
   endif

RETURN Self

/*
 *  TWCGI:Get()
 */
METHOD Read( cName ) CLASS TWCGI                  // [by ER]

   if cName != ::cName
      ::nPos   := aScan( ::aVars, { |e,n| UPPE(ALLTRIM(e[1])) == AllTrim(Upper(cName)) } )
      ::cName  := cName
   endif

RETURN ::aVars[::nPos,2]

/*
 *  TWCGI:Set()
 */
METHOD Set( cName, xValue ) CLASS TWCGI             // [by ER]


   if cName != ::cName
      ::nPos   := aScan( ::aVars, { |e,n| ALLTRIM(UPPE(e[1])) == AllTrim(Upper(cName)) } )
      ::cName  := cName
   endif

   ::aVars[::nPos,2] := xValue

RETURN nil // Self

/*
 *  TWCGI:GetPos()                         // [by ER]
 */
METHOD GetPos( cName ) CLASS TWCGI

   ::cName  := cName

RETURN ::nPos := aScan( ::aVars, { |e,n| alltrim(uppe(e[1])) == AllTrim(Upper(cName)) } )

/*
// Asignaciones Valores Publicos del CGI
*/
METHOD Public(cVarName,uValue) CLASS TWCGI
  LOCAL nAt
  cVarName:=ALLTRIM(UPPER(cVarName))
  nAt:=ASCAN(oCgi:aPublics,cVarName)
  IF nAt>0
     ::aPublics[nAt,2]:=uValue
   ELSE
     AADD(::aPublics,{ALLTRIM(UPPE(cVarName)),uValue})
  ENDIF
  // De la Misma Forma Crea una Varible para el CGI
  IF !::IsDef(cVarName)
     ::Add(cVarName,uValue)
  ENDIF
RETURN NIL

/*
// Avance de Linea
*/

METHOD NewLine(nLines) CLASS TWCGI
    LOCAL I
    DEFAULT nLines:=1
    FOR I := 1 TO nLines
      oCgi:SayHtml("<BR>")
    NEXT I
RETURN NIL

METHOD Listbox(aItems,cVar,uValue,nSize) CLASS TWCGI
   LOCAL nCiclo,cValue:="",cFound,oCgi:=SELF

   IF !EMPTY(uValue)
       cValue:=[VALUE= "]+uValue+["]
   ENDIF

   DEFAULT nSize := 0

   IIF(oCgi:lTable,oCgi:SayHtml([<TD>]),NIL)

   oCgi:SayHtml([<SELECT NAME=]+cVar+[ ]+cValue+[ ]+IIF(nSize >0,[SIZE=]+LTRIM(STR(nSize)),"")+[>])

   FOR nCiclo := 1 TO LEN(aItems)
      IF uValue!=NIL .AND. ALLTRIM(aItems[nCiclo])==ALLTRIM(uValue)
        oCgi:SayHtml([<OPTION VALUE="]+uValue+[" selected>]+uValue) // Venezuela
      ELSE
        oCgi:SayHtml([<OPTION>]+aItems[nCiclo])
      ENDIF
   NEXT
   oCGi:SayHtml("</SELECT>")

   IIF(oCgi:lTable,oCgi:SayHtml([</TD>]),NIL)

RETURN NIL


/*
 *  TWCGI:Release()
METHOD Release() CLASS TWCGI

   ASIZE(::aVars,0)
   ::cName  := ""
   ::nPos   := 0

RETURN Self
*/


/*
 *  OnError()
 */
METHOD OnError( uValue,nError,nPar3,nPar4,nPar5,nPar6,nPar7,nPar8,nPar9,nPar10,nPar11 ) CLASS TWCGI

  local cErrorLog,cMsg,lScript:=.F.,J,N //,oFrameDp
  local lRet,oScript

  #ifdef __HARBOUR__  // JN
      cMsg   := __GetMessage()
  #endif

  cMsg := Upper( AllTrim( cMsg ))

  if SubStr( cMsg, 1, 1 ) == "_" // Asignar Valor

      cMsg:=Subs(cMsg,2)

    //  ? cMsg,::cName,::nPos

      if UPPE(cMsg) == Upper(::cName)
         ::aVars[::nPos,2] := uValue
         ::Set(UPPE(::cName),uValue)
      elseif ( ::nPos := aScan( ::aVars, { |e,n| ALLTRIM(UPPE(e[1])) == ALLTRIM(UPPE(cMsg)) } ) ) != 0
         ::cName  := cMsg
         ::aVars[::nPos,2] := uValue // ( 1, 1 )
         ::Set(UPPE(::cName),uValue)

      else

         if !::lAutomatic	// [WA]
            _ClsSetError( _GenError( nError, ::ClassName(), cMsg ) )
            ::cName  := ""
            ::nPos   := 0
         else
            ::add(UPPE(cMsg))
            ::aVars[::nPos,2] := uValue //  GetParam( 1, 1 )
         endif
      endif
   else

   IF ::cScript!=NIL

   ENDIF

      if UPPE(ALLTRIM(cMsg)) == Upper(ALLTRIM(::cName))           // [by ER]

         RETURN ::aVars[::nPos,2]

      elseif ( ::nPos := aScan( ::aVars, { |e,n| UPPE(ALLTRIM(e[1])) == UPPE(ALLTRIM(cMsg)) } ) ) != 0
         ::cName  := UPPE(ALLTRIM(cMsg))
         RETURN ::aVars[::nPos,2]
      else
         ::cName  := ""
         ::nPos   := 0

         // ? ::oScript:ClassName(),cMsg

         IF ValType(::oScript)="O" // busca la función en el Script
            lScript:=::oScript:IsFunction(cMsg)

            Private oCgi:=Self

            IF lScript

               ::nEvent++
               IF ::nEvent>5
                  msgalert("recursidad exedida")
                  __quit()
               ENDIF

               // EJECUTAR(::cScript)

               // lRet:=SCRRUN(::cScript,cMsg,uValue,nError,nPar3,nPar4,nPar5,nPar6,nPar7,nPar8,nPar9,nPar10,nPar11)
               // ? ::cScript
               //              SCRRUN
               lRet:=::oScript:RUN(cMsg,uValue,nError,nPar3,nPar4,nPar5,nPar6,nPar7,nPar8,nPar9,nPar10,nPar11)
               // oScript:=GetScript() // Script que estaba Corriendo

               ::nEvent--

               IF ValType(::oScript)="O" .AND. !EMPTY(::oScript:cError)
                  ErrorCgi(nil,Self,::oScript:cError)
               ENDIF

               RETURN lRet

            ENDIF

         ENDIF

         IF !lScript
            _ClsSetError( _GenError( nError, ::ClassName(), cMsg ) )
         ENDIF

      endif
   endif

RETURN NIL

