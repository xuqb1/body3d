#PBFORMS CREATED
#COMPILE EXE
#IF NOT %DEF(%WINAPI)
    #INCLUDE "win32api.inc"
#ENDIF
#IF NOT %DEF(%PB_GLinc)
    #INCLUDE "gl/gl.inc"
#ENDIF
#IF NOT %DEF(%PB_GLUinc)
    #INCLUDE "gl/glu.inc"
#ENDIF
#INCLUDE "gl/pbglaux.inc"
#IF NOT %DEF(%COMMCTRL_INC)
    #INCLUDE "COMMCTRL.INC"
#ENDIF
%max_vertices=64000-1 '// Max number of vertices (for each object)
%max_polygons=64000-1 '// Max number of polygons (for each object)
%max_textures=64000-1 '// Max number of textures (for each object)
%max_obj=200-1
%sBUFSIZE=256
%FEED_BUFF_SIZE=32768 '为选取时显示选取框做缓冲区大小准备
GLOBAL bRect AS RECT
'// Our vertex type
TYPE vertex_type
  x AS SINGLE
  y AS SINGLE
  z AS SINGLE
  'norm(3) as single
END TYPE

'// The polygon (triangle), 3 numbers that aim 3 vertices
TYPE polygon_type
  a AS LONG
  b AS LONG
  c AS LONG
  flags AS DWORD
END TYPE
'// The mapcoord type, 2 texture coordinates for each vertex
TYPE mapcoord_type
  u AS SINGLE
  v AS SINGLE
END TYPE

'// The object type
TYPE obj_type
  name1(%max_obj) AS ASCIIZ *200   '200
  obj_poly(%max_obj) AS LONG
  prefix AS STRING *400  '196        '338
  vertices_qty AS DWORD
  polygons_qty AS DWORD     '49091
  textures_qty AS DWORD
  vertex(%max_vertices) AS vertex_type
  polygon1(%max_polygons) AS polygon_type
  mapcoord(%max_textures) AS mapcoord_type
  id_texture AS LONG
  '//int id_texture;
END TYPE
#INCLUDE "load3ds.inc"
GLOBAL Obj AS obj_type
'GLOBAL pObj AS obj_type PTR
GLOBAL numObj AS INTEGER
GLOBAL size1 AS INTEGER
GLOBAL test AS INTEGER
GLOBAL glHandle AS LONG
GLOBAL bSelect AS DWORD
GLOBAL SelObject AS DWORD
GLOBAL texture() AS DWORD

TYPE GLPOS                 '为每项选取时，绘制选取框设置信息
  x AS SINGLE 'x坐标
  y AS SINGLE 'y坐标
  z AS SINGLE 'z坐标
  vx AS SINGLE ' x向宽度
  vy AS SINGLE ' y向宽度
  vz AS SINGLE ' z向宽度
  s AS SINGLE  ' 缩放值
END TYPE
TYPE GLCOLOR
  r AS BYTE
  g AS BYTE
  b AS BYTE
END TYPE
'global viewport() as single
GLOBAL itemNum AS INTEGER     '项数
GLOBAL itemObjID() AS INTEGER '每项对应的模型中的ID号=SelObject
GLOBAL itemName() AS STRING   '每项名称，如yhluntai等
GLOBAL itemChName() AS STRING '每项的中文名称
GLOBAL itemSign() AS INTEGER  '项状态标识：1表示正常，显示为绿色，0表示异常，显示为红色
GLOBAL itemStatus() AS STRING '项当前状态：关闭/打开，正常/异常，收起/放下
GLOBAL itemIDC() AS DWORD     '每项对应的窗口中的控件ID
GLOBAL itemGLPOS() AS GLPOS   '每项选取时信息设置
GLOBAL itemColor() AS GLCOLOR
GLOBAL itemHasTrans() AS INTEGER '每项是否已经被变换位置或旋转了:1表示已经改变，0表示未改变
GLOBAL ztianxianLastStatus AS INTEGER '保存左天线最后的状态
GLOBAL ytianxianLastStatus AS INTEGER '保存右天线最后的状态

#IF NOT %DEF(%DDTOPENGL_INC)
%DDTOPENGL_INC=1
%IDC_PIC = 1000
%IDC_LABEL1   = 201
%IDC_LABEL2   = 202
%IDC_LABEL3   = 203
%IDC_LABEL4   = 204
%IDC_LABEL5   = 205
%IDC_LABEL6   = 206

%IDC_QRYTB    = 210
%IDC_QRYBT    = 211
%IDC_RSLIST   = 212


%IDC_MSCTLS_UPDOWN32_1=2001
%IDC_TEXTBOX2_1=2011
%IDC_MSCTLS_UPDOWN32_2=2002
%IDC_TEXTBOX2_2=2012
%IDC_MSCTLS_UPDOWN32_3=2003
%IDC_TEXTBOX2_3=2013
%IDC_MSCTLS_UPDOWN32_4=2004
%IDC_TEXTBOX2_4=2014
%IDC_MSCTLS_UPDOWN32_5=2005
%IDC_TEXTBOX2_5=2015
%IDC_MSCTLS_UPDOWN32_6=2006
%IDC_TEXTBOX2_6=2016

%IDC_CHECKBOX1= 3001 '控制是否自动转动
%IDC_LABEL80 = 3002 '显示帮助
%IDC_DEBUGCKB = 3003 '调试
%IDC_JINGMAILIST = 3004
%IDC_XUEWEILIST  = 3005
%IDC_INFOTB = 3006

GLOBAL logEnabled AS INTEGER
GLOBAL logHandle AS LONG

GLOBAL hPic     AS DWORD 'Handle to the Label (picture,image)
GLOBAL hPicDC   AS DWORD 'Handle to a Device Context
GLOBAL hPicRC   AS DWORD 'Handle to a Rendering Context
GLOBAL Mx,My,Mz AS STRING
GLOBAL Rx,Ry,Rz AS STRING
GLOBAL hWnd     AS DWORD
GLOBAL hImage   AS LONG
GLOBAL DefaultT AS LONG
GLOBAL apt      AS POINTAPI, _
       apt0     AS POINTAPI
GLOBAL rottri AS SINGLE
GLOBAL rotquad AS SINGLE
GLOBAL rot3 AS SINGLE

GLOBAL objfile AS ASCIIZ * 100
GLOBAL textlist AS STRING
GLOBAL defauttext AS STRING

GLOBAL CorX,CorY,CorZ AS STRING '用于调试的坐标位置
'DECLARE FUNCTION hbmpjpg LIB "jpeg.dll" ALIAS "LoadImageFile" (BYVAL hwin AS DWORD,BYVAL fn AS STRING PTR) AS LONG

TYPE xuewei_type
  POS AS vertex_type
  NAME AS STRING * 30
  desc AS STRING * 500
END TYPE
TYPE jingmai_type
  NAME AS STRING * 30
  xueweiNum AS LONG
  xuewei(66) AS xuewei_type
END TYPE
GLOBAL jingmai() AS jingmai_type
GLOBAL jingmaiName() AS STRING
GLOBAL seljingmai AS LONG
GLOBAL selxuewei  AS LONG
GLOBAL jingmaiXuewei() AS STRING

DECLARE FUNCTION load3DS3 LIB "load3DS_chung.dll" ALIAS "load3DS3" (BYVAL object1 AS obj_type PTR,BYVAL ficload AS STRING PTR,BYVAL textlist AS STRING PTR,_
         BYVAL defauttext AS STRING PTR) AS LONG

DECLARE FUNCTION PixelFormatSetup() AS LONG
DECLARE SUB SizeOpenGL(BYVAL dWidth AS DWORD, BYVAL dHeight AS DWORD)
DECLARE FUNCTION InitOpenGL(BYVAL dWidth AS DWORD, BYVAL dHeight AS DWORD) AS LONG

DECLARE SUB RenderOpenGL
DECLARE SUB CloseOpenGL
DECLARE FUNCTION InitDialog(BYVAL hDlg AS DWORD) AS LONG
DECLARE SUB CloseDialog()
DECLARE FUNCTION ShowDialog2() AS LONG
DECLARE CALLBACK FUNCTION DlgProc
DECLARE FUNCTION OpenglCL(BYVAL hWnd AS LONG, BYVAL wMsg AS LONG, _
    BYVAL wParam AS LONG, BYVAL lParam AS LONG) AS LONG

