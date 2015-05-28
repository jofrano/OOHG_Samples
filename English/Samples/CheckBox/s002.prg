/*
 * Checkbox Sample n° 2
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to use three stated and leftaligned
 * Checkboxes.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */


#include "oohg.ch"

FUNCTION Main

    DEFINE WINDOW Form1 ;
      AT 0,0 ;
      WIDTH 408 ;
      HEIGHT 176 ;
      TITLE 'ooHg - Three state and leftalign checkbox demo' ;
      MAIN ;
      NOSIZE

      DEFINE MAIN MENU
         POPUP 'CheckBox'
            ITEM 'Set Chk2 to UNCHECKED'     ACTION SetChkState(0)
            ITEM 'Set Chk2 to CHECKED'       ACTION SetChkState(1)
            ITEM 'Set Chk2 to INDETERMINATE' ACTION SetChkState(2)
            SEPARATOR
            ITEM 'Exit' ACTION Form1.Release
         END POPUP
      END MENU

      @ 30,30 CHECKBOX Chk1 ;
         CAPTION 'Chk1 LeftAlign' ;
         WIDTH 100 ;
         HEIGHT 28 ;
         LEFTALIGN

      @ 30,200 CHECKBOX Chk2 ;
         OBJ Chk2 ;
         CAPTION 'Chk2 Three State' ;
         WIDTH 100 ;
         HEIGHT 28 ;
         THREESTATE

      DEFINE CHECKBOX Chk3
         ROW 60
         COL 30
         WIDTH 100
         HEIGHT 28
         CAPTION 'Chk3 AltSyntax'
         VALUE .T.
         LEFTALIGN .T.
       END CHECKBOX

      DEFINE CHECKBOX Chk4
         ROW 60
         COL 200
         CAPTION 'Chk4 AltSyntax'
         VALUE .T.
         TOOLTIP 'Chk4 AltSyntax'
         ONCHANGE ShowState()
         THREESTATE .T.
      END CHECKBOX

   END WINDOW

   CENTER WINDOW Form1

   ACTIVATE WINDOW Form1

Return Nil


Function SetChkState( nState )

   do case
   case nState == 0                 // UNCHECKED
      Form1.Chk2.Value := .F.
   case nState == 1                 // CHECKED
      Form1.Chk2.Value := .T.
   otherwise                        // INDETERMINATE
      Form1.Chk2.Value := NIL
   endcase

Return Nil


Function ShowState()
   Local ret := Form1.Chk4.Value

   do case
   case ret == Nil
      MsgInfo('Chk4 status is INDETERMINATE')
   case ret == .t.
      MsgInfo('Chk4 status is CHECKED')
   otherwise
      MsgInfo('Chk4 status is UNCHECKED')
   endcase

Return Nil

/*
 * EOF
 */
