'-----------------------------------------------------------------------
'  GLU.INC -- Part of the OpenGL32 API Includes for PB/DLL 6.0 Release 4
'  [gl.h, glu.h, glaux.h + wgl API]
'  Copyright 1999 sublevel6.
'  Portions copyright Silicon Graphics and Microsoft.
'
'  Release date: Saturday, December 04, 1999
'  Homepage:     -
'  E-Mail:       dinky@pmail.net (to Dinky)
'                angus_law@hotmail.com (to rYme)
'-----------------------------------------------------------------------

'/*
'** Copyright 1991-1993, Silicon Graphics, Inc.
'** All Rights Reserved.
'**
'** This is UNPUBLISHED PROPRIETARY SOURCE CODE of Silicon Graphics, Inc.;
'** the contents of this file may not be disclosed to third parties, copied or
'** duplicated in any form, in whole or in part, without the prior written
'** permission of Silicon Graphics, Inc.
'**
'** RESTRICTED RIGHTS LEGEND:
'** Use, duplication or disclosure by the Government is subject to restrictions
'** as set forth in subdivision (c)(1)(ii) of the Rights in Technical Data
'** and Computer Software clause at DFARS 252.227-7013, and/or in similar or
'** successor clauses in the FAR, DOD or NASA FAR Supplement. Unpublished -
'** rights reserved under the Copyright Laws of the United States.
'*/

#IF NOT %DEF(%GL_INC)
  #INCLUDE "gl/gl.inc"
#ENDIF

%GLU_INC                         = 1

%GLU_VERSION_1_1                 = 1
%GLU_VERSION_1_2                 = 1

%GLU_INVALID_ENUM                = 100900
%GLU_INVALID_VALUE               = 100901
%GLU_OUT_OF_MEMORY               = 100902
%GLU_INCOMPATIBLE_GL_VERSION     = 100903

%GLU_VERSION                     = 100800
%GLU_EXTENSIONS                  = 100801

%GLU_TRUE                        = %GL_TRUE
%GLU_FALSE                       = %GL_FALSE

%GLU_SMOOTH                      = 100000
%GLU_FLAT                        = 100001
%GLU_NONE                        = 100002

%GLU_POINT                       = 100010
%GLU_LINE                        = 100011
%GLU_FILL                        = 100012
%GLU_SILHOUETTE                  = 100013

%GLU_OUTSIDE                     = 100020
%GLU_INSIDE                      = 100021

'GLOBAL GLU_TESS_MAX_COORD AS DOUBLE
'GLU_TESS_MAX_COORD              = 1.0e150

%GLU_TESS_WINDING_RULE           = 100140
%GLU_TESS_BOUNDARY_ONLY          = 100141
%GLU_TESS_TOLERANCE              = 100142

%GLU_TESS_WINDING_ODD            = 100130
%GLU_TESS_WINDING_NONZERO        = 100131
%GLU_TESS_WINDING_POSITIVE       = 100132
%GLU_TESS_WINDING_NEGATIVE       = 100133
%GLU_TESS_WINDING_ABS_GEQ_TWO    = 100134

%GLU_TESS_BEGIN                  = 100100
%GLU_TESS_VERTEX                 = 100101
%GLU_TESS_END                    = 100102
%GLU_TESS_ERROR                  = 100103
%GLU_TESS_EDGE_FLAG              = 100104
%GLU_TESS_COMBINE                = 100105

%GLU_TESS_BEGIN_DATA             = 100106

%GLU_TESS_VERTEX_DATA            = 100107

%GLU_TESS_END_DATA               = 100108
%GLU_TESS_ERROR_DATA             = 100109

%GLU_TESS_EDGE_FLAG_DATA         = 100110

%GLU_TESS_COMBINE_DATA           = 100111

%GLU_TESS_ERROR1                 = 100151
%GLU_TESS_ERROR2                 = 100152
%GLU_TESS_ERROR3                 = 100153
%GLU_TESS_ERROR4                 = 100154
%GLU_TESS_ERROR5                 = 100155
%GLU_TESS_ERROR6                 = 100156
%GLU_TESS_ERROR7                 = 100157
%GLU_TESS_ERROR8                 = 100158