GLOBAL szAppName AS ASCIIZ * 27
GLOBAL hMainDC   AS LONG
GLOBAL PI        AS SINGLE
GLOBAL lpMap()   AS BYTE
GLOBAL dWidth    AS DWORD
GLOBAL dHeight   AS DWORD
GLOBAL CRect     AS RECT
GLOBAL HitDetection AS DWORD
GLOBAL Position1() AS SINGLE
GLOBAL Position2() AS SINGLE
GLOBAL guiwindc0 AS DWORD
FUNCTION PBMAIN()
    ShowDialog2
END FUNCTION
'===========================================================================================================
' 窗口构造并加载物体模型文件
'-----------------------------------------------------------------------------------------------------------
FUNCTION ShowDialog2() AS LONG
'******************************************************************************
    LOCAL COUNT AS LONG
    LOCAL hDlg AS DWORD
    LOCAL t AS DWORD
    LOCAL x1,y1 AS INTEGER
    LOCAL MyMenu AS LONG
    LOCAL p AS LONG
    LOCAL i AS INTEGER
    LOCAL tmpstr AS STRING
    x1=25
    y1=222
    DIALOG NEW %HWND_DESKTOP, "人体经脉穴位 v1.0",165,90, 710, 440,_
            %WS_POPUP OR %WS_SYSMENU OR %WS_DLGFRAME OR %WS_CAPTION OR %WS_SIZEBOX OR _
            %WS_MINIMIZEBOX OR %WS_MAXIMIZEBOX OR %WS_CLIPSIBLINGS OR %WS_CLIPCHILDREN OR _
            %WS_VISIBLE OR %DS_MODALFRAME OR %DS_3DLOOK OR %DS_NOFAILCREATE OR _
            %DS_SETFONT, %WS_EX_WINDOWEDGE OR %WS_EX_CONTROLPARENT , TO hDlg
    'DIALOG SET TEXT hDlg,"OpenGL图形模型"
    hWnd=hDlg
    CONTROL ADD IMAGE, hDlg, %IDC_PIC,"",2,2,230,220, %WS_CHILD OR %WS_VISIBLE OR _
                        %SS_LEFT ,  %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR %WS_EX_LTRREADING OR %WS_EX_STATICEDGE

    CONTROL SET COLOR hDlg,%IDC_PIC,%WHITE,%BLUE
    CONTROL ADD LABEL,   hDlg, %IDC_LABEL1, "移动 X:", x1, y1+2, 25, 15, %WS_CHILD _
                        OR %WS_VISIBLE OR %SS_LEFT, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
                        %WS_EX_LTRREADING
    CONTROL ADD TEXTBOX, hDlg, %IDC_TEXTBOX2_1, "0", x1+25, y1, 20, 15, %WS_CHILD _
                        OR %WS_VISIBLE, %WS_EX_CLIENTEDGE
    CONTROL ADD "msctls_updown32", hDlg, %IDC_MSCTLS_UPDOWN32_1, _
                        "msctls_updown32_1", x1+45, y1, 15, 15,  %WS_CHILD OR %WS_VISIBLE OR _
                        %UDS_SETBUDDYINT OR %UDS_AUTOBUDDY OR %UDS_WRAP
    CONTROL ADD LABEL,   hDlg, %IDC_LABEL2, "Y:", x1+59, y1+2, 6, 15, %WS_CHILD _
                        OR %WS_VISIBLE OR %SS_LEFT, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
                        %WS_EX_LTRREADING
    CONTROL ADD TEXTBOX, hDlg, %IDC_TEXTBOX2_2, "0", x1+65, y1, 20, 15, %WS_CHILD _
                        OR %WS_VISIBLE, %WS_EX_CLIENTEDGE
    CONTROL ADD "msctls_updown32", hDlg, %IDC_MSCTLS_UPDOWN32_2, _
                        "msctls_updown32_2", x1+85, y1, 15, 15,  %WS_CHILD OR %WS_VISIBLE OR _
                        %UDS_SETBUDDYINT OR %UDS_AUTOBUDDY OR %UDS_WRAP

    CONTROL ADD LABEL,   hDlg, %IDC_LABEL3, "Z:", x1+98, Y1+2, 6, 15, %WS_CHILD _
                        OR %WS_VISIBLE OR %SS_LEFT, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
                        %WS_EX_LTRREADING
    CONTROL ADD TEXTBOX, hDlg, %IDC_TEXTBOX2_3, "0", x1+105, y1, 20, 15, %WS_CHILD _
                        OR %WS_VISIBLE, %WS_EX_CLIENTEDGE
    CONTROL ADD "msctls_updown32", hDlg, %IDC_MSCTLS_UPDOWN32_3, _
                        "msctls_updown32_3", x1+125, y1, 15, 15,  %WS_CHILD OR %WS_VISIBLE OR _
                        %UDS_SETBUDDYINT OR %UDS_AUTOBUDDY OR %UDS_WRAP
    CONTROL ADD LABEL,   hDlg, %IDC_LABEL4, "旋转 X:", x1, y1+17, 25, 15, %WS_CHILD _
                        OR %WS_VISIBLE OR %SS_LEFT, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
                        %WS_EX_LTRREADING
    CONTROL ADD TEXTBOX, hDlg, %IDC_TEXTBOX2_4, "0", x1+25, y1+15, 20, 15, %WS_CHILD _
                        OR %WS_VISIBLE, %WS_EX_CLIENTEDGE
    CONTROL ADD "msctls_updown32", hDlg, %IDC_MSCTLS_UPDOWN32_4, _
                        "msctls_updown32_4", x1+45, y1+15, 15, 15,  %WS_CHILD OR %WS_VISIBLE OR _
                        %UDS_SETBUDDYINT OR %UDS_AUTOBUDDY OR %UDS_WRAP
    CONTROL ADD LABEL,   hDlg, %IDC_LABEL5, "Y:", x1+59, y1+17, 6, 15, %WS_CHILD _
                        OR %WS_VISIBLE OR %SS_LEFT, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
                        %WS_EX_LTRREADING
    CONTROL ADD TEXTBOX, hDlg, %IDC_TEXTBOX2_5, "0", x1+65, y1+15, 20, 15, %WS_CHILD _
                        OR %WS_VISIBLE, %WS_EX_CLIENTEDGE
    CONTROL ADD "msctls_updown32", hDlg, %IDC_MSCTLS_UPDOWN32_5, _
                        "msctls_updown32_5", x1+85, y1+15, 15, 15,  %WS_CHILD OR %WS_VISIBLE OR _
                        %UDS_SETBUDDYINT OR %UDS_AUTOBUDDY OR %UDS_WRAP
    CONTROL ADD LABEL,   hDlg, %IDC_LABEL6, "Z:", x1+98, y1+17, 6, 15, %WS_CHILD _
                        OR %WS_VISIBLE OR %SS_LEFT, %WS_EX_TRANSPARENT OR %WS_EX_LEFT OR _
                        %WS_EX_LTRREADING
    CONTROL ADD TEXTBOX, hDlg, %IDC_TEXTBOX2_6, "0", x1+105, y1+15, 20, 15, %WS_CHILD _
                        OR %WS_VISIBLE, %WS_EX_CLIENTEDGE
    CONTROL ADD "msctls_updown32", hDlg, %IDC_MSCTLS_UPDOWN32_6, _
                        "msctls_updown32_6", x1+125, y1+15, 15, 15,  %WS_CHILD OR %WS_VISIBLE OR _
                        %UDS_SETBUDDYINT OR %UDS_AUTOBUDDY OR %UDS_WRAP

    CONTROL ADD CHECKBOX,hDlg,%IDC_DEBUGCKB,"调试  ",10,10,55,10,%BS_RIGHT OR %BS_LEFTTEXT
    CONTROL ADD CHECKBOX,hDlg,%IDC_CHECKBOX1,"自动旋转  ",10,10,55,10,%BS_RIGHT OR %BS_LEFTTEXT

    CONTROL SET CHECK hDlg,%IDC_CHECKBOX1,1
    initItem()
    seljingmai = -1
    CONTROL ADD LISTBOX,hDlg,%IDC_JINGMAILIST,jingmaiName(),10,10,130,100,%LBS_NOINTEGRALHEIGHT OR %LBS_NOTIFY OR %WS_TABSTOP OR %WS_VSCROLL,%WS_EX_STATICEDGE
    CONTROL ADD LISTBOX,hDlg,%IDC_XUEWEILIST,,10,10,130,100,%LBS_NOINTEGRALHEIGHT OR %LBS_NOTIFY OR %WS_TABSTOP OR %WS_VSCROLL,%WS_EX_STATICEDGE
    CONTROL ADD TEXTBOX,hDlg,%IDC_QRYTB,"",10,10,105,12,%WS_TABSTOP,%WS_EX_STATICEDGE
    CONTROL ADD BUTTON, hDlg,%IDC_QRYBT,"查询",10,10,23,12
    CONTROL ADD LISTBOX,hDlg,%IDC_RSLIST,,10,10,130,40,%LBS_NOINTEGRALHEIGHT OR %LBS_NOTIFY OR %WS_TABSTOP OR %WS_VSCROLL,%WS_EX_STATICEDGE
    CONTROL ADD TEXTBOX,hDlg,%IDC_INFOTB,"",10,10,130,86,%ES_READONLY OR %ES_MULTILINE OR %WS_TABSTOP OR %WS_VSCROLL,%WS_EX_STATICEDGE
    'tmpstr="选择并切换被监控项状态:  左键单击" & $CRLF & _
    tmpstr= "移动:  左键按下并移动" & $CRLF & _
            "缩放:  前后滚动滚轮" & $CRLF & _
            "XY平面旋转:  右键按下并移动" & $CRLF & _
            "Z向旋转:  滚轮按下并移动"
    CONTROL ADD LABEL, hDlg,%IDC_LABEL80,tmpstr,10,10,130,36 ,,%WS_EX_STATICEDGE


    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_1, %UDM_SETRANGE32, -100  ,100
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_2, %UDM_SETRANGE32, -100  ,100
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_3, %UDM_SETRANGE32, -100  ,100
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_4, %UDM_SETRANGE32, 0     ,359
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_5, %UDM_SETRANGE32, 0     ,359
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_6, %UDM_SETRANGE32, 0     ,359
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_3, %UDM_SETPOS32  , 0     ,-60
    '仅用于调试坐标
