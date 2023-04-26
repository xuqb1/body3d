'------------------------------------------------------------------------
'  PBGL.INC -- Part of the OpenGL32 API Includes for PB/DLL 6.0 Release 4
'  [gl.h, glu.h, glaux.h + wgl API]
'  Copyright 1999 sublevel6.
'
'  Release date: Saturday, December 04, 1999
'  Homepage:     -
'  E-Mail:       dinky@pmail.net (to Dinky)
'                angus_law@hotmail.com (to rYme)
'-------------------------------------------------------------

#IF NOT %DEF(%GL_INC)
  $INCLUDE "gl/gl.inc"
#ENDIF

#IF NOT %DEF(%GLU_INC)
  #INCLUDE "gl/glu.inc"
#ENDIF

#IF NOT %DEF(%GLWGL_INC)
  #INCLUDE "gl/glwgl.inc"
#ENDIF

#IF NOT %DEF(%CDS_FULLSCREEN)
  %CDS_FULLSCREEN = 4
#ENDIF

#IF NOT %DEF(%DISP_CHANGE_SUCCESSFUL)
  %DISP_CHANGE_SUCCESSFUL = 0
#ENDIF


FUNCTION pbglSetupPixelFormat(BYVAL hDC AS LONG, BYVAL cColorBits AS LONG) AS LONG
  DIM lpPixelFormat AS PIXELFORMATDESCRIPTOR
  DIM lPixelFormat  AS LONG

  lpPixelFormat.nSize = LEN(lpPixelFormat)
  lpPixelFormat.nVersion = 1
  lpPixelFormat.dwFlags = %PFD_SUPPORT_OPENGL OR %PFD_DRAW_TO_WINDOW OR %PFD_DOUBLEBUFFER
  lpPixelFormat.dwLayerMask = %PFD_MAIN_PLANE
  lpPixelFormat.iPixelType = %PFD_TYPE_RGBA
  lpPixelFormat.cColorBits = cColorBits
  lpPixelFormat.cDepthBits = cColorBits
  lpPixelFormat.cAccumBits = 0
  lpPixelFormat.cStencilBits = 0

  lPixelFormat = ChoosePixelFormat(hDC, lpPixelFormat)

  IF ISFALSE(lPixelFormat) THEN
    FUNCTION = 0
    EXIT FUNCTION
  END IF

  DescribePixelFormat hDC, lPixelFormat, LEN(lpPixelFormat), lpPixelFormat
  SetPixelFormat hDC, lPixelFormat, lpPixelFormat

  FUNCTION = -1
END FUNCTION


SUB pbglResizeViewport(BYVAL lWidth AS LONG, BYVAL lHeight AS LONG, BYVAL zFar AS DOUBLE)
  DIM dAspect AS DOUBLE

  glViewport 0, 0, lWidth, lHeight
  dAspect = lWidth / lHeight

  glMatrixMode %GL_PROJECTION
  glLoadIdentity

  gluPerspective 90 / dAspect, dAspect, 0.1, zFar
  glMatrixMode %GL_MODELVIEW
END SUB


FUNCTION pbglRegisterClass(BYVAL hInstance AS LONG, BYVAL lpWndProc AS LONG, lpClassName AS ASCIIZ) AS LONG
  DIM lpWndClass AS WNDCLASS

  lpWndClass.style         = 0
  lpWndClass.lpfnWndProc   = lpWndProc
  lpWndClass.cbClsExtra    = 0
  lpWndClass.cbWndExtra    = 0
  lpWndClass.hInstance     = hInstance
  lpWndClass.hIcon         = %NULL
  lpWndClass.hCursor       = LoadCursor(%NULL, BYVAL %IDC_ARROW)
  lpWndClass.hbrBackground = GetStockObject(%BLACK_BRUSH)
  lpWndClass.lpszMenuName  = %NULL
  lpWndClass.lpszClassName = VARPTR(lpClassName)

  FUNCTION = RegisterClass(lpWndClass)
END FUNCTION


FUNCTION pbglProcMsg() AS LONG
  DIM lpMsg AS tagMSG

  IF PeekMessage(lpMsg, 0, 0, 0, %PM_NOREMOVE) THEN
    IF GetMessage(lpMsg, 0, 0, 0) THEN
      TranslateMessage lpMsg
      DispatchMessage lpMsg
    ELSE
      FUNCTION = -1
      EXIT FUNCTION
    END IF
  END IF
  FUNCTION = 0
  EXIT FUNCTION
END FUNCTION


FUNCTION pbglSetVideoMode(BYVAL lWidth AS LONG, BYVAL lHeight AS LONG, BYVAL lBpp AS LONG) AS LONG
  DIM lpDevMode AS DEVMODE

  lpDevMode.dmSize = LEN(DEVMODE)
  lpDevMode.dmPelsWidth = lWidth
  lpDevMode.dmPelsHeight = lHeight
  lpDevMode.dmFields = %DM_PELSWIDTH OR %DM_PELSHEIGHT
  IF lBpp THEN
    lpDevMode.dmBitsPerPel = lBpp
    lpDevMode.dmFields = lpDevMode.dmFields OR %DM_BITSPERPEL
  END IF
  FUNCTION = (ChangeDisplaySettings(lpDevMode, %CDS_FULLSCREEN) = %DISP_CHANGE_SUCCESSFUL)
END FUNCTION


SUB pbglRestoreVideoMode()
  ChangeDisplaySettings BYVAL 0, 0
END SUB

