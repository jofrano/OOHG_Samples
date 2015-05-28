/*
 * This file is part of the HTTP Sample n° 1
 * This code used to be part of OOHG library but now
 * this functionality is included in (x)Harbour libs.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

*-----------------------------------------------------------------------------*
Function httpconnect( Connection, Server, Port )
*-----------------------------------------------------------------------------*
Local oUrl

   If ! Upper( Left( Server, 7 ) ) == "HTTP://"
      Server := "http://" + Server
   EndIf

   oUrl := tURL():New( Server + ":" + Ltrim( Str( Port ) ) )

   If HB_IsString( Connection )
      Public &Connection

      If Empty( oUrl )
         &Connection := Nil
      Else
         &Connection := TIpClientHttp():New( oUrl )

         If ! (&Connection):Open()
            &Connection := Nil
         EndIf
      EndIf
   Else
      If Empty( oUrl )
         Connection := Nil
      Else
         Connection := TIpClientHttp():New( oUrl )

         If ! Connection:Open()
            Connection := Nil
         EndIf
      EndIf
   EndIf

Return Nil

*-----------------------------------------------------------------------------*
Function httpgeturl( Connection, cPage, uRet )
*-----------------------------------------------------------------------------*
Local cUrl, cResponse, cHeader, i, cRet

   cUrl := "http://"
   If ! Empty( Connection:oUrl:cUserid )
      cUrl += Connection:oUrl:cUserid
      If ! Empty( Connection:oUrl:cPassword )
         cUrl += ":" + Connection:oUrl:cPassword
      EndIf
      cUrl += "@"
   EndIf
   If ! Empty( Connection:oUrl:cServer )
      cUrl += Connection:oUrl:cServer
      If Connection:oUrl:nPort > 0
         cUrl += ":" + hb_ntos( Connection:oUrl:nPort )
      EndIf
   EndIf
   cUrl += cPage

   If Connection:Open( cUrl )
      cResponse := Connection:Read()
      If ! hb_IsString( cResponse )
         cResponse := "<No data returned>"
      EndIf

      If hb_IsLogical( uRet )
         cHeader := Connection:cReply
         If ! hb_IsString( cHeader )
            cHeader := "<No header returned>"
         EndIf
         cHeader += hb_OsNewLine()

         For i := 1 to Len( Connection:hHeaders )
            #ifdef __XHARBOUR__
               cHeader += hGetKeyAt( Connection:hHeaders, i ) + ": " + hGetValueAt( Connection:hHeaders, i ) + hb_OsNewLine()
            #else
               cHeader += hb_HKeyAt( Connection:hHeaders, i ) + ": " + hb_HValueAt( Connection:hHeaders, i ) + hb_OsNewLine()
            #endif
         Next
         cHeader += hb_OsNewLine()

         If uRet                       // return DATA and HEADERS
            cRet := cHeader + cResponse
         Else                          // return HEADERS only
            cRet := cHeader
         EndIf
      Else                             // return DATA only
         cRet := cResponse
      EndIf
   Else
      cRet := "<Error opening URL>"
   EndIf

Return cRet