'    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_7, %UDM_SETRANGE32, -100  ,100
'    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_8, %UDM_SETRANGE32, -100  ,100
'    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_9, %UDM_SETRANGE32, -100  ,100

    Mz="-60"
    CONTROL SEND hDlg, %IDC_MSCTLS_UPDOWN32_4, %UDM_SETPOS32  ,0,30
    Rx="30"
    Ry="-3"
    objfile="man.3ds"'"truck4-1.3ds"
    IF Exist("man.3ds")=0 THEN
      MSGBOX "模型数据文件不存在",,"提示"
      EXIT FUNCTION
    END IF
    load3DS3(VARPTR(Obj),VARPTR(objfile),VARPTR(textlist),VARPTR(defauttext))
    'Load3DSobj(varptr(Obj),objfile)
    tmpstr=""
    FOR i=0 TO 200
      tmpstr=tmpstr & STR$(i) & ":" & Obj.name1(i) & ","
    NEXT i
    'msgbox tmpstr
    logEnabled=0
    OpenLog("ddtopengl1.log")
    WriteLog(tmpstr)
    closeLog()
    logEnabled=0
    'msgbox tmpstr
    DIALOG SHOW MODELESS hDlg CALL DlgProc
    DO
      DIALOG DOEVENTS TO COUNT
      IF GetTickCount() > t+5??? THEN
          RenderOpenGL
          t=GetTickCount()
      END IF
    LOOP WHILE COUNT
END FUNCTION
'===========================================================================================================
' 窗口回调函数
'-----------------------------------------------------------------------------------------------------------
CALLBACK FUNCTION DlgProc()
'******************************************************************************
    'LOCAL rtn AS LONG
    LOCAL ay1 AS SINGLE
    LOCAL ay2 AS SINGLE
    LOCAL ay AS INTEGER
    LOCAL i AS INTEGER
    LOCAL bx AS INTEGER
    LOCAL tmpstr AS STRING
    LOCAL j AS LONG
    LOCAL tmpLng AS LONG
    SELECT CASE CBMSG
        CASE %WM_INITDIALOG
            IF ISFALSE InitDialog (CBHNDL) THEN
                DIALOG POST CBHNDL,%WM_USER+999,0,0
            END IF
            DIALOG SET ICON CBHNDL, "TBICON"
            DefaultT=SetWindowLong(hPic,%GWL_WNDPROC,CODEPTR(OpenglCL))
            Mx="0":My="0":Mz="-60"
            Rx="30":Ry="0":Rz="0"
            CorX="0":CorY="0":CorZ="0"
        CASE %WM_MOVE
            getwindowrect CBHNDL,CRect
            DIALOG REDRAW CBHNDL
        CASE %WM_SIZE
            LOCAL  ax AS INTEGER
            DIALOG GET CLIENT CB.HNDL TO xx&,yy&
            IF xx&<640 THEN
                xx&=640
                DIALOG SET CLIENT CB.HNDL,xx&,yy&
            END IF
            IF yy&<400 THEN
                yy&=400
                DIALOG SET CLIENT CB.HNDL,xx&,yy&
            END IF
            ax=xx&-140
            bx=xx&-70
            ay1=0.87
            ay2=0.93
            CONTROL SET SIZE CBHNDL,  %IDC_PIC                ,xx&-150 , yy&-4
            '位移
            CONTROL SET LOC CBHNDL,   %IDC_LABEL1             , ax    , 10
            CONTROL SET LOC CBHNDL,   %IDC_TEXTBOX2_1         , ax+26 , 9
            CONTROL SET LOC CBHNDL,   %IDC_MSCTLS_UPDOWN32_1  , ax+46 , 9
            CONTROL SET SIZE CBHNDL,  %IDC_TEXTBOX2_1         , 20    , 10
            CONTROL SET SIZE CBHNDL,  %IDC_MSCTLS_UPDOWN32_1  , 10    , 10
            CONTROL SET LOC CBHNDL,   %IDC_LABEL2             , ax+18 , 22
            CONTROL SET LOC CBHNDL,   %IDC_TEXTBOX2_2         , ax+26 , 21
            CONTROL SET LOC CBHNDL,   %IDC_MSCTLS_UPDOWN32_2  , ax+46 , 21
            CONTROL SET SIZE CBHNDL,  %IDC_TEXTBOX2_2         , 20    , 10
            CONTROL SET SIZE CBHNDL,  %IDC_MSCTLS_UPDOWN32_2  , 10    , 10
            CONTROL SET LOC CBHNDL,   %IDC_LABEL3             , ax+18 , 32
            CONTROL SET LOC CBHNDL,   %IDC_TEXTBOX2_3         , ax+26 , 31
            CONTROL SET LOC CBHNDL,   %IDC_MSCTLS_UPDOWN32_3  , ax+46 , 31
            CONTROL SET SIZE CBHNDL,  %IDC_TEXTBOX2_3         , 20    , 10
            CONTROL SET SIZE CBHNDL,  %IDC_MSCTLS_UPDOWN32_3  , 10    , 10
            '旋转
            CONTROL SET LOC CBHNDL,   %IDC_LABEL4             , bx    , 10
            CONTROL SET LOC CBHNDL,   %IDC_TEXTBOX2_4         , bx+26 , 9
            CONTROL SET LOC CBHNDL,   %IDC_MSCTLS_UPDOWN32_4  , bx+46 , 9
            CONTROL SET SIZE CBHNDL,  %IDC_TEXTBOX2_4         , 20    , 10
            CONTROL SET SIZE CBHNDL,  %IDC_MSCTLS_UPDOWN32_4  , 10    , 10
            CONTROL SET LOC CBHNDL,   %IDC_LABEL5             , bx+18 , 22
            CONTROL SET LOC CBHNDL,   %IDC_TEXTBOX2_5         , bx+26 , 21
            CONTROL SET LOC CBHNDL,   %IDC_MSCTLS_UPDOWN32_5  , bx+46 , 21
            CONTROL SET SIZE CBHNDL,  %IDC_TEXTBOX2_5         , 20    , 10
            CONTROL SET SIZE CBHNDL,  %IDC_MSCTLS_UPDOWN32_5  , 10    , 10
            CONTROL SET LOC CBHNDL,   %IDC_LABEL6             , bx+18 , 34
            CONTROL SET LOC CBHNDL,   %IDC_TEXTBOX2_6         , bx+26 , 33
            CONTROL SET LOC CBHNDL,   %IDC_MSCTLS_UPDOWN32_6  , bx+46 , 33
            CONTROL SET SIZE CBHNDL,  %IDC_TEXTBOX2_6         , 20    , 10
            CONTROL SET SIZE CBHNDL,  %IDC_MSCTLS_UPDOWN32_6  , 10    , 10
            CONTROL SET LOC CBHNDL,   %IDC_DEBUGCKB           , ax    , 48
            CONTROL SET LOC CBHNDL,   %IDC_CHECKBOX1          , bx-4  , 48
            CONTROL SET LOC CBHNDL,   %IDC_JINGMAILIST        , ax    , 62
            CONTROL SET LOC CBHNDL,   %IDC_XUEWEILIST         , ax    , 164
            CONTROL SET LOC CBHNDL,   %IDC_QRYTB              , ax    , 266
            CONTROL SET LOC CBHNDL,   %IDC_QRYBT              , ax+107, 266
            CONTROL SET LOC CBHNDL,   %IDC_RSLIST             , ax    , 280
            CONTROL SET LOC CBHNDL,   %IDC_INFOTB             , ax    , 322
            CONTROL SET SIZE CBHNDL,  %IDC_INFOTB             , 130   , yy& - 365


            '右下角帮助提示信息
            CONTROL SET LOC CB.HNDL,%IDC_LABEL80,xx&-140,yy&-38
            InitDialog CBHNDL
            DIALOG REDRAW CBHNDL
        CASE %WM_USER+999
            MSGBOX "初始化失败！",%MB_ICONERROR,"提示信息"
            DIALOG END CB.HNDL,0
