nmergen.pl
==========

nmergen.pl creates a single nmer string from input tracking session
data. Run it from the command line like this (the dollar sign is the
prompt):

$ ./nmergen.pl < <input-filename>

The input file should contain the results from a single eye tracking
session for a single subject and topic.

The output file itself will contain the subject ID, followed by a
colon, followed by a single string of characters, one for each
fixation recorded in the input file. Duplicate fixations are
eliminated automatically.

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


fixations.pl
============

fixations.pl produces statistics about fixations in an input tracking
session. Run it from the command line like this:

$ ./fixations.pl < <input-filename>

Use the same input files as for nmergen.pl. As with nmergen.pl,
duplicate lines in the file are eliminated automatically. Also, the
AOI ID "Content" is automatically converted to "0".

The output file will contain a single line of tab-delimited data. The
first field is the subject ID. The second field is the count of the
number of numeric (white-space) AOI IDs found in the input file.

The remaining fields are sets of data centered around each numeric AOI
ID. The first set corresponding to the first number, the second to the
second number, and so on. The fields in each set are as follows:

- the numeric AOI ID itself
- its position in the file (not including duplicate lines), where 0 is
  the first position
- the count of non-numeric AOI IDs preceding the numeric AOI ID, but
  after the last non-numeric AOI ID ("leading" non-numeric AOI IDs)
- the number of runs of leading non-numeric AOI IDs
- the number of unique leading non-numeric AOI IDs
- the AOI ID (numeric or not) immediately preceding the numeric AOI ID
- the AOI ID (numeric or not) immediately succeeding the numeric AOI
  ID
- the total duration across the leading non-numeric AOI IDs

For the immediately preceding and succeeding AOI ID fields, if the
corresponding numeric AOI ID is at the first or last position,
respectively, in the input file, then the field value is "-".

For example, with this set of fixations:

Subject: 123-456
 
100    200    0    R    Topic1_high_1290x1024.jpg
300    100    0    R    Topic1_high_1290x1024.jpg
400    200    0    C    Topic1_high_1290x1024.jpg
600    100    0    1    Topic1_high_1290x1024.jpg
700    300    0    P    Topic1_high_1290x1024.jpg
1000   100    0    P    Topic1_high_1290x1024.jpg
1100   200    0    C    Topic1_high_1290x1024.jpg
1300   300    0    P    Topic1_high_1290x1024.jpg
1600   100    0    2    Topic1_high_1290x1024.jpg 
1700   100    0    3    Topic1_high_1290x1024.jpg 
1800   400    0    P    Topic1_high_1290x1024.jpg
2200   200    0    1    Topic1_high_1290x1024.jpg

the following data is generated. The output here is split across
several lines for readability, but for an actual run it would be on a
single line.

123-456	4
1	3	3	2	2	C	P	500
2	8	4	3	2	P	3	900
3	9	0	0	0	2	P	0
1	11	1	1	1	P	-	400
	
