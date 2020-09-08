# Files-Organiser

Organise the files inside a directory according to their types (file type extensions)

Run the script while providing the source and destination parameters.
If you skip providing the arguments, by default the script will consider the source and destination directories to be present in the same folder as the script.


To run the script, type the following path in the PowerShell prompt: 
```
  & 'C:\Users\User Name\Desktop\organiserScript.ps1'
```

  NOTE:
    1. Here the script is present in the Desktop folder of the user 'User Name' and source and destination are also considered to be in the same location.
    2. '&' (ampersand) allows a space to be present in the file path. Without '&' your script will not run if there are spaces present anywhere in the file path.
    3. Instead of providing absolute paths, relative paths can be used based on the current folder you are in.