%GLU_TESS_MISSING_BEGIN_POLYGON  = %GLU_TESS_ERROR1
%GLU_TESS_MISSING_BEGIN_CONTOUR  = %GLU_TESS_ERROR2
%GLU_TESS_MISSING_END_POLYGON    = %GLU_TESS_ERROR3
%GLU_TESS_MISSING_END_CONTOUR    = %GLU_TESS_ERROR4
%GLU_TESS_COORD_TOO_LARGE        = %GLU_TESS_ERROR5
%GLU_TESS_NEED_COMBINE_CALLBACK  = %GLU_TESS_ERROR6

%GLU_AUTO_LOAD_MATRIX            = 100200
%GLU_CULLING                     = 100201
%GLU_SAMPLING_TOLERANCE          = 100203
%GLU_DISPLAY_MODE                = 100204
%GLU_PARAMETRIC_TOLERANCE        = 100202
%GLU_SAMPLING_METHOD             = 100205
%GLU_U_STEP                      = 100206
%GLU_V_STEP                      = 100207

%GLU_PATH_LENGTH                 = 100215
%GLU_PARAMETRIC_ERROR            = 100216
%GLU_DOMAIN_DISTANCE             = 100217

%GLU_MAP1_TRIM_2                 = 100210
%GLU_MAP1_TRIM_3                 = 100211

%GLU_OUTLINE_POLYGON             = 100240
%GLU_OUTLINE_PATCH               = 100241

%GLU_NURBS_ERROR1                = 100251
%GLU_NURBS_ERROR2                = 100252
%GLU_NURBS_ERROR3                = 100253
%GLU_NURBS_ERROR4                = 100254
%GLU_NURBS_ERROR5                = 100255
%GLU_NURBS_ERROR6                = 100256
%GLU_NURBS_ERROR7                = 100257
%GLU_NURBS_ERROR8                = 100258
%GLU_NURBS_ERROR9                = 100259
%GLU_NURBS_ERROR10               = 100260
%GLU_NURBS_ERROR11               = 100261
%GLU_NURBS_ERROR12               = 100262
%GLU_NURBS_ERROR13               = 100263
%GLU_NURBS_ERROR14               = 100264
%GLU_NURBS_ERROR15               = 100265
%GLU_NURBS_ERROR16               = 100266
%GLU_NURBS_ERROR17               = 100267
%GLU_NURBS_ERROR18               = 100268
%GLU_NURBS_ERROR19               = 100269
%GLU_NURBS_ERROR20               = 100270
%GLU_NURBS_ERROR21               = 100271
%GLU_NURBS_ERROR22               = 100272
%GLU_NURBS_ERROR23               = 100273
%GLU_NURBS_ERROR24               = 100274
%GLU_NURBS_ERROR25               = 100275
%GLU_NURBS_ERROR26               = 100276
%GLU_NURBS_ERROR27               = 100277
%GLU_NURBS_ERROR28               = 100278
%GLU_NURBS_ERROR29               = 100279
%GLU_NURBS_ERROR30               = 100280
%GLU_NURBS_ERROR31               = 100281
%GLU_NURBS_ERROR32               = 100282
%GLU_NURBS_ERROR33               = 100283
%GLU_NURBS_ERROR34               = 100284
%GLU_NURBS_ERROR35               = 100285
%GLU_NURBS_ERROR36               = 100286
%GLU_NURBS_ERROR37               = 100287


%GLU_CW                          = 100120
%GLU_CCW                         = 100121
%GLU_INTERIOR                    = 100122
%GLU_EXTERIOR                    = 100123
%GLU_UNKNOWN                     = 100124

%GLU_BEGIN                       = %GLU_TESS_BEGIN
%GLU_VERTEX                      = %GLU_TESS_VERTEX
%GLU_END                         = %GLU_TESS_END
%GLU_ERROR                       = %GLU_TESS_ERROR
%GLU_EDGE_FLAG                   = %GLU_TESS_EDGE_FLAG


