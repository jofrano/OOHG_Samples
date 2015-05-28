/*
 * HTTP Sample n° 3 - Include file
 * Author: Fernando Yurisich <fernando.yurisich@gmail.com>
 * Licenced under The Code Project Open License (CPOL) 1.02
 * See <http://www.codeproject.com/info/cpol10.aspx>
 *
 * Visit us at https://github.com/fyurisich/OOHG_Samples or at
 * http://oohg.wikia.com/wiki/Object_Oriented_Harbour_GUI_Wiki
 */

#xcommand OPEN CONNECTION [<obj: OBJ>] <con> SERVER <server> PORT <port> HTTP ;
   => ;
   httpconnect( iif( <.obj.>, @<con>, <(con)>), <server>, <port> )


#xcommand CLOSE CONNECTION <con> ;
   => ;
   <con>:Close()

#xcommand GET URL <url> TO <response> CONNECTION <con> [ <data: NOHEADERS, HEADERS> ] ;
   => ;
   <response> := httpgeturl( <con>, <url>, iif( upper( #<data> ) == "HEADERS", .F., iif( upper( #<data> ) == "NOHEADERS", NIL, .T. ) ) )