'        CASE %WM_CLOSE
'            CloseDialog
        CASE %WM_DESTROY
            wndshutdown (CB.HNDL,hPicDC,hPicRC)
        CASE %WM_COMMAND
          IF CB.CTLMSG<>%LBN_SELCHANGE AND CB.CTLMSG<>%BN_CLICKED THEN
            EXIT FUNCTION
          END IF
            SELECT CASE AS LONG CB.CTL
              CASE %IDC_JINGMAILIST
                LISTBOX RESET CB.HNDL,%IDC_XUEWEILIST
                CONTROL SET TEXT CB.HNDL,%IDC_INFOTB,""
                selxuewei=-1
                LISTBOX GET TEXT CB.HNDL,%IDC_JINGMAILIST TO tmpstr
                FOR i=0 TO UBOUND(jingmaiName())
                  IF tmpstr=jingmaiName(i) THEN
                    seljingmai = i
                    EXIT FOR
                  END IF
                NEXT i
                IF i<=UBOUND(jingmaiName()) THEN
                  FOR j=0 TO jingmai(i).xueweiNum-1
                    LISTBOX ADD CB.HNDL,%IDC_XUEWEILIST,TRIM$(jingmai(i).xuewei(j).NAME)
                  NEXT j
                END IF
              CASE %IDC_XUEWEILIST
                LISTBOX GET SELECT CB.HNDL,%IDC_XUEWEILIST TO selxuewei
                selxuewei = selxuewei-1
                IF selxuewei<0 THEN EXIT FUNCTION
                CONTROL SET TEXT CB.HNDL,%IDC_INFOTB,TRIM$(jingmai(seljingmai).xuewei(selxuewei).NAME) & $CRLF & TRIM$(jingmai(seljingmai).xuewei(selxuewei).desc)
              CASE %IDC_RSLIST
                LISTBOX GET TEXT CB.HNDL,%IDC_RSLIST TO tmpstr
                tmpstr=TRIM$(tmpstr)
                IF tmpstr="" THEN
                  EXIT FUNCTION
                END IF
                tmpstr=PARSE$(tmpstr,",",2)
                tmpstr=TRIM$(tmpstr)
                IF tmpstr="" THEN
                  EXIT FUNCTION
                END IF
                FOR i=0 TO UBOUND(jingmai())
                  IF tmpstr=TRIM$(jingmai(i).NAME) THEN
                    CONTROL SEND CB.HNDL,%IDC_JINGMAILIST,%LB_SETCURSEL ,1,i
                    DIALOG SEND CB.HNDL,%WM_COMMAND,%IDC_JINGMAILIST,%LBN_SELCHANGE
                    'SendMessage(CB.HNDL,%WM_COMMAND,%IDC_JINGMAILIST,%LBN_SELCHANGE)
                    EXIT FOR
                  END IF
                NEXT i
              CASE %IDC_QRYBT
                LISTBOX RESET CB.HNDL,%IDC_RSLIST
                CONTROL GET TEXT CB.HNDL,%IDC_QRYTB TO tmpstr
                tmpstr=TRIM$(tmpstr)
                IF tmpstr="" THEN
                  MSGBOX "请输入要查询的穴位名称",,"提示"
                  EXIT FUNCTION
                END IF
                FOR i=0 TO UBOUND(jingmaiXuewei())
                  IF INSTR(PARSE$(jingmaiXuewei(i),",",1),tmpstr)>0 THEN
                    LISTBOX ADD CB.HNDL,%IDC_RSLIST,jingmaiXuewei(i)
                  END IF
                NEXT i
                LISTBOX GET COUNT CB.HNDL,%IDC_RSLIST TO tmpLng
                IF tmpLng<=0 THEN
                  MSGBOX "未找到要查询的穴位",,"提示"
                END IF
              CASE %IDC_TextBox2_1
                  CONTROL GET TEXT hWnd,%IDC_TextBox2_1 TO Mx
              CASE %IDC_TextBox2_2
                  CONTROL GET TEXT hWnd,%IDC_TextBox2_2 TO My
              CASE %IDC_TextBox2_3
                  CONTROL GET TEXT hWnd,%IDC_TextBox2_3 TO Mz
              CASE %IDC_TextBox2_4
                  CONTROL GET TEXT hWnd,%IDC_TextBox2_4 TO Rx
              CASE %IDC_TextBox2_5
                  CONTROL GET TEXT hWnd,%IDC_TextBox2_5 TO Ry
              CASE %IDC_TextBox2_6
                  CONTROL GET TEXT hWnd,%IDC_TextBox2_6 TO Rz
                '仅用于调试坐标
'                CASE %IDC_TextBox2_7
'                    CONTROL GET TEXT hWnd,%IDC_TextBox2_7 TO CorX
'                CASE %IDC_TextBox2_8
'                    CONTROL GET TEXT hWnd,%IDC_TextBox2_8 TO CorY
'                CASE %IDC_TextBox2_9
'                    CONTROL GET TEXT hWnd,%IDC_TextBox2_9 TO CorZ
              CASE %IDCANCEL
                DIALOG END CB.HNDL,0
            END SELECT
    END SELECT
END FUNCTION

