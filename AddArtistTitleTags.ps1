# Run in administrator (Powershell)
# Set-ExecutionPolicy RemoteSigned
# cd C:\Users\William\Desktop\mp3_folder

# OR for future uses, right-click file, "Run with Powershell"


# Load the assembly. Used a relative path
[Reflection.Assembly]::LoadFrom( (Resolve-Path ".\taglib-sharp-2.1.0.0-windows\Libraries\taglib-sharp.dll"))

$files = @(Get-ChildItem ".\New\")
$successCnt = 0

for ($i=0; $i -lt $files.Count; $i++) {
    
    $fileName = $files[$i].Basename
    $fileParts = @($fileName -split " - ")
    

    if ($fileParts.count -eq 2) {
        $media = [TagLib.File]::Create((resolve-path $files[$i].FullName ))
        $media.Tag.AlbumArtists = $fileParts[0]
        $media.Tag.Title = $fileParts[1]
        $media.Save() 

        $successCnt++
    } else {
        Write-Output "$($files[$i].Name) -incompatible"
    }    
}

Write-Output "`nRenamed $($successCnt) files"

Write-Output "`nPress any key to continue..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")


<#

# set the tags 
$media.Tag.Album = "Todd Klindt's SharePoint Netcast" 
$media.Tag.Year = "2014" 
$media.Tag.Title = "Netcast 185 - Growing Old with Todd" 
$media.Tag.Track = "185" 
$media.Tag.AlbumArtists = "Todd Klindt" 
$media.Tag.Comment = "http://www.toddklindt.com/blog"

# Load up the picture and set it 
$pic = [taglib.picture]::createfrompath("c:\Dropbox\Netcasts\Todd Netcast 1 - 480.jpg") 
$media.Tag.Pictures = $pic

# Save the file back 
$media.Save() 

#>