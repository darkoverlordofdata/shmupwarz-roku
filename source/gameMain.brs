' ********************************************************************************************************
' ********************************************************************************************************
' **
' **
' **
' ********************************************************************************************************
' ********************************************************************************************************
Library "v30/bslDefender.brs"

Sub Main()
    'Constants
    m.code = bslUniversalControlEventCodes()
    m.const = GetConstants()
    m.colors = { red: &hAA0000FF, green:&h00AA00FF, yellow: &hFFFF55FF, black: &hFF, white: &hFFFFFFFF, gray: &h404040FF, navy: &h080030FF, darkred: &h810000FF }
    m.maxLevels = 14
    'Util objects
    m.theme = GetTheme()
    m.port = CreateObject("roMessagePort")
    m.clock = CreateObject("roTimespan")
    m.timer = CreateObject("roTimespan")
    m.audioPlayer = CreateObject("roAudioPlayer")
    m.audioPort = CreateObject("roMessagePort")
    m.audioPlayer.SetMessagePort(m.audioPort)
    m.files = CreateObject("roFileSystem")
    m.fonts = {reg:CreateObject("roFontRegistry")}
    m.fonts.reg.Register("pkg:/assets/fonts/Gotham-Medium.otf")
    m.fonts.KeysFont = m.fonts.reg.getFont("Gotham Medium", 30, false, false)
    m.status = []
    ResetMainScreen()


    m.mainScreen.Clear(0)
    scale = Int(GetScale(m.mainScreen, 640, 432))
    centerX = Cint((m.mainScreen.GetWidth() - (640 * scale)) / 2)
    centerY = Cint((m.mainScreen.GetHeight() - (432 * scale)) / 2)
    backImage = ScaleBitmap(CreateObject("roBitmap", "pkg:/images/background.png"), scale)

    menuFont = m.fonts.reg.getFont("Prince of Persia Game Font", 26, false, false)

    while true
        print m.timer.TotalMilliseconds()
        m.mainScreen.Clear(0)

        m.mainScreen.DrawObject(centerX, centerY, backImage)

        m.mainScreen.DrawText("Give Me Those Shmup Wars", centerX + 225, centerY + 162, &hFF0000FF, m.fonts.KeysFont)

        m.mainScreen.SwapBuffers()
    end while
    
End Sub



Function GetTheme() as object
    theme = {
        
        BackgroundColor: "#000000FF",
        OverhangSliceSD: "pkg:/images/overhang_sd.jpg",
        OverhangSliceHD: "pkg:/images/overhang_hd.jpg",
        ListScreenHeaderText: "#FFFFFFFF",
        ListScreenDescriptionText: "#FFFFFFFF",
        ListItemHighlightSD: "pkg:/images/item_highlight_sd.png",
        ListItemHighlightHD: "pkg:/images/item_highlight_hd.png",
        ListItemText: "#C0C0C0FF",
        ListItemHighlightText: "#FF0000FF"
    }
    return theme
End Function


