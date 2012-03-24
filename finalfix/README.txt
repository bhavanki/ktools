finalfix.pl
==========

finalfix.pl reports on the final fixations in a set of input tracking session
data. Run it from the command line like this (the dollar sign is the
prompt):

$ ./finalfix.pl <directory> > <output file>

The directory should contain files that each contain the results from a
single eye tracking session for a single subject and topic.

The output file will contain one line for each subject. Each line will
have the following tab-separated columns: subject ID, final duration, average
of all other durations, final AOI. Duplicate fixations are eliminated
automatically and not accounted for in the averages.

For example, with this short set of fixations:

Subject: 123-456
 
225699    316    0    R    Topic1_high_1290x1024.jpg
226015    333    0    R    Topic1_high_1290x1024.jpg
226348    100    0    C    Topic1_high_1290x1024.jpg
232394    183    0    1    Topic1_high_1290x1024.jpg

the following line is generated.

123-456	183	249.66667	1

