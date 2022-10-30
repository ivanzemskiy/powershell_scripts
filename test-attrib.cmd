cls

@REM help
:: ASSOC          Displays or modifies file extension associations.
:: ATTRIB         Displays or changes file attributes.

ATTRIB /?
:: Displays or changes file attributes.
:: ATTRIB [+R | -R] [+A | -A] [+S | -S] [+H | -H] [+O | -O] [+I | -I] [+X | -X] [+P | -P] [+U | -U]
::        [drive:][path][filename] [/S [/D]] [/L]
::   +   Sets an attribute.
::   -   Clears an attribute.
::   R   Read-only file attribute.
::   A   Archive file attribute.
::   S   System file attribute.
::   H   Hidden file attribute.
::   O   Offline attribute.
::   I   Not content indexed file attribute.
::   X   No scrub file attribute.
::   V   Integrity attribute.
::   P   Pinned attribute.
::   U   Unpinned attribute.
::   B   SMR Blob attribute.
::   [drive:][path][filename]
::       Specifies a file or files for attrib to process.
::   /S  Processes matching files in the current folder
::       and all subfolders.
::   /D  Processes folders as well.
::   /L  Work on the attributes of the Symbolic Link versus
::       the target of the Symbolic Link

ASSOC /?
:: Displays or modifies file extension associations
:: ASSOC [.ext[=[fileType]]]
::   .ext      Specifies the file extension to associate the file type with
::   fileType  Specifies the file type to associate with the file extension
:: Type ASSOC without parameters to display the current file associations.
:: If ASSOC is invoked with just a file extension, it displays the current
:: file association for that file extension.  Specify nothing for the file
:: type and the command will delete the association for the file extension.

