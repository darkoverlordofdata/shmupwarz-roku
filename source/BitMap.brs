Function ScaleBitmap(bitmap As Object, scale As Float, simpleMode = False As Boolean)
    If bitmap = Invalid Then Return bitmap
    If scale = 1.0
        scaled = bitmap
    Else If scale = Int(scale) or simpleMode
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

