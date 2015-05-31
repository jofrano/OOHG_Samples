/*
 * Checkbox Sample n° 1
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to define a treestate left aligned
 * Checkbox with transparent background inside a Tab control.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Form_1 ;
      AT 0,0 ;
      WIDTH 640 HEIGHT 480 ;
      TITLE 'ooHg - Checkbox with transparent background in tab control' ;
      MAIN

      DEFINE TAB Tab_1 ;
         AT 10,10 ;
         WIDTH 600 ;
         HEIGHT 400 ;
         VALUE 1

         PAGE 'Page &1'

            DEFINE CHECKBOX ChkBox
               ROW 70
               COL 10
               WIDTH 280
               VALUE .F.
               CAPTION 'CheckBox with Transparent Background'
               THREESTATE .T.
               LEFTALIGN .T.
            END CHECKBOX

         END PAGE

      END TAB

   END WINDOW

   Form_1.Center

   Form_1.Activate

RETURN Nil

/*
 * EOF
 */
