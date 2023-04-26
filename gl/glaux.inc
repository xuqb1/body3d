'--------------------------------------------------------------------------
'  GLAUX.INC -- Part of the OpenGL32 API Includes  for PB/DLL 6.0 Release 4
'  [gl.h, glu.h, glaux.h + wgl API]
'  Copyright 1999 sublevel6.
'  Portions copyright Silicon Graphics and Microsoft.
'
'  Release date: Saturday, December 04, 1999
'  Homepage:     -
'  E-Mail:       dinky@pmail.net (to Dinky)
'                angus_law@hotmail.com (to rYme)
'--------------------------------------------------------------------------

'/*
' * (c) Copyright 1993, Silicon Graphics, Inc.
' * All RIGHTS RESERVED
' * Permission To use, copy, modify, And distribute this software For
' * Any purpose And without fee is hereby granted, provided that the above
' * copyright notice appear In All copies And that both the copyright notice
' * And this permission notice appear In supporting documentation, And that
' * the Name of Silicon Graphics, Inc. Not be used In advertising
' * Or publicity pertaining To distribution of the software without specific,
' * written prior permission.
' *
' * THE MATERIAL EMBODIED On THIS SOFTWARE IS PROVIDED To YOU "AS-IS"
' * And WITHOUT WARRANTY OF Any KIND, EXPRESS, IMPLIED Or OTHERWISE,
' * INCLUDING WITHOUT LIMITATION, Any WARRANTY OF MERCHANTABILITY Or
' * FITNESS For A PARTICULAR PURPOSE.  In NO EVENT SHALL SILICON
' * GRAPHICS, INC.  BE LIABLE To YOU Or ANYONE Else For Any DIRECT,
' * SPECIAL, INCIDENTAL, INDIRECT Or CONSEQUENTIAL DAMAGES OF Any
' * KIND, Or Any DAMAGES WHATSOEVER, INCLUDING WITHOUT LIMITATION,
' * LOSS OF PROFIT, LOSS OF USE, SAVINGS Or REVENUE, Or THE CLAIMS OF
' * THIRD PARTIES, WHETHER Or Not SILICON GRAPHICS, INC.  HAS BEEN
' * ADVISED OF THE POSSIBILITY OF SUCH LOSS, HOWEVER CAUSED And On
' * Any THEORY OF LIABILITY, ARISING OUT OF Or In CONNECTION With THE
' * POSSESSION, USE Or PERFORMANCE OF THIS SOFTWARE.
' *
' * US Government Users Restricted Rights
' * Use, duplication, Or disclosure by the Government is subject To
' * restrictions Set forth In FAR 52.227.19(c)(2) Or subparagraph
' * (c)(1)(ii) of the Rights In Technical Data And Computer Software
' * clause At DFARS 252.227-7013 And/Or In similar Or successor
' * clauses In the FAR Or the DOD Or NASA FAR Supplement.
' * Unpublished-- rights reserved under the copyright laws of the
' * United States.  Contractor/manufacturer is Silicon Graphics,
' * Inc., 2011 N.  Shoreline Blvd., Mountain View, CA 94039-7311.
' *
' * OpenGL(TM) is a trademark of Silicon Graphics, Inc.
' */

#IF NOT %DEF(%GL_INC)
  #INCLUDE "gl/gl.inc"
#ENDIF

%GLAUX_INC         = 1

%AUX_RGB           = 0
%AUX_RGBA          = %AUX_RGB
%AUX_INDEX         = 1
%AUX_SINGLE        = 0
%AUX_DOUBLE        = 2
%AUX_DIRECT        = 0
%AUX_INDIRECT      = 4

%AUX_ACCUM         = 8
%AUX_ALPHA         = 16
%AUX_DEPTH24       = 32
%AUX_STENCIL       = 64
%AUX_AUX           = 128
%AUX_DEPTH16       = 256
%AUX_FIXED_332_PAL = 512
%AUX_DEPTH         = %AUX_DEPTH16

%AUX_EXPOSE        = 1
%AUX_CONFIG        = 2
%AUX_DRAW          = 4
%AUX_KEYEVENT      = 8
%AUX_MOUSEDOWN     = 16
%AUX_MOUSEUP       = 32
%AUX_MOUSELOC      = 64

%AUX_WINDOWX       = 0
%AUX_WINDOWY       = 1
%AUX_MOUSEX        = 0
%AUX_MOUSEY        = 1
%AUX_MOUSESTATUS   = 3
%AUX_KEY           = 0
%AUX_KEYSTATUS     = 1

