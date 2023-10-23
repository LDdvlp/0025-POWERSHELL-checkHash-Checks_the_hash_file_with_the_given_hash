Clear-Host

Write-Host ""
$FileName = $(Write-Host "File name :" -ForegroundColor Red; Read-Host)
$FileLocation = "C:\$env:HOMEPATH\Downloads\$FileName"


Function Show-Hash-Menu {
    param (
        [string]$Title1 = 'File location',
        [string]$Title2 = 'Select file hash'
    )
    Clear-Host
    Write-Host ""
    Write-Host "================ $Title1 ================" -ForegroundColor Magenta
    Write-Host $FileLocation -ForegroundColor Magenta
    Write-Host "================ $Title2 ================" -ForegroundColor DarkCyan
    Write-Host "1. SHA1" -ForegroundColor Cyan
    Write-Host "2. SHA256" -ForegroundColor Cyan
    Write-Host "3. SHA384" -ForegroundColor Cyan
    Write-Host "4. SHA512" -ForegroundColor Cyan
    Write-Host "5. MD5" -ForegroundColor Cyan
    Write-Host "6. Exit" -ForegroundColor Cyan
}
Function Select-Hash-Menu {
    param (
        [string]$FileHash
    )
    $Selection = $(Write-Host "Selection :" -ForegroundColor DarkCyan; Read-Host)
    switch ($Selection){
        1 {$FileHash = "SHA1"}
        2 {$FileHash = "SHA256"}
        3 {$FileHash = "SHA384"}
        4 {$FileHash = "SHA512"}
        5 {$FileHash = "MD5"}
        6 {Exit}
    }
    Return $FileHash
}

$Continue = $True
While ($Continue) {
    Show-Hash-Menu
    $SelectedHashFile = Select-Hash-Menu
    $Confirm = $(Write-Host "Confirm selection for $SelectedHashFile (y/n) ? " -ForegroundColor DarkGreen; Read-Host)
    switch ($Confirm) {
        'y' {$Continue = $False}
    }
}

Get-FileHash $FileLocation -Algorithm $SelectedHashFile | Format-List

$ExtractedHash = $(Write-Host "Extracted hash :" -ForegroundColor Yellow; Read-Host)
Write-Host ""
$GivenHash = $(Write-Host "Given hash :" -ForegroundColor Yellow; Read-Host)
Write-Host ""
Write-Host "Veracity :" -ForegroundColor Blue
$ExtractedHash -eq $GivenHash
Write-Host ""
Read-Host "Appuyez sur ENTREE pour sortir..."