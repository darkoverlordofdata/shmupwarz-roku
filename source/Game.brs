' ********************************************************************************************************
' ********************************************************************************************************
' ** Game Object
' **
' **
' ********************************************************************************************************
' ********************************************************************************************************
Library "v30/bslDefender.brs"


' ********************************************************************************************************
' ** Game Constructor
' **
' **
' ********************************************************************************************************
Function CreateGame(width As Integer, height As Integer, title As String) As Object
    Return {
        ' **
        ' ** Properties 
        Width: width,
        Height: height,
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
        Fonts: {Reg:CreateObject("roFontRegistry")},
        ' **
        ' ** Methods 
        Init:   Sub () : End Sub,
        Draw:   Sub (delta As Float) : End Sub,
        Update: Sub (delta As Float) : End Sub,
        Tick:   Sub () : End Sub,

        Run:    Game_Run,

    }
End Function



' ********************************************************************************************************
' ** Game Run
' ** Implementation
' **
' ********************************************************************************************************
Sub Game_Run()
    m.AudioPlayer.SetMessagePort(m.AudioPort)
    m.Init()

    If IsHD()
        m.Screen = CreateObject("roScreen", True, 854, 480)
    Else
        m.Screen = CreateObject("roScreen", True, 720, 540)
    End If

    m.Screen.SetMessagePort(m.Port)
    m.Screen.SetAlphaEnable(True)

    m.Screen.Clear(0)
    m.Scale = Int(GetScale(m.Screen, m.Height, m.Width))
    m.CenterX = CInt((m.Screen.GetWidth() - (m.Width * m.Scale)) / 2)
    m.CenterY = CInt((m.Screen.GetHeight() - (m.Width * m.Scale)) / 2)
    m.BackImage = ScaleBitmap(CreateObject("roBitmap", "pkg:/images/background.png"), m.Scale)


    While True

        m.Screen.Clear(0)

        m.Update(0.01667)
        m.Draw(0.01667)

        m.Screen.SwapBuffers()

    End While
End Sub

