/*
 * OpenOffice Sample n° 4
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Portions of the code in the ToOpenOffice function are
 * licensed under OOHG's license.
 *
 * This sample shows how to copy and move worksheets of
 * an OpenOffice Calc workbook.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include 'oohg.ch'

FUNCTION Main()

   LOCAL i, aRows[ 15, 5 ]

   SET DATE BRITISH
   SET CENTURY ON
   SET NAVIGATION EXTENDED

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 600 ;
      HEIGHT 480 ;
      TITLE "Copy and Move OpenOffice Calc WorkSheets" ;
      MAIN

      DEFINE STATUSBAR
         STATUSITEM 'OOHG Power !!!'
      END STATUSBAR

      FOR i := 1 TO 15
          aRows[ i ] := { Str(HB_RandomInt( 99 ), 2), ;
                          HB_RandomInt( 100 ), ;
                          Date() + Random( HB_RandomInt() ), ;
                          'Refer ' + Str( HB_RandomInt( 10 ), 2 ), ;
                          HB_RandomInt( 10000 ) }
      NEXT i

      @ 20,20 GRID Grid_1 obj oGrid ;
         WIDTH 520 ;
         HEIGHT 330 ;
         HEADERS { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' } ;
         WIDTHS {60, 80, 100, 120, 140} ;
         ITEMS aRows ;
         COLUMNCONTROLS { { 'TEXTBOX', 'CHARACTER', '99' } , ;
                          { 'TEXTBOX', 'NUMERIC', '999999' } , ;
                          { 'TEXTBOX', 'DATE' }, ;
                          { 'TEXTBOX', 'CHARACTER' }, ;
                          { 'TEXTBOX', 'NUMERIC', ' 999,999,999.99' } } ;
         FONT 'COURIER NEW' SIZE 10

      @ 370,20 BUTTON btn_Export ;
         CAPTION 'Export to OpenOffice' ;
         WIDTH 140 ;
         ACTION ToOpenOffice( oGrid )

      ON KEY ESCAPE ACTION Form_1.Release()
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION ToOpenOffice( oGrid )

   LOCAL cBefore, oSerM, oDesk, oBook, oPropVals, oSheet1, bErrBlck2, x, bErrBlck1
   LOCAL nLin, nCol, cFile, oCell, nRow, uValue
   LOCAL aHeaders := { 'CODE', 'NUMBER', 'DATE', 'REFERENCE', 'AMOUNT' }
   LOCAL aData    := { { "AB1", 12, Date(), "Ref. 12", 128.10 }, ;
                       { "AB5", 34, Date(), "Ref. 34", 578.43 }, ;
                       { "XC3", 87, Date(), "Ref. 87", 879.60 }, ;
                       { "MN6", 65, Date(), "Ref. 65", 322.33 }, ;
                       { "OO9", 90, Date(), "Ref. 90", 765.77 } }

   cFile := HB_DirBase() + "TEST.ODS"

   cBefore := oForm:StatusBar:Item( 1 )
   oForm:StatusBar:Item( 1, 'Creating ' + cFile + ' ...' )

   ERASE (cFile)

   // open service manager
   #ifndef __XHARBOUR__
      IF( oSerM := win_oleCreateObject( 'com.sun.star.ServiceManager' ) ) == NIL
         MsgStop( 'Error: OpenOffice not available. [' + win_oleErrorText()+ ']' )
         RETURN NIL
      ENDIF
   #else
      oSerM := TOleAuto():New( 'com.sun.star.ServiceManager' )
      IF Ole2TxtError() != 'S_OK'
         MsgStop( 'Error: OpenOffice not available.' )
         RETURN NIL
      ENDIF
   #endif

   // catch any errors
   bErrBlck1 := ErrorBlock( { | x | break( x ) } )

   BEGIN SEQUENCE
      // open desktop service
      IF (oDesk := oSerM:CreateInstance("com.sun.star.frame.Desktop")) == NIL
         MsgStop( 'Error: OpenOffice Desktop not available.' )
         BREAK
      ENDIF

      // set properties for new book
      oPropVals := oSerM:Bridge_GetStruct("com.sun.star.beans.PropertyValue")
      oPropVals:Name := "Hidden"
      oPropVals:Value := .T.

      // open new book
      IF (oBook := oDesk:LoadComponentFromURL("private:factory/scalc", "_blank", 0, {oPropVals})) == NIL
         MsgStop( 'Error: OpenOffice Calc not available.' )
         BREAK
      ENDIF

      // set first sheet as current
      oSheet1 := oBook:Sheets:GetByIndex(0)
      oBook:getCurrentController:SetActiveSheet(oSheet1)

      // change sheet's name and default font name and size
      oSheet1:Name := "Data"
      oSheet1:CharFontName := 'Arial'
      oSheet1:CharHeight := 10

      // put title
      oCell := oSheet1:GetCellByPosition( 0, 0 )
      oCell:SetString( 'Exported from OOHG !!!' )
      oCell:CharWeight := 150

      // put headers using bold style
      nLin := 4
      FOR nCol := 1 TO 5
         oCell := oSheet1:GetCellByPosition( nCol - 1, nLin - 1 )
         oCell:SetString( aHeaders[ nCol ] )
         oCell:CharWeight := 150
      NEXT
      nLin += 2

      // put rows
      FOR nRow := 1 to 5
         FOR nCol := 1 to 5
            oCell := oSheet1:GetCellByPosition( nCol - 1, nLin - 1 )
            uValue := aData[ nRow, nCol ]
            DO CASE
            CASE uValue == NIL
            CASE ValType( uValue ) == "C"
               IF Left( uValue, 1 ) == "'"
                  uValue := "'" + uValue
               ENDIF
               oCell:SetString( uValue )
            CASE ValType( uValue ) == "N"
               oCell:SetValue( uValue )
            CASE ValType( uValue ) == "L"
               oCell:SetValue( uValue )
               oCell:SetPropertyValue("NumberFormat", 99 )
            CASE ValType( uValue ) == "D"
               oCell:SetValue( uValue )
               oCell:SetPropertyValue( "NumberFormat", 36 )
            CASE ValType( uValue ) == "T"
               oCell:SetString( uValue )
            OTHERWISE
               oCell:SetFormula( uValue )
            ENDCASE
         NEXT
         nRow ++
         nLin ++
      NEXT

      // autofit columns
      oSheet1:GetColumns():SetPropertyValue( "OptimalWidth", .T. )

      // copy sheet before
      oSheet1:Copy( oSheet1 )
      oSheet2 := oExcel:ActiveSheet()
      oSheet2:Name := "Sheet2"

      oSheet1 := oBook:Sheets:InsertNewByName("Sheet2", 0)
      oBook:getCurrentController:selectSheetByName("Sheet2")
      oSheet1 := oBook:Sheets:GetByIndex(0)

ThisComponent.Sheets.copyByName("Header",nameSheet,thisComponent.getSheets.getCount())

      // copy sheet after
      oSheet1:Copy( oSheet1 )
      oSheet3 := oExcel:ActiveSheet()
      oSheet3:Name := "Sheet3"
      oSheet1:Move( oSheet3 )

      // Final sheet order: Sheet2, Sheet1, Sheet3

      bErrBlck2 := ErrorBlock( { | x | break( x ) } )

      BEGIN SEQUENCE
         ERASE ( cFile )

         // save
         oBook:StoreToURL( OO_ConvertToURL( cFile ), {} )
         oBook:Close( 1 )

         IF MsgYesNo( cFile + ' was created.' + HB_OsNewLine() + "Create Dbf?" )
            ConvertToDbf( oForm, cFile )
         ENDIF
      RECOVER USING x
         // if oBook:StoreToURL() fails, show the error
         MsgStop( x:Description, "OpenOffice Error" )
         MsgStop( cFile + ' was not created !!!' )
      END SEQUENCE

      ErrorBlock( bErrBlck2 )
   RECOVER USING x
      MsgStop( x:Description, "OpenOffice Error" )
   END SEQUENCE

   ErrorBlock( bErrBlck1 )

   // cleanup
   oCell   := NIL
   oSheet1 := NIL
   oSheet2 := NIL
   oSheet3 := NIL
   oBook   := Nil
   oDesk   := Nil
   oSerM   := Nil

   Form_1.StatusBar.Item( 1 ) := cBefore

RETURN NIL

/*
 * EOF
 */