%AUX_LEFTBUTTON    = 1
%AUX_RIGHTBUTTON   = 2
%AUX_MIDDLEBUTTON  = 4
%AUX_SHIFT         = 1
%AUX_CONTROL       = 2


%AUX_RETURN        = &H0D
%AUX_ESCAPE        = &H1B
%AUX_SPACE         = &H20
%AUX_LEFT          = &H25
%AUX_UP            = &H26
%AUX_RIGHT         = &H27
%AUX_DOWN          = &H28
$AUX_A             = "A"
$AUX_B             = "B"
$AUX_C             = "C"
$AUX_D             = "D"
$AUX_E             = "E"
$AUX_F             = "F"
$AUX_G             = "G"
$AUX_H             = "H"
$AUX_I             = "I"
$AUX_J             = "J"
$AUX_K             = "K"
$AUX_L             = "L"
$AUX_M             = "M"
$AUX_N             = "N"
$AUX_O             = "O"
$AUX_P             = "P"
$AUX_Q             = "Q"
$AUX_R             = "R"
$AUX_S             = "S"
$AUX_T             = "T"
$AUX_U             = "U"
$AUX_V             = "V"
$AUX_W             = "W"
$AUX_X             = "X"
$AUX_Y             = "Y"
$AUX_Z             = "Z"
$AUX_sa            = "a"
$AUX_sb            = "b"
$AUX_sc            = "c"
$AUX_sd            = "d"
$AUX_se            = "e"
$AUX_sf            = "f"
$AUX_sg            = "g"
$AUX_sh            = "h"
$AUX_si            = "i"
$AUX_sj            = "j"
$AUX_sk            = "k"
$AUX_sl            = "l"
$AUX_sm            = "m"
$AUX_sn            = "n"
$AUX_so            = "o"
$AUX_sp            = "p"
$AUX_sq            = "q"
$AUX_sr            = "r"
$AUX_ss            = "s"
$AUX_st            = "t"
$AUX_su            = "u"
$AUX_sv            = "v"
$AUX_sw            = "w"
$AUX_sx            = "x"
$AUX_sy            = "y"
$AUX_sz            = "z"
$AUX_0             = "0"
$AUX_1             = "1"
$AUX_2             = "2"
$AUX_3             = "3"
$AUX_4             = "4"
$AUX_5             = "5"
$AUX_6             = "6"
$AUX_7             = "7"
$AUX_8             = "8"
$AUX_9             = "9"

%AUX_FD            = 1
%AUX_COLORMAP      = 3
%AUX_GREYSCALEMAP  = 4
%AUX_FOGMAP        = 5
%AUX_ONECOLOR      = 6

%AUX_BLACK         = 0
%AUX_RED           = 13
%AUX_GREEN         = 14
%AUX_YELLOW        = 15
%AUX_BLUE          = 16
%AUX_MAGENTA       = 17
%AUX_CYAN          = 18
%AUX_WHITE         = 19


'enum {
'    AUX_USE_ID = 1,
'    AUX_EXACT_MATCH,
'    'AUX_MINIMUM_CRITERIA
'};

%AUX_USE_ID = 1 ' ?
%AUX_EXACT_MATCH = 2 ' ?
%AUX_MINIMUM_CRITERIA = 3 ' ?

TYPE AUX_EVENTREC
  event    AS LONG
  ndata(3) AS LONG
END TYPE

TYPE AUX_RGBImageRec
  sizeX AS LONG
  sizeY AS LONG
  nData AS LONG PTR
END TYPE


