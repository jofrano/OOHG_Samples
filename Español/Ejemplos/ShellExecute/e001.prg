/*
 * Ejemplo ShellExecute n° 1
 * Autor: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licenciado bajo The Code Project Open License (CPOL) 1.02
 * Ver <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Este ejemplo muestra como usar la funcion ShellExecute para
 * abrir una ventana de Explorer en una carpeta dada.
 *
 * Visítenos en https://github.com/fyurisich/OOHG_Samples o en
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main

   DEFINE WINDOW Win1 ;
      WIDTH 400 ;
      HEIGHT 200 ;
      TITLE "Abrir Explorer desde OOHG"

      @ 10, 10 BUTTON But1 ;
         CAPTION "Abrir" ;
         ACTION ( ShellExecute( 0, "open", GetStartUpFolder(), 0, 0, 1 ), ;
                  MsgBox( "La ejecución continúa sin pausa !!!" ) )

      @ 100, 10 LABEL Lbl1 ;
         VALUE "Haga clic en el botón para abrir Explorer" ;
         AUTOSIZE

      ON KEY ESCAPE ACTION Win1.Release()
   END WINDOW

   Win1.Center
   Win1.Activate

RETURN NIL

/*
 * EOF
 */