DECLARE FUNCTION gluErrorString      LIB "glu32.dll" ALIAS "gluErrorString"          (BYVAL errCode AS DWORD) AS LONG
DECLARE FUNCTION gluGetString        LIB "glu32.dll" ALIAS "gluGetString"            (BYVAL nname AS DWORD) AS LONG
DECLARE SUB gluOrtho2D               LIB "glu32.dll" ALIAS "gluOrtho2D"              (BYVAL nleft AS DOUBLE, BYVAL nright AS DOUBLE, BYVAL nbottom AS DOUBLE, BYVAL ntop AS DOUBLE)
DECLARE SUB gluPerspective           LIB "glu32.dll" ALIAS "gluPerspective"          (BYVAL fovy AS DOUBLE, BYVAL aspect AS DOUBLE, BYVAL zNear AS DOUBLE, BYVAL zFar AS DOUBLE)
DECLARE SUB gluPickMatrix            LIB "glu32.dll" ALIAS "gluPickMatrix"           (BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, _
      BYVAL nwidth AS DOUBLE, BYVAL nheight AS DOUBLE, viewport AS ANY)
DECLARE SUB gluLookAt                LIB "glu32.dll" ALIAS "gluLookAt"               (BYVAL eyex AS DOUBLE, BYVAL eyey AS DOUBLE, _
      BYVAL eyez AS DOUBLE, BYVAL centerx AS DOUBLE, BYVAL centery AS DOUBLE, BYVAL centerz AS DOUBLE, BYVAL upx AS DOUBLE, _
      BYVAL upy AS DOUBLE, BYVAL upz AS DOUBLE)
DECLARE FUNCTION gluProject          LIB "glu32.dll" ALIAS "gluProject"              (BYVAL objx AS DOUBLE, _
      BYVAL objy AS DOUBLE, BYVAL objz AS DOUBLE, BYVAL modelMatrix AS DOUBLE, BYVAL projMatrix AS DOUBLE, _
      BYVAL viewport AS LONG, winx AS DOUBLE, winy AS DOUBLE, winz AS DOUBLE) AS LONG
DECLARE FUNCTION gluUnProject        LIB "glu32.dll" ALIAS "gluUnProject"            (BYVAL winx AS DOUBLE, _
      BYVAL winy AS DOUBLE, BYVAL winz AS DOUBLE, modelMatrix AS ANY, projMatrix AS ANY, viewport AS ANY, _
      objx AS DOUBLE, objy AS DOUBLE, objz AS DOUBLE) AS LONG
DECLARE FUNCTION gluScaleImage       LIB "glu32.dll" ALIAS "gluScaleImage"           (BYVAL nformat AS DWORD, BYVAL widthin AS LONG, _
      BYVAL heightin AS LONG, BYVAL typein AS DWORD, datain AS ANY, BYVAL widthout AS LONG, BYVAL heightout AS LONG, _
      BYVAL typeout AS DWORD, dataout AS ANY) AS LONG
DECLARE FUNCTION gluBuild1DMipmaps   LIB "glu32.dll" ALIAS "gluBuild1DMipmaps"       (BYVAL ntarget AS DWORD, _
      BYVAL components AS LONG, BYVAL nwidth AS LONG, BYVAL nformat AS DWORD, BYVAL ntype AS DWORD, ndata AS ANY) AS LONG
DECLARE FUNCTION gluBuild2DMipmaps   LIB "glu32.dll" ALIAS "gluBuild2DMipmaps"       (BYVAL ntarget AS DWORD, _
      BYVAL components AS LONG, BYVAL nwidth AS LONG, BYVAL nheight AS LONG, BYVAL nformat AS DWORD, _
      BYVAL ntype AS DWORD, ndata AS ANY) AS LONG
