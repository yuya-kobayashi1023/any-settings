# push-and-sync.ps1

# 1. push する
git push

# 2. push が成功したら、init.lua を AppData にコピーする
if ($LASTEXITCODE -eq 0) {
    $sourcePath = "$env:USERPROFILE\src\any-settings\nvim-setting\init.lua"
    $destPath = "$env:LOCALAPPDATA\nvim\init.lua"
    Copy-Item $sourcePath $destPath -Force
    Write-Host "init.lua copied to $destPath"
} else {
    Write-Host "Git push failed. init.lua not copied."
}
