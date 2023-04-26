''
''
'' OpenGL Utility Toolkit -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#IF NOT %DEF(%PB_GLUTinc)
%PB_GLUTinc = 1
DECLARE SUB glutInit LIB "glut32.dll" ALIAS "glutInit" (BYREF argcp AS INTEGER, BYREF argv AS LONG)
DECLARE SUB glutInitDisplayMode LIB "glut32.dll" ALIAS "glutInitDisplayMode" (BYVAL mode AS INTEGER)
DECLARE SUB glutInitDisplayString LIB "glut32.dll" ALIAS "glutInitDisplayString" (BYVAL str AS STRING)
DECLARE SUB glutInitWindowPosition LIB "glut32.dll" ALIAS "glutInitWindowPosition" (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
DECLARE SUB glutInitWindowSize LIB "glut32.dll" ALIAS "glutInitWindowSize" (BYVAL width1 AS INTEGER, BYVAL height AS INTEGER)
DECLARE SUB glutMainLoop LIB "glut32.dll" ALIAS "glutMainLoop" ()
DECLARE FUNCTION glutCreateWindow LIB "glut32.dll" ALIAS "glutCreateWindow" (BYVAL title AS STRING) AS INTEGER
DECLARE FUNCTION glutCreateSubWindow LIB "glut32.dll" ALIAS "glutCreateSubWindow" (BYVAL win AS INTEGER, BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL width1 AS INTEGER, BYVAL height AS INTEGER) AS INTEGER
DECLARE SUB glutDestroyWindow LIB "glut32.dll" ALIAS "glutDestroyWindow" (BYVAL win AS INTEGER)
DECLARE SUB glutPostRedisplay LIB "glut32.dll" ALIAS "glutPostRedisplay" ()
DECLARE SUB glutPostWindowRedisplay LIB "glut32.dll" ALIAS "glutPostWindowRedisplay" (BYVAL win AS INTEGER)
DECLARE SUB glutSwapBuffers LIB "glut32.dll" ALIAS "glutSwapBuffers" ()
DECLARE FUNCTION glutGetWindow LIB "glut32.dll" ALIAS "glutGetWindow" () AS INTEGER
DECLARE SUB glutSetWindow LIB "glut32.dll" ALIAS "glutSetWindow" (BYVAL win AS INTEGER)
DECLARE SUB glutSetWindowTitle LIB "glut32.dll" ALIAS "glutSetWindowTitle" (BYVAL title AS STRING)
DECLARE SUB glutSetIconTitle LIB "glut32.dll" ALIAS "glutSetIconTitle" (BYVAL title AS STRING)
DECLARE SUB glutPositionWindow LIB "glut32.dll" ALIAS "glutPositionWindow" (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
DECLARE SUB glutReshapeWindow LIB "glut32.dll" ALIAS "glutReshapeWindow" (BYVAL width1 AS INTEGER, BYVAL height AS INTEGER)
DECLARE SUB glutPopWindow LIB "glut32.dll" ALIAS "glutPopWindow" ()
DECLARE SUB glutPushWindow LIB "glut32.dll" ALIAS "glutPushWindow" ()
DECLARE SUB glutIconifyWindow LIB "glut32.dll" ALIAS "glutIconifyWindow" ()
DECLARE SUB glutShowWindow LIB "glut32.dll" ALIAS "glutShowWindow" ()
DECLARE SUB glutHideWindow LIB "glut32.dll" ALIAS "glutHideWindow" ()
DECLARE SUB glutFullScreen LIB "glut32.dll" ALIAS "glutFullScreen" ()
DECLARE SUB glutSetCursor LIB "glut32.dll" ALIAS "glutSetCursor" (BYVAL cursor AS INTEGER)
DECLARE SUB glutWarpPointer LIB "glut32.dll" ALIAS "glutWarpPointer" (BYVAL x AS INTEGER, BYVAL y AS INTEGER)
DECLARE SUB glutEstablishOverlay LIB "glut32.dll" ALIAS "glutEstablishOverlay" ()
DECLARE SUB glutRemoveOverlay LIB "glut32.dll" ALIAS "glutRemoveOverlay" ()
DECLARE SUB glutUseLayer LIB "glut32.dll" ALIAS "glutUseLayer" (BYVAL layer AS GLenum)
DECLARE SUB glutPostOverlayRedisplay LIB "glut32.dll" ALIAS "glutPostOverlayRedisplay" ()
DECLARE SUB glutPostWindowOverlayRedisplay LIB "glut32.dll" ALIAS "glutPostWindowOverlayRedisplay" (BYVAL win AS INTEGER)
DECLARE SUB glutShowOverlay LIB "glut32.dll" ALIAS "glutShowOverlay" ()
DECLARE SUB glutHideOverlay LIB "glut32.dll" ALIAS "glutHideOverlay" ()
DECLARE FUNCTION glutCreateMenu LIB "glut32.dll" ALIAS "glutCreateMenu" (BYVAL func AS LONG) AS INTEGER
DECLARE SUB glutDestroyMenu LIB "glut32.dll" ALIAS "glutDestroyMenu" (BYVAL menu1 AS INTEGER)
DECLARE FUNCTION glutGetMenu LIB "glut32.dll" ALIAS "glutGetMenu" () AS INTEGER
DECLARE SUB glutSetMenu LIB "glut32.dll" ALIAS "glutSetMenu" (BYVAL menu1 AS INTEGER)
DECLARE SUB glutAddMenuEntry LIB "glut32.dll" ALIAS "glutAddMenuEntry" (BYVAL LABEL AS STRING, BYVAL value AS INTEGER)
DECLARE SUB glutAddSubMenu LIB "glut32.dll" ALIAS "glutAddSubMenu" (BYVAL LABEL AS STRING, BYVAL submenu AS INTEGER)
DECLARE SUB glutChangeToMenuEntry LIB "glut32.dll" ALIAS "glutChangeToMenuEntry" (BYVAL item AS INTEGER, BYVAL LABEL AS STRING, BYVAL value AS INTEGER)
DECLARE SUB glutChangeToSubMenu LIB "glut32.dll" ALIAS "glutChangeToSubMenu" (BYVAL item AS INTEGER, BYVAL LABEL AS STRING, BYVAL submenu AS INTEGER)
DECLARE SUB glutRemoveMenuItem LIB "glut32.dll" ALIAS "glutRemoveMenuItem" (BYVAL item AS INTEGER)
DECLARE SUB glutAttachMenu LIB "glut32.dll" ALIAS "glutAttachMenu" (BYVAL BUTTON AS INTEGER)
DECLARE SUB glutDetachMenu LIB "glut32.dll" ALIAS "glutDetachMenu" (BYVAL BUTTON AS INTEGER)
DECLARE SUB glutDisplayFunc LIB "glut32.dll" ALIAS "glutDisplayFunc" (BYVAL func AS LONG)
DECLARE SUB glutReshapeFunc LIB "glut32.dll" ALIAS "glutReshapeFunc" (BYVAL func AS LONG)
DECLARE SUB glutKeyboardFunc LIB "glut32.dll" ALIAS "glutKeyboardFunc" (BYVAL func AS LONG)
DECLARE SUB glutMouseFunc LIB "glut32.dll" ALIAS "glutMouseFunc" (BYVAL func AS LONG)
DECLARE SUB glutMotionFunc LIB "glut32.dll" ALIAS "glutMotionFunc" (BYVAL func AS LONG)
DECLARE SUB glutPassiveMotionFunc LIB "glut32.dll" ALIAS "glutPassiveMotionFunc" (BYVAL func AS LONG)
DECLARE SUB glutEntryFunc LIB "glut32.dll" ALIAS "glutEntryFunc" (BYVAL func AS LONG)
DECLARE SUB glutVisibilityFunc LIB "glut32.dll" ALIAS "glutVisibilityFunc" (BYVAL func AS LONG)
DECLARE SUB glutIdleFunc LIB "glut32.dll" ALIAS "glutIdleFunc" (BYVAL func AS LONG)
DECLARE SUB glutTimerFunc LIB "glut32.dll" ALIAS "glutTimerFunc" (BYVAL millis AS INTEGER, BYVAL func AS LONG, BYVAL value AS INTEGER)
DECLARE SUB glutMenuStateFunc LIB "glut32.dll" ALIAS "glutMenuStateFunc" (BYVAL func AS LONG)
DECLARE SUB glutSpecialFunc LIB "glut32.dll" ALIAS "glutSpecialFunc" (BYVAL func AS LONG)
DECLARE SUB glutSpaceballMotionFunc LIB "glut32.dll" ALIAS "glutSpaceballMotionFunc" (BYVAL func AS LONG)
DECLARE SUB glutSpaceballRotateFunc LIB "glut32.dll" ALIAS "glutSpaceballRotateFunc" (BYVAL func AS LONG)
DECLARE SUB glutSpaceballButtonFunc LIB "glut32.dll" ALIAS "glutSpaceballButtonFunc" (BYVAL func AS LONG)
DECLARE SUB glutButtonBoxFunc LIB "glut32.dll" ALIAS "glutButtonBoxFunc" (BYVAL func AS LONG)
DECLARE SUB glutDialsFunc LIB "glut32.dll" ALIAS "glutDialsFunc" (BYVAL func AS LONG)
DECLARE SUB glutTabletMotionFunc LIB "glut32.dll" ALIAS "glutTabletMotionFunc" (BYVAL func AS LONG)
DECLARE SUB glutTabletButtonFunc LIB "glut32.dll" ALIAS "glutTabletButtonFunc" (BYVAL func AS LONG)
DECLARE SUB glutMenuStatusFunc LIB "glut32.dll" ALIAS "glutMenuStatusFunc" (BYVAL func AS LONG)
DECLARE SUB glutOverlayDisplayFunc LIB "glut32.dll" ALIAS "glutOverlayDisplayFunc" (BYVAL func AS LONG)
DECLARE SUB glutWindowStatusFunc LIB "glut32.dll" ALIAS "glutWindowStatusFunc" (BYVAL func AS LONG)
DECLARE SUB glutKeyboardUpFunc LIB "glut32.dll" ALIAS "glutKeyboardUpFunc" (BYVAL func AS LONG)
DECLARE SUB glutSpecialUpFunc LIB "glut32.dll" ALIAS "glutSpecialUpFunc" (BYVAL func AS LONG)
DECLARE SUB glutJoystickFunc LIB "glut32.dll" ALIAS "glutJoystickFunc" (BYVAL func AS LONG, BYVAL pollInterval AS INTEGER)
DECLARE SUB glutSetColor LIB "glut32.dll" ALIAS "glutSetColor" (BYVAL a1 AS INTEGER, BYVAL red AS GLfloat, BYVAL green AS GLfloat, BYVAL blue AS GLfloat)
DECLARE FUNCTION glutGetColor LIB "glut32.dll" ALIAS "glutGetColor" (BYVAL ndx AS INTEGER, BYVAL component1 AS INTEGER) AS GLfloat
DECLARE SUB glutCopyColormap LIB "glut32.dll" ALIAS "glutCopyColormap" (BYVAL win AS INTEGER)
DECLARE FUNCTION glutGet LIB "glut32.dll" ALIAS "glutGet" (BYVAL type1 AS GLenum) AS INTEGER
DECLARE FUNCTION glutDeviceGet LIB "glut32.dll" ALIAS "glutDeviceGet" (BYVAL type1 AS GLenum) AS INTEGER
DECLARE FUNCTION glutExtensionSupported LIB "glut32.dll" ALIAS "glutExtensionSupported" (BYVAL name1 AS STRING) AS INTEGER
DECLARE FUNCTION glutGetModifiers LIB "glut32.dll" ALIAS "glutGetModifiers" () AS INTEGER
DECLARE FUNCTION glutLayerGet LIB "glut32.dll" ALIAS "glutLayerGet" (BYVAL type1 AS GLenum) AS INTEGER
DECLARE SUB glutBitmapCharacter LIB "glut32.dll" ALIAS "glutBitmapCharacter" (BYVAL font1 AS LONG, BYVAL character AS INTEGER)
DECLARE FUNCTION glutBitmapWidth LIB "glut32.dll" ALIAS "glutBitmapWidth" (BYVAL font1 AS LONG, BYVAL character AS INTEGER) AS INTEGER
DECLARE SUB glutStrokeCharacter LIB "glut32.dll" ALIAS "glutStrokeCharacter" (BYVAL font1 AS LONG, BYVAL character AS INTEGER)
DECLARE FUNCTION glutStrokeWidth LIB "glut32.dll" ALIAS "glutStrokeWidth" (BYVAL font1 AS LONG, BYVAL character AS INTEGER) AS INTEGER
DECLARE FUNCTION glutBitmapLength LIB "glut32.dll" ALIAS "glutBitmapLength" (BYVAL font1 AS LONG, BYVAL string1 AS LONG) AS INTEGER
DECLARE FUNCTION glutStrokeLength LIB "glut32.dll" ALIAS "glutStrokeLength" (BYVAL font1 AS LONG, BYVAL string1 AS LONG) AS INTEGER


DECLARE SUB glutWireSphere LIB "glut32.dll" ALIAS "glutWireSphere" (BYVAL radius AS GLdouble, BYVAL slices AS GLint, BYVAL stacks AS GLint)
DECLARE SUB glutSolidSphere LIB "glut32.dll" ALIAS "glutSolidSphere" (BYVAL radius AS GLdouble, BYVAL slices AS GLint, BYVAL stacks AS GLint)
DECLARE SUB glutWireCone LIB "glut32.dll" ALIAS "glutWireCone" (BYVAL base1 AS GLdouble, BYVAL height AS GLdouble, BYVAL slices AS LONG, BYVAL stacks AS LONG)
DECLARE SUB glutSolidCone LIB "glut32.dll" ALIAS "glutSolidCone" (BYVAL base1 AS GLdouble, BYVAL height AS GLdouble, BYVAL slices AS GLint, BYVAL stacks AS GLint)
DECLARE SUB glutWireCube LIB "glut32.dll" ALIAS "glutWireCube" (BYVAL size1 AS GLdouble)
DECLARE SUB glutSolidCube LIB "glut32.dll" ALIAS "glutSolidCube" (BYVAL size1 AS GLdouble)
DECLARE SUB glutWireTorus LIB "glut32.dll" ALIAS "glutWireTorus" (BYVAL innerRadius AS GLdouble, BYVAL outerRadius AS GLdouble, BYVAL sides AS GLint, BYVAL rings AS GLint)
DECLARE SUB glutSolidTorus LIB "glut32.dll" ALIAS "glutSolidTorus" (BYVAL innerRadius AS GLdouble, BYVAL outerRadius AS GLdouble, BYVAL sides AS GLint, BYVAL rings AS GLint)
DECLARE SUB glutWireDodecahedron LIB "glut32.dll" ALIAS "glutWireDodecahedron" ()
DECLARE SUB glutSolidDodecahedron LIB "glut32.dll" ALIAS "glutSolidDodecahedron" ()
DECLARE SUB glutWireTeapot LIB "glut32.dll" ALIAS "glutWireTeapot" (BYVAL SIZE AS GLdouble)
DECLARE SUB glutSolidTeapot LIB "glut32.dll" ALIAS "glutSolidTeapot" (BYVAL SIZE AS GLdouble)
DECLARE SUB glutWireOctahedron LIB "glut32.dll" ALIAS "glutWireOctahedron" ()
DECLARE SUB glutSolidOctahedron LIB "glut32.dll" ALIAS "glutSolidOctahedron" ()
DECLARE SUB glutWireTetrahedron LIB "glut32.dll" ALIAS "glutWireTetrahedron" ()
DECLARE SUB glutSolidTetrahedron LIB "glut32.dll" ALIAS "glutSolidTetrahedron" ()
DECLARE SUB glutWireIcosahedron LIB "glut32.dll" ALIAS "glutWireIcosahedron" ()
DECLARE SUB glutSolidIcosahedron LIB "glut32.dll" ALIAS "glutSolidIcosahedron" ()


DECLARE FUNCTION glutVideoResizeGet LIB "glut32.dll" ALIAS "glutVideoResizeGet" (BYVAL param AS GLenum) AS INTEGER
DECLARE SUB glutSetupVideoResizing LIB "glut32.dll" ALIAS "glutSetupVideoResizing" ()
DECLARE SUB glutStopVideoResizing LIB "glut32.dll" ALIAS "glutStopVideoResizing" ()
DECLARE SUB glutVideoResize LIB "glut32.dll" ALIAS "glutVideoResize" (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL width1 AS INTEGER, BYVAL height AS INTEGER)
DECLARE SUB glutVideoPan LIB "glut32.dll" ALIAS "glutVideoPan" (BYVAL x AS INTEGER, BYVAL y AS INTEGER, BYVAL width1 AS INTEGER, BYVAL height AS INTEGER)
DECLARE SUB glutReportErrors LIB "glut32.dll" ALIAS "glutReportErrors" ()

DECLARE SUB glutIgnoreKeyRepeat LIB "glut32.dll" ALIAS "glutIgnoreKeyRepeat" (BYVAL ignore AS INTEGER)
DECLARE SUB glutSetKeyRepeat LIB "glut32.dll" ALIAS "glutSetKeyRepeat" (BYVAL repeatMode AS INTEGER)
DECLARE SUB glutForceJoystickFunc LIB "glut32.dll" ALIAS "glutForceJoystickFunc" ()

DECLARE SUB glutGameModeString LIB "glut32.dll" ALIAS "glutGameModeString" (BYVAL string1 AS STRING)
DECLARE FUNCTION glutEnterGameMode LIB "glut32.dll" ALIAS "glutEnterGameMode" () AS INTEGER
DECLARE SUB glutLeaveGameMode LIB "glut32.dll" ALIAS "glutLeaveGameMode" ()
DECLARE FUNCTION glutGameModeGet LIB "glut32.dll" ALIAS "glutGameModeGet" (BYVAL mode AS GLenum) AS INTEGER
#ENDIF