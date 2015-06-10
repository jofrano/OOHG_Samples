/*
 * Ejemplo Checkbox n° 2
 * Authr: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licenciado bajo The Code Project Open License (CPOL) 1.02
 * Ver <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Ese ejemplo muestra como definir y trabajar con
 * diferentes tipos de controles CheckBox.
 *
 * Visítenos en https://github.com/fyurisich/OOHG_Samples o en
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

    DEFINE WINDOW Form1 ;
      AT 0,0 ;
      WIDTH 408 ;
      HEIGHT 176 ;
      TITLE 'ooHg - Controles CheckBox' ;
      MAIN ;
      NOSIZE

      DEFINE MAIN MENU
         POPUP 'CheckBox'
            ITEM 'Setear Chk2 a DESMARCADO'    ACTION SetChkState(0)
            ITEM 'Setear Chk2 a MARCADO'       ACTION SetChkState(1)
            ITEM 'Setear Chk2 a INDETERMINADO' ACTION SetChkState(2)
            SEPARATOR
            ITEM 'Exit' ACTION Form1.Release
         END POPUP
      END MENU

      @ 30,30 CHECKBOX Chk1 ;
         CAPTION 'Chk1 Alin. Izquierda' ;
         WIDTH 100 ;
         HEIGHT 28 ;
         LEFTALIGN

      @ 30,200 CHECKBOX Chk2 ;
         OBJ Chk2 ;
         CAPTION 'Chk2 Triestado' ;
         WIDTH 100 ;
         HEIGHT 28 ;
         THREESTATE

      DEFINE CHECKBOX Chk3
         ROW 60
         COL 30
         WIDTH 100
         HEIGHT 28
         CAPTION 'Chk3 Sintaxis Alt.'
         VALUE .T.
         LEFTALIGN .T.
       END CHECKBOX

      DEFINE CHECKBOX Chk4
         ROW 60
         COL 200
         CAPTION 'Chk4 Sintaxis Alt.'
         VALUE .T.
         TOOLTIP 'Chk4 Sintaxis Alternativa'
         ONCHANGE ShowState()
         THREESTATE .T.
      END CHECKBOX

   END WINDOW

   CENTER WINDOW Form1

   ACTIVATE WINDOW Form1

Return Nil


Function SetChkState( nState )

   do case
   case nState == 0                 // DESMARCADO
      Form1.Chk2.Value := .F.
   case nState == 1                 // MARCADO
      Form1.Chk2.Value := .T.
   otherwise                        // INDETERMINADO
      Form1.Chk2.Value := NIL
   endcase

Return Nil


Function ShowState()
   Local ret := Form1.Chk4.Value

   do case
   case ret == Nil
      MsgInfo('El estado de Chk4 es INDETERMINADO')
   case ret == .t.
      MsgInfo('El estado de Chk4 es MARCADO')
   otherwise
      MsgInfo('El estado de Chk4 es DESMARCADO')
   endcase

Return Nil

/*
 * EOF
 */