DECLARE FUNCTION gluNewQuadric       LIB "glu32.dll" ALIAS "gluNewQuadric"           () AS LONG
DECLARE SUB gluDeleteQuadric         LIB "glu32.dll" ALIAS "gluDeleteQuadric"        (BYVAL STATE AS ANY)
DECLARE SUB gluQuadricNormals        LIB "glu32.dll" ALIAS "gluQuadricNormals"       (BYVAL quadObject AS ANY, BYVAL normals AS DWORD)
DECLARE SUB gluQuadricTexture        LIB "glu32.dll" ALIAS "gluQuadricTexture"       (BYVAL quadObject AS ANY, textureCoords AS ANY)
DECLARE SUB gluQuadricOrientation    LIB "glu32.dll" ALIAS "gluQuadricOrientation"   (BYVAL quadObject AS ANY, BYVAL ORIENTATION AS DWORD)
DECLARE SUB gluQuadricDrawStyle      LIB "glu32.dll" ALIAS "gluQuadricDrawStyle"     (BYVAL quadObject AS ANY, BYVAL drawStyle AS DWORD)
DECLARE SUB gluCylinder              LIB "glu32.dll" ALIAS "gluCylinder"             (BYVAL qobj AS ANY, BYVAL baseRadius AS DOUBLE, _
      BYVAL topRadius AS DOUBLE, BYVAL nheight AS DOUBLE, BYVAL slices AS LONG, BYVAL stacks AS LONG)
DECLARE SUB gluDisk                  LIB "glu32.dll" ALIAS "gluDisk"                 (BYVAL qobj AS ANY, BYVAL innerRadius AS DOUBLE, _
      BYVAL outerRadius AS DOUBLE, BYVAL slices AS LONG, BYVAL loops AS LONG)
DECLARE SUB gluPartialDisk           LIB "glu32.dll" ALIAS "gluPartialDisk"          (BYVAL qobj AS ANY, BYVAL innerRadius AS DOUBLE, _
      BYVAL outerRadius AS DOUBLE, BYVAL slices AS LONG, BYVAL loops AS LONG, BYVAL startAngle AS DOUBLE, BYVAL sweepAngle AS DOUBLE)
DECLARE SUB gluSphere                LIB "glu32.dll" ALIAS "gluSphere"               (BYVAL qobj AS ANY, BYVAL radius AS DOUBLE, _
      BYVAL slices AS LONG, BYVAL stacks AS LONG)
DECLARE SUB gluQuadricCallback       LIB "glu32.dll" ALIAS "gluQuadricCallback"      (BYVAL qobj AS ANY, BYVAL which AS DWORD, BYVAL nfn AS LONG)
DECLARE FUNCTION gluNewTess          LIB "glu32.dll" ALIAS "gluNewTess"              () AS LONG
DECLARE SUB gluDeleteTess            LIB "glu32.dll" ALIAS "gluDeleteTess"           (BYVAL tess AS ANY)
DECLARE SUB gluTessBeginPolygon      LIB "glu32.dll" ALIAS "gluTessBeginPolygon"     (BYVAL tess AS ANY, polygon_data AS ANY)
DECLARE SUB gluTessBeginContour      LIB "glu32.dll" ALIAS "gluTessBeginContour"     (BYVAL tess AS ANY)
DECLARE SUB gluTessVertex            LIB "glu32.dll" ALIAS "gluTessVertex"           (BYVAL tess AS ANY, coords AS ANY, ndata AS ANY)
DECLARE SUB gluTessEndContour        LIB "glu32.dll" ALIAS "gluTessEndContour"       (BYVAL tess AS ANY)
DECLARE SUB gluTessEndPolygon        LIB "glu32.dll" ALIAS "gluTessEndPolygon"       (BYVAL tess AS ANY)
DECLARE SUB gluTessProperty          LIB "glu32.dll" ALIAS "gluTessProperty"         (BYVAL tess AS ANY, BYVAL which AS DWORD, BYVAL value AS DOUBLE)
DECLARE SUB gluTessNormal            LIB "glu32.dll" ALIAS "gluTessNormal"           (BYVAL tess AS ANY, BYVAL x AS DOUBLE, BYVAL y AS DOUBLE, BYVAL z AS DOUBLE)
DECLARE SUB gluTessCallback          LIB "glu32.dll" ALIAS "gluTessCallback"         (BYVAL tess AS ANY, BYVAL which AS DWORD, BYVAL nfn AS LONG)
DECLARE SUB gluGetTessProperty       LIB "glu32.dll" ALIAS "gluGetTessProperty"      (BYVAL tess AS ANY, BYVAL which AS DWORD, value AS DOUBLE)
DECLARE FUNCTION gluNewNurbsRenderer LIB "glu32.dll" ALIAS "gluNewNurbsRenderer"     () AS LONG
DECLARE SUB gluDeleteNurbsRenderer   LIB "glu32.dll" ALIAS "gluDeleteNurbsRenderer"  (BYVAL nobj AS ANY)
DECLARE SUB gluBeginSurface          LIB "glu32.dll" ALIAS "gluBeginSurface"         (BYVAL nobj AS ANY)
DECLARE SUB gluBeginCurve            LIB "glu32.dll" ALIAS "gluBeginCurve"           (BYVAL nobj AS ANY)
DECLARE SUB gluEndCurve              LIB "glu32.dll" ALIAS "gluEndCurve"             (BYVAL nobj AS ANY)
DECLARE SUB gluEndSurface            LIB "glu32.dll" ALIAS "gluEndSurface"           (BYVAL nobj AS ANY)
DECLARE SUB gluBeginTrim             LIB "glu32.dll" ALIAS "gluBeginTrim"            (BYVAL nobj AS ANY)
DECLARE SUB gluEndTrim               LIB "glu32.dll" ALIAS "gluEndTrim"              (BYVAL nobj AS ANY)
DECLARE SUB gluPwlCurve              LIB "glu32.dll" ALIAS "gluPwlCurve"             (BYVAL nobj AS ANY, BYVAL ncount AS LONG, _
      narray AS ANY, BYVAL stride AS LONG, BYVAL ntype AS DWORD)