FUNCTION initItem() AS LONG
  LOCAL fn AS LONG
  LOCAL tmpstr AS STRING
  LOCAL lineStr AS STRING
  LOCAL tmpLng AS LONG
  LOCAL jingmaiNum AS LONG
  LOCAL xueweiNum AS LONG
  LOCAL i AS LONG
  'msgbox exe.path$ + "xwsj.txt" & $crlf & str$(isfile(exe.path$ & "xwsj.txt"))
  IF ISFILE(EXE.PATH$ + "xwsj.txt")=0 THEN
    MSGBOX "穴位数据文件不存在",,"提示"
    EXIT FUNCTION
  END IF
  fn=FREEFILE
  OPEN EXE.PATH$ + "xwsj.txt" FOR INPUT AS #fn
  WHILE ISFALSE EOF(#fn)
    LINE INPUT #fn,lineStr
    tmpstr = tmpstr & lineStr & $CRLF
  WEND
  CLOSE #fn
  IF RIGHT$(tmpstr,2)=$CRLF THEN
    tmpstr=MID$(tmpstr,1,LEN(tmpstr)-2)
  END IF
  tmpLng=PARSECOUNT(tmpstr,$CRLF)
  REDIM jingmaiName(tmpLng-1)
  REDIM jingmai(tmpLng-1)
  REDIM jingmaiXuewei(tmpLng-1)
  jingmaiNum=0
  xueweiNum=0
  'msgbox str$(tmpLng)
  FOR i=0 TO tmpLng-1
    lineStr=PARSE$(tmpstr,$CRLF,i+1)
    'msgbox lineStr
    IF i>0 THEN
      IF PARSE$(lineStr," ",13)<>TRIM$(jingmaiName(jingmaiNum)) THEN
        'msgbox "test"
        jingmai(jingmaiNum).xueweiNum = xueweiNum
        xueweiNum=0
        INCR jingmaiNum
      END IF
    END IF
    jingmaiName(jingmaiNum)=PARSE$(lineStr," ",13)
    jingmai(jingmaiNum).NAME=PARSE$(lineStr," ",13)
    jingmai(jingmaiNum).xuewei(xueweiNum).pos.x=VAL(PARSE$(lineStr," ",1))
    jingmai(jingmaiNum).xuewei(xueweiNum).pos.y=VAL(PARSE$(lineStr," ",2))
    jingmai(jingmaiNum).xuewei(xueweiNum).pos.z=VAL(PARSE$(lineStr," ",3))
    jingmai(jingmaiNum).xuewei(xueweiNum).NAME=PARSE$(lineStr," ",11)
    jingmai(jingmaiNum).xuewei(xueweiNum).desc=PARSE$(lineStr," ",14) & $CRLF & PARSE$(lineStr," ",15) & $CRLF & PARSE$(lineStr," ",16)
    INCR xueweiNum
    jingmaiXuewei(i)=PARSE$(lineStr," ",11) & "," & PARSE$(lineStr," ",13)
  NEXT i
  jingmai(jingmaiNum).xueweiNum=xueweiNum-1
  REDIM PRESERVE jingmaiName(jingmaiNum)
  REDIM PRESERVE jingmai(jingmaiNum)
END FUNCTION
'===========================================================================================================
' 判断文件是否存在
'-----------------------------------------------------------------------------------------------------------
FUNCTION Exist(sFilename AS STRING) AS LONG
    ' Checks to see if a given disk file exists
    LOCAL    dummy              AS LONG
    dummy = GETATTR(sFilename)
    FUNCTION = (ERRCLEAR = 0)
END FUNCTION
'===========================================================================================================
' 打开日志文件
'-----------------------------------------------------------------------------------------------------------
SUB OpenLog(fname AS STRING)
    ' Attempts to either create a new log file or open the existing one
    IF logEnabled THEN CloseLog
    logHandle = FREEFILE
    OPEN fname FOR APPEND AS #logHandle
    IF ERRCLEAR THEN EXIT SUB
    PRINT #logHandle, STRING$(65, "=")
    PRINT #logHandle, "Log begins at " + TIME$ + " " + DATE$
    PRINT #logHandle, STRING$(65, "-")
    logEnabled = 1
END SUB
'===========================================================================================================
' 写日志文件
'-----------------------------------------------------------------------------------------------------------
SUB WriteLog(entry AS STRING)
    IF logEnabled THEN PRINT #logHandle, entry
END SUB
'-----------------------------------------------------------------------------------------------------------
'===========================================================================================================
' 关闭日志文件
'-----------------------------------------------------------------------------------------------------------
SUB CloseLog()
    IF logEnabled THEN
        PRINT #logHandle, STRING$(65, "-")
        PRINT #logHandle, "Log ends at " + TIME$ + " " + DATE$
        PRINT #logHandle, STRING$(65, "=")
        PRINT #logHandle,
        logEnabled = 0
    END IF
    CLOSE #logHandle
END SUB
'===========================================================================================================
' 设置象素格式
'-----------------------------------------------------------------------------------------------------------
FUNCTION PixelFormatSetup() AS LONG
'******************************************************************************
  LOCAL pfd AS PIXELFORMATDESCRIPTOR
  LOCAL PixelFormat AS LONG
  pfd.nSize = SIZEOF(PIXELFORMATDESCRIPTOR)
  pfd.nVersion = 1
  pfd.dwFlags = %PFD_DRAW_TO_WINDOW OR %PFD_SUPPORT_OPENGL OR %PFD_DOUBLEBUFFER
  pfd.dwLayerMask = %PFD_MAIN_PLANE
  pfd.iPixelType = %PFD_TYPE_RGBA
  pfd.cCOLORBits = 32
  pfd.cDepthBits = 24
  pfd.cAccumBits = 0
  pfd.cStencilBits = 0
  PixelFormat = ChoosePixelFormat(hPicDC , pfd)
  IF PixelFormat THEN
    IF SetPixelFormat(hPicDC, PixelFormat, pfd) THEN
      FUNCTION = %True
      EXIT FUNCTION
    END IF
  END IF
  FUNCTION = %False
END FUNCTION
'===========================================================================================================
' 重设OpenGL视窗尺寸
'-----------------------------------------------------------------------------------------------------------
SUB SizeOpenGL(BYVAL dWidth AS DWORD, BYVAL dHeight AS DWORD)
'******************************************************************************
  IF dHeight = 0 THEN dHeight = 1
  glMatrixMode %GL_MODELVIEW
  glViewport 0,0,dWidth,dHeight
  glMatrixMode %GL_PROJECTION
  glLoadIdentity
  gluPerspective 45.0,dWidth/dHeight,0.1,150.0
  glMatrixMode %GL_MODELVIEW
  glOrtho -dWidth/2,dHeight/2,-dWidth/2,dHeight/2,100,-100
  'lighting()
  glLoadIdentity
END SUB
'===========================================================================================================
' 初始化OpenGL
'-----------------------------------------------------------------------------------------------------------
FUNCTION InitOpenGL(BYVAL dWidth AS DWORD, BYVAL dHeight AS DWORD) AS LONG
'******************************************************************************
  IF PixelFormatSetup() THEN
    hPicRC = wglCreateContext (hPicDC)
    IF hPicRC THEN
      wglMakeCurrent hPicDC, hPicRC
      LoadGLTextures
      Graphics()
      glEnable %GL_DEPTH_RANGE
      SizeOpenGL dWidth, dHeight
      FUNCTION = %True
      EXIT FUNCTION
    END IF
  END IF
  FUNCTION = %False
END FUNCTION
'===========================================================================================================
' 灯光设置
'-----------------------------------------------------------------------------------------------------------
SUB lighting()
  DIM Ambient(4)       AS SINGLE
  DIM Diffuse(4)       AS SINGLE
  DIM Specular(4)       AS SINGLE
  'DIM Position(4)      AS SINGLE
  DIM Attenuation(4)   AS SINGLE
  REDIM Position1(4)
  REDIM position2(4)
  glLightModeli(%GL_LIGHT_MODEL_LOCAL_VIEWER, %GL_TRUE)
  DIM b AS LOCAL SINGLE: b=1.0'0.2   ' ambient level
  DIM d AS LOCAL SINGLE: d=0.8   ' diffuse level
  DIM s AS LOCAL SINGLE: s=1.0   ' specular level
  DIM a AS LOCAL SINGLE: a=0.1 ' attenuation
  Ambient(0)  = b : Ambient(1)  = b : Ambient(2)  = b : Ambient(3)  = 1.0
  Diffuse(0)  = d : Diffuse(1)  = d : Diffuse(2)  = d : Diffuse(3)  = 1.0
  Specular(0) = s : Specular(1) = s : Specular(2) = s : Specular(3) = 1.0
  Attenuation(0)=a
  Position1(0) = -30.0 : Position1(1) = 30.0 : Position1(2) = -30.0 : Position1(3) = 1.0 '
  glLightfv %GL_LIGHT1, %GL_DIFFUSE,  VARPTR(Diffuse(0))
  glLightfv %GL_LIGHT1, %GL_POSITION, VARPTR(Position1(0))
  glEnable %GL_LIGHT1
  Position2(0) = 0.0 : Position2(1) = 0.0 : Position2(2) = 1 : Position2(3) = 1.0
  glLightfv %GL_LIGHT2, %GL_DIFFUSE,  VARPTR(Diffuse(0))
  glLightfv %GL_LIGHT2, %GL_SPECULAR, VARPTR(Specular(0))
  glLightfv %GL_LIGHT2, %GL_POSITION, VARPTR(Position2(0))
  glLightfv %GL_LIGHT2, %GL_LINEAR_ATTENUATION, VARPTR(Attenuation(0))
  glEnable %GL_LIGHT2
END SUB
'===========================================================================================================
' 程序退出前销毁各对象
'-----------------------------------------------------------------------------------------------------------
SUB wndshutdown(hWnd AS DWORD,hDC AS DWORD,hRC AS DWORD)
  CLOSE
  wglMakeCurrent hDC, %NULL
  wglDeleteContext hRC
  ReleaseDC hWnd,hDC
  glDeleteLists 1000, 255
  KillTimer hWnd,1
  ChangeDisplaySettings BYVAL %NULL,0
  PostQuitMessage 0
END SUB
FUNCTION DrawSphere(BYVAL radius AS SINGLE)AS LONG
  LOCAL pObj AS LONG 'GLUquadricObj ptr
  pObj = gluNewQuadric()
  gluQuadricNormals(pObj, %GLU_SMOOTH)
  gluSphere(pObj, radius, 26, 13)
  gluDeleteQuadric(pObj)
END FUNCTION
SUB indicate_object (s AS SINGLE)
  glPushMatrix
  glLineWidth 3
  glBegin %GL_LINES
  glColor3f 0.8,0.8,0.8
  glVertex3f  -s,0,0
  glVertex3f   s,0,0
  glEnd
  glBegin %GL_LINES
  glColor3f 0.9,0.9,0.9
  glVertex3f  0,-s,0
  glVertex3f  0, s,0
  glEnd
  glBegin %GL_LINES
  glColor3f 0.8,0.8,0.8
  glVertex3f  0,0,-s
  glVertex3f  0,0, s
  glEnd
  glPopMatrix
END SUB
'**********************************
FUNCTION firstWordc(BYVAL t$)AS STRING
  LOCAL tmpstr AS STRING
  tmpstr=TRIM$(t$)
  tmpstr=tmpstr & " "
  tmpstr=MID$(tmpstr,1,INSTR(tmpstr," "))
  FUNCTION=tmpstr
END FUNCTION
FUNCTION nextWordc(BYVAL t$) AS STRING
  LOCAL tmpstr AS STRING
  tmpstr=TRIM$(t$)
  tmpstr=MID$(tmpstr,INSTR(tmpstr," "))
  tmpstr=TRIM$(tmpstr)
  tmpstr=" " & tmpstr & " "
  FUNCTION=tmpstr
END FUNCTION
'绘制经脉
FUNCTION drawJingmai(BYVAL kk AS SINGLE)AS DWORD
  LOCAL i AS LONG
  LOCAL qobj AS DWORD
  IF seljingmai<0 OR seljingmai>UBOUND(jingmaiName()) THEN
    EXIT FUNCTION
  END IF
  glRotatef -180,1,0,0
  glColor3f 1,0,0
  FOR i=0 TO jingmai(seljingmai).xueweiNum-1
    glPushMatrix
    glTranslatef jingmai(seljingmai).xuewei(i).pos.x*kk, jingmai(seljingmai).xuewei(i).pos.z*kk,-jingmai(seljingmai).xuewei(i).pos.y*kk
    IF i=0 OR i=jingmai(seljingmai).xueweiNum-1 THEN
      glColor3f 0,1,0
    END IF
    IF selxuewei>=0 AND selxuewei=i THEN
      glColor3f 1,1,0
    END IF
    DrawSphere(0.1)
    IF selxuewei>=0 AND selxuewei=i THEN
      glColor3f 1,0,0
    END IF
    IF i=0 OR i=jingmai(seljingmai).xueweiNum-1 THEN
      glColor3f 1,0,0
    END IF
    glTranslatef -jingmai(seljingmai).xuewei(i).pos.x*kk, -jingmai(seljingmai).xuewei(i).pos.z*kk,jingmai(seljingmai).xuewei(i).pos.y*kk
    glPopMatrix
  NEXT i
  glPushMatrix
  glBegin %GL_LINE_STRIP '%GL_LINES
  glLineWidth 3
  FOR i=0 TO jingmai(seljingmai).xueweiNum-1
    glVertex3f jingmai(seljingmai).xuewei(i).pos.x*kk, jingmai(seljingmai).xuewei(i).pos.z*kk,-jingmai(seljingmai).xuewei(i).pos.y*kk
    'glVertex3f jingmai(seljingmai).xuewei(i).pos.x, jingmai(seljingmai).xuewei(i).pos.z,-jingmai(seljingmai).xuewei(i).pos.y
  NEXT i
  glEnd
  glPopMatrix
  glRotatef 180,1,0,0
END FUNCTION
'******************************************************************************
FUNCTION drawobj1(BYVAL textlist$,BYVAL defauttex$,BYVAL size1 AS INTEGER,BYVAL test AS INTEGER) AS DWORD
  LOCAL l_index AS LONG
  LOCAL vn AS LONG
  LOCAL v AS DWORD
  LOCAL objnum AS INTEGER
  LOCAL x1,y1,z1,x2,y2,z2,x3,y3,z3,vx1,vy1,vz1,vx2,vy2,vz2,vx3,vy3,vz3 AS SINGLE 'float
  LOCAL vmax AS SINGLE
  LOCAL kk AS SINGLE
  LOCAL objn AS DWORD
  LOCAL obj_poly AS DWORD
  LOCAL itext AS DWORD
  LOCAL objstr$,text0$,prefix$
  LOCAL text$
  LOCAL aux$
  LOCAL oldObj$
  'local test as integer
  vmax=0.001
  objn=0
  obj_poly=Obj.obj_poly(objn)
  itext=0
  objstr$=Obj.name1(objn)
  oldObj$=objstr$
  prefix$=Obj.prefix
  text$=textlist$
  aux$="               "

  IF test=1 THEN
    ? "obj$=" & objstr$
    ? "textlist$=" & text$
    ? "drawobj size1=" & STR$(size1)
    ? "drawobj prefix$=" & prefix$
    ? "drawobj @pObj.vertices_qty =" & STR$(Obj.vertices_qty)
  END IF
  '? "drawobj1 " & str$(obj.vertices_qty)
  IF size1>0 THEN
    FOR v=1 TO Obj.vertices_qty
      vmax=MAX(vmax,0.5*vmax+0.5*(Obj.vertex(v).x),0.5*vmax+0.5*(Obj.vertex(v).y), _
                0.5*vmax+0.5*(Obj.vertex(v).z))
    NEXT v
    kk=size1/vmax
  ELSE
    kk=1
  END IF
  objnum=1
  glLoadName(objnum)
  'RotateMove objstr$,1  '对异常的对象进行旋转或缩放，1表示动作，0表示恢复
  glPassThrough(CSNG(objnum))
  glShadeModel(%GL_SMOOTH)
'  IF oldObj$<>objstr$ THEN
'    RotateMove oldObj$,0
'    oldObj$=objStr$
'    RotateMove objstr$,1
'  END IF
  glEnable(%GL_BLEND)
  drawJingmai(kk)
  glColor4ub(90,90,90,100)
  glBegin(%GL_TRIANGLES)
  IF test=1 THEN
    ? "drawobj vmax=" & STR$(vmax)
    ? "drawobj kk=" & STR$(kk)
    ? "@pObj.vertices_qty=" & STR$(Obj.vertices_qty)
    ? "@pObj.polygons_qty=" & STR$(Obj.polygons_qty)
    ? "@pObj.textures_qty=" & STR$(Obj.textures_qty)
  END IF
  FOR l_index=0 TO Obj.polygons_qty-1  '从0到总的多边形数量进行循环,obj_poly中存储的是每个物体中的多边形开始数量，如第一个物体中多边形数量为10个，则
    IF l_index>=obj_poly THEN             '如：第一个物体中多边形为10个，则l_index从0到9循环，以三角形形式输出多边形
      WHILE l_index>=obj_poly AND objn<%max_obj   '当l_index为10时，进入本判断分支，
        objn+=1
        obj_poly=Obj.obj_poly(objn)
      WEND
      glEnd()
      objnum+=1
      glLoadName(objnum)
      glPassThrough(objnum)
      glBegin(%GL_TRIANGLES)
    END IF
    vn=Obj.polygon1(l_index).a
    x1=Obj.vertex(vn).x
    y1=Obj.vertex(vn).y
    z1=Obj.vertex(vn).z

    vn=Obj.polygon1(l_index).b
    x2=Obj.vertex(vn).x
    y2=Obj.vertex(vn).y
    z2=Obj.vertex(vn).z

    vn=Obj.polygon1(l_index).c
    x3=Obj.vertex(vn).x
    y3=Obj.vertex(vn).y
    z3=Obj.vertex(vn).z

    vx1=x2-x1
    vy1=y2-y1
    vz1=z2-z1

    vx2=x3-x1
    vy2=y3-y1
    vz2=z3-z1

    vx3=(vz2*vy1)-(vy2*vz1)
    vy3=(vx2*vz1)-(vz2*vx1)
    vz3=(vy2*vx1)-(vx2*vy1)

    glNormal3f(vx3,vy3,vz3)

'    //----------------- FIRST VERTEX -----------------
'    // Texture coordinates of the first vertex
    '// Coordinates of the first vertex
    glVertex3f( Obj.vertex( Obj.polygon1(l_index).a).x*kk, _
                Obj.vertex( Obj.polygon1(l_index).a ).y*kk, _
                Obj.vertex( Obj.polygon1(l_index).a ).z*kk) '//Vertex definition
    'glNormal3f(vx3,vy3,vz3)
'    //----------------- SECOND VERTEX -----------------
'    // Texture coordinates of the second vertex
   ' // Coordinates of the second vertex
    glVertex3f( Obj.vertex( Obj.polygon1(l_index).b).x*kk, _
                Obj.vertex( Obj.polygon1(l_index).b ).y*kk, _
                Obj.vertex( Obj.polygon1(l_index).b ).z*kk) '//Vertex definition
    'glNormal3f(vx1,vy1,vz1)
'    //----------------- THIRD VERTEX -----------------
    '// Coordinates of the Third vertex
    glVertex3f( Obj.vertex( Obj.polygon1(l_index).c).x*kk, _
                Obj.vertex( Obj.polygon1(l_index).c ).y*kk, _
                Obj.vertex( Obj.polygon1(l_index).c ).z*kk) '//Vertex definition
    'glVertex3f(0,0,0)
  NEXT l_index
  glEnd()
'  IF oldObj$<>objstr$ THEN
'    RotateMove oldObj$,0
'    oldObj$=objStr$
'    RotateMove objstr$,1
'  END IF
END FUNCTION
'===========================================================================================================
' 加载物体模型并列表化
'-----------------------------------------------------------------------------------------------------------

SUB Graphics()
    DIM fogColor(4) AS SINGLE
    DIM heightScale#  ' Height map scale factor
    DIM xSize AS INTEGER
    DIM ySize AS INTEGER
    DIM xStr AS STRING
    DIM yStr AS STRING
    DIM zStr AS STRING
    DIM xMask AS INTEGER
    DIM yMask AS INTEGER      ' bitmasks to apply to X and Y coordinates
    DIM filenum  AS INTEGER              ' File handle
    STATIC rotreg AS SINGLE
    DIM AutoRot AS LONG
    DIM fi AS LONG
    glClearColor 0.4,0.5,0.6,0.8
    glClearDepth 1.0
    'glShadeModel %GL_SMOOTH
    glEnable %GL_DEPTH_TEST
    glEnable %GL_TEXTURE_2D
    glDepthFunc %GL_LESS '%GL_LEQUAL
    glEnable %GL_DEPTH_TEST
    glHint %GL_PERSPECTIVE_CORRECTION_HINT, %GL_NICEST

    glEnable %GL_COLOR_MATERIAL
    glEnable %GL_NORMALIZE
    glEnable %GL_LIGHTING
    glEnable %GL_LIGHT0
    'glEnable %GL_LIGHT1

    'glColor4f(.5,.5,.5,0.5)        '// Full Brightness, 50% Alpha ( NEW )
    glBlendFunc(%GL_SRC_ALPHA,%GL_ONE)
    'glBlendFunc(%GL_SRC_ALPHA, %GL_ONE_MINUS_SRC_ALPHA) 'Enable Alpha Blending
    glEnable(%GL_BLEND)                                'Enable Blending
    glAlphaFunc(%GL_GREATER,0.1)                       'Set Alpha Testing
    glEnable(%GL_ALPHA_TEST)
    glMatrixMode %GL_MODELVIEW '%GL_PROJECTION '
  glPushMatrix()

    glTranslatef VAL(Mx),0,0
    glTranslatef 0,VAL(My)+10,0
    glTranslatef 0,0,VAL(Mz)
    glRotatef VAL(Rx)-90,1,0,0
    glRotatef VAL(Ry),0,1,0
    glRotatef VAL(Rz),0,0,1
    glInitNames()
    glPushName(0)
    glRotatef -rotreg,0.0,0.0,1.0
    CONTROL GET CHECK hWnd,%IDC_CHECKBOX1 TO AutoRot
    IF AutoRot THEN
      rotreg+=0.5
    END IF
    IF rotreg=360 THEN rotreg=0
    glTranslatef 0,5,-8
    drawObj1(textlist,defauttext,25,0)
    glPopName()
  glPopMatrix()

END SUB

SUB cosmic_sky
  glBegin %GL_QUADS
    glColor3f 0,0,0
    glNormal3f 0,0,100
    glVertex3f -1000,-1000,-1000
    GlColor3f 0,0.5,1
    glVertex3f 1000,-1000,-1000
    glColor3f 0,1,0
    glVertex3f 1000,10000,-1000
    glColor3f 0.3,0.0,0
    glVertex3f -1000,1000,-1000
  glEnd
END SUB
'===========================================================================================================
' 渲染物体模型并响应选择
'-----------------------------------------------------------------------------------------------------------
SUB RenderOpenGL
  DIM viewport(3) AS GLOBAL LONG
  DIM sPosX   AS GLOBAL LONG
  DIM sPosY   AS GLOBAL LONG
  DIM ePosX   AS GLOBAL LONG
  DIM ePosY   AS GLOBAL LONG
  DIM mPosX   AS GLOBAL LONG
  DIM mPosY   AS GLOBAL LONG
  DIM bLeft   AS GLOBAL LONG
  DIM SelectBuf(%sBUFSIZE-1) AS STATIC LONG
  LOCAL tmpstr AS STRING
  GLOBAL hits AS LONG
  LOCAL i,c,j,count1 AS LONG
  STATIC feedBackBuff() AS SINGLE
  REDIM feedBackBuff(%FEED_BUFF_SIZE)
  IF hPicRC THEN
    'glEnable %GL_LIGHT0                                'Enable Default Light (Quick And Dirty)
    glLoadIdentity
    glClear %GL_COLOR_BUFFER_BIT OR %GL_DEPTH_BUFFER_BIT
    'DrawObjects()
    Graphics()
    IF bSelect THEN

      bSelect=0
      SelObject=0
      HitDetection=1
      'selection
      RESET selectBuf()
      glSelectBuffer (%sBUFSIZE, selectBuf(0))
      glGetIntegerv(%GL_VIEWPORT,viewport(0))
      glMatrixMode(%GL_PROJECTION)
      glPushMatrix()
      glRenderMode(%GL_SELECT)
      glLoadIdentity()
      gluPickMatrix( mPosX,viewport(3) - mPosY+viewport(1), 1, 1, viewport(0)) ' single pixel selection zone
      gluPerspective(45.0, dWidth/dHeight, 1.0, 425.0)
      Graphics()
      hits=glRenderMode(%GL_RENDER)
      glMatrixMode(%GL_PROJECTION)
      glPopMatrix()
      glMatrixMode(%GL_MODELVIEW)
      ' nearest named object
      'if hits>0 then
        LOCAL v AS DWORD
        LOCAL w AS DWORD
        w=-1
        v=&h7fffffff
        i=0
        c=hits*4
        'w= SelectBuf(3)'i+3)
        tmpstr=""
