/*
 * Ejemplo Form n° 7
 * Autor: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licenciado bajo The Code Project Open License (CPOL) 1.02
 * Ver <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Este ejemplos muestra como crear un formulario con
 * fondo transparente.
 *
 * Visítenos en https://github.com/fyurisich/OOHG_Samples o en
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#include "oohg.ch"

FUNCTION Main()

   DEFINE WINDOW Form_1 ;
      OBJ oForm1 ;
      AT 0,0 ;
      WIDTH 420 ;
      HEIGHT 200 ;
      CLIENTAREA ;
      MAIN ;
      TITLE "Formulario con fondo transparente" ;
      BACKCOLOR YELLOW ;
      ON INIT SetTransparent( oForm1:hWnd, RGB_VALUE( oForm1:BackColor ) )

      @ 30,10 TEXTBOX txt_1 ;
         OBJ oTxt1 ;
         VALUE "El fondo del formulario es transparente !!!" ;
         WIDTH 400

      ON KEY ESCAPE ACTION Form_1.Release
   END WINDOW

   CENTER WINDOW Form_1
   ACTIVATE WINDOW Form_1

RETURN NIL

FUNCTION RGB_VALUE( aColor )

RETURN ( aColor[ 1 ] + ( aColor[ 2 ] * 256 ) + ( aColor[ 3 ] * 256 * 256 ) )

#pragma BEGINDUMP

#if defined ( __MINGW32__ )
   #define _WIN32_WINNT 0x0500
#endif

#include <windows.h>
#include "hbapi.h"

HB_FUNC( SETTRANSPARENT )
{

	typedef BOOL (__stdcall *PFN_SETLAYEREDWINDOWATTRIBUTES) (HWND, COLORREF, BYTE, DWORD);

	PFN_SETLAYEREDWINDOWATTRIBUTES pfnSetLayeredWindowAttributes = NULL;

	HINSTANCE hLib = LoadLibrary("user32.dll");

	if (hLib != NULL)
	{
		pfnSetLayeredWindowAttributes = (PFN_SETLAYEREDWINDOWATTRIBUTES) GetProcAddress(hLib, "SetLayeredWindowAttributes");
	}

	if (pfnSetLayeredWindowAttributes)
	{
		SetWindowLong((HWND) hb_parnl (1), GWL_EXSTYLE, GetWindowLong((HWND) hb_parnl (1), GWL_EXSTYLE) | WS_EX_LAYERED);
		pfnSetLayeredWindowAttributes((HWND) hb_parnl (1), hb_parni (2), 0, LWA_COLORKEY);
	}

	if (!hLib)
	{
		FreeLibrary(hLib);
	}

}

#pragma ENDDUMP

/*
 * EOF
 */