DECLARE SUB auxInitDisplayMode           LIB "pbglaux.dll" ALIAS "auxInitDisplayMode"       (BYVAL a AS DWORD)
DECLARE SUB auxInitPosition              LIB "pbglaux.dll" ALIAS "auxInitPosition"          (BYVAL a AS LONG, BYVAL b AS LONG, BYVAL c AS LONG, BYVAL d AS LONG)
DECLARE FUNCTION auxInitWindow           LIB "pbglaux.dll" ALIAS "auxInitWindowA"           (a AS ASCIIZ) AS DWORD
DECLARE SUB auxCloseWindow               LIB "pbglaux.dll" ALIAS "auxCloseWindow"           ()
DECLARE SUB auxQuit                      LIB "pbglaux.dll" ALIAS "auxQuit"                  ()
DECLARE SUB auxSwapBuffers               LIB "pbglaux.dll" ALIAS "auxSwapBuffers"           ()
DECLARE SUB auxMainLoop                  LIB "pbglaux.dll" ALIAS "auxMainLoop"              (BYVAL a AS LONG)
DECLARE SUB auxExposeFunc                LIB "pbglaux.dll" ALIAS "auxExposeFunc"            (BYVAL a AS LONG)
DECLARE SUB auxReshapeFunc               LIB "pbglaux.dll" ALIAS "auxReshapeFunc"           (BYVAL a AS LONG)
DECLARE SUB auxIdleFunc                  LIB "pbglaux.dll" ALIAS "auxIdleFunc"              (BYVAL a AS LONG)
DECLARE SUB auxKeyFunc                   LIB "pbglaux.dll" ALIAS "auxKeyFunc"               (BYVAL a AS LONG, BYVAL b AS LONG)
DECLARE SUB auxMouseFunc                 LIB "pbglaux.dll" ALIAS "auxMouseFunc"             (BYVAL a AS LONG, BYVAL b AS LONG, BYVAL c AS LONG)
DECLARE FUNCTION auxGetColorMapSize      LIB "pbglaux.dll" ALIAS "auxGetColorMapSize"       () AS LONG
DECLARE SUB auxGetMouseLoc               LIB "pbglaux.dll" ALIAS "auxGetMouseLoc"           (a AS LONG, b AS LONG)
DECLARE SUB auxSetOneColor               LIB "pbglaux.dll" ALIAS "auxSetOneColor"           (BYVAL a AS LONG, BYVAL b AS SINGLE, BYVAL c AS SINGLE, BYVAL d AS SINGLE)
DECLARE SUB auxSetFogRamp                LIB "pbglaux.dll" ALIAS "auxSetFogRamp"            (BYVAL a AS LONG, BYVAL b AS LONG)
DECLARE SUB auxSetGreyRamp               LIB "pbglaux.dll" ALIAS "auxSetGreyRamp"           ()
DECLARE SUB auxSetRGBMap                 LIB "pbglaux.dll" ALIAS "auxSetRGBMap"             (BYVAL a AS LONG, b AS SINGLE)
DECLARE FUNCTION auxRGBImageLoad         LIB "pbglaux.dll" ALIAS "auxRGBImageLoadA"         (a AS ASCIIZ * 100) AS LONG
DECLARE FUNCTION auxDIBImageLoad         LIB "pbglaux.dll" ALIAS "auxDIBImageLoadA"         (a AS ASCIIZ * 100) AS LONG
DECLARE SUB auxCreateFont                LIB "pbglaux.dll" ALIAS "auxCreateFont"            ()
DECLARE SUB auxDrawStr                   LIB "pbglaux.dll" ALIAS "auxDrawStrA"              (a AS ASCIIZ)
DECLARE SUB auxWireSphere                LIB "pbglaux.dll" ALIAS "auxWireSphere"            (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidSphere               LIB "pbglaux.dll" ALIAS "auxSolidSphere"           (BYVAL a AS DOUBLE)
DECLARE SUB auxWireCube                  LIB "pbglaux.dll" ALIAS "auxWireCube"              (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidCube                 LIB "pbglaux.dll" ALIAS "auxSolidCube"             (BYVAL a AS DOUBLE)
DECLARE SUB auxWireBox                   LIB "pbglaux.dll" ALIAS "auxWireBox"               (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE, BYVAL c AS DOUBLE)
DECLARE SUB auxSolidBox                  LIB "pbglaux.dll" ALIAS "auxSolidBox"              (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE, BYVAL c AS DOUBLE)
DECLARE SUB auxWireTorus                 LIB "pbglaux.dll" ALIAS "auxWireTorus"             (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE)
DECLARE SUB auxSolidTorus                LIB "pbglaux.dll" ALIAS "auxSolidTorus"            (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE)
DECLARE SUB auxWireCylinder              LIB "pbglaux.dll" ALIAS "auxWireCylinder"          (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE)
DECLARE SUB auxSolidCylinder             LIB "pbglaux.dll" ALIAS "auxSolidCylinder"         (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE)
DECLARE SUB auxWireIcosahedron           LIB "pbglaux.dll" ALIAS "auxWireIcosahedron"       (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidIcosahedron          LIB "pbglaux.dll" ALIAS "auxSolidIcosahedron"      (BYVAL a AS DOUBLE)
DECLARE SUB auxWireOctahedron            LIB "pbglaux.dll" ALIAS "auxWireOctahedron"        (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidOctahedron           LIB "pbglaux.dll" ALIAS "auxSolidOctahedron"       (BYVAL a AS DOUBLE)
DECLARE SUB auxWireTetrahedron           LIB "pbglaux.dll" ALIAS "auxWireTetrahedron"       (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidTetrahedron          LIB "pbglaux.dll" ALIAS "auxSolidTetrahedron"      (BYVAL a AS DOUBLE)
DECLARE SUB auxWireDodecahedron          LIB "pbglaux.dll" ALIAS "auxWireDodecahedron"      (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidDodecahedron         LIB "pbglaux.dll" ALIAS "auxSolidDodecahedron"     (BYVAL a AS DOUBLE)
DECLARE SUB auxWireCone                  LIB "pbglaux.dll" ALIAS "auxWireCone"              (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE)
DECLARE SUB auxSolidCone                 LIB "pbglaux.dll" ALIAS "auxSolidCone"             (BYVAL a AS DOUBLE, BYVAL b AS DOUBLE)
DECLARE SUB auxWireTeapot                LIB "pbglaux.dll" ALIAS "auxWireTeapot"            (BYVAL a AS DOUBLE)
DECLARE SUB auxSolidTeapot               LIB "pbglaux.dll" ALIAS "auxSolidTeapot"           (BYVAL a AS DOUBLE)
DECLARE FUNCTION auxGetHWND              LIB "pbglaux.dll" ALIAS "auxGetHWND"               () AS LONG
DECLARE FUNCTION auxGetHDC               LIB "pbglaux.dll" ALIAS "auxGetHDC"                () AS LONG
DECLARE FUNCTION auxGetHGLRC             LIB "pbglaux.dll" ALIAS "auxGetHGLRC"              () AS LONG
DECLARE SUB auxInitDisplayModePolicy     LIB "pbglaux.dll" ALIAS "auxInitDisplayModePolicy" (BYVAL a AS DWORD)
DECLARE FUNCTION auxInitDisplayModeID    LIB "pbglaux.dll" ALIAS "auxInitDisplayModeID"     (BYVAL a AS LONG) AS DWORD
DECLARE FUNCTION auxGetDisplayModePolicy LIB "pbglaux.dll" ALIAS "auxGetDisplayModePolicy"  () AS DWORD
DECLARE FUNCTION auxGetDisplayModeID     LIB "pbglaux.dll" ALIAS "auxGetDisplayModeID"      () AS LONG
DECLARE FUNCTION auxGetDisplayMode       LIB "pbglaux.dll" ALIAS "auxGetDisplayMode"        () AS DWORD


FUNCTION AUX_WIND_IS_RGB(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_INDEX) = 0)
END FUNCTION

FUNCTION AUX_WIND_IS_INDEX(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_INDEX) <> 0)
END FUNCTION

FUNCTION AUX_WIND_IS_SINGLE(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_DOUBLE) = 0)
END FUNCTION

FUNCTION AUX_WIND_IS_DOUBLE(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_DOUBLE) <> 0)
END FUNCTION

FUNCTION AUX_WIND_IS_INDIRECT(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_INDIRECT) <> 0)
END FUNCTION

FUNCTION AUX_WIND_IS_DIRECT(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_INDIRECT) = 0)
END FUNCTION

FUNCTION AUX_WIND_HAS_ACCUM(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_ACCUM) <> 0)
END FUNCTION

FUNCTION AUX_WIND_HAS_ALPHA(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_ALPHA) <> 0)
END FUNCTION

FUNCTION AUX_WIND_HAS_DEPTH(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND (%AUX_DEPTH24 OR %AUX_DEPTH16)) <> 0)
END FUNCTION

FUNCTION AUX_WIND_HAS_STENCIL(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_STENCIL) <> 0)
END FUNCTION

FUNCTION AUX_WIND_USES_FIXED_332_PAL(BYVAL x AS LONG) AS LONG
  FUNCTION = ((x AND %AUX_FIXED_332_PAL) <> 0)
END FUNCTION


GLOBAL auxRGBMap() AS SINGLE

FUNCTION AUX_SETCOLOR(BYVAL x AS LONG, BYVAL y AS LONG) AS LONG
  DIM auxRGBMap(19, 2)

  IF AUX_WIND_IS_RGB(x) THEN
    glColor3fv auxRGBMap(y, 0)
  ELSE
    glIndexf y
  END IF
  FUNCTION = 0 ' fvck knows what it should return
END FUNCTION

