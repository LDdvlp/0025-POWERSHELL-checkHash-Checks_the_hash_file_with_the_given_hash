Clear-Host

<# ***  1. LOCATE FILE WITH HASH *** ---------------------------------------------------- #>

Write-Host ""
$FileName = $(Write-Host "File name :" -ForegroundColor Red; Read-Host)
$FileLocation = "C:\$env:HOMEPATH\Downloads\$FileName"

<# ***  2. SHOW MENU *** ---------------------------------------------------------------- #>

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

<# ***  3. PROCESS MENU *** ------------------------------------------------------------- #>

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

<# ***  4. EXTRACT HASH FROM FILE *** --------------------------------------------------- #>

Get-FileHash $FileLocation -Algorithm $SelectedHashFile | Format-List

<# ***  5. COPY EXTRACTED HASH *** ------------------------------------------------------ #>

$ExtractedHash = $(Write-Host "Extracted hash :" -ForegroundColor Yellow; Read-Host)
Write-Host ""

<# ***  6. COPY GIVEN HASH *** ---------------------------------------------------------- #>

$GivenHash = $(Write-Host "Given hash :" -ForegroundColor Yellow; Read-Host)
Write-Host ""

<# ***  7. COMPARE EXTRACTED AND GIVEN HASHES *** --------------------------------------- #>

Write-Host "Veracity :" -ForegroundColor Blue
$ExtractedHash -eq $GivenHash
Write-Host ""

<# ***  8. QUIT APPLICATION *** --------------------------------------------------------- #>

Read-Host "STRIKE ENTER KEY TO EXIT, BYE ;-)"
