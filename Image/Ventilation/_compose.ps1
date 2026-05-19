Add-Type -AssemblyName System.Drawing

$dir = "E:\personal\liuyuanru123.github.io\Image\Ventilation"
$out = "$dir\SensingArchitecture.png"

$CanvasW = 1800; $CanvasH = 900
$bmp = New-Object System.Drawing.Bitmap($CanvasW, $CanvasH)
$g   = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode     = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.Clear([System.Drawing.Color]::White)

# Palette
$cSense  = [System.Drawing.Color]::FromArgb(255, 255, 228, 181)  # FFE4B5
$cSenseB = [System.Drawing.Color]::FromArgb(255, 122,  92,   0)
$cEst    = [System.Drawing.Color]::FromArgb(255, 214, 234, 248)  # D6EAF8
$cEstB   = [System.Drawing.Color]::FromArgb(255,  27,  79, 114)
$cOpt    = [System.Drawing.Color]::FromArgb(255, 213, 245, 227)  # D5F5E3
$cOptB   = [System.Drawing.Color]::FromArgb(255,  25, 111,  61)
$cAdapt  = [System.Drawing.Color]::FromArgb(255, 253, 226, 228)  # FDE2E4
$cAdaptB = [System.Drawing.Color]::FromArgb(255, 123,  36,  28)
$cText   = [System.Drawing.Color]::FromArgb(255,  30,  30,  30)
$cGrey   = [System.Drawing.Color]::FromArgb(255, 110, 110, 110)

# Fonts
$fTitle  = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
$fHeader = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
$fBody   = New-Object System.Drawing.Font("Segoe UI", 12)
$fSmall  = New-Object System.Drawing.Font("Segoe UI", 11)
$fMono   = New-Object System.Drawing.Font("Consolas", 13, [System.Drawing.FontStyle]::Bold)

# Title
$titleRect = New-Object System.Drawing.RectangleF(0, 12, $CanvasW, 36)
$sfCenter  = New-Object System.Drawing.StringFormat
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("Dual-Module Sensing Architecture for Ventilation Volume Estimation",
              $fTitle, [System.Drawing.Brushes]::Black, $titleRect, $sfCenter)
$g.DrawString("BreathFlow  -  Layer 1+2 detail view",
              $fSmall, [System.Drawing.Brushes]::DimGray,
              (New-Object System.Drawing.RectangleF(0, 50, $CanvasW, 22)), $sfCenter)

# ----- Helper -----
function Draw-Box($x,$y,$w,$h,$fill,$border,$radius=12) {
    $rect = New-Object System.Drawing.Rectangle($x,$y,$w,$h)
    $path = New-Object System.Drawing.Drawing2D.GraphicsPath
    $path.AddArc($x,$y,$radius,$radius,180,90)
    $path.AddArc($x+$w-$radius,$y,$radius,$radius,270,90)
    $path.AddArc($x+$w-$radius,$y+$h-$radius,$radius,$radius,0,90)
    $path.AddArc($x,$y+$h-$radius,$radius,$radius,90,90)
    $path.CloseFigure()
    $brush = New-Object System.Drawing.SolidBrush($fill)
    $g.FillPath($brush, $path)
    $pen = New-Object System.Drawing.Pen($border, 2)
    $g.DrawPath($pen, $path)
    $brush.Dispose(); $pen.Dispose(); $path.Dispose()
}
function Draw-Text($txt,$x,$y,$font,$color=$cText) {
    $br = New-Object System.Drawing.SolidBrush($color)
    $g.DrawString($txt, $font, $br, [float]$x, [float]$y)
    $br.Dispose()
}
function Draw-Arrow($x1,$y1,$x2,$y2,$color=$cText,$width=2,$dashed=$false) {
    $pen = New-Object System.Drawing.Pen($color, $width)
    if ($dashed) { $pen.DashPattern = @(6,4) }
    $pen.EndCap = [System.Drawing.Drawing2D.LineCap]::ArrowAnchor
    $g.DrawLine($pen, [float]$x1, [float]$y1, [float]$x2, [float]$y2)
    $pen.Dispose()
}