DECLARE SUB gluNurbsCurve            LIB "glu32.dll" ALIAS "gluNurbsCurve"           (BYVAL nobj AS ANY, BYVAL nknots AS LONG, _
      knot AS ANY, BYVAL stride AS LONG, ctlarray AS ANY, BYVAL order AS LONG, BYVAL ntype AS DWORD)
DECLARE SUB gluNurbsSurface          LIB "glu32.dll" ALIAS "gluNurbsSurface"         (BYVAL nobj AS ANY, BYVAL sknot_count AS LONG, _
      BYVAL sknot AS LONG PTR, BYVAL tknot_count AS LONG, tknot AS ANY, BYVAL s_stride AS LONG, BYVAL t_stride AS LONG, ctlarray AS ANY, _
      BYVAL sorder AS LONG, BYVAL torder AS LONG, BYVAL ntype AS DWORD)
DECLARE SUB gluLoadSamplingMatrices  LIB "glu32.dll" ALIAS "gluLoadSamplingMatrices" (BYVAL nobj AS ANY, modelMatrix AS ANY, projMatrix AS ANY, viewport AS ANY)
DECLARE SUB gluNurbsProperty         LIB "glu32.dll" ALIAS "gluNurbsProperty"        (BYVAL nobj AS ANY, BYVAL PROPERTY AS DWORD, value AS ANY)
DECLARE SUB gluGetNurbsProperty      LIB "glu32.dll" ALIAS "gluGetNurbsProperty"     (BYVAL nobj AS ANY, BYVAL PROPERTY AS DWORD, value AS ANY)
DECLARE SUB gluNurbsCallback         LIB "glu32.dll" ALIAS "gluNurbsCallback"        (BYVAL nobj AS ANY, BYVAL which AS DWORD, _
      BYVAL nfn AS LONG)
DECLARE SUB gluBeginPolygon          LIB "glu32.dll" ALIAS "gluBeginPolygon"         (BYVAL tess AS ANY)
DECLARE SUB gluNextContour           LIB "glu32.dll" ALIAS "gluNextContour"          (BYVAL tess AS ANY, BYVAL ntype AS DWORD)
DECLARE SUB gluEndPolygon            LIB "glu32.dll" ALIAS "gluEndPolygon"           (BYVAL tess AS ANY)
