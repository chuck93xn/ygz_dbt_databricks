$envFile = Join-Path $PSScriptRoot "..\.env"
Get-Content $envFile | ForEach-Object {
    if ($_ -match '^\s*([^#=]+?)\s*=\s*(.*)\s*$') {
        [System.Environment]::SetEnvironmentVariable($matches[1], $matches[2])
    }
}
Write-Host "Loaded env vars from $envFile"
