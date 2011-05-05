nmergen.pl and nmergen2.pl are scripts for creating a single nmer input file.
Run them from the command line like this (the dollar sign is the prompt):

$ ./nmergen.pl <filename-part> < <input-filename>
$ ./nmergen2.pl <filename-part> < <input-filename>

The input file should contain the results from a single eye tracking session
for a single subject and topic. The script will create a file with the
subject's ID and the "filename-part" passed to the script. For example, if the
subject's ID is 123-456 and you call:

./nmergen.pl foo < input.file

then the output will be placed in a file called foo_123-456.nmer.

The output file itself will contain a single string of characters, one for each
fixation recorded in the input file.

nmergen.pl: If the AOI ID contains an underscore, then the last character in
the AOI ID is emitted for that fixation. Otherwise, the character '0' is
emitted. For example, with this short set of fixations:

225699    316    0    T1H_R    Topic1_high_1290x1024.jpg
226015    333    0    T1H_R    Topic1_high_1290x1024.jpg
226348    100    0    T1H_C    Topic1_high_1290x1024.jpg
232394    183    0    Content    Topic1_high_1290x1024.jpg

the string "RRC0" is generated. 

nmergen2.pl: The AOI ID is emitted as is for that fixation. For example, with
this short set of fixations:

225699    316    0    R    Topic1_high_1290x1024.jpg
226015    333    0    R    Topic1_high_1290x1024.jpg
226348    100    0    C    Topic1_high_1290x1024.jpg
232394    183    0    1    Topic1_high_1290x1024.jpg

the string "RRC1" is generated.
