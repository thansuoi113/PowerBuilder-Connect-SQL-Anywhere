$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type dw_1 from datawindow within w_main
end type
type cb_2 from commandbutton within w_main
end type
type st_5 from statictext within w_main
end type
type sle_database from singlelineedit within w_main
end type
type cb_1 from commandbutton within w_main
end type
type sle_db from singlelineedit within w_main
end type
type sle_user from singlelineedit within w_main
end type
type sle_pass from singlelineedit within w_main
end type
type cb_3 from commandbutton within w_main
end type
type st_1 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type cb_4 from commandbutton within w_main
end type
type st_4 from statictext within w_main
end type
end forward

global type w_main from window
integer width = 2400
integer height = 1596
boolean titlebar = true
string title = "Connect SQL AnyWhere"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
st_5 st_5
sle_database sle_database
cb_1 cb_1
sle_db sle_db
sle_user sle_user
sle_pass sle_pass
cb_3 cb_3
st_1 st_1
st_2 st_2
st_3 st_3
cb_4 cb_4
st_4 st_4
end type
global w_main w_main

type variables
transaction itran
end variables

on w_main.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.st_5=create st_5
this.sle_database=create sle_database
this.cb_1=create cb_1
this.sle_db=create sle_db
this.sle_user=create sle_user
this.sle_pass=create sle_pass
this.cb_3=create cb_3
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_4=create cb_4
this.st_4=create st_4
this.Control[]={this.dw_1,&
this.cb_2,&
this.st_5,&
this.sle_database,&
this.cb_1,&
this.sle_db,&
this.sle_user,&
this.sle_pass,&
this.cb_3,&
this.st_1,&
this.st_2,&
this.st_3,&
this.cb_4,&
this.st_4}
end on

on w_main.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.st_5)
destroy(this.sle_database)
destroy(this.cb_1)
destroy(this.sle_db)
destroy(this.sle_user)
destroy(this.sle_pass)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_4)
destroy(this.st_4)
end on

event close;If IsValid(itran) Then
	Disconnect Using itran ;
	Destroy itran;
End If

end event

type dw_1 from datawindow within w_main
integer x = 37
integer y = 768
integer width = 2231
integer height = 672
integer taborder = 50
string title = "none"
string dataobject = "d_example"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_main
integer x = 841
integer y = 640
integer width = 306
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Retrieve"
end type

event clicked;dw_1.settransobject( itran)

dw_1.reset()
dw_1.retrieve( )
end event

type st_5 from statictext within w_main
integer x = 5
integer y = 320
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Database:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_database from singlelineedit within w_main
integer x = 343
integer y = 316
integer width = 1760
integer height = 80
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "peat"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_main
integer x = 329
integer y = 640
integer width = 498
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Connect ODBC"
end type

event clicked;String ls_database,  ls_user, ls_pass, ls_databasefile

ls_user = sle_user.Text
ls_pass = sle_pass.Text
ls_databasefile = sle_db.Text
ls_database = sle_database.text


RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\" + ls_database,"AutoStop",RegString!,"yes")
RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\" + ls_database,"DatabaseFile",RegString!, ls_databasefile)
RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\" + ls_database,"DatabaseName",RegString!,ls_database)
RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\" + ls_database,"Driver",RegString!,"dbodbc9.dll")
RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\" + ls_database,"Start",RegString!,"dbeng9")
RegistrySet("HKEY_CURRENT_USER\SOFTWARE\ODBC\ODBC.INI\ODBC DATA SOURCES", ls_database , RegString!, "SQL Anywhere 9")


Transaction ltran_conn
ltran_conn = Create Transaction

// Using ODBC Connect To SQL Anywhere
ltran_conn.DBMS = "ODBC"
ltran_conn.AutoCommit = False
ltran_conn.DBParm = "ConnectString='DSN="+ls_database+";UID="+ls_user+";PWD="+ls_pass+"'"

Connect Using ltran_conn ;
If ltran_conn.SQLCode = -1 Then
	MessageBox('Warning','Connect Database Error' + ltran_conn.SQLErrText)
Else
	MessageBox('Warning',"Connect Success!")
End If

itran = ltran_conn
//Disconnect Using ltran_conn ;




end event

type sle_db from singlelineedit within w_main
integer x = 343
integer y = 220
integer width = 1760
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "peat.db"
borderstyle borderstyle = stylelowered!
end type

type sle_user from singlelineedit within w_main
integer x = 343
integer y = 412
integer width = 1760
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "dba"
borderstyle borderstyle = stylelowered!
end type

type sle_pass from singlelineedit within w_main
integer x = 343
integer y = 508
integer width = 1760
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "sql"
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_main
integer x = 1975
integer y = 640
integer width = 265
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_main
integer x = 5
integer y = 236
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "DB:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_main
integer x = 5
integer y = 424
integer width = 320
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer x = 5
integer y = 520
integer width = 320
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "PassWord:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_main
integer x = 2112
integer y = 216
integer width = 123
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;String ls_path, ls_file
Int li_rc

ls_path = sle_db.Text
li_rc = GetFileSaveName ( "Select File",   ls_path, ls_file, "mdb",  "Microsoft Access 2003 (*.mdb),*.mdb,Microsoft Access 2007 (*.accdb),*.accdb,All Files (*.*),*.*" )

If li_rc = 1 Then
	sle_db.Text = ls_path
End If


end event

type st_4 from statictext within w_main
integer x = 18
integer y = 40
integer width = 2359
integer height = 136
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Connect SQL AnyWhere"
alignment alignment = center!
boolean focusrectangle = false
end type

