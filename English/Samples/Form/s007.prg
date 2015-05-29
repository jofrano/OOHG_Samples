/*
 * Form Sample n° 7
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licensed under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * This sample shows how to create a form with transparent
 * background.
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
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
      TITLE "Form with transparent background" ;
      BACKCOLOR YELLOW ;
      ON INIT SetTransparent( oForm1:hWnd, RGB_VALUE( oForm1:BackColor ) )

      @ 30,10 TEXTBOX txt_1 ;
         OBJ oTxt1 ;
         VALUE "The form's background is transparent !!!" ;
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