'        WHILE i<c
'          IF SelectBuf(i+1)<v THEN
'            v=SelectBuf(i+1)
'            w=SelectBuf(i+3)
'            IF w=5 OR w= 18 OR w=10 OR w=11 THEN
'              EXIT
'            END IF
'          END IF
'          tmpstr=tmpstr & "," & STR$(SelectBuf(i)) & "," & STR$(SelectBuf(i+1)) & "," & STR$(SelectBuf(i+2)) & "," & STR$(SelectBuf(i+3)) & $CRLF
'          i=i+4'SelectBuf(i)+3
'        WEND
'        IF w>=0 THEN SelObject=w
      'end if
'      IF selobject THEN
'        SetItem(selObject)
'        SelObject=0
'      END IF
    END IF
    SwapBuffers hPicDC
  END IF
END SUB
SUB RenderOpenGL_BAK
  DIM viewport(3) AS GLOBAL LONG
  DIM sPosX   AS GLOBAL LONG
  DIM sPosY   AS GLOBAL LONG
  DIM ePosX   AS GLOBAL LONG
  DIM ePosY   AS GLOBAL LONG
  DIM mPosX   AS GLOBAL LONG
  DIM mPosY   AS GLOBAL LONG
  DIM bLeft   AS GLOBAL LONG
  LOCAL tmpstr AS STRING
  GLOBAL hits AS LONG
  LOCAL i,c,j,count1 AS LONG
  STATIC feedBackBuff() AS SINGLE
  REDIM feedBackBuff(%FEED_BUFF_SIZE)
  IF hPicRC THEN
    glLoadIdentity
    glClear %GL_COLOR_BUFFER_BIT OR %GL_DEPTH_BUFFER_BIT
    Graphics()
    IF bSelect THEN
      DIM SelectBuf(%sBUFSIZE-1) AS  LONG
      bSelect=0
      SelObject=0
      HitDetection=1
      'selection
      glSelectBuffer (%sBUFSIZE, selectBuf(0))
      glRenderMode(%GL_SELECT)
      glInitNames()
      glPushName(0) ' an arbitrary value
      glMatrixMode(%GL_PROJECTION)
      glPushMatrix()
      glLoadIdentity()
      glGetIntegerv(%GL_VIEWPORT,viewport(0))
      gluPickMatrix( mPosX,dHeight - mPosY, 1.0, 1.0, viewport(0)) ' single pixel selection zone
      gluPerspective(45.0, dWidth/dHeight, 1.0, 1000.0)
      'render
      glMatrixMode(%GL_MODELVIEW)
      'DrawObjects()
      Graphics()
      glPopName()
      hits=glRenderMode(%GL_RENDER)

      HitDetection=0
      glMatrixMode(%GL_PROJECTION)
      glLoadIdentity()
      ' nearest named object
      LOCAL v AS DWORD
      LOCAL w AS DWORD
      w=-1
      v=&h7fffffff
      i=0
      c=hits*4
      'w= SelectBuf(3)'i+3)
      WHILE i<c
        IF SelectBuf(i+1)<v THEN v=SelectBuf(i+1): w=SelectBuf(i+3)
        i=i+SelectBuf(i)+3
        'tmpstr=tmpstr & "," & str$(SelectBuf(i)) & "," & str$(SelectBuf(i+1)) & "," & str$(SelectBuf(i+2)) & "," & str$(SelectBuf(i+3)) & $crlf
      WEND
      gluPerspective(45.0, dWidth/dHeight, 1.0, 1000.0)
      glMatrixMode(%GL_MODELVIEW)
    END IF
    SwapBuffers hPicDC
  END IF
