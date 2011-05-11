nmergen.pl creates a single nmer string from input tracking session
data. Run it from the command line like this (the dollar sign is the
prompt):

$ ./nmergen.pl < <input-filename>

The input file should contain the results from a single eye tracking
session for a single subject and topic.

The output file itself will contain the subject ID, followed by a
colon, followed by a single string of characters, one for each
fixation recorded in the input file.

The AOI ID is emitted as is for that fixation, except for the ID
"Content", which is converted to "0". For example, with this short set
of fixations:

Subject: 123-456

225699    316    0    R    Topic1_high_1290x1024.jpg
226015    333    0    R    Topic1_high_1290x1024.jpg
226348    100    0    C    Topic1_high_1290x1024.jpg
232394    183    0    1    Topic1_high_1290x1024.jpg

the string "123-456:RRC1" is generated.

You can pass the -n option to nmergen.pl. When that option is passed,
the output does not include any AOI IDs in the range 0 - 9 (or the ID
"Content" which is converted to 0). Given the above short set of
fixations, calling:

$ ./nmergen.pl -n < <input-filename>

results in the string "123-456:RRC".
