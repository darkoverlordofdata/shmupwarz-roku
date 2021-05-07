Function IsHD()
    di = CreateObject("roDeviceInfo")
    Return (di.GetUIResolution().height >= 720)
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
