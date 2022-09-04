# This script was used in SANS530 (Lab 4.2) to locate files that may contain credit card information.

# Create a variable to store findings.
$files_discovered = @()

# List of allowed directories to scan.
$path = @("/etc","/home","/usr")

# Recursively search each specified folder for credit card regex matches.
foreach($folder in $path){

    # The search includes any .csv file, but could be extended to include other file types (.doc, .txt, etc.).
    $files_discovered += Get-ChildItem -Path $folder -Force -Recurse -Include *.csv -ErrorAction SilentlyContinue |
    
    # Regex pattern reference: Visa / American Express / Discover
    Select-String -Pattern "4[0-9]{12}(?:[0-9]{3})?|3[47][0-9]{13}|6(?:011|5[0-9]{2})[0-9]{12}"
}

# Lists each file that contained a match. To view individual entries, comment everything after the pipe.
$files_discovered | Group-Object -Property Filename
