sequential.pl
=============

sequential.pl reports on the durations in a set of input tracking
session data. Run it from the command line like this (the dollar sign
is the prompt):

$ ./sequential.pl <directory> > <output file>

The directory should contain files that each contain the results from a
single eye tracking session for a single subject and topic.

The output file will contain one line for each subject. Each line will
have an initial column for the subject ID, and one column thereafter
for each incidence of an AOI, starting from the first, present in at
least one of the input files. Each AOI column value contains the
duration of the fixation on the AOI. Numeric AOIs and the AOI
"Content" are skipped.

For example, with this short set of fixations:

Subject: 123-456
 
225699    316    0    R    Topic1_high_1290x1024.jpg
226015    333    0    R    Topic1_high_1290x1024.jpg
226348    100    0    C    Topic1_high_1290x1024.jpg
232394    183    0    1    Topic1_high_1290x1024.jpg

the following lines are generated.

Subj    C1      R1      R2
123-456 100     316     333

The script can also aggregate the durations of consecutive fixations
on the same AOI. Pass the "-a" option to the command like this:

$ ./sequential.pl -a <directory> > <output file>

Under aggregation, the above short set of fixations leads to the
following lines:

Subj    C1      R1      R2
123-456 100     649     333

