' ********************************************************************************************************
' ********************************************************************************************************
' **
' **
' **
' ********************************************************************************************************
' ********************************************************************************************************
Library "v30/bslDefender.brs"

Sub Main()
    game = CreateGame(432, 640, "Shmupwarz")
    game.Init( {font: "Gotham-Medium"} )

    game.ResetScreen(m)


    m.mainScreen.Clear(0)
    scale = Int(GetScale(m.mainScreen, 640, 432))
    centerX = CInt((m.mainScreen.GetWidth() - (640 * scale)) / 2)
    centerY = CInt((m.mainScreen.GetHeight() - (432 * scale)) / 2)
    backImage = ScaleBitmap(CreateObject("roBitmap", "pkg:/images/background.png"), scale)

    Print game.Title

    While True
        ' Print m.timer.TotalMilliseconds()
        m.mainScreen.Clear(0)

        m.mainScreen.DrawObject(centerX, centerY, backImage)

        m.mainScreen.DrawText("Give Me Those Shmup Wars", centerX + 225, centerY + 162, game.Colors.Green, game.Fonts.KeysFont)

        m.mainScreen.SwapBuffers()
    End While
    
End Sub





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