END SUB
'===========================================================================================================
' 关闭OpenGL
'-----------------------------------------------------------------------------------------------------------
SUB CloseOpenGL
'******************************************************************************
  wglMakeCurrent %NULL, %NULL
  IF (hPicRC) THEN
    wglDeleteContext hPicRC
    hPicRC = %False
  END IF
END SUB
'===========================================================================================================
' 初始化窗口，同时初始化OpenGL
'-----------------------------------------------------------------------------------------------------------
FUNCTION InitDialog(BYVAL hDlg AS DWORD) AS LONG
'******************************************************************************
  LOCAL x AS DWORD
  LOCAL y AS DWORD
  CONTROL HANDLE hDlg, %IDC_PIC TO hPic
  hPicDC = GetDC(hPic)
  CONTROL GET CLIENT hDlg, %IDC_PIC TO x, y
  DIALOG UNITS hDlg, x, y TO PIXELS dWidth, dHeight
  IF InitOpenGL (dWidth, dHeight) THEN
      FUNCTION = %True
     EXIT FUNCTION
  END IF
  FUNCTION = %False
END FUNCTION
'===========================================================================================================
' 关闭窗口
'-----------------------------------------------------------------------------------------------------------
SUB CloseDialog()
'******************************************************************************
    CloseOpenGL
    ReleaseDC hPic,hPicDC
