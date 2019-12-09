<#
#### requires ps-version 5.1 ####

.DESCRIPTION
Simple monitor script to check a directory with logging content and remove the 
oldest file if the free size is unther a speciefied trigger
.NOTES
   Version:        0.1
   Author:         Maarten Schmeitz
   Creation Date:  Monday, December 9th 2019, 12:58:02 pm
   File: monitor.ps1
   Copyright (c) 2019 Advantive

HISTORY:
Date      	          By	Comments
----------	          ---	----------------------------------------------------------
2019-12-09-12-59	 MSCH	Initial Version

.LINK
   www.advantive.nl

.LICENSE
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the Software), to deal
in the Software without restriction, including without limitation the rights
to use copy, modify, merge, publish, distribute sublicense and /or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 
#>






# Drives to check: set to $null or empty to check all local (non-network) drives
# $drives = @("C","D");
$drives = @("D");
 
# The minimum disk size to check for raising the warning
$minSize = 10GB;
 


foreach ($d in $drives) {
  Write-Host ("`r`n");
  Write-Host ("Checking drive " + $d + " ...");
  $disk = Get-PSDrive $d;
  if ($disk.Free -lt $minSize) {
    Write-Host ("Drive " + $d + " has less than " + $minSize `
      + " bytes free (" + $disk.free + "): CleaningUP...");
    
    Get-ChildItem 'D:\eventlog\' |Sort-Object LastWriteTime |Select-Object -First 1 |Remove-Item
        
    
  }
  else {
    write-host $disk.free
    Write-Host ("Drive " + $d + " has more than " + $minSize + " bytes free: nothing to do.");
  }
}
