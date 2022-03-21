$output = ""

Get-ChildItem -Path Registry::HKEY_USERS | Select-Object Name | ForEach-Object {
    $path = "Registry::" + $_.Name + "\Control Panel\International"    
    if(Test-Path $path)
    {
        $item = Get-ItemProperty -Path $path -Name "sShortDate" -ErrorAction Ignore
        if($item.sShortDate -notmatch "yyyy"){
            $outputTmp = $item.PSPath + "\sShortDate=" + $item.sShortDate
            $outputTmp = $outputTmp.Replace("Microsoft.PowerShell.Core\Registry::", "")
            $output = $output + $outputTmp + "`r`n"
        }
    }
}
if($output.Length -eq 0){
Write-Output "All is good!"
}
else{
Write-Output "Some parameter seems to be wrong :"
Write-Output $output
}