END SUB
'===========================================================================================================
' 对OpenGL容器控件进行回调，以响应鼠标操作：拖动，缩放，旋转，选择
'-----------------------------------------------------------------------------------------------------------
FUNCTION OpenglCL(BYVAL hCnd AS LONG, BYVAL wMsg AS LONG, _
    BYVAL wParam AS LONG, BYVAL lParam AS LONG) EXPORT AS LONG
    DIM viewport(4) AS LONG
    DIM buffer(512) AS LONG
    LOCAL hits AS LONG
    GetCursorPos apt
    IF (apt.x>=CRect.nLeft+3) AND (apt.x<=(CRect.nLeft+dWidth+3)) _
       AND (apt.y>=CRect.nTop+30) AND (apt.y<=(CRect.nTop+dHeight+30)) THEN
        setfocus hCnd
    END IF
    SELECT CASE wMSG
        CASE %WM_LBUTTONUP
          bSelect=0
        CASE %WM_LBUTTONDOWN
            'GetCursorPos apt0
            bSelect=1
            mPosX= LOWRD(lParam)
            mPosY=HIWRD(lParam)
            apt0.x=mPosX
            apt0.y=mPosY
        CASE %WM_RBUTTONDOWN
            'GetCursorPos apt0
            apt0.x=LOWRD(lParam)
            apt0.y=HIWRD(lParam)
        CASE %WM_MBUTTONDOWN
            'GetCursorPos apt0
            apt0.x=LOWRD(lParam)
            apt0.y=HIWRD(lParam)
        CASE %WM_MOUSEMOVE
            'GetCursorPos apt
            apt.x=LOWRD(lParam)
            apt.y=HIWRD(lParam)
            IF (WPARAM AND %MK_LBUTTON) OR (WPARAM AND %MK_RBUTTON) OR (WPARAM AND %MK_MBUTTON) THEN
                IF (WPARAM AND %MK_LBUTTON) THEN
                    IF apt.x>apt0.x THEN
                        Mx=STR$(VAL(Mx)+1)
                    END IF
                    IF apt.x<apt0.x THEN
                        Mx=STR$(VAL(Mx)-1)
                    END IF
                    IF apt.y>apt0.y THEN
                        My=STR$(VAL(My)-1)
                    END IF
                    IF apt.y<apt0.y THEN
                        My=STR$(VAL(My)+1)
                    END IF
                END IF
                IF (WPARAM AND %MK_RBUTTON) THEN
                    IF apt.x>apt0.x THEN
                        Ry=STR$(VAL(Ry)+2)
                    END IF
                    IF apt.x<apt0.x THEN
                        Ry=STR$(VAL(Ry)-2)
                    END IF
                    IF apt.y>apt0.y THEN
                        Rx=STR$(VAL(Rx)+2)
                    END IF
                    IF apt.y<apt0.y THEN
                        Rx=STR$(VAL(Rx)-2)
                    END IF
                END IF
                IF (WPARAM AND %MK_MBUTTON) THEN
                    Rz=STR$(VAL(Rz)-(apt.x-apt0.x))
                END IF
                apt0=apt
            END IF
        CASE %WM_MOUSEWHEEL
            'GetCursorPos apt
            apt.x=LOWRD(lParam)
            apt.y=HIWRD(lParam)
            IF (apt.x>=CRect.nLeft+3) AND (apt.x<=(CRect.nLeft+dWidth+3)) _
                AND (apt.y>=CRect.nTop+30) AND (apt.y<=(CRect.nTop+dHeight+30)) THEN
                IF WPARAM>0 THEN
                    Mz=STR$(VAL(Mz)-2)
                END IF
                IF WPARAM<0 THEN
                    Mz=STR$(VAL(Mz)+2)
                END IF
            END IF
        CASE ELSE
            FUNCTION=DefWindowProc(hCnd,wMsg,wParam,lParam)
    END SELECT
    CONTROL SET TEXT hWnd,%IDC_TEXTBOX2_1,Mx
    CONTROL SET TEXT hWnd,%IDC_TEXTBOX2_2,My
    CONTROL SET TEXT hWnd,%IDC_TEXTBOX2_3,Mz
    CONTROL SET TEXT hWnd,%IDC_TEXTBOX2_4,Rx
    CONTROL SET TEXT hWnd,%IDC_TEXTBOX2_5,Ry
    CONTROL SET TEXT hWnd,%IDC_TEXTBOX2_6,Rz
END FUNCTION
' Load Bitmaps And Convert To Textures
SUB LoadGLTextures()
  ' Load Texture
  DIM texture1 AS AUX_RGBImageRec PTR
  DIM texture(2)

  texture1 = auxDIBImageLoad("img/ManArmL.jpg")
  'msgbox str$(texture1)
  IF texture1 = 0 THEN
    ExitProcess 1
  END IF

  ' Create Nearest Filtered Texture
  glGenTextures 3, texture(0)
  glBindTexture %GL_TEXTURE_2D, texture(0)
  glTexParameteri %GL_TEXTURE_2D, %GL_TEXTURE_MAG_FILTER, %GL_NEAREST
  glTexParameteri %GL_TEXTURE_2D, %GL_TEXTURE_MIN_FILTER, %GL_NEAREST
  glTexImage2D %GL_TEXTURE_2D, 0, 3, @texture1.sizeX, @texture1.sizeY, 0, %GL_RGB, %GL_UNSIGNED_BYTE, @texture1.@ndata

  ' Create Linear Filtered Texture
  glBindTexture %GL_TEXTURE_2D, texture(1)
  glTexParameteri %GL_TEXTURE_2D, %GL_TEXTURE_MAG_FILTER, %GL_LINEAR
  glTexParameteri %GL_TEXTURE_2D, %GL_TEXTURE_MIN_FILTER, %GL_LINEAR
  glTexImage2D %GL_TEXTURE_2D, 0, 3, @texture1.sizeX, @texture1.sizeY, 0, %GL_RGB, %GL_UNSIGNED_BYTE, @texture1.@ndata

  ' Create MipMapped Texture
  glBindTexture %GL_TEXTURE_2D, texture(2)
  glTexParameteri %GL_TEXTURE_2D, %GL_TEXTURE_MAG_FILTER, %GL_LINEAR
  glTexParameteri %GL_TEXTURE_2D, %GL_TEXTURE_MIN_FILTER, %GL_LINEAR_MIPMAP_NEAREST
  gluBuild2DMipmaps %GL_TEXTURE_2D, 3, @texture1.sizeX, @texture1.sizeY, %GL_RGB, %GL_UNSIGNED_BYTE, @texture1.@ndata
END SUB
#ENDIF