# ===== LEFT: device photos =====
$dev1 = [System.Drawing.Image]::FromFile("$dir\Device.png")
$dev2 = [System.Drawing.Image]::FromFile("$dir\device2.jpg")

# Module A photo (window module close-up = device2.jpg)
$mAx = 30; $mAy = 100; $mAw = 280; $mAh = 320
Draw-Box $mAx $mAy $mAw ($mAh+90) $cSense $cSenseB
Draw-Text "Module A" ($mAx+10) ($mAy+8) $fHeader $cSenseB
Draw-Text "Window Aperture Sensor" ($mAx+10) ($mAy+30) $fBody $cText
$g.DrawImage($dev2, [float]($mAx+15), [float]($mAy+58), [float]($mAw-30), [float]($mAh-70))
Draw-Text "ultrasonic + magnetic reed" ($mAx+10) ($mAy+$mAh) $fSmall $cGrey
Draw-Text "-> aperture A(t)  [m^2]" ($mAx+10) ($mAy+$mAh+20) $fMono $cSenseB
Draw-Text "-> open/closed state" ($mAx+10) ($mAy+$mAh+44) $fMono $cSenseB

# Module B photo (full device.png)
$mBx = 30; $mBy = 555; $mBw = 280; $mBh = 220
Draw-Box $mBx $mBy $mBw ($mBh+100) $cSense $cSenseB
Draw-Text "Module B" ($mBx+10) ($mBy+8) $fHeader $cSenseB
Draw-Text "Ventilation & IEQ Sensor Stack" ($mBx+10) ($mBy+30) $fBody $cText
$g.DrawImage($dev1, [float]($mBx+15), [float]($mBy+58), [float]($mBw-30), [float]($mBh-70))
Draw-Text "anemometer + CO2/PM/T/RH/MRT" ($mBx+10) ($mBy+$mBh) $fSmall $cGrey
Draw-Text "-> wind v(t), dT, RH, CO2," ($mBx+10) ($mBy+$mBh+20) $fMono $cSenseB
Draw-Text "   PM2.5, PM10, MRT" ($mBx+10) ($mBy+$mBh+44) $fMono $cSenseB

$dev1.Dispose(); $dev2.Dispose()

# ===== MIDDLE: signal extraction =====
$sx = 380; $sw = 380
# A signals
$sAy = 130
Draw-Box $sx $sAy $sw 200 $cEst $cEstB
Draw-Text "Signals from Module A" ($sx+15) ($sAy+10) $fHeader $cEstB
Draw-Text "- Aperture area  A(t)   [m^2]"     ($sx+20) ($sAy+45)  $fBody
Draw-Text "- Effective opening height  H_eff"  ($sx+20) ($sAy+72)  $fBody
Draw-Text "- Open / closed binary state"       ($sx+20) ($sAy+99)  $fBody
Draw-Text "- Opening duration  dt_open"        ($sx+20) ($sAy+126) $fBody
Draw-Text "sampling: 1 Hz, on-device"          ($sx+20) ($sAy+158) $fSmall $cGrey

# B signals
$sBy = 555
Draw-Box $sx $sBy $sw 260 $cEst $cEstB
Draw-Text "Signals from Module B" ($sx+15) ($sBy+10) $fHeader $cEstB
Draw-Text "- Wind speed at window  v(t)  [m/s]" ($sx+20) ($sBy+45)  $fBody
Draw-Text "- Indoor T, Outdoor T   ->  dT"       ($sx+20) ($sBy+72)  $fBody
Draw-Text "- Globe temperature      ->  MRT"     ($sx+20) ($sBy+99)  $fBody
Draw-Text "- RH (in/out), CO2 ppm"                ($sx+20) ($sBy+126) $fBody
Draw-Text "- PM2.5, PM10  (in/out)"               ($sx+20) ($sBy+153) $fBody
Draw-Text "- CO2 decay slope (tracer)"            ($sx+20) ($sBy+180) $fBody
Draw-Text "sampling: 1 Hz, edge MCU"              ($sx+20) ($sBy+212) $fSmall $cGrey

