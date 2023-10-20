Cls

$FileName = Read-Host -Prompt 'File name'
$FileLocation = "C:\Users\loicd\Downloads\$FileName"
Write-Host ""

Write-Host "Choose one of the following file hash"
Write-Host "SHA1"
Write-Host "SHA256"
Write-Host "SHA384"
Write-Host "SHA512"
Write-Host "MD5"

$FileHash = Read-Host -Prompt 'Choosen hash'

Get-FileHash $FileLocation -Algorithm $FileHash | Format-List


$ExtractedHash = Read-Host -Prompt 'Extracted hash'
Write-Host ""
$GivenHash = Read-Host -Prompt 'Given hash'
Write-Host ""
$ExtractedHash -eq $GivenHash