Function GetConstants() as object
    const = {}

    const.TIME_LIMIT = 3600

    const.SPRITES_DOS = 0
    const.SPRITES_MAC = 1

    const.CONTROL_VERTICAL = 0
    const.CONTROL_HORIZONTAL = 1

    const.FACE_LEFT = 0
    const.FACE_RIGHT = 1

    const.BLOCK_WIDTH = 32
    const.BLOCK_HEIGHT = 63

    const.TILE_WIDTH = 60
    const.TILE_HEIGHT = 79

    const.ROOM_WIDTH = 320
    const.ROOM_HEIGHT = const.BLOCK_HEIGHT * 3

    const.CMD_FRAME = 0
    const.CMD_NEXTLEVEL = 241
    const.CMD_TAP = 242
    const.CMD_EFFECT = 243
    const.CMD_JARD = 244
    const.CMD_JARU = 245
    const.CMD_DIE = 246
    const.CMD_IFWTLESS = 247
    const.CMD_SETFALL = 248
    const.CMD_ACT = 249
    const.CMD_CHY = 250
    const.CMD_CHX = 251
    const.CMD_DOWN = 252
    const.CMD_UP = 253
    const.CMD_ABOUTFACE = 254
    const.CMD_GOTO = 255

    const.TYPE_DUNGEON = 0
    const.TYPE_PALACE = 1

    const.START_HEALTH = 3
    const.LIMIT_HEALTH = 10

    const.GRAVITY_NORMAL = 3
    const.GRAVITY_WEIGHTLESS = 1
    const.TOP_SPEED_NORMAL = 33
    const.TOP_SPEED_WEIGHTLESS = 4

    const.TILE_SPACE = 0
    const.TILE_FLOOR = 1
    const.TILE_SPIKES = 2
    const.TILE_PILLAR = 3
    const.TILE_GATE = 4
    const.TILE_STUCK_BUTTON = 5
    const.TILE_DROP_BUTTON = 6
    const.TILE_TAPESTRY = 7
    const.TILE_BOTTOM_BIG_PILLAR = 8
    const.TILE_TOP_BIG_PILLAR = 9
    const.TILE_POTION = 10
    const.TILE_LOOSE_BOARD = 11
    const.TILE_TAPESTRY_TOP = 12
    const.TILE_MIRROR = 13
    const.TILE_DEBRIS = 14
    const.TILE_RAISE_BUTTON = 15
    const.TILE_EXIT_LEFT = 16
    const.TILE_EXIT_RIGHT = 17
    const.TILE_SLICER = 18
    const.TILE_TORCH = 19
    const.TILE_WALL = 20
    const.TILE_SKELETON = 21
    const.TILE_SWORD = 22
    const.TILE_BALCONY_LEFT = 23
    const.TILE_BALCONY_RIGHT = 24
    const.TILE_LATTICE_PILLAR = 25
    const.TILE_LATTICE_SUPPORT = 26
    const.TILE_SMALL_LATTICE = 27
    const.TILE_LATTICE_LEFT = 28
    const.TILE_LATTICE_RIGHT = 29
    const.TILE_TORCH_WITH_DEBRIS = 30
    const.TILE_NULL = 31

    const.POTION_EMPTY = 0
    const.POTION_HEALTH = 1
    const.POTION_LIFE = 2
    const.POTION_WEIGHTLESS = 3
    const.POTION_INVERT = 4
    const.POTION_POISON = 5
    const.POTION_OPEN = 6

    const.FIGHT_ATTACK = 0
    const.FIGHT_ALERT  = 1
    const.FIGHT_FROZEN = 2

    const.REWFF_LEVEL  = 0
    const.REWFF_HEALTH = 1
    const.REWFF_TIME   = 2
    const.REWFF_NONE   = 3

    const.OKMODE_TIME  = 0
    const.OKMODE_DEBUG = 1

    const.DO_MOVE = 0
    const.DO_STRIKE = 1
    const.DO_DEFEND = 2
    const.DO_BLOCK = 3
    const.DO_STRIKE_TO_BLOCK = 4
    const.DO_BLOCK_TO_STRIKE = 5

    const.BUTTON_YES = 0
    const.BUTTON_NO = 1
    const.BUTTON_CANCEL = 2

    const.SPECIAL_CONTINUE = 0
    const.SPECIAL_RESET = 1
    const.SPECIAL_FINISH = 2

    return const
End Function
Function IsHD()
    di = CreateObject("roDeviceInfo")
    return (di.GetUIResolution().height >= 720)
End Function

Sub ResetMainScreen()
    if isHD()
        m.mainScreen = CreateObject("roScreen", true, 854, 480)
    else
        m.mainScreen = CreateObject("roScreen", true, 720, 540)
    end if
    m.mainScreen.SetMessagePort(m.port)
    m.mainScreen.SetAlphaEnable(true)
End Sub

Function ScaleBitmap(bitmap as object, scale as float, simpleMode = false as boolean)
    if bitmap = invalid then return bitmap
    if scale = 1.0
        scaled = bitmap
    else if scale = int(scale) or simpleMode
		scaled = CreateObject("roBitmap",{width:int(bitmap.GetWidth()*scale), height:int(bitmap.GetHeight()*scale), alphaenable:true})
		scaled.DrawScaledObject(0,0,scale,scale,bitmap)
    else
        region = CreateObject("roRegion", bitmap, 0, 0, bitmap.GetWidth(), bitmap.GetHeight())
        region.SetScaleMode(1)
        scaled = CreateObject("roBitmap",{width:int(bitmap.GetWidth()*scale), height:int(bitmap.GetHeight()*scale), alphaenable:true})
        scaled.DrawScaledObject(0,0,scale,scale,region)
	end if
    return scaled
End Function

Function GetScale(screen as object, width as integer, height as integer) as float
    scaleX = screen.GetWidth() / width
    scaleY = screen.GetHeight() / height
    if  scaleX > scaleY
        scale = scaleY
    else
        scale = scaleX
    end if
    return scale
End Function