# ===== RIGHT TOP: Physics model =====
$px = 820; $pw = 950
$pPy = 100
Draw-Box $px $pPy $pw 220 $cOpt $cOptB
Draw-Text "Physics-based Estimator" ($px+15) ($pPy+10) $fHeader $cOptB
Draw-Text "Buoyancy-driven (stack):" ($px+20) ($pPy+45) $fBody
Draw-Text "  Q_b = Cd * A(t) * sqrt( 2 g * dT * H / T )" ($px+20) ($pPy+68) $fMono $cOptB
Draw-Text "Wind-driven (cross):" ($px+20) ($pPy+100) $fBody
Draw-Text "  Q_w = Cw * A(t) * v(t)" ($px+20) ($pPy+123) $fMono $cOptB
Draw-Text "Combined:" ($px+20) ($pPy+155) $fBody
Draw-Text "  Q_phys = sqrt( Q_b^2 + Q_w^2 )" ($px+20) ($pPy+178) $fMono $cOptB

# ===== RIGHT MIDDLE: LSTM fusion =====
$pLy = 350
Draw-Box $px $pLy $pw 180 $cEst $cEstB
Draw-Text "LSTM Fusion (residual + temporal)" ($px+15) ($pLy+10) $fHeader $cEstB
Draw-Text "Input window: last 10 min" ($px+20) ($pLy+45) $fBody
Draw-Text "Features: [A, v, dT, RH, CO2, slope, Q_phys]" ($px+20) ($pLy+72) $fBody
Draw-Text "Target: ACH (h^-1)" ($px+20) ($pLy+99) $fBody
Draw-Text "ACH_hat = Q_phys + LSTM_residual" ($px+20) ($pLy+128) $fMono $cEstB
Draw-Text "calibrated by CO2-decay ground truth" ($px+20) ($pLy+150) $fSmall $cGrey

# ===== RIGHT BOTTOM: Output =====
$pOy = 560
Draw-Box $px $pOy $pw 220 $cAdapt $cAdaptB
Draw-Text "Output to BreathFlow Layer 2" ($px+15) ($pOy+10) $fHeader $cAdaptB
Draw-Text "Estimated Air Change per Hour:" ($px+20) ($pOy+45) $fBody
Draw-Text "  ACH_hat(t)  [h^-1]" ($px+20) ($pOy+72) $fMono $cAdaptB
Draw-Text "Confidence:" ($px+20) ($pOy+102) $fBody
Draw-Text "  sigma from LSTM dropout ensemble" ($px+20) ($pOy+125) $fMono $cAdaptB
Draw-Text "Feeds:" ($px+20) ($pOy+155) $fBody
Draw-Text "  -> PMV / Adaptive Comfort predictor" ($px+30) ($pOy+178) $fSmall
Draw-Text "  -> Decision layer (open / hybrid / AC)" ($px+30) ($pOy+198) $fSmall

# ===== Arrows =====
# A photo -> A signals
Draw-Arrow ($mAx+$mAw) ($mAy+180) ($sx) ($sAy+90)
# B photo -> B signals
Draw-Arrow ($mBx+$mBw) ($mBy+180) ($sx) ($sBy+130)
# A signals -> Physics
Draw-Arrow ($sx+$sw) ($sAy+100) ($px) ($pPy+90)
# B signals -> Physics
Draw-Arrow ($sx+$sw) ($sBy+90) ($px) ($pPy+150)
# A signals -> LSTM
Draw-Arrow ($sx+$sw) ($sAy+150) ($px) ($pLy+60)
# B signals -> LSTM
Draw-Arrow ($sx+$sw) ($sBy+150) ($px) ($pLy+110)
# Physics -> LSTM
Draw-Arrow ($px+$pw/2) ($pPy+220) ($px+$pw/2) ($pLy) $cText 2 $true
# LSTM -> Output
Draw-Arrow ($px+$pw/2) ($pLy+180) ($px+$pw/2) ($pOy)

# Footer label
$footerY = $CanvasH - 30
$g.DrawString("liuyuanru123.github.io  -  Indoor Environment + Edge AI Research",
              $fSmall, [System.Drawing.Brushes]::DimGray,
              (New-Object System.Drawing.RectangleF(0, $footerY, $CanvasW, 22)), $sfCenter)

# Save
$bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose()
"Saved: $out  ($((Get-Item $out).Length) bytes)"
