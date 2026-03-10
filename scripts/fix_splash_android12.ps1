# Ejecutar después de: dart run flutter_native_splash:create
# Corrige values-v31 para mostrar splash_logo completo (sin círculo) en Android 12+

$v31 = "android/app/src/main/res/values-v31/styles.xml"
$v31night = "android/app/src/main/res/values-night-v31/styles.xml"

$launchThemeContent = @"
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">@drawable/launch_background</item>
        <item name="android:windowSplashScreenAnimatedIcon">@drawable/empty_splash_icon</item>
        <item name="android:windowSplashScreenAnimationDuration">0</item>
        <item name="android:forceDarkAllowed">false</item>
        <item name="android:windowFullscreen">false</item>
        <item name="android:windowDrawsSystemBarBackgrounds">false</item>
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
    </style>
"@

$launchThemeNightContent = @"
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">@drawable/launch_background</item>
        <item name="android:windowSplashScreenAnimatedIcon">@drawable/empty_splash_icon</item>
        <item name="android:windowSplashScreenAnimationDuration">0</item>
        <item name="android:forceDarkAllowed">false</item>
        <item name="android:windowFullscreen">false</item>
        <item name="android:windowDrawsSystemBarBackgrounds">false</item>
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
    </style>
"@

$basePath = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Set-Location $basePath

# Patch values-v31
$content = Get-Content $v31 -Raw
$content = $content -replace '(?s)<style name="LaunchTheme" parent="@android:style/Theme\.Light\.NoTitleBar">.*?</style>', $launchThemeContent.Trim()
Set-Content $v31 $content -NoNewline

# Patch values-night-v31  
$content = Get-Content $v31night -Raw
$content = $content -replace '(?s)<style name="LaunchTheme" parent="@android:style/Theme\.Black\.NoTitleBar">.*?</style>', $launchThemeNightContent.Trim()
Set-Content $v31night $content -NoNewline

Write-Host "Splash Android 12+ fix aplicado."
