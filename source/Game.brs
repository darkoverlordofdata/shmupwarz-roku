' ********************************************************************************************************
' ********************************************************************************************************
' **
' **
' **
' ********************************************************************************************************
' ********************************************************************************************************
Library "v30/bslDefender.brs"


' ********************************************************************************************************
' ** Game Constructor
' **
' ********************************************************************************************************
Function CreateGame(h As Integer, w As Integer, title As String) As Object
    Return {
        ' **
        ' ** Properties 
        Width: w,
        Height: h,
        Title: title,    
        Colors: { 
            Red: &hAA0000FF, 
            Green:&h00AA00FF, 
            Yellow: &hFFFF55FF, 
            Black: &hFF, 
            White: &hFFFFFFFF, 
            Gray: &h404040FF, 
            Navy: &h080030FF, 
            DarkRed: &h810000FF,
        }    
        Code: bslUniversalControlEventCodes(),
        Port: CreateObject("roMessagePort"),
        Clock: CreateObject("roTimespan"),
        Timer: CreateObject("roTimespan"),
        AudioPlayer: CreateObject("roAudioPlayer"),
        AudioPort: CreateObject("roMessagePort"),
        Files: CreateObject("roFileSystem"),
        Fonts: {reg:CreateObject("roFontRegistry")},
        ' **
        ' ** Methods 
        Init:   Game_Init,
        Run:    Game_Run,
        Draw:   Game_Draw,
        Update: Game_Update,
        Tick:   Game_Tick,
    }
End Function

Sub Game_Init()
End Sub

Sub Game_Draw(delta As Float)
End Sub

Sub Game_Update(delta As Float)
End Sub

Sub Game_Tick()
End Sub

Sub Game_Run()
    m.audioPlayer.SetMessagePort(m.audioPort)
    m.Init()
    If IsHD()
        m.Screen = CreateObject("roScreen", True, 854, 480)
    Else
        m.Screen = CreateObject("roScreen", True, 720, 540)
    End If

    m.Screen.SetMessagePort(m.Port)
    m.Screen.SetAlphaEnable(True)

    m.Screen.Clear(0)
    m.Scale = Int(GetScale(m.Screen, 640, 432))
    m.CenterX = CInt((m.Screen.GetWidth() - (640 * m.Scale)) / 2)
    m.CenterY = CInt((m.Screen.GetHeight() - (432 * m.Scale)) / 2)
    m.BackImage = ScaleBitmap(CreateObject("roBitmap", "pkg:/images/background.png"), m.Scale)


    While True

        m.Screen.Clear(0)

        m.Draw(0.01667)
        m.Update(0.01667)

        m.Screen.SwapBuffers()

    End While
End Sub

Function IsHD()
    di = CreateObject("roDeviceInfo")
    Return (di.GetUIResolution().height >= 720)
End Function




Function ScaleBitmap(bitmap As Object, scale As Float, simpleMode = False As Boolean)
    If bitmap = Invalid Then Return bitmap
    If scale = 1.0
        scaled = bitmap
    Else If scale = int(scale) or simpleMode
		scaled = CreateObject("roBitmap",{width:int(bitmap.GetWidth()*scale), height:int(bitmap.GetHeight()*scale), alphaenable:True})
		scaled.DrawScaledObject(0,0,scale,scale,bitmap)
    Else
        region = CreateObject("roRegion", bitmap, 0, 0, bitmap.GetWidth(), bitmap.GetHeight())
        region.SetScaleMode(1)
        scaled = CreateObject("roBitmap",{width:int(bitmap.GetWidth()*scale), height:int(bitmap.GetHeight()*scale), alphaenable:True})
        scaled.DrawScaledObject(0,0,scale,scale,region)
	End If
    Return scaled
End Function

Function GetScale(screen As Object, width As Integer, height As Integer) As Float
    scaleX = screen.GetWidth() / width
    scaleY = screen.GetHeight() / height
    If  scaleX > scaleY
        scale = scaleY
    Else
        scale = scaleX
    End If
    Return scale
End Function
