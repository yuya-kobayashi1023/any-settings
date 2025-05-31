# execute push
git push

# overwrite setting
if ($LASTEXITCODE -eq 0) {
    $sourcePath = "$env:USERPROFILE\src\any-settings\nvim-setting\init.lua"
    $destPath = "$env:LOCALAPPDATA\nvim\init.lua"
    Copy-Item $sourcePath $destPath -Force
    Write-Host "init.lua copied to $destPath"
} else {
    Write-Host "Git push failed. init.lua not copied."
}
