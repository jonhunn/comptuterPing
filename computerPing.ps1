# This script pings a list of computers
# and pushes them to a modified open source ping program
# called vmPing https://github.com/R-Smith/vmPing



$list = ''
$finalList = ''
$pathVMping = 'Software\vmPing\vmping.exe'
$pathFMlist = 'C:\sns\fmList.txt'

function killVMping{
	$task = Get-Process -name vmping -erroraction SilentlyContinue
	if ($task){
         $task | Stop-Process -Force
         }
}
function getOffline{
		Get-Content $pathFMlist| ForEach-Object {
			if(Test-Connection -computer $_ -count 1 -Quiet){
				#purposefully left blank in case something is needed in the future
			}else{
				$list = $_
				$finalList = $finalList +" "+$list
			}
		}
		killVMping
		Start-Process $pathVMping $finalList
}

getOffline